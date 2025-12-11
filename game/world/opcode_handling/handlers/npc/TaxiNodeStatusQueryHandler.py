from struct import unpack

from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager


class TaxiNodeStatusQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty taxi node status query packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid <= 0:
                return 0

            node = TaxiManager.get_nearest_taxi_node(world_session.player_mgr)
            if node == -1:
                return 0

            world_session.player_mgr.taxi_manager.handle_node_status_query(guid, node)

        return 0
