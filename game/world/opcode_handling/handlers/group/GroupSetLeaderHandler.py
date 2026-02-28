from game.world.opcode_handling.HandlerValidator import HandlerValidator
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from network.packet.PacketReader import *
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupSetLeaderHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty Group Set Leader packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = RealmDatabaseManager.character_get_by_name(target_name)
        group_manager = player_mgr.group_manager

        if not group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)
            return 0

        if not target_player_mgr:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, target_name,
                                                     PartyResults.ERR_BAD_PLAYER_NAME_S)
            return 0

        if not group_manager.is_party_member(target_player_mgr.guid):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE,
                                                     target_name,
                                                     PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return 0

        group_manager.set_party_leader(player_mgr.guid, target_player_mgr.guid)

        return 0
