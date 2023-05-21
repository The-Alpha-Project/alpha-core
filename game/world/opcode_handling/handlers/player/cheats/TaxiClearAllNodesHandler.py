from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.Logger import Logger


class TaxiClearAllNodesHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to clear all taxi nodes.')
            return 0

        player_mgr.taxi_manager.disable_all_taxi_nodes()

        return 0
