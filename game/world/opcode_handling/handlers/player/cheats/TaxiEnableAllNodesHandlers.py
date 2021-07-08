from network.packet.PacketReader import *


class TaxiEnableAllNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.is_gm:  # GM only.
            world_session.player_mgr.taxi_manager.enable_all_taxi_nodes()

        return 0
