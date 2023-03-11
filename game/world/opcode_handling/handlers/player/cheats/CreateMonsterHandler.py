from game.world.managers.CommandManager import CommandManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger

from network.packet.PacketReader import *


class CreateMonsterHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried create monster.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty create monster packet.
            creature_entry = unpack('<I', reader.data[:4])[0]
            CommandManager.createmonster(world_session, str(creature_entry))

        return 0
