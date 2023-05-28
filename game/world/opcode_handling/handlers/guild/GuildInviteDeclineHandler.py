from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class GuildInviteDeclineHandler(object):

    @staticmethod
    def handle(world_session, reader):
        player_mgr = world_session.player_mgr

        if player_mgr.guid in GuildManager.PENDING_INVITES:
            inviter = GuildManager.PENDING_INVITES[player_mgr.guid].inviter
            GuildManager.PENDING_INVITES.pop(player_mgr.guid)

            inviter_name_bytes = PacketWriter.string_to_bytes(inviter.get_name())
            data = pack(
                f'<{len(inviter_name_bytes)}s',
                inviter_name_bytes
            )

            inviter.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GUILD_DECLINE, data))

        return 0
