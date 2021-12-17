from network.packet.PacketReader import *
from utils.Logger import Logger


class TaxiClearAllNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.is_gm:  # GM only.
            world_session.player_mgr.taxi_manager.disable_all_taxi_nodes()
        else:
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to clear all there known taxi nodes.')

        return 0
