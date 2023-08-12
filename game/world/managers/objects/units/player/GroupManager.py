from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import Group, GroupMember
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.Formulas import Distances
from utils.constants.GroupCodes import PartyOperations, PartyResults
from utils.constants.MiscCodes import WhoPartyStatus, LootMethods, PlayerFlags
from utils.constants.OpCodes import OpCode

MAX_GROUP_SIZE = 5
GROUPS = {}


# TODO: 0.5.3 has no SMSG_LOOT_MASTER_LIST nor CMSG_LOOT_MASTER_GIVE, how exactly they handled ML?
class GroupManager(object):
    def __init__(self, group):
        self.group = group
        self.members: dict[int, GroupMember] = {}
        self.invites = {}
        self.allowed_looters = {}
        self.last_group_update = 0
        self._last_looter = None  # For Round Robin, cycle will start at leader.
        self.instance_tokens = {}

    def load_group_members(self):
        members = RealmDatabaseManager.group_get_members(self.group)
        for member in members:
            # If this member is no longer available on the database, remove it.
            if not RealmDatabaseManager.character_get_by_guid(member.guid):
                RealmDatabaseManager.group_remove_member(member)
            else:
                self.members[member.guid] = member

        # If this group is no longer valid, destroy it.
        if len(self.members) < 2:
            RealmDatabaseManager.group_destroy(self.group)
            return False
        return True

    # When player sends an invite, a GroupManager is created, that doesn't mean the party actually exists until
    # the other player accepts the invitation.
    def is_party_formed(self):
        return len(self.members) > 1

    def has_instance_token(self, map_id):
        return map_id in self.instance_tokens

    def get_instance_token(self, map_id):
        if not self.has_instance_token(map_id):
            return 0
        return self.instance_tokens[map_id]

    def add_instance_token(self, map_id, token):
        self.instance_tokens[map_id] = token

    def get_leader_guid(self):
        return self.group.leader_guid

    # When on a group, members should no longer hold individual tokens to the same map-instance_id kvp.
    def update_instance_token_for_members(self, instance_token):
        from game.world.managers.maps.InstancesManager import InstancesManager
        for guid, member in list(self.members.items()):
            member_instance_token = InstancesManager.get_instance_token_for_player_guid(guid, instance_token.map_id)
            if member_instance_token and member_instance_token.id == instance_token.id:
                InstancesManager.remove_token_for_player(guid, member_instance_token)

    # TODO, check if ordering becomes an issue cause of using dictionary for members.
    def get_member_at(self, index):
        for idx, member in enumerate(list(self.members.keys())):
            if index == idx:
                player_mgr = WorldSessionStateHandler.find_player_by_guid(member)
                return player_mgr if player_mgr else None
        return None

    def try_add_member(self, player_mgr, invite):
        # Check if we have space.
        if self.is_full():
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, '',
                                                     PartyResults.ERR_GROUP_FULL)
            return False

        if invite:
            self.invites[player_mgr.guid] = player_mgr
            player_mgr.group_manager = self
            player_mgr.has_pending_group_invite = True
            return True
        else:
            if len(self.members) == 0:  # Party just formed, store the group and params.
                leader_player = WorldSessionStateHandler.find_player_by_guid(self.group.leader_guid)
                if leader_player:  # If online, we set leader group status.
                    RealmDatabaseManager.group_create(self.group)
                    GROUPS[self.group.group_id] = self
                    leader = GroupManager._create_new_member(self.group, leader_player)
                    RealmDatabaseManager.group_add_member(leader)
                    self.members[self.group.leader_guid] = leader
                    leader_player.group_status = WhoPartyStatus.WHO_PARTY_STATUS_IN_PARTY
                    GroupManager._set_leader_flag(leader)
                else:  # Leader went offline after sending the invite.
                    return False

            new_member = GroupManager._create_new_member(self.group, player_mgr)
            new_member = RealmDatabaseManager.group_add_member(new_member)
            self.members[player_mgr.guid] = new_member

            # Update newly added member group_manager ref, party status and pending invite flag.
            player_mgr.group_manager = self
            player_mgr.group_status = WhoPartyStatus.WHO_PARTY_STATUS_IN_PARTY
            player_mgr.has_pending_group_invite = False

            query_details_packet = NameQueryHandler.get_query_details(player_mgr.player)
            self.send_packet_to_members(query_details_packet)

            if len(self.members) > 1:
                self.send_update()

            return True

    def is_full(self):
        return len(self.members) == MAX_GROUP_SIZE

    def set_leader(self, player_guid):
        # First, demote previous leader.
        GroupManager._remove_leader_flag(self.members[self.group.leader_guid])
        # Second, promote new leader.
        GroupManager._set_leader_flag(self.members[player_guid])
        self.group.leader_guid = player_guid
        RealmDatabaseManager.group_update(self.group)

        leader_name_bytes = PacketWriter.string_to_bytes(self.members[player_guid].character.name)
        data = pack(f'<{len(leader_name_bytes)}s', leader_name_bytes)
        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_SET_LEADER, data)
        self.send_packet_to_members(packet)
        self.send_update()

    def set_loot_method(self, loot_method, master_looter_guid=None):
        self.group.loot_method = int(loot_method)
        self.group.loot_master = master_looter_guid if master_looter_guid else 0
        RealmDatabaseManager.group_update(self.group)
        self.send_update()

    def send_update(self):
        for member in list(self.members.keys()):
            player_mgr = WorldSessionStateHandler.find_player_by_guid(member)
            if player_mgr:
                player_mgr.enqueue_packet(self._build_group_list(player_mgr))

        self.send_party_members_stats()

    # TODO: Status flag (Online/Offline) is not working, we might have something wrong in the pkt structure.
    def _build_group_list(self, player_mgr):
        leader_name_bytes = PacketWriter.string_to_bytes(self.members[self.group.leader_guid].character.name)
        leader = WorldSessionStateHandler.find_player_by_guid(self.group.leader_guid)
        #  Members excluding self unless self == leader
        member_count = len(self.members) if player_mgr.guid == self.group.leader_guid else len(self.members) - 1

        # Header
        data = bytearray(pack(
            f'<I{len(leader_name_bytes)}sQB',
            member_count,
            leader_name_bytes,
            self.group.leader_guid,
            1 if leader and leader.online else 0
        ))

        # Fill all group members except self or leader.
        for member in list(self.members.values()):
            if member.guid == self.group.leader_guid or member.guid == player_mgr.guid:
                continue

            member_player = WorldSessionStateHandler.find_player_by_guid(member.guid)
            member_name_bytes = PacketWriter.string_to_bytes(member.character.name)

            data.extend(pack(
                f'<{len(member_name_bytes)}sQB',
                member_name_bytes,
                member.guid,
                1 if member_player and member_player.online else 0
            ))

        data.extend(pack(
            '<BQ',
            self.group.loot_method,
            self.group.loot_master  # Master Looter guid
        ))

        return PacketWriter.get_packet(OpCode.SMSG_GROUP_LIST, data)

    def update_party_member_stats(self, elapsed, requester=None):
        self.last_group_update += elapsed
        # Every 500ms.
        if self.last_group_update >= 0.5:
            self.send_party_members_stats(requester)
            self.last_group_update = 0

    def send_party_members_stats(self, requester=None):
        for member in list(self.members.values()):
            if requester and requester.guid != member.guid:
                continue
            # Send member stats to everyone except the member itself.
            self.send_packet_to_members(GroupManager._build_party_member_stats(member), exclude=member)

    def leave_party(self, player_guid, force_disband=False, is_kicked=False):
        disband = player_guid == self.group.leader_guid or len(self.members) == 2 or force_disband
        was_formed = self.is_party_formed()

        #  Group was disbanded before even existing.
        if disband and player_guid == self.group.leader_guid and len(self.members) == 0:
            leader_player = WorldSessionStateHandler.find_player_by_guid(self.group.leader_guid)
            if leader_player:
                leader_player.group_manager = None
                leader_player.has_pending_invite = False
        else:
            for member in list(self.members.values()):  # Avoid mutability.
                if disband or member.guid == player_guid:
                    member_player = WorldSessionStateHandler.find_player_by_guid(member.guid)
                    if member_player:
                        member_player.has_pending_group_invite = False
                        member_player.group_manager = None
                        member_player.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY

                    if member.guid == self.group.leader_guid:
                        GroupManager._remove_leader_flag(member)

                    if not disband:
                        self._set_previous_looter(member.guid)

                    RealmDatabaseManager.group_remove_member(member)
                    self.members.pop(member.guid)

                    if was_formed and member_player and disband and not is_kicked and member.guid != player_guid:
                        disband_packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_DESTROYED)
                        member_player.enqueue_packet(disband_packet)
                    elif was_formed and member_player and disband and member.guid != player_guid:
                        disband_packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_DESTROYED)
                        member_player.enqueue_packet(disband_packet)
                    elif was_formed and member_player and not is_kicked:
                        GroupManager.send_group_operation_result(member_player, PartyOperations.PARTY_OP_LEAVE, member_player.get_name(),
                                                                 PartyResults.ERR_PARTY_RESULT_OK)
                    # 'You have been removed from the group.' message.
                    if member_player and is_kicked and member.guid == player_guid:
                        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_UNINVITE)
                        member_player.enqueue_packet(packet)

        if disband:
            self.flush()
        else:
            self.send_update()

        return disband

    def un_invite_player(self, player_guid, target_player_guid):
        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
        if not player_mgr:
            return
        if target_player_guid not in self.members:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return
        elif self.group.leader_guid != player_guid:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_LEADER)
            return

        self.leave_party(target_player_guid, is_kicked=True)

    def set_party_leader(self, player_guid, target_player_guid):
        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
        if not player_mgr:
            return

        if target_player_guid not in self.members:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return
        elif self.group.leader_guid != player_guid:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '', PartyResults.ERR_NOT_LEADER)
            return

        self.set_leader(target_player_guid)

    def remove_invitation(self, player_guid):
        if player_guid in self.invites:
            self.invites.pop(player_guid, None)

        player_mgr = WorldSessionStateHandler.find_player_by_guid(player_guid)
        if player_mgr:
            player_mgr.has_pending_group_invite = False
            player_mgr.group_manager = None
            player_mgr.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY

        if len(self.members) <= 1 and len(self.invites) == 0:
            self.leave_party(self.group.leader_guid, force_disband=True)

    def remove_member_invite(self, player_guid):
        if player_guid in self.invites:
            self.invites.pop(player_guid, None)

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

    def is_party_member(self, player_guid):
        return player_guid in self.members

    def get_close_members(self, requester):
        close_members = []
        for guid in [*self.members]:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(guid)
            if self.is_close_member(requester, player_mgr):
                close_members.append(player_mgr)
        return close_members

    # noinspection PyMethodMayBeStatic
    def is_close_member(self, requester, player_mgr):
        return requester and player_mgr and player_mgr.online and requester.map_id == player_mgr.map_id and \
               requester.location.distance(player_mgr.location) < Distances.GROUP_SHARING_DISTANCE

    def reward_group_reputation(self, requester, creature):
        for player_mgr in self.get_close_members(requester):
            player_mgr.reward_reputation_on_kill(creature)

    def reward_quest_completion(self, requester, quest_entry):
        for player_mgr in self.get_close_members(requester):
            if quest_entry not in player_mgr.quest_manager.active_quests:
                continue
            player_mgr.quest_manager.active_quests[quest_entry].set_explored_or_event_complete()
            player_mgr.quest_manager.reward_quest_event()

    def fail_quest_for_group(self, requester, quest_entry):
        for player_mgr in self.get_close_members(requester):
            if quest_entry in player_mgr.quest_manager.active_quests:
                player_mgr.quest_manager.fail_quest_by_id(quest_entry)

    def reward_group_money(self, looter, creature):
        close_members = self.get_close_members(looter)
        if len(close_members) < 2:
            return False

        share = int(creature.loot_manager.current_money / len(close_members))
        if share < 1:
            return False

        # Notify the money looter with 'You distribute <coinage> to your party' message.
        data = pack('<QI', looter.guid, int(creature.loot_manager.current_money))
        split_packet = PacketWriter.get_packet(OpCode.MSG_SPLIT_MONEY, data)
        looter.enqueue_packet(split_packet)

        # Append div remainder to the player who killed the creature for now.
        remainder = int(creature.loot_manager.current_money % len(close_members))

        for player_mgr in close_members:
            player_share = share if player_mgr != creature.killed_by else share + remainder
            data = pack('<I', player_share)
            player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_MONEY_NOTIFY, data))
            player_mgr.mod_money(player_share)
            player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_CLEAR_MONEY))

        creature.loot_manager.clear_money()
        return True

    def reward_group_xp(self, requester, creature, is_elite):
        close_members = self.get_close_members(requester)
        highest_level = requester.level
        level_sum = 0
        # Need to loop first through all members in order to find the highest level one and the total sum of levels.
        for player_mgr in close_members:
            if player_mgr.level > highest_level:
                highest_level = player_mgr.level
            level_sum += player_mgr.level

        # Calculate base XP based on the player with the highest level.
        base_xp = Formulas.CreatureFormulas.xp_reward(creature.level, highest_level, is_elite)

        # Iterate again over member players in order to award XP.
        for player_mgr in close_members:
            player_mgr.give_xp([base_xp * player_mgr.level / level_sum], creature)

    def reward_group_creature_or_go(self, requester, creature):
        close_members = self.get_close_members(requester)
        # Party kill log packet, not sure how to display on client but, it is handled.
        data = pack('<2Q', requester.guid, creature.guid)  # Player with killing blow and victim guid.
        kill_log_packet = PacketWriter.get_packet(OpCode.SMSG_PARTYKILLLOG, data)

        for player_mgr in close_members:
            player_mgr.enqueue_packet(kill_log_packet)
            player_mgr.quest_manager.reward_creature_or_go(creature)

    def send_invite_decline(self, player_name):
        player_mgr = WorldSessionStateHandler.find_player_by_guid(self.group.leader_guid)
        if player_mgr:
            name_bytes = PacketWriter.string_to_bytes(player_name)
            data = pack(
                f'<{len(name_bytes)}s',
                name_bytes
            )

            packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_DECLINE, data)
            player_mgr.enqueue_packet(packet)

    def send_packet_to_members(self, packet, ignore=None, source=None, use_ignore=False, exclude=None,
                               surrounding_only=False):
        for member in [*self.members.values()]:
            if exclude and member.guid == exclude.guid:
                continue

            player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
            if surrounding_only and source and not self.is_close_member(source, player_mgr):
                continue
            if not player_mgr or not player_mgr.online:
                continue
            if ignore and player_mgr.guid in ignore:
                continue
            if use_ignore and source and player_mgr.friends_manager.has_ignore(source.guid):
                continue

            player_mgr.enqueue_packet(packet)

    def send_minimap_ping(self, guid, x, y):
        self.send_packet_to_members(PacketWriter.get_packet(OpCode.MSG_MINIMAP_PING, pack('<Q2f', guid, x, y)))

    def flush(self):
        if self.group.group_id in GROUPS:
            GROUPS.pop(self.group.group_id)
            RealmDatabaseManager.group_destroy(self.group)
        self.members.clear()
        self.allowed_looters.clear()
        self.invites.clear()
        self.instance_tokens.clear()
        self.group = None
        self._last_looter = None

    def _fill_allowed_looters(self):
        if self.group.loot_method == LootMethods.LOOT_METHOD_MASTERLOOTER:
            return [self.group.loot_master]
        elif self.group.loot_method == LootMethods.LOOT_METHOD_FREEFORALL:
            return list(self.members.keys())
        elif self.group.loot_method == LootMethods.LOOT_METHOD_ROUNDROBIN:
            if not self._last_looter:
                self._last_looter = self.group.leader_guid
                return [self._last_looter]
            return [self._get_next_looter(self._last_looter)]
        return []

    def _set_previous_looter(self, player_guid):
        _list = list(self.members.keys())
        _index = list.index(_list, player_guid)

        if _index - 1 >= 0:
            self._last_looter = _list[_index - 1]
        else:
            self._last_looter = _list[-1]

    def _get_next_looter(self, player_guid):
        _list = list(self.members.keys())
        _index = list.index(_list, player_guid)

        if _index + 1 < len(_list):
            self._last_looter = _list[_index + 1]
            return _list[_index + 1]
        else:
            self._last_looter = _list[0]
            return _list[0]

    @staticmethod
    def load_group(raw_group):
        group_manager = GroupManager(raw_group)
        if group_manager.load_group_members():
            GROUPS[raw_group.group_id] = group_manager

    @staticmethod
    def set_character_group(player_mgr):
        group_id = RealmDatabaseManager.character_get_group_id(player_mgr.player)
        if group_id >= 0 and group_id in GROUPS:
            player_mgr.group_manager = GROUPS[group_id]

    @staticmethod
    def invite_player(player_mgr, target_player):
        if player_mgr.is_hostile_to(target_player):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_player.get_name(), PartyResults.ERR_PLAYER_WRONG_FACTION)
            return

        if target_player.friends_manager.has_ignore(player_mgr.guid):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_player.get_name(), PartyResults.ERR_IGNORING_YOU_S)
            return

        if target_player.group_manager and target_player.group_manager.is_party_formed():
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_player.get_name(), PartyResults.ERR_ALREADY_IN_GROUP_S)
            return

        if player_mgr.group_manager:
            if player_mgr.group_manager.group.leader_guid != player_mgr.guid:
                GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                         target_player.get_name(), PartyResults.ERR_NOT_LEADER)
                return

            if player_mgr.group_manager.is_full():
                GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                         target_player.get_name(), PartyResults.ERR_GROUP_FULL)
                return

            if not player_mgr.group_manager.try_add_member(target_player, True):
                return
        else:
            new_group = GroupManager._create_group(player_mgr)
            player_mgr.group_manager = GroupManager(new_group)
            if not player_mgr.group_manager.try_add_member(target_player, invite=True):
                return

        target_player.has_pending_group_invite = True
        name_bytes = PacketWriter.string_to_bytes(player_mgr.get_name())
        data = pack(
            f'<{len(name_bytes)}s',
            name_bytes
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_GROUP_INVITE, data)
        target_player.enqueue_packet(packet)

        GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, target_player.get_name(), PartyResults.ERR_PARTY_RESULT_OK)

    @staticmethod
    def send_group_operation_result(player, group_operation, name, result):
        name_bytes = PacketWriter.string_to_bytes(name)
        data = pack(
            f'<I{len(name_bytes)}sI',
            group_operation,
            name_bytes,
            result
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_PARTY_COMMAND_RESULT, data)
        player.enqueue_packet(packet)

    @staticmethod
    def _set_leader_flag(member):
        player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
        if player_mgr:
            player_mgr.set_extra_flag(PlayerFlags.PLAYER_FLAGS_GROUP_LEADER)

    @staticmethod
    def _remove_leader_flag(member):
        player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
        if player_mgr:
            player_mgr.set_extra_flag(PlayerFlags.PLAYER_FLAGS_GROUP_LEADER, False)

    @staticmethod
    def _create_group(player_mgr):
        new_group = Group()
        new_group.leader_guid = player_mgr.guid
        new_group.loot_master = 0  # Guid
        new_group.loot_method = 0  # FreeForAll
        return new_group

    @staticmethod
    def _create_new_member(group, player_mgr):
        new_member = GroupMember()
        new_member.group_id = group.group_id
        new_member.guid = player_mgr.guid
        return new_member

    @staticmethod
    def _build_party_member_stats(group_member):
        from game.world.managers.maps.MapManager import MapManager
        player_mgr = WorldSessionStateHandler.find_player_by_guid(group_member.guid)
        character = None

        # If player is offline, build stats based on db information.
        if not player_mgr or not player_mgr.online:
            player_mgr = None
            character = RealmDatabaseManager.character_get_by_guid(group_member.guid)

        data = pack(
            '<Q2IB6I3f',
            player_mgr.guid if player_mgr else character.guid,
            player_mgr.health if player_mgr else 0,
            player_mgr.max_health if player_mgr else 0,
            player_mgr.power_type if player_mgr else 0,
            player_mgr.get_power_value() if player_mgr else 0,
            player_mgr.get_max_power_value() if player_mgr else 0,
            player_mgr.level if player_mgr else character.level,
            player_mgr.map_id if player_mgr else character.map,
            # Client expects an AreaNumber from AreaTable, not a zone id.
            MapManager.get_area_number_by_zone_id(player_mgr.zone if player_mgr else character.zone),
            player_mgr.class_ if player_mgr else character.class_,
            player_mgr.location.x if player_mgr else character.position_x,
            player_mgr.location.y if player_mgr else character.position_y,
            player_mgr.location.z if player_mgr else character.position_z,
        )

        return PacketWriter.get_packet(OpCode.SMSG_PARTY_MEMBER_STATS, data)
