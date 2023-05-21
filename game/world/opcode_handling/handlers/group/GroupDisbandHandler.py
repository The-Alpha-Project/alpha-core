from game.world.managers.objects.units.player.GroupManager import GroupManager
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupDisbandHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.group_manager:
            GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)
        else:
            world_session.player_mgr.group_manager.leave_party(world_session.player_mgr.guid)

        return 0
