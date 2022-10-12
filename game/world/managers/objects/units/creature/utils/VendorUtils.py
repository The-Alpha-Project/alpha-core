from struct import pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class VendorUtils:

    @staticmethod
    def send_inventory_list(creature_mgr, player_mgr):
        vendor_data, session = WorldDatabaseManager.creature_get_vendor_data(creature_mgr.entry)
        item_count = len(vendor_data) if vendor_data else 0

        data = pack(
            '<QB',
            creature_mgr.guid,
            item_count
        )

        if item_count == 0:
            data += pack('<B', 0)
        else:
            item_templates = []
            for count, vendor_data_entry in enumerate(vendor_data):
                data += pack(
                    '<7I',
                    count + 1,  # m_muid, acts as slot counter.
                    vendor_data_entry.item,
                    vendor_data_entry.item_template.display_id,
                    0xFFFFFFFF if vendor_data_entry.maxcount <= 0 else vendor_data_entry.maxcount,
                    vendor_data_entry.item_template.buy_price,
                    vendor_data_entry.item_template.max_durability,  # Max durability (not implemented in 0.5.3).
                    vendor_data_entry.item_template.buy_count  # Stack count.
                )
                item_templates.append(vendor_data_entry.item_template)

            # Send all vendor item query details.
            player_mgr.enqueue_packets(ItemManager.get_item_query_packets(item_templates))

        session.close()
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LIST_INVENTORY, data))