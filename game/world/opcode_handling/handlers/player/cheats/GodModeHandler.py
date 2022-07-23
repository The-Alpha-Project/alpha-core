from game.world.managers.objects.units.player.ChatManager import ChatManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger


class GodModeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to set god mode.')
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty god mode packet.
            player_mgr.is_god = unpack('<B', reader.data[:1])[0] >= 1
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GODMODE, reader.data[:1]))
            ChatManager.send_system_message(world_session, f'GodMode: {player_mgr.is_god}')

        return 0
