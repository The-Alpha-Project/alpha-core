from game.world.managers.CommandManager import CommandManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from network.packet.PacketReader import *



class DestroyMonsterHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_dev():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried destroy monster.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty destroy monster packet.
            creature_guid = unpack('<Q', reader.data[:8])[0]
            CommandManager.destroymonster(world_session, str(creature_guid))

        return 0
