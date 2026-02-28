from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from utils.constants.ItemCodes import InventorySlots, InventoryError, InventoryTypes


class AutoequipItemHandler:
    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty autoequip item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        source_bag_slot, source_slot = unpack('<2B', reader.data[:2])

        if source_bag_slot == 0xFF:
            source_bag_slot = InventorySlots.SLOT_INBACKPACK.value

        inventory = world_session.player_mgr.inventory
        source_container = inventory.get_container(source_bag_slot)
        source_item = inventory.get_item(source_bag_slot, source_slot)
        if not source_container or not source_item:
            return 0

        inv_type = source_item.item_template.inventory_type
        target_slot = inventory.get_next_available_slot_for_inv_type(inv_type)

        # Equipment (excluding bags) can be swapped in with autoequip.
        # If there's no available slot (target_slot == -1), swap into default equip slot
        if target_slot == -1 and inv_type != InventoryTypes.NONE_EQUIP and inv_type != InventoryTypes.BAG:
            target_slot = source_item.equip_slot

        target_bag_slot = InventorySlots.SLOT_INBACKPACK.value
        if target_slot == -1 or inv_type == InventoryTypes.NONE_EQUIP or \
                inv_type == InventoryTypes.AMMO:  # unequippable item or no free bag slot for bag autoequip
            inventory.send_equip_error(InventoryError.BAG_NOT_EQUIPPABLE, source_item, None)
            return 0
        inventory.swap_item(source_bag_slot, source_slot, target_bag_slot, target_slot)
        return 0
