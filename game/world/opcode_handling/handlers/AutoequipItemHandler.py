from struct import unpack

from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryError, InventoryTypes


class AutoequipItemHandler(object):
    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty sell item packet
            source_bag_slot, source_slot = unpack('<2B', reader.data[:3])

            if source_bag_slot == 255:
                source_bag_slot = InventorySlots.SLOT_INBACKPACK.value

            inventory = world_session.player_mgr.inventory
            source_container = inventory.containers[source_bag_slot]
            if not source_container:
                return 0
            source_item = inventory.get_item(source_bag_slot, source_slot)
            if not source_item:
                return 0

            inv_type = source_item.item_template.inventory_type
            # Seems to only work for bags.
            if inv_type == InventoryTypes.BAG:
                target_slot = inventory.get_next_available_bag_slot()
                target_bag_slot = InventorySlots.SLOT_INBACKPACK
            else:
                target_slot = -1
                target_bag_slot = -1

            if target_slot == -1 or target_bag_slot == -1:
                # TODO Irrelevant error code, but only one that seems to not display anything to the client.
                inventory.send_equip_error(InventoryError.BAG_LOOT_GONE, source_item, None)
                return 0
            inventory.swap_item(source_bag_slot, source_slot, target_bag_slot.value, target_slot.value)

        return 0
