class GroupDisbandHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):

        if not world_session.player_mgr.group_manager:
            return

        world_session.player_mgr.group_manager.leave_party(world_session.player_mgr)
        return 0
