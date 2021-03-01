from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import *


class ItemQuerySingleHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty item query packet
            entry = unpack('<I', reader.data[:4])[0]
            if entry > 0:
                item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
                if item_template:
                    item_mgr = ItemManager(
                        item_template=item_template
                    )
                    socket.sendall(item_mgr.query_details())

        return 0
