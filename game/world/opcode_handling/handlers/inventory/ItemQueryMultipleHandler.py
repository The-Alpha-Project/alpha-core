from struct import unpack, pack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter, OpCode


class ItemQueryMultipleHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty multiple item query packet.
            requested_item_count = unpack('<I', reader.data[:4])[0]
            if requested_item_count:
                found_items = 0
                item_query_data = b''
                for requested_item in range(requested_item_count):
                    entry = unpack('<I', reader.data[4 + (requested_item_count * 4):4])[0]
                    item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
                    if item_template:
                        found_items += 1
                        item_query_data += ItemManager.generate_query_details_data(item_template)

                if found_items:
                    data = pack(f'<I{len(item_query_data)}s', found_items, item_query_data)
                    packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_MULTIPLE_RESPONSE, data)
                    world_session.enqueue_packet(packet)
        return 0
