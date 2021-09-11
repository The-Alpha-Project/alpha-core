from struct import unpack
from game.world.managers.objects.units.player.taxi import TaxiManager


class TaxiQueryNodesHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty taxi query nodes packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid <= 0:
                return 0

            node = TaxiManager.get_nearest_taxi_node(world_session.player_mgr)
            if node == -1:
                return 0

            world_session.player_mgr.taxi_manager.handle_query_node(guid, node)

        return 0
