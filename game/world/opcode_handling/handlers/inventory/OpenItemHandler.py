from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags
from utils.constants.MiscCodes import HighGuid
from utils.constants.UnitCodes import UnitFlags


class OpenItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty open item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=2):
            return 0
        bag, slot = unpack('<2B', reader.data[:2])
        if bag == 0xFF:
            bag = InventorySlots.SLOT_INBACKPACK.value
        inventory = player_mgr.inventory

        item = inventory.get_item(bag, slot)
        if not item:
            inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return 0

        if player_mgr.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            inventory.send_equip_error(InventoryError.BAG_ERROR)
            return 0

        if not player_mgr.is_alive:
            inventory.send_equip_error(InventoryError.BAG_NOT_WHILE_DEAD)
            return 0

        # Interrupt casts if any.
        player_mgr.spell_manager.remove_casts(remove_active=False)

        # Validate lock.
        if not item.has_flag(ItemDynFlags.ITEM_DYNFLAG_UNLOCKED) and item.lock:
            # Check if lock id points to a valid lock.
            lock_info = DbcDatabaseManager.LocksHolder.get_lock_by_id(item.lock)
            if not lock_info:
                inventory.send_equip_error(InventoryError.BAG_ITEM_LOCKED, item_1=item)
                return 0

            # Requires pick lock.
            if lock_info.skills[0] or lock_info.skills[1]:
                inventory.send_equip_error(InventoryError.BAG_ITEM_LOCKED, item_1=item)
                return 0

        # Wrapped item.
        if item.has_flag(ItemDynFlags.ITEM_DYNFLAG_WRAPPED):
            character_gift = RealmDatabaseManager.character_get_gift(item.guid & ~HighGuid.HIGHGUID_ITEM)
            if character_gift:
                if item.unwrap(character_gift):
                    # Remove gift record.
                    RealmDatabaseManager.character_gift_delete(character_gift)
                else:
                    inventory.send_equip_error(InventoryError.BAG_ERROR)
            else:  # Invalid gift, destroy.
                inventory.remove_item(bag, slot, clear_slot=True)
                inventory.send_equip_error(InventoryError.BAG_UNKNOWN_ITEM, item_1=item)
                return 0
        elif item.loot_manager:
            if not item.loot_manager.has_loot():
                item.loot_manager.generate_loot(player_mgr)
            player_mgr.send_loot(item.loot_manager, from_item_container=True)

        return 0
