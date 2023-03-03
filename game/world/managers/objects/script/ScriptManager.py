from random import choice
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.ScriptCodes import ScriptTarget, AttackingTarget


class ScriptManager:
    def __init__(self):
        pass

    @staticmethod
    # This can return either UnitManager or GameObjectManager. (Both have spell managers and aura managers)
    def get_target_by_type(caster, target, target_type, param1=None, param2=None, spell_template=None):
        if target_type == ScriptTarget.TARGET_T_PROVIDED_TARGET:
            return target
        elif target_type == ScriptTarget.TARGET_T_HOSTILE:
            if ScriptManager._validate_is_unit(caster):
                if caster.combat_target:
                    return caster.combat_target
        elif target_type == ScriptTarget.TARGET_T_HOSTILE_SECOND_AGGRO:
            if ScriptManager._validate_is_unit(caster):
                return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_TOPAGGRO)
        elif target_type == ScriptTarget.TARGET_T_HOSTILE_LAST_AGGRO:
            if ScriptManager._validate_is_unit(caster):
                return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_BOTTOMAGGRO)
        elif target_type == ScriptTarget.TARGET_T_HOSTILE_RANDOM:
            if ScriptManager._validate_is_unit(caster):
                return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOM)
        elif target_type == ScriptTarget.TARGET_T_HOSTILE_RANDOM_NOT_TOP:
            if ScriptManager._validate_is_unit(caster):
                return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOMNOTTOP)
        elif target_type == ScriptTarget.TARGET_T_OWNER_OR_SELF:
            if not ScriptManager._validate_is_unit(caster):
                return None
            return caster.get_charmer_or_summoner(include_self=True)
        elif target_type == ScriptTarget.TARGET_T_OWNER:
            if not ScriptManager._validate_is_unit(caster):
                return None
            return caster.get_charmer_or_summoner()
        elif target_type == ScriptTarget.TARGET_T_NEAREST_CREATURE_WITH_ENTRY:
            # TODO: entry -> object type identification.
            #  Based on objects high guids.

            targets = ScriptManager._get_surrounding_units_and_players(caster, friends_only=False)
            if not targets:
                return None
            else:
                for t in targets:
                    if t.entry == param1:
                        return t
            return None
        elif target_type == ScriptTarget.TARGET_T_RANDOM_CREATURE_WITH_ENTRY:
            # TODO: entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif target_type == ScriptTarget.TARGET_T_CREATURE_WITH_GUID:
            # TODO: might need to do some guid conversion between low and high?
            unit_guid: Optional[int] = param1
            unit = MapManager.get_surrounding_unit_by_guid(caster, unit_guid, True)
            return unit if unit and unit.is_alive else None
        elif target_type == ScriptTarget.TARGET_T_CREATURE_FROM_INSTANCE_DATA:
            # TODO: instancing.
            pass
        elif target_type == ScriptTarget.TARGET_T_NEAREST_GAMEOBJECT_WITH_ENTRY:
            # TODO: entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif target_type == ScriptTarget.TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY:
            # TODO: entry -> object type identification.
            #  Based on objects high guids.
            pass
        elif target_type == ScriptTarget.TARGET_T_GAMEOBJECT_WITH_GUID:
            # TODO: might need to do some guid conversion between low and high?
            gameobject_guid: Optional[int] = param1
            gameobject = MapManager.get_surrounding_gameobject_by_guid(caster, gameobject_guid)
            return gameobject if gameobject and gameobject.is_spawned else None
        elif target_type == ScriptTarget.TARGET_T_GAMEOBJECT_FROM_INSTANCE_DATA:
            # TODO: instancing.
            pass
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY:
            if not ScriptManager._validate_is_unit(caster):
                return None
            search_range: Optional[float] = param1
            exclude_target: Optional[UnitManager] = param2

            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)

            friendlies = ScriptManager._get_surrounding_units_and_players(caster,
                                                                          search_range=search_range,
                                                                          friends_only=True,
                                                                          exclude_unit=exclude_target)
            # Did not find any friendlies.
            if not friendlies:
                return None

            # Return 1 randomly picked friendly unit.
            return choice(friendlies)
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY_INJURED:
            if not ScriptManager._validate_is_unit(caster):
                return None
            search_range: Optional[float] = param1
            hp_percent: Optional[float] = param2
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            if not hp_percent:
                hp_percent = 50.0
            injured_friendlies = ScriptManager._get_injured_friendly_units(caster,
                                                                           radius=search_range,
                                                                           hp_threshold=hp_percent)
            return injured_friendlies[0] if injured_friendlies else None
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY_INJURED_EXCEPT:
            if not ScriptManager._validate_is_unit(caster):
                return None
            search_range: Optional[float] = param1
            hp_percent: Optional[float] = param2
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            if not hp_percent:
                hp_percent = 50.0
            injured_friendlies = ScriptManager._get_injured_friendly_units(caster,
                                                                           radius=search_range,
                                                                           hp_threshold=hp_percent,
                                                                           exclude_unit=target)
            return injured_friendlies[0] if injured_friendlies else None
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF:
            search_range: Optional[float] = param1
            spell_id: int = param2
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            # Surrounding friendly units.
            surrounding_units = ScriptManager._get_surrounding_units_and_players(caster,
                                                                                 search_range,
                                                                                 friends_only=True)
            # No surrounding units found.
            if not surrounding_units:
                return None

            for friendly_unit in surrounding_units:
                if not friendly_unit.aura_manager.has_aura_by_spell_id(spell_id):
                    return friendly_unit
            # No suitable target found.
            return None
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF_EXCEPT:
            search_range: Optional[float] = param1
            spell_id: int = param2
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            # Surrounding friendly units.
            surrounding_units = ScriptManager._get_surrounding_units_and_players(caster,
                                                                                 search_range,
                                                                                 friends_only=True,
                                                                                 exclude_unit=target)
            # No surrounding units found.
            if not surrounding_units:
                return None

            for friendly_unit in surrounding_units:
                if not friendly_unit.aura_manager.has_aura_by_spell_id(spell_id):
                    return friendly_unit
            # No suitable target found.
            return None
        elif target_type == ScriptTarget.TARGET_T_FRIENDLY_CC:
            pass
        elif target_type == ScriptTarget.TARGET_T_MAP_EVENT_SOURCE:
            pass
        elif target_type == ScriptTarget.TARGET_T_MAP_EVENT_TARGET:
            pass
        elif target_type == ScriptTarget.TARGET_T_MAP_EVENT_EXTRA_TARGET:
            pass
        elif target_type == ScriptTarget.TARGET_T_NEAREST_PLAYER:
            search_range: Optional[float] = param1
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            # Surrounding units.
            surrounding_units = ScriptManager._get_surrounding_units_and_players(caster, search_range)
            # No surrounding units found.
            if not surrounding_units:
                return None
            # Filter players.
            players = [unit for unit in surrounding_units if unit.get_type_id() == ObjectTypeIds.ID_PLAYER]
            # No players found.
            if len(players) == 0:
                return None
            # Sort by distance.
            players.sort(key=lambda player: caster.location.distance(player.location))
            return players[0]
        elif target_type == ScriptTarget.TARGET_T_NEAREST_HOSTILE_PLAYER:
            search_range: Optional[float] = param1
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            # Surrounding enemy units.
            surrounding_units = ScriptManager._get_surrounding_units_and_players(caster, search_range,
                                                                                 enemies_only=True)
            # No surrounding units found.
            if not surrounding_units:
                return None
            # Filter enemy players.
            enemy_players = [unit for unit in surrounding_units if unit.get_type_id() == ObjectTypeIds.ID_PLAYER]
            # No enemy players found.
            if len(enemy_players) == 0:
                return None
            # Sort by distance.
            enemy_players.sort(key=lambda player: caster.location.distance(player.location))
            return enemy_players[0]
        elif target_type == ScriptTarget.TARGET_T_NEAREST_FRIENDLY_PLAYER:
            search_range: Optional[float] = param1
            # Set range if not provided.
            search_range = ScriptManager._get_search_range(search_range, spell_template)
            # Surrounding friendly units.
            surrounding_units = ScriptManager._get_surrounding_units_and_players(caster, search_range,
                                                                                 friends_only=True)
            # No surrounding units found.
            if not surrounding_units:
                return None
            # Filter friendly players.
            friendly_players = [unit for unit in surrounding_units if unit.get_type_id() == ObjectTypeIds.ID_PLAYER]
            # No enemy players found.
            if len(friendly_players) == 0:
                return None
            # Sort by distance.
            friendly_players.sort(key=lambda player: caster.location.distance(player.location))
            return friendly_players[0]

    @staticmethod
    def _get_search_range(search_range=None, spell_template=None):
        if not search_range:
            if not spell_template:
                return 30.0
            range_index = spell_template.RangeIndex
            range_entry = DbcDatabaseManager.spell_range_get_by_id(range_index)
            return range_entry.RangeMax
        else:
            return search_range

    @staticmethod
    def _validate_is_unit(world_object):
        return world_object and world_object.get_type_id() == ObjectTypeIds.ID_UNIT

    @staticmethod
    def _get_unit_hp_percent(unit_caller):
        return unit_caller.health * 100 / unit_caller.max_health

    @staticmethod
    def _get_injured_friendly_units(caster, radius, hp_threshold, exclude_unit=None) -> Optional[list[UnitManager]]:
        # Surrounding friendly units within range, including players.
        surrounding_units_and_players = ScriptManager._get_surrounding_units_and_players(caster, radius,
                                                                                         friends_only=True,
                                                                                         exclude_unit=exclude_unit)
        # Did not find any injured friendly.
        if not surrounding_units_and_players:
            return None

        # Units below hp_threshold.
        injured_friendly_units = [unit for unit in surrounding_units_and_players if ScriptManager._get_unit_hp_percent(
            unit) < hp_threshold]

        # No units below hp_threshold found.
        if len(injured_friendly_units) == 0:
            return None

        # Sort them by lowest hp percentage.
        injured_friendly_units.sort(key=lambda unit: ScriptManager._get_unit_hp_percent(unit))
        return injured_friendly_units

    @staticmethod
    def _get_surrounding_units_and_players(unit_caller, search_range=0.0, friends_only=False, enemies_only=False,
                                           exclude_unit=None) -> Optional[list[UnitManager]]:
        # Surrounding units including players.
        surrounding_units = MapManager.get_surrounding_units(unit_caller, include_players=True)
        # Merge results.
        surrounding_units_list = list(surrounding_units[0].values()) + list(surrounding_units[1].values())

        # Did not find surrounding units.
        if len(surrounding_units_list) == 0:
            return None

        # Only within search range, if given.
        if search_range > 0:
            surrounding_units_list = [unit for unit in surrounding_units_list if
                                      unit_caller.location.distance(unit.location) < search_range]
        # Only friendly units, if requested.
        if friends_only:
            surrounding_units_list = [unit for unit in surrounding_units_list if not unit_caller.is_hostile_to(unit)]
        # Only enemies, if requested.
        if enemies_only:
            surrounding_units_list = [unit for unit in surrounding_units_list if unit_caller.is_hostile_to(unit)]
        # Exclude unit, if provided.
        if exclude_unit:
            surrounding_units_list = [unit for unit in surrounding_units_list if
                                      unit != exclude_unit]
        return surrounding_units_list if len(surrounding_units_list) > 0 else None
