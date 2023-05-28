from struct import unpack

from game.world.opcode_handling.handlers.spell.CastSpellHandler import CastSpellHandler


class UseItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 5:  # Avoid handling empty use item packet.
            bag, slot, spell_count, target_mask = unpack('<3BH', reader.data[:5])

            item = world_session.player_mgr.inventory.get_item(bag, slot)
            if not item:
                return 0

            target_bytes = reader.data[5:]
            target = CastSpellHandler.get_target_info(world_session, target_mask, target_bytes)

            world_session.player_mgr.spell_manager.handle_item_cast_attempt(item, target, target_mask)
        return 0
