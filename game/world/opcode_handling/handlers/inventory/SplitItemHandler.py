from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots


class SplitItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty split item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=5):
            return 0
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

        return 0
