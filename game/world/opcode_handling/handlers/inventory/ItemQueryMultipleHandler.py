from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager


class ItemQueryMultipleHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty multiple item query packet.
            requested_item_count = unpack('<I', reader.data[:4])[0]
            if requested_item_count:
                item_templates = []
                for requested_item in range(requested_item_count):
                    entry = unpack('<I', reader.data[4 + (requested_item_count * 4):4])[0]
                    item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
                    if item_template:
                        item_templates.append(item_template)

                if item_templates:
                    packets = ItemManager.get_item_query_packets(item_templates)
                    world_session.enqueue_packets(packets)
        return 0
