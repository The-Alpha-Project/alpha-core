class FriendsListHandler:

    @staticmethod
    def handle(world_session, reader):
        world_session.player_mgr.friends_manager.send_friends_and_ignores()

        return 0
