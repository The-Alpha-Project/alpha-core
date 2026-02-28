from game.world.opcode_handling.HandlerValidator import HandlerValidator
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.GroupManager import GroupManager
from network.packet.PacketReader import *
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupInviteHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res
        # Avoid handling an empty Group Invite packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)

        if player_mgr.has_pending_group_invite:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, '',
                                                     PartyResults.ERR_INVITE_RESTRICTED)
        elif player_mgr.group_manager and player_mgr.group_manager.is_full():
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE, '',
                                                     PartyResults.ERR_GROUP_FULL)
        elif not target_player_mgr:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_name, PartyResults.ERR_BAD_PLAYER_NAME_S)
        elif target_player_mgr.friends_manager.has_ignore(player_mgr.guid):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_name, PartyResults.ERR_IGNORING_YOU_S)
        elif target_player_mgr and (target_player_mgr.has_pending_group_invite or target_player_mgr.group_manager):
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_player_mgr.get_name(), PartyResults.ERR_ALREADY_IN_GROUP_S)
        elif target_player_mgr and target_player_mgr.guid == player_mgr.guid:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                     target_player_mgr.get_name(), PartyResults.ERR_INVITE_RESTRICTED)
        else:
            GroupManager.invite_player(player_mgr, target_player_mgr)

        return 0
