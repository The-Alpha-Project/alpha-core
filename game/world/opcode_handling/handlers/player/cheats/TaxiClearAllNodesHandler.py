from network.packet.PacketReader import *


class TaxiClearAllNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.is_gm:  # GM only.
            world_session.player_mgr.taxi_manager.disable_all_taxi_nodes()

        return 0
