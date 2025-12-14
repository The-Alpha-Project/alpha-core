from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags


class WrapItemHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty open item packet.
            wrapper_container_slot, wrapper_item_slot, item_container_slot, item_slot = unpack('<4B', reader.data[:4])

            if wrapper_container_slot == 0xFF:
                wrapper_container_slot = InventorySlots.SLOT_INBACKPACK.value

            if item_container_slot == 0xFF:
                item_container_slot = InventorySlots.SLOT_INBACKPACK.value

            # Wrapping Paper.
            wrapper_item = world_session.player_mgr.inventory.get_item(wrapper_container_slot, wrapper_item_slot)
            if not wrapper_item:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
                return 0

            # To wrap item.
            to_wrap_item = world_session.player_mgr.inventory.get_item(item_container_slot, item_slot)
            if not to_wrap_item:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            elif to_wrap_item.item_instance.stackcount > 1:  # Stackable.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_STACKABLE)
            elif to_wrap_item.is_equipped():  # Equipped.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_EQUIPPED)
            elif to_wrap_item.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_WRAPPED:  # Already wrapped.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_WRAPPED)
            elif to_wrap_item.is_container():  # Bag.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_BAGS)
            elif to_wrap_item.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_BOUND:  # Soulbound.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_BOUND)
            elif to_wrap_item.item_template.max_count > 0:  # Unique.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_CANT_WRAP_UNIQUE)
            elif world_session.player_mgr.spell_manager.is_casting():  # Prevent wrap while cast.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ERROR)
            elif to_wrap_item.set_wrapped(world_session.player_mgr, wrapper_item.item_template.entry):  # Actual wrap succeeds.
                # Remove wrapper item stack or item.
                world_session.player_mgr.inventory.remove_from_container_by_slots(wrapper_container_slot,
                                                                                  wrapper_item_slot, item_count=1)
            else:  # Wrap call failed.
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ERROR)

        return 0
