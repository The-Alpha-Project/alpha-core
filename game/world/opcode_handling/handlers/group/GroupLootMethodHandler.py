from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupLootMethodHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty group loot method packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0
        loot_method, loot_master = unpack('<IQ', reader.data[:12])
        group_manager = player_mgr.group_manager

        if not group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)
            return 0

        if player_mgr.guid != group_manager.group.leader_guid:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     '', PartyResults.ERR_NOT_LEADER)
            return 0

        if loot_master <= 0:
            group_manager.set_loot_method(loot_method)
            return 0

        target_player_mgr = RealmDatabaseManager.character_get_by_guid(loot_master)
        if target_player_mgr:
            group_manager.set_loot_method(loot_method, master_looter_guid=target_player_mgr.guid)
            return 0

        group_manager.set_loot_method(loot_method)

        return 0
