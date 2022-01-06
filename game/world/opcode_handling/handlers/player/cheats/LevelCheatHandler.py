from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class LevelCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid empty packet level cheat packet.
            new_level = unpack('<I', reader.data[:4])[0]
            if not world_session.player_mgr.is_gm:
                Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to level to {new_level}.')
                return 0

            world_session.player_mgr.mod_level(new_level)

        return 0
