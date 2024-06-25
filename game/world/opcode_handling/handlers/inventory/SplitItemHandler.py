from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots


class SplitItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 5:  # Avoid handling empty split item packet.
            source_bag_slot, source_slot, dest_bag_slot, dest_slot, count = unpack('<5B', reader.data[:5])
            inventory = world_session.player_mgr.inventory

            if source_bag_slot == 0xFF:
                source_bag_slot = InventorySlots.SLOT_INBACKPACK.value
            if dest_bag_slot == 0xFF:
                dest_bag_slot = InventorySlots.SLOT_INBACKPACK.value

            source_item = inventory.get_item(source_bag_slot, source_slot)
            if source_item.item_instance.stackcount < count:
                inventory.send_equip_error(InventoryError.BAG_ITEM_TOO_FEW_TO_SPLIT, source_item, None)
                return 0

            if not source_item or count <= 0:
                inventory.send_equip_error(InventoryError.BAG_ITEM_SPLIT_FAILED, source_item, None)
                return 0

            if not inventory.add_item_to_slot(dest_bag_slot, dest_slot, item=source_item,
                                              item_template=source_item.item_template, count=count):
                return 0
            new_stack_count = source_item.item_instance.stackcount - count
            source_item.set_stack_count(new_stack_count)

            source_container = inventory.get_container(source_bag_slot)
            if source_container and not source_container.is_backpack:
                source_container.build_container_update_packet()

            if inventory.update_locked:
                inventory.update_locked = False

        return 0
