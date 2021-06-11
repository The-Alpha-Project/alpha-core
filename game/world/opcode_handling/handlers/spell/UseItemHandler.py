from struct import unpack, pack
from game.world.opcode_handling.handlers.spell.CastSpellHandler import CastSpellHandler
from utils.constants.ItemCodes import InventorySlots
from utils.constants.SpellCodes import SpellTargetMask


class UseItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 2:  # Avoid handling empty use item packet.
            bag, slot = unpack('<2B', reader.data[:2])

            if bag == 0xFF:
                bag = InventorySlots.SLOT_INBACKPACK.value

            item = world_session.player_mgr.inventory.get_item(bag, slot)

            # TODO: This simply redirects item spell to CastSpellHandler forcing self mask.
            #  Handle SpellTrigger, SpellCharges, Item stack pop, checks for races/class, spell_id 2/3/4, etc..
            #  Players do not have Food and Drink spells as default.
            if item and item.item_template.spellid_1 > 0:
                reader.data = pack('<IH', item.item_template.spellid_1, SpellTargetMask.SELF)
                CastSpellHandler.handle(world_session, socket, reader)

        return 0
