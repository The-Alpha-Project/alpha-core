from random import choice
from typing import Optional

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.ScriptCodes import ScriptTarget, AttackingTarget


class ScriptManager:
    @staticmethod
    def get_target_by_type(source_world_object, target_world_object, script_target, param1, param2, spell_entry) -> Optional[ObjectManager]:
        if script_target == ScriptTarget.TARGET_T_PROVIDED_TARGET:
            return target_world_object
        elif script_target == ScriptTarget.TARGET_T_HOSTILE:
            if ScriptManager._validate_is_unit(source_world_object):
                if source_world_object.combat_target:
                    return source_world_object.combat_target
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_SECOND_AGGRO:
            if ScriptManager._validate_is_unit(source_world_object):
                return source_world_object.ThreatManager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_TOPAGGRO)
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_LAST_AGGRO:
            if ScriptManager._validate_is_unit(source_world_object):
                return source_world_object.ThreatManager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_BOTTOMAGGRO)
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_RANDOM:
            if ScriptManager._validate_is_unit(source_world_object):
                return source_world_object.ThreatManager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOM)
        elif script_target == ScriptTarget.TARGET_T_HOSTILE_RANDOM_NOT_TOP:
            if ScriptManager._validate_is_unit(source_world_object):
                return source_world_object.ThreatManager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOMNOTTOP)
        elif script_target == ScriptTarget.TARGET_T_OWNER_OR_SELF:
            # TODO
            #  return source.get_charmer_or_self()
            pass
        elif script_target == ScriptTarget.TARGET_T_OWNER:
            # TODO
            #  return source.get_owner(), what does owner means here?
            pass
        elif script_target == ScriptTarget.TARGET_T_NEAREST_CREATURE_WITH_ENTRY:
            # TODO, entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif script_target == ScriptTarget.TARGET_T_RANDOM_CREATURE_WITH_ENTRY:
            # TODO, entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif script_target == ScriptTarget.TARGET_T_CREATURE_WITH_GUID:
            # TODO, might need to do some guid conversion between low and high?
            unit_guid = param1
            unit = MapManager.get_surrounding_unit_by_guid(source_world_object, unit_guid, True)
            return unit if unit and unit.is_alive else None
        elif script_target == ScriptTarget.TARGET_T_CREATURE_FROM_INSTANCE_DATA:
            # TODO, instancing.
            pass
        elif script_target == ScriptTarget.TARGET_T_NEAREST_GAMEOBJECT_WITH_ENTRY:
            # TODO, entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif script_target == ScriptTarget.TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY:
            # TODO, entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif script_target == ScriptTarget.TARGET_T_GAMEOBJECT_WITH_GUID:
            # TODO, might need to do some guid conversion between low and high?
            gameobject_guid = param1
            gameobject = MapManager.get_surrounding_gameobject_by_guid(source_world_object, gameobject_guid)
            return gameobject if gameobject and gameobject.is_spawned else None
        elif script_target == ScriptTarget.TARGET_T_GAMEOBJECT_FROM_INSTANCE_DATA:
            # TODO, instancing.
            pass
        elif script_target == ScriptTarget.TARGET_T_FRIENDLY:
            if not ScriptManager._validate_is_unit(source_world_object):
                return None
            search_range: Optional[float] = param1
            exclude_target: Optional[UnitManager] = param2
            # TODO, retrieve spell range.
            # if not search_range and spell_entry:
            if not search_range:
                search_range = 30.0
            # Surrounding units including players.
            surrounding_units = MapManager.get_surrounding_units(source_world_object, include_players=True)
            # Merge results.
            surrounding_units_list = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
            # Units within search_range and not the excluded target, if any.
            in_range_units = [unit for unit in surrounding_units_list if
                              source_world_object.location.distance(unit) <= search_range and unit != exclude_target]
            # Return 1 randomly picked friendly unit.
            return choice([unit for unit in in_range_units if not source_world_object.can_attack_target(unit)])
        elif ScriptTarget.TARGET_T_FRIENDLY_INJURED:
            if not ScriptManager._validate_is_unit(source_world_object):
                return None
            search_range: Optional[float] = param1
            hp_percent: Optional[float] = param2
            # TODO, retrieve spell range if spell was provided and we have no search range.
            # if not search_range and spell_entry:
            if not search_range:
                search_range = 30.0
            if not hp_percent:
                hp_percent = 50.0
            injured_friendly_units = ScriptManager._get_injured_friendly_units(source_world_object, search_range, hp_percent)
            return injured_friendly_units[0] if injured_friendly_units else None
        elif ScriptTarget.TARGET_T_FRIENDLY_INJURED_EXCEPT:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF_EXCEPT:
            pass
        elif ScriptTarget.TARGET_T_FRIENDLY_CC:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_SOURCE:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_TARGET:
            pass
        elif ScriptTarget.TARGET_T_MAP_EVENT_EXTRA_TARGET:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_PLAYER:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_HOSTILE_PLAYER:
            pass
        elif ScriptTarget.TARGET_T_NEAREST_FRIENDLY_PLAYER:
            pass

    @staticmethod
    def _validate_is_unit(world_object):
        return world_object and world_object.get_type_id() == ObjectTypeIds.ID_UNIT

    @staticmethod
    def _get_unit_hp_percent(unit):
        return unit.health * 100 / unit.max_health

    @staticmethod
    def _get_injured_friendly_units(unit, search_range, hp_threshold) -> Optional[list[UnitManager]]:
        if not search_range:
            search_range = 30.0
        # Surrounding units including players.
        surrounding_units = MapManager.get_surrounding_units(unit, include_players=True)
        # Merge results.
        surrounding_units_list = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
        # Friendly Units below hp_threshold and within search range.
        injured_friendly_units = [unit for unit in surrounding_units_list if ScriptManager._get_unit_hp_percent(
            unit) < hp_threshold and not unit.can_attack_target(unit) and unit.location.distance(unit) < search_range]
        # Sort them by lowest hp percentage.
        injured_friendly_units.sort(key=lambda _unit: ScriptManager._get_unit_hp_percent(_unit))
        return injured_friendly_units if len(injured_friendly_units) > 0 else None
