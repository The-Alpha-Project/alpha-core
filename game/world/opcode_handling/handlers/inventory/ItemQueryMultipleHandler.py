from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager


class ItemQueryMultipleHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty multiple item query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        requested_item_count = unpack('<I', reader.data[:4])[0]
        if not requested_item_count:
            return 0

        expected_size = 4 + requested_item_count * 4
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=expected_size):
            return 0

        item_templates = []
        for requested_item in range(requested_item_count):
            offset = 4 + (requested_item * 4)
            entry = unpack('<I', reader.data[offset:offset + 4])[0]
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
            if item_template:
                item_templates.append(item_template)

        if item_templates:
            packets = ItemManager.get_item_query_packets(item_templates)
            world_session.enqueue_packets(packets)
        return 0
