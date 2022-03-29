from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger


class GodModeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 1:  # Avoid handling empty god mode packet.
            if not world_session.player_mgr.is_gm:
                Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to set godmode.')
                return 0

            world_session.player_mgr.is_god = unpack('<B', reader.data[:1])[0] >= 1
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_GODMODE, reader.data[:1]))

        return 0
