from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemQueryDetailCache import ItemQueryDetailCache


class ItemQuerySingleHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty item query packet.
            entry = unpack('<I', reader.data[:4])[0]
            if entry > 0:
                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
                if item_template:
                    query_packet = ItemQueryDetailCache.get_item_detail_query(item_template)
                    world_session.enqueue_packet(query_packet)

        return 0
