from network.packet.PacketWriter import *
from utils.constants.UnitCodes import Classes, Races
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.constants.ObjectCodes import GuildCommandResults, GuildTypeCommand
from utils.TextUtils import GameTextFormatter


class GuildRosterHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr

        if not player.guild_manager:
            GuildManager.send_guild_command_result(player, GuildTypeCommand.GUILD_CREATE_S, '',
                                                   GuildCommandResults.GUILD_PLAYER_NOT_IN_GUILD)
        else:
            guild_info = PacketWriter.string_to_bytes(player.guild_manager.guild_name)
            data = pack(
                '<%us' % len(guild_info),
                guild_info
            )

            # Members count
            data += pack('<I', len(player.guild_manager.members))
            # Todo: Accounts?
            data += pack('<I', 0)

            for member in player.guild_manager.members.values():
                area = WorldDatabaseManager.area_get_by_id(member.zone).name
                race = GameTextFormatter.race_to_text(member.player.race)
                class_ = GameTextFormatter.class_to_text(member.player.class_)
                player_info = '%s %s | Level %u %u %u, Zone: %s' % ('Online' if member.online else 'Offline',
                                                                    member.player.name, member.level, race, class_,
                                                                    area if area else member.zone)
                info_bytes = PacketWriter.string_to_bytes(player_info[:127])  # Max Length: 128)
                data += pack(
                    '<%usI' % len(info_bytes),
                    info_bytes,
                    member.guild_manager.get_guild_rank(member)
                )

            player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_GUILD_ROSTER, data))

        return 0
