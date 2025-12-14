from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class LevelCheatHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to modify level.')
            return 0

        if len(reader.data) >= 4:  # Avoid empty packet level cheat packet.
            new_level = unpack('<I', reader.data[:4])[0]
            player_mgr.mod_level(new_level)

        return 0
