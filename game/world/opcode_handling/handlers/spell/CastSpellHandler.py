from struct import unpack

from game.world.managers.abstractions.Vector import Vector
from utils.constants.SpellCodes import SpellTargetMask


class CastSpellHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 6:  # Avoid handling empty cast spell packet.
            spell_id, target_mask = unpack('<IH', reader.data[:6])

            target_bytes = reader.data[6:]  # Remove first 6 bytes to get targeting info.

            spell_target = CastSpellHandler.get_target_info(world_session, target_mask, target_bytes)

            world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, spell_target, target_mask)
            return 0

    @staticmethod
    def get_target_info(world_session, target_mask, target_bytes):
        caster = world_session.player_mgr

        if target_mask & SpellTargetMask.CAN_TARGET_TERRAIN != 0 and len(target_bytes) == 12:
            target_info = Vector.from_bytes(target_bytes)  # Terrain, target is vector.
        elif len(target_bytes) == 8:
            target_info = unpack('<Q', target_bytes)[0]  # Some object (read guid).
        else:
            target_info = caster  # Self

        if target_mask & SpellTargetMask.CAN_TARGET_TERRAIN:
            return target_info
        if target_mask & SpellTargetMask.UNIT and target_info != caster:
            return caster.get_map().get_surrounding_unit_by_guid(caster, target_info, include_players=True)
        if target_mask & SpellTargetMask.ITEM_TARGET_MASK and not target_mask & SpellTargetMask.TRADE_ITEM:
            return caster.inventory.get_item_info_by_guid(target_info)[3]  # (container_slot, container, slot, item).
        if target_mask & SpellTargetMask.CAN_TARGET_OBJECTS:  # Can also include items, so we check for that first.
            return caster.get_map().get_surrounding_gameobject_by_guid(caster, target_info)
        if target_mask & SpellTargetMask.ITEM_TARGET_MASK and target_mask & SpellTargetMask.TRADE_ITEM:
            if caster.trade_data and caster.trade_data.other_player and caster.trade_data.other_player.trade_data:
                return caster.trade_data.other_player.trade_data.get_item_by_slot(target_info)

        return caster  # Assume self cast for now. Invalid target will be resolved later.
