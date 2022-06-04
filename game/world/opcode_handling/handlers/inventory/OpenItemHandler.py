from struct import unpack

from game.world.managers.objects.locks.LockManager import LockManager
from utils.constants.ItemCodes import InventoryError, InventorySlots, ItemDynFlags
from utils.constants.MiscCodes import LockType
from utils.constants.SpellCodes import SpellCheckCastResult


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

            # TODO: Better handling of this: check if player can use item, etc.
            if not item.has_flag(ItemDynFlags.ITEM_DYNFLAG_UNLOCKED):
                unlock = LockManager.can_open_lock(world_session.player_mgr, LockType.LOCKTYPE_OPEN, item.lock)
                if unlock.result != SpellCheckCastResult.SPELL_NO_ERROR:
                    world_session.player_mgr.inventory.send_equip_error(InventoryError.BAG_ITEM_LOCKED, item_1=item)
                    return
                else:
                    item.set_unlocked()

            if item.loot_manager:
                if not item.loot_manager.has_loot():
                    item.loot_manager.generate_loot(world_session.player_mgr)
                world_session.player_mgr.send_loot(item.loot_manager)

        return 0
