class GroupInviteAcceptHandler:

    @staticmethod
    def handle(world_session, reader):
        if not world_session.player_mgr.group_manager:
            return 0

        world_session.player_mgr.group_manager.remove_member_invite(world_session.player_mgr.guid)
        world_session.player_mgr.group_manager.try_add_member(world_session.player_mgr, False)

        return 0
