from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.locks.LockManager import LockManager
from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags
from utils.constants.MiscCodes import LockType, HighGuid
from utils.constants.SpellCodes import SpellCheckCastResult
from utils.constants.UnitCodes import UnitFlags


class OpenItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty open item packet.
            bag, slot = unpack('<2B', reader.data[:2])
            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, slot)
            if not item:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
                return 0

            if world_session.player_mgr.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ERROR)
                return 0

            if not world_session.player_mgr.is_alive:
                world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_NOT_WHILE_DEAD)
                return 0

            # Interrupt casts if any.
            if world_session.player_mgr.spell_manager.is_casting():
                world_session.player_mgr.spell_manager.remove_all_casts()

            # TODO: Missing checks.
            if not item.has_flag(ItemDynFlags.ITEM_DYNFLAG_UNLOCKED):
                unlock = LockManager.can_open_lock(world_session.player_mgr, LockType.LOCKTYPE_OPEN, item.lock)
                if unlock.result != SpellCheckCastResult.SPELL_NO_ERROR:
                    world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_LOCKED, item_1=item)
                    return 0
                else:
                    item.set_unlocked()

            # Wrapped item.
            if item.has_flag(ItemDynFlags.ITEM_DYNFLAG_WRAPPED):
                character_gift = RealmDatabaseManager.character_get_gift(item.guid & ~HighGuid.HIGHGUID_ITEM)
                if character_gift:
                    if item.unwrap(character_gift):
                        # Remove gift record.
                        RealmDatabaseManager.character_gift_delete(character_gift)
                    else:
                        world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ERROR)
                else:  # Invalid gift, destroy.
                    world_session.player_mgr.inventory.remove_item(bag, slot, clear_slot=True)
                    world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_UNKNOWN_ITEM, item_1=item)
                    return 0
            elif item.loot_manager:
                if not item.loot_manager.has_loot():
                    item.loot_manager.generate_loot(world_session.player_mgr)
                world_session.player_mgr.send_loot(item.loot_manager)

        return 0
