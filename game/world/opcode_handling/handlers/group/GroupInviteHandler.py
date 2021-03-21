from network.packet.PacketReader import *
from game.world.managers.objects.player.GroupManager import GroupManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from utils.constants.GroupCodes import PartyOperation as Po, PartyResult as Pr


class GroupInviteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        target_name = PacketReader.read_string(reader.data, 0).strip()
        target_player_mgr = WorldSessionStateHandler.find_player_by_name(target_name)

        if target_player_mgr:
            GroupManager.invite_player(world_session.player_mgr, target_player_mgr)
        else:
            GroupManager.send_group_operation_result(world_session.player_mgr, Po.PARTY_OP_INVITE, target_name,
                                                     Pr.ERR_BAD_PLAYER_NAME_S)
        return 0
