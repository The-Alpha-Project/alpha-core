from network.packet.PacketWriter import *
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand


class GuildInviteDeclineHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr

        if player_mgr.guid in GuildManager.PENDING_INVITES:
            inviter = GuildManager.PENDING_INVITES[player_mgr.guid].inviter
            GuildManager.PENDING_INVITES.pop(player_mgr.guid)

            inviter_name_bytes = PacketWriter.string_to_bytes(inviter.player.name)
            data = pack(
                f'<{len(inviter_name_bytes)}s',
                inviter_name_bytes,
            )

            inviter.session.send_message(PacketWriter.get_packet(OpCode.SMSG_GUILD_DECLINE, data))

        return 0
