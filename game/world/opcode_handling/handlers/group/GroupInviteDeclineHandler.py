class GroupInviteDeclineHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr
        if not player.group_manager:
            return 0

        if player.guid != player.group_manager.group.leader_guid:
            player.group_manager.send_invite_decline(player.player.name)

        player.group_manager.remove_invitation(player.guid)

        return 0
