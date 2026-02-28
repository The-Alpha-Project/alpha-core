from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from game.world.managers.abstractions.Vector import Vector
from utils.constants.SpellCodes import SpellTargetMask


class CastSpellHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty cast spell packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=6):
            return 0
        spell_id, target_mask = unpack('<IH', reader.data[:6])
        target_bytes = reader.data[6:]  # Remove first 6 bytes to get targeting info.
        spell_target = CastSpellHandler.get_target_info(world_session, target_mask, target_bytes)
        world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, spell_target, target_mask)

        return 0

    @staticmethod
    def get_target_info(world_session, target_mask, target_bytes):
        caster = world_session.player_mgr

        offset = 0
        unit_guid = None
        item_guid = None
        source_location = None
        dest_location = None

        if target_mask & SpellTargetMask.UNIT_TARGET_MASK and len(target_bytes) >= offset + 8:
            # Unit GUID is serialized first when present.
            unit_guid = unpack('<Q', target_bytes[offset:offset + 8])[0]
            offset += 8
        if target_mask & SpellTargetMask.ITEM_TARGET_MASK and len(target_bytes) >= offset + 8:
            # Item GUID follows unit GUID when item targets are included.
            item_guid = unpack('<Q', target_bytes[offset:offset + 8])[0]
            offset += 8
        if target_mask & SpellTargetMask.SOURCE_LOCATION and len(target_bytes) >= offset + 12:
            # Source vector comes before destination when both are present.
            source_location = Vector.from_bytes(target_bytes[offset:offset + 12])
            offset += 12
        if target_mask & SpellTargetMask.DEST_LOCATION and len(target_bytes) >= offset + 12:
            # Destination vector is last in SpellPutCastTargets order.
            dest_location = Vector.from_bytes(target_bytes[offset:offset + 12])
            offset += 12

        if target_mask & SpellTargetMask.CAN_TARGET_TERRAIN:
            # Prefer destination for terrain casts, fallback to source if only one is sent.
            return dest_location or source_location or caster
        if target_mask & SpellTargetMask.UNIT and unit_guid is not None:
            # Resolve unit GUID into a nearby unit/player.
            return caster.get_map().get_surrounding_unit_by_guid(caster, unit_guid, include_players=True)
        if target_mask & SpellTargetMask.ITEM_TARGET_MASK and not target_mask & SpellTargetMask.TRADE_ITEM:
            if item_guid is not None:
                # Item GUID resolves to an inventory item.
                return caster.inventory.get_item_info_by_guid(item_guid)[3]  # item.
        if target_mask & SpellTargetMask.CAN_TARGET_OBJECTS and unit_guid is not None:  # Can also include items.
            # GameObject GUID shares the unit GUID slot in target bytes.
            return caster.get_map().get_surrounding_gameobject_by_guid(caster, unit_guid)
        if target_mask & SpellTargetMask.ITEM_TARGET_MASK and target_mask & SpellTargetMask.TRADE_ITEM:
            if item_guid is not None and caster.trade_data and caster.trade_data.other_player and caster.trade_data.other_player.trade_data:
                # Trade item GUID resolves via the other player's trade data.
                return caster.trade_data.other_player.trade_data.get_item_by_slot(item_guid)

        return caster  # Assume self-cast.
