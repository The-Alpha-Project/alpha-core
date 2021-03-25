from network.packet.PacketReader import *
from game.world.managers.objects.player.GroupManager import GroupManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupUnInviteGuidHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty loot release packet
            guid = unpack('<Q', reader.data[:8])[0]
            target_player_mgr = WorldSessionStateHandler.find_player_by_guid(guid)

            if not target_player_mgr:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                         PartyResults.ERR_BAD_PLAYER_NAME_S)
            elif world_session.player_mgr.group_manager:
                world_session.player_mgr.group_manager.un_invite_player(world_session.player_mgr, target_player_mgr)

        return 0
