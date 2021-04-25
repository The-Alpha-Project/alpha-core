class GroupInviteDeclineHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr
        if not player.group_manager:
            return

        if player != player.group_manager.party_leader:
            player.group_manager.send_invite_decline(player.player.name)

        player.group_manager.remove_invitation(player)

        return 0
