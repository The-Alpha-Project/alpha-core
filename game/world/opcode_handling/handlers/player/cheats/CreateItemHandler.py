from game.world.managers.CommandManager import CommandManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger

from network.packet.PacketReader import *


class CreateItemHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried create item.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty create item packet.
            item_entry = unpack('<I', reader.data[:4])[0]
            CommandManager.additem(world_session, str(item_entry))

        return 0
