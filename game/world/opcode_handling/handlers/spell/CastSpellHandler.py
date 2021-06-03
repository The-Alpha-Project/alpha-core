from struct import unpack

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from utils.constants.SpellCodes import SpellTargetMask


class CastSpellHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 6:  # Avoid handling empty cast spell packet.
            spell_id, target_mask = unpack('<IH', reader.data[:6])

            caster = world_session.player_mgr
            game_object = None

            if target_mask & SpellTargetMask.CAN_TARGET_TERRAIN != 0 and len(reader.data) >= 18:
                target_info = Vector.from_bytes(reader.data[-12:])  # Terrain, target is vector
            elif len(reader.data) == 14:
                target_info = unpack('<Q', reader.data[-8:])[0]  # some object (read guid)
                game_object = MapManager.get_surrounding_gameobject_by_guid(caster, target_info)
            else:
                target_info = caster  # Self

            # TODO: @Flug, gameobject is not resolving on 'elif target_mask & SpellTargetMask.CAN_TARGET_OBJECTS'
            #  Not sure why, I had to force it.
            if game_object:
                spell_target = game_object
            elif target_mask & SpellTargetMask.CAN_TARGET_TERRAIN:
                spell_target = target_info
            elif target_mask & SpellTargetMask.UNIT_TARGET_MASK and target_info != caster:
                spell_target = MapManager.get_surrounding_unit_by_guid(caster, target_info, include_players=True)
            elif target_mask & SpellTargetMask.ITEM_TARGET_MASK:
                spell_target = caster.inventory.get_item_info_by_guid(target_info)[3]  # (container_slot, container, slot, item)
            elif target_mask & SpellTargetMask.CAN_TARGET_OBJECTS:  # Can also include items so we check for that first
                spell_target = MapManager.get_surrounding_gameobject_by_guid(caster, target_info)
            else:
                spell_target = caster  # Assume self cast for now. Invalid target will be resolved later

            world_session.player_mgr.spell_manager.handle_cast_attempt(spell_id, world_session.player_mgr, spell_target,
                                                                       target_mask)
        return 0
