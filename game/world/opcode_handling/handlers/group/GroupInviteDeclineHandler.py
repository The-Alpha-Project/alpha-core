class GroupInviteDeclineHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr
        if not player.group_manager:
            return

        tmp_group_manager = player.group_manager
        player.group_manager.remove_invitation(player)

        if player == tmp_group_manager.party_leader:
            return 0

        tmp_group_manager.send_invite_decline(player.player.name)

        return 0
