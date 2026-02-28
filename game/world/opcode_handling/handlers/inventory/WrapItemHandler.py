from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags


class WrapItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty open item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        wrapper_container_slot, wrapper_item_slot, item_container_slot, item_slot = unpack('<4B', reader.data[:4])

        if wrapper_container_slot == 0xFF:
            wrapper_container_slot = InventorySlots.SLOT_INBACKPACK.value

        if item_container_slot == 0xFF:
            item_container_slot = InventorySlots.SLOT_INBACKPACK.value

        inventory = player_mgr.inventory

        # Wrapping Paper.
        wrapper_item = inventory.get_item(wrapper_container_slot, wrapper_item_slot)
        if not wrapper_item:
            inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return 0

        # To wrap item.
        to_wrap_item = inventory.get_item(item_container_slot, item_slot)
        if not to_wrap_item:
            inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return 0

        if to_wrap_item.item_instance.stackcount > 1:  # Stackable.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_STACKABLE)
            return 0

        if to_wrap_item.is_equipped():  # Equipped.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_EQUIPPED)
            return 0

        if to_wrap_item.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_WRAPPED:  # Already wrapped.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_WRAPPED)
            return 0

        if to_wrap_item.is_container():  # Bag.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_BAGS)
            return 0

        if to_wrap_item.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_BOUND:  # Soulbound.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_BOUND)
            return 0

        if to_wrap_item.item_template.max_count > 0:  # Unique.
            inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_UNIQUE)
            return 0

        if player_mgr.spell_manager.is_casting():  # Prevent wrap while cast.
            inventory.send_equip_error(InventoryError.BAG_ERROR)
            return 0

        if to_wrap_item.set_wrapped(player_mgr, wrapper_item.item_template.entry):  # Actual wrap succeeds.
            # Remove wrapper item stack or item.
            inventory.remove_from_container_by_slots(wrapper_container_slot, wrapper_item_slot, item_count=1)
            return 0

        # Wrap call failed.
        inventory.send_equip_error(InventoryError.BAG_ERROR)

        return 0
