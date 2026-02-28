from game.world.opcode_handling.HandlerValidator import HandlerValidator
from game.world.managers.objects.units.player.GroupManager import GroupManager
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupDisbandHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not player_mgr.group_manager:
            GroupManager.send_group_operation_result(player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                     PartyResults.ERR_NOT_IN_GROUP)
            return 0

        player_mgr.group_manager.leave_party(player_mgr.guid)

        return 0
