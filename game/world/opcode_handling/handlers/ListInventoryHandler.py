from struct import pack, unpack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class ListInventoryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty ping packet
            npc_guid = unpack('<Q', reader.data[:8])[0]

            if npc_guid > 0:
                vendor = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, npc_guid)
                if vendor:
                    vendor.send_inventory_list(world_session)

        return 0
