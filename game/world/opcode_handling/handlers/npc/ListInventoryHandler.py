from struct import unpack

from game.world.managers.maps.MapManager import MapManager


class ListInventoryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty list inventory packet.
            npc_guid = unpack('<Q', reader.data[:8])[0]

            if npc_guid > 0:
                vendor = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, npc_guid)
                if vendor and vendor.is_within_interactable_distance(world_session.player_mgr):
                    vendor.send_inventory_list(world_session)

        return 0
