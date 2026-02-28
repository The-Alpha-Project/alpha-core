from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from utils.constants.ItemCodes import InventoryError, InventorySlots


class AutostoreBagItemHandler:
    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty autostore bag item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=3):
            return 0
        source_bag_slot, source_slot, dest_bag_slot = unpack('<3B', reader.data[:3])

        if source_bag_slot == 0xFF:
            source_bag_slot = InventorySlots.SLOT_INBACKPACK.value
        if dest_bag_slot == 0xFF:
            dest_bag_slot = InventorySlots.SLOT_INBACKPACK.value

        inventory = world_session.player_mgr.inventory
        source_container = inventory.get_container(source_bag_slot)
        dest_container = inventory.get_container(dest_bag_slot)
        if not dest_container or not source_container:
            return 0

        source_item = source_container.get_item(source_slot)
        if not source_item:
            return 0

        amount = source_item.item_instance.stackcount

        dest_slot = dest_container.next_available_slot()
        if dest_slot == -1:
            if inventory.can_store_item(source_item.item_template, amount) == InventoryError.BAG_OK:
                dest_bag_slot, dest_slot = inventory.get_next_available_inventory_slot()
            else:
                inventory.send_equip_error(InventoryError.BAG_INV_FULL, source_item, dest_container)
                return 0
        if dest_slot == -1:
            # Case when there are no available slots but the item can fit in other stacks.
            source_container.remove_item_in_slot(source_slot)
            inventory.add_item(item_template=source_item.item_template, count=amount,
                               looted=False, show_item_get=False)
            return 0
        if dest_bag_slot == source_bag_slot and dest_slot >= source_slot:
            # TODO Irrelevant error code, but only one that seems to not display anything to the client.
            inventory.send_equip_error(InventoryError.BAG_LOOT_GONE, source_item, None)
            return 0
        inventory.swap_item(source_bag_slot, source_slot, dest_bag_slot, dest_slot)

        return 0
