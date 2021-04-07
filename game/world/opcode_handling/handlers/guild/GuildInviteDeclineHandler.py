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
                '<%us' % len(inviter_name_bytes),
                inviter_name_bytes,
            )

            inviter.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_GUILD_DECLINE, data))

        return 0