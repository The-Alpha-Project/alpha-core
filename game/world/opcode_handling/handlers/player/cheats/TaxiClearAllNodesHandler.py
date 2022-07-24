from network.packet.PacketReader import *
from utils.Logger import Logger


class TaxiClearAllNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to clear all taxi nodes.')
            return 0

        player_mgr.taxi_manager.disable_all_taxi_nodes()

        return 0
