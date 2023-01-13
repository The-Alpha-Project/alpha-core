from game.world.managers.CommandManager import CommandManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.Logger import Logger


class TeleportToPlayerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not player_mgr.session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to port to a player.')
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty teleport to player packet.
            player_name: str = PacketReader.read_string(reader.data, 0)
            result = CommandManager.goplayer(world_session, player_name)

            if result[0] == -1:
                CommandManager.tel(world_session, player_name)

        return 0
