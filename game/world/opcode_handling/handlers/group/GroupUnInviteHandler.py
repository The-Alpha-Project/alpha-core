from network.packet.PacketReader import *
from game.world.managers.objects.player.GroupManager import GroupManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from utils.constants.GroupCodes import PartyOperation as Po, PartyResult as Pr


class GroupUnInviteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)

        if not target_player_mgr:
            GroupManager.send_group_operation_result(world_session.player_mgr, Po.PARTY_OP_LEAVE, '', Pr.ERR_BAD_PLAYER_NAME_S)
            return 0
        elif world_session.player_mgr.group_manager:
            world_session.player_mgr.group_manager.un_invite_player(world_session.player_mgr, target_player_mgr)
        return 0
