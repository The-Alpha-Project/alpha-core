from struct import pack
from utils import Formulas
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.GroupCodes import PartyOperations, PartyResults
from utils.constants.ObjectCodes import WhoPartyStatus, LootMethods
from game.world.managers.GridManager import GridManager
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler

MAX_GROUP_SIZE = 5


# TODO: 0.5.3 has no SMSG_LOOT_MASTER_LIST nor CMSG_LOOT_MASTER_GIVE, how exactly they handled ML?
class GroupManager(object):
    def __init__(self, player_mgr):
        self.party_leader = player_mgr
        self.members = {player_mgr.guid: player_mgr}
        self.invites = {}
        self.loot_method = LootMethods.LOOT_METHOD_FREEFORALL
        self.master_looter = None
        self.party_leader.set_group_leader(True)
        self.party_leader.group_status = WhoPartyStatus.WHO_PARTY_STATUS_IN_PARTY
        self.allowed_looters = {}
        self._last_looter = None  # For Round Robin, cycle will start at leader.

    def try_add_member(self, player_mgr, invite):
        # Check if new player is not in a group already and if we have space.
        if self.is_full():
            return False

        if invite:
            self.invites[player_mgr.guid] = player_mgr
            player_mgr.group_manager = self
            return True
        else:
            self.members[player_mgr.guid] = player_mgr
            player_mgr.group_manager = self
            player_mgr.group_status = WhoPartyStatus.WHO_PARTY_STATUS_IN_PARTY

            query_details_packet = NameQueryHandler.get_query_details(player_mgr.player)
            self.send_packet_to_members(query_details_packet)

            if player_mgr != self.party_leader:
                player_mgr.set_group_leader(False)

            if len(self.members) > 1:
                self.send_update()
                self.send_party_members_stats()

            return True

    def is_full(self):
        return len(self.members) == MAX_GROUP_SIZE

    def set_leader(self, player_mgr):
        self.party_leader.set_group_leader(False)
        player_mgr.set_group_leader(True)
        leader_name_bytes = PacketWriter.string_to_bytes(player_mgr.player.name)
        data = pack(f'<{len(leader_name_bytes)}s', leader_name_bytes)
        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_SET_LEADER, data)
        self.send_packet_to_members(packet)
        self.send_update()

    def set_loot_method(self, loot_method, master_looter=None):
        self.loot_method = LootMethods(loot_method)
        self.master_looter = master_looter if master_looter else None
        self.send_update()

    def send_update(self):
        leader_name_bytes = PacketWriter.string_to_bytes(self.party_leader.player.name)

        # Header
        data = pack(
            f'<I{len(leader_name_bytes)}sQB',
            len(self.members),
            leader_name_bytes,
            self.party_leader.guid,
            1  # If party leader is online or not
        )

        # Fill all group members.
        for member in self.members.values():
            if member == self.party_leader:
                continue

            member_name_bytes = PacketWriter.string_to_bytes(member.player.name)
            data += pack(
                f'<{len(member_name_bytes)}sQB',
                member_name_bytes,
                member.guid,
                1  # If member is online or not
             )

        data += pack(
            '<BQ',
            self.loot_method,
            0 if not self.master_looter else self.master_looter.guid  # Master Looter guid
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_LIST, data)
        self.send_packet_to_members(packet)
        self.send_party_members_stats()

    def leave_party(self, player_mgr, force_disband=False, is_kicked=False):
        disband = player_mgr == self.party_leader or len(self.members) == 2 or force_disband
        for member in self.members.values():
            if disband or member == player_mgr:
                GroupManager.send_group_operation_result(member, PartyOperations.PARTY_OP_LEAVE, member.player.name, PartyResults.ERR_PARTY_RESULT_OK)
                member.group_manager = None
                member.set_group_leader(False)
                member.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY

                if is_kicked and member == player_mgr:  # 'You have been removed from the group.' message
                    packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_UNINVITE)
                    player_mgr.session.enqueue_packet(packet)

        if disband:
            self.members.clear()
        elif player_mgr.guid in self.members:
            self._set_previous_looter(player_mgr)
            self.members.pop(player_mgr.guid)

        self.send_update()

    def un_invite_player(self, player_mgr, target_player_mgr):
        if not target_player_mgr.group_manager or target_player_mgr.guid not in self.members:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return
        elif self.party_leader != player_mgr or self != target_player_mgr.group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_NOT_LEADER)
            return

        self.leave_party(target_player_mgr, is_kicked=True)

    def set_party_leader(self, player_mgr, target_player_mgr):
        if not target_player_mgr.group_manager or target_player_mgr.guid not in self.members:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return
        elif self.party_leader != player_mgr or self != target_player_mgr.group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_NOT_LEADER)
            return

        self.party_leader.set_group_leader(False)
        self.party_leader = target_player_mgr
        self.party_leader.set_group_leader(True)

        name_bytes = PacketWriter.string_to_bytes(target_player_mgr.player.name)
        data = pack(
            f'<{len(name_bytes)}s',
            name_bytes,
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_SET_LEADER, data)
        self.send_packet_to_members(packet)
        self.send_update()

    def remove_invitation(self, player_mgr):
        if player_mgr.guid in self.invites:
            self.invites.pop(player_mgr.guid, None)
            player_mgr.group_manager = None
            player_mgr.set_group_leader(False)
            player_mgr.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY

            if len(self.members) <= 1:
                self.leave_party(self.party_leader, force_disband=True)

    def remove_member_invite(self, guid):
        if guid in self.invites:
            self.invites.pop(guid, None)

    # Called once upon victim dead.
    def set_allowed_looters(self, victim):
        if victim.guid in self.allowed_looters:
            return
        self.allowed_looters[victim.guid] = self._fill_allowed_looters()

    # Get allowed looters for specific creature.
    def get_allowed_looters(self, victim):
        if victim.guid in self.allowed_looters:
            return self.allowed_looters[victim.guid]
        return []

    def clear_looters_for_victim(self, victim):
        if victim.guid in self.allowed_looters:
            self.allowed_looters.pop(victim.guid)

    def _fill_allowed_looters(self):
        if self.loot_method == LootMethods.LOOT_METHOD_MASTERLOOTER:
            return [self.master_looter]
        elif self.loot_method == LootMethods.LOOT_METHOD_FREEFORALL:
            return self.members.values()
        elif self.loot_method == LootMethods.LOOT_METHOD_ROUNDROBIN:
            if not self._last_looter:
                self._last_looter = self.party_leader
                return [self._last_looter]
            return [self._get_next_looter(self._last_looter)]
        return []

    def _set_previous_looter(self, player_mgr):
        _list = list(self.members.values())
        _index = list.index(_list, player_mgr)

        if _index - 1 >= 0:
            self._last_looter = _list[_index - 1]
        else:
            self._last_looter = _list[-1]

    def _get_next_looter(self, player_mgr):
        _list = list(self.members.values())
        _index = list.index(_list, player_mgr)

        if _index + 1 < len(_list):
            self._last_looter = _list[_index + 1]
            return _list[_index + 1]
        else:
            self._last_looter = _list[0]
            return _list[0]

    def is_party_member(self, player):
        return player in self.members.values()

    def reward_group_money(self, player, creature):
        surrounding = [m for m in self.members.values() if m in GridManager.get_surrounding_players(player).values()]
        share = int(creature.loot_manager.current_money / len(surrounding))
        # Append div remainder to the player who killed the creature for now.
        remainder = int(creature.loot_manager.current_money % len(surrounding))

        for member in surrounding:
            player_share = share if member != creature.killed_by else share + remainder
            # TODO: MSG_SPLIT_MONEY seems not to have any effect on the client.
            # data = pack('<Q2I', creature.guid, creature.loot_manager.current_money, ply_share)
            # split_packet = PacketWriter.get_packet(OpCode.MSG_SPLIT_MONEY, data)
            # member.session.send_message(split_packet)
            data = pack('<I', player_share)
            member.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_MONEY_NOTIFY, data))
            member.mod_money(player_share)

        creature.loot_manager.clear_money()
        self.send_packet_to_members(PacketWriter.get_packet(OpCode.SMSG_LOOT_CLEAR_MONEY))

    def reward_group_xp(self, player, creature, is_elite):
        surrounding = [m for m in self.members.values() if m in GridManager.get_surrounding_players(player).values()]
        surrounding.sort(key=lambda players: players.level, reverse=True)  # Highest level on top
        sum_levels = sum(player.level for player in surrounding)
        base_xp = Formulas.CreatureFormulas.xp_reward(creature.level, surrounding[0].level, is_elite)

        for member in surrounding:
            member.give_xp([base_xp * member.level / sum_levels], creature)

    def send_party_members_stats(self):
        for member in self.members.values():
            self.send_party_member_stats(member)

    def send_party_member_stats(self, player_mgr):
        data = pack('<Q2IB6I',
                    player_mgr.guid,
                    player_mgr.health,
                    player_mgr.max_health,
                    player_mgr.power_type,
                    player_mgr.get_power_type_value(),  # Todo Current power value
                    player_mgr.get_power_type_value(),  # Todo Max power value
                    player_mgr.level,
                    player_mgr.zone,
                    player_mgr.map_,
                    player_mgr.player.class_,
                    )

        packet = PacketWriter.get_packet(OpCode.SMSG_PARTY_MEMBER_STATS, data)
        self.send_packet_to_members(packet)

    def send_invite_decline(self, player_name):
        name_bytes = PacketWriter.string_to_bytes(player_name)
        data = pack(
            f'<{len(name_bytes)}s',
            name_bytes,
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_DECLINE, data)
        self.party_leader.session.enqueue_packet(packet)

    def send_packet_to_members(self, packet, ignore=None, source=None, use_ignore=False):
        for member in self.members.values():
            if member == ignore:
                continue
            if use_ignore and source and member.friends_manager.has_ignore(source.guid):
                continue

            member.session.enqueue_packet(packet)

    def send_minimap_ping(self, player_mgr, x, y):
        data = pack('<Q2f', player_mgr.guid, x, y)
        packet = PacketWriter.get_packet(OpCode.MSG_MINIMAP_PING, data)
        self.send_packet_to_members(packet)

    @staticmethod
    def invite_player(player_mgr, target_player_mgr):
        if player_mgr.is_enemy_to(target_player_mgr):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_PLAYER_WRONG_FACTION)
            return

        if target_player_mgr.friends_manager.has_ignore(player_mgr.guid):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_IGNORING_YOU_S)
            return

        if target_player_mgr.group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_ALREADY_IN_GROUP_S)
            return

        if player_mgr.group_manager:
            if player_mgr.group_manager.party_leader != player_mgr:
                GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_NOT_LEADER)
                return

            if len(player_mgr.group_manager.members) == MAX_GROUP_SIZE:
                GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_GROUP_FULL)
                return

            if not player_mgr.group_manager.try_add_member(target_player_mgr, True):
                return
        else:
            player_mgr.group_manager = GroupManager(player_mgr)
            if not player_mgr.group_manager.try_add_member(target_player_mgr, True):
                return

        name_bytes = PacketWriter.string_to_bytes(player_mgr.player.name)
        data = pack(
            f'<{len(name_bytes)}s',
            name_bytes,
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_INVITE, data)
        target_player_mgr.session.enqueue_packet(packet)

        GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player_mgr.player.name, PartyResults.ERR_PARTY_RESULT_OK)

    @staticmethod
    def send_group_operation_result(player, group_operation, name, result):
        name_bytes = PacketWriter.string_to_bytes(name)
        data = pack(
            f'<I{len(name_bytes)}sI',
            group_operation,
            name_bytes,
            result,
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_PARTY_COMMAND_RESULT, data)
        player.session.enqueue_packet(packet)
