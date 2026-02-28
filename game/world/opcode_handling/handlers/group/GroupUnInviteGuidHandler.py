from game.world.opcode_handling.HandlerValidator import HandlerValidator
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from network.packet.PacketReader import *
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupUnInviteGuidHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty group uninvite guid packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        target_player_mgr = RealmDatabaseManager.character_get_by_guid(guid)
        group_manager = player_mgr.group_manager

        if not group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)
            return 0

        if not target_player_mgr:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, 'Player',
                                                     PartyResults.ERR_BAD_PLAYER_NAME_S)
            return 0

        if not group_manager.is_party_member(target_player_mgr.guid):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE,
                                                     target_player_mgr.name,
                                                     PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            return 0

        group_manager.un_invite_player(player_mgr.guid, target_player_mgr.guid)

        return 0
