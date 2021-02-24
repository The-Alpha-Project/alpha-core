from struct import unpack

from utils.constants.ItemCodes import InventorySlots, InventoryError, InventoryTypes


class AutoequipItemHandler(object):
    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty autoequip item packet
            source_bag_slot, source_slot = unpack('<2B', reader.data[:3])

            if source_bag_slot == 0xFF or source_bag_slot == InventorySlots.SLOT_BANK_END:
                source_bag_slot = InventorySlots.SLOT_INBACKPACK.value

            inventory = world_session.player_mgr.inventory
            source_container = inventory.get_container(source_bag_slot)
            source_item = inventory.get_item(source_bag_slot, source_slot)
            target_bag_slot = InventorySlots.SLOT_INBACKPACK.value

            if source_container and source_item:
                inv_type = source_item.item_template.inventory_type
                if inv_type == InventoryTypes.BAG:
                    target_slot = inventory.get_next_available_bag_slot().value
                else:
                    # If a main weapon already exists, equip this one in the offhand unless there's already one
                    if source_item.item_template.inventory_type == InventoryTypes.WEAPON and inventory.has_main_weapon() \
                            and not inventory.has_offhand():
                        target_slot = InventorySlots.SLOT_OFFHAND.value
                        source_item.equip_slot = InventorySlots.SLOT_OFFHAND.value
                    else:
                        target_slot = source_item.equip_slot
            else:
                # Something is really malfunctioning or client sent wrong data, try to reload the inventory
                world_session.player_mgr.set_dirty(is_dirty=True, dirty_inventory=True)
                return 0

            if target_slot == -1:
                # TODO Irrelevant error code, but only one that seems to not display anything to the client.
                inventory.send_equip_error(InventoryError.BAG_LOOT_GONE, source_item, None)
                return 0
            inventory.swap_item(source_bag_slot, source_slot, target_bag_slot, target_slot)

        return 0
