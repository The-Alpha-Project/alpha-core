from game.world.opcode_handling.HandlerValidator import HandlerValidator


class GroupInviteAcceptHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        group_manager = player_mgr.group_manager
        if not group_manager:
            return 0

        group_manager.remove_member_invite(player_mgr.guid)
        # Group got full or the leader went offline, drop the invite state or the player can't be invited again.
        if not group_manager.try_add_member(player_mgr, False):
            group_manager.remove_invitation(player_mgr.guid)

        return 0
