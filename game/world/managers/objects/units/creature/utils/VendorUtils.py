from struct import pack
from typing import Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.creature.vendors.VendorData import VendorData
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.MiscCodes import BuyResults
from utils.constants.OpCodes import OpCode


class VendorUtils:
    VENDOR_DATA = {}

    @staticmethod
    def get_vendor_data(creature_guid, item_entry) -> Optional[VendorData]:
        if creature_guid not in VendorUtils.VENDOR_DATA:
            return None
        if not VendorUtils.VENDOR_DATA[creature_guid].has_item_data(item_entry):
            return None
        return VendorUtils.VENDOR_DATA[creature_guid]

    @staticmethod
    def send_inventory_list(creature_mgr, player_mgr):
        # Initialize this vendor data if needed.
        if creature_mgr.guid not in VendorUtils.VENDOR_DATA:
            # Prioritize an inventory list specific for this creature.
            if creature_mgr.creature_template.vendor_id == 0:
                vendor_db_data = WorldDatabaseManager.creature_get_vendor_data(creature_mgr.entry)
            # Otherwise, try to load vendor template data.
            else:
                vendor_db_data = WorldDatabaseManager.creature_get_vendor_template_data(
                    creature_mgr.creature_template.vendor_id)

            if not vendor_db_data:
                Logger.error(f'No inventory found for vendor with entry {creature_mgr.entry}.')

            vendor_data = VendorData(vendor_db_data)
            VendorUtils.VENDOR_DATA[creature_mgr.guid] = vendor_data
        else:
            vendor_data = VendorUtils.VENDOR_DATA[creature_mgr.guid]

        item_templates = []
        items_data = bytearray()

        for count, item_entry in enumerate(vendor_data.get_vendor_items()):
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry.item)
            if item_template:
                items_data.extend(pack(
                    '<3i4I',
                    count + 1,  # m_muid, acts as slot counter.
                    item_template.entry,
                    item_template.display_id,
                    vendor_data.get_max_count(item_entry.item),
                    item_template.buy_price,
                    item_template.max_durability,  # Max durability (not implemented in 0.5.3).
                    item_template.buy_count  # Stack count.
                ))
                item_templates.append(item_template)
            else:
                Logger.warning(f'Vendor {creature_mgr.get_name()} has invalid item with entry {item_entry.item}')

        item_count = len(item_templates)
        if item_count == 0:
            items_data.extend(pack('<B', 0))

        data = pack(f'<QB{len(items_data)}s', creature_mgr.guid, item_count, items_data)

        # Send all vendor item query details.
        if item_count > 0:
            player_mgr.enqueue_packets(ItemManager.get_item_query_packets(item_templates))

        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LIST_INVENTORY, data))

    @staticmethod
    def handle_buy_item(player_mgr, vendor_guid, item_id, count, bag_guid=0, slot=0):
        vendor = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, vendor_guid)
        # Unable to locate vendor.
        if not vendor:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_DISTANCE_TOO_FAR, item_id, vendor_guid)
            return

        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_id)
        vendor_data = VendorUtils.get_vendor_data(vendor.guid, item_id)
        # Invalid item or vendor has no data for the given item.
        if not item_template or not vendor_data:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_CANT_FIND_ITEM, item_id, vendor_guid)
            return

        if count <= 0:
            count = 1

        total_cost = item_template.buy_price * count
        real_count = count if item_template.buy_count == 1 else item_template.buy_count

        if player_mgr.coinage < total_cost:
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_NOT_ENOUGH_MONEY, item_id, vendor.guid, real_count)
            return

        # Check if this is a depleted limited item.
        if vendor_data.is_limited_item(item_id) and vendor_data.is_limited_item_locked(item_id):
            player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_ITEM_SOLD_OUT, item_id, vendor.guid, real_count)
            return

        if bag_guid:
            bag_slot = player_mgr.inventory.get_container_slot_by_guid(bag_guid)
            succeed = player_mgr.inventory.add_item_to_slot(dest_bag_slot=bag_slot, dest_slot=slot,
                                                            item_template=item_template, count=real_count)
        else:
            succeed = player_mgr.inventory.add_item(item_template=item_template, count=real_count)

        # Don't continue if item was not successfully added to the inventory.
        if not succeed:
            return

        player_mgr.mod_money(total_cost * -1)
        if not vendor_data.is_limited_item(item_id):
            return

        vendor_data.update_limited_item(item_id, qty=count)
        # Available count changed, update vendor.
        vendor_slot = vendor_data.get_item_slot(item_id)
        max_count = vendor_data.get_max_count(item_id)
        data = pack('<Q3I', vendor.guid, vendor_slot, max_count, count)
        packet = PacketWriter.get_packet(OpCode.SMSG_BUY_ITEM, data)
        player_mgr.get_map().send_surrounding(packet, player_mgr)
