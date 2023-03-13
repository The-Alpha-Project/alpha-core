from random import choice, shuffle
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.ScriptCodes import ScriptTarget, AttackingTarget


class ScriptManager:
    def __init__(self):
        pass

    @staticmethod
    # This can return either UnitManager or GameObjectManager. (Both have spell managers and aura managers)
    def get_target_by_type(caster, target, target_type, param1=None, param2=None, spell_template=None):
        try:
            if not ScriptManager._validate_is_unit(caster):
                return None
            return SCRIPT_TARGETS[target_type](caster, target, param1, param2, spell_template)
        except KeyError:
            Logger.warning(f'Unknown target type {target_type}.')
        return None

    @staticmethod
    def handle_provided_target(caster, target=None, param1=None, param2=None, spell_template=None):
        return target

    @staticmethod
    def handle_hostile(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.combat_target if caster.combat_target else None

    @staticmethod
    def handle_hostile_second_aggro(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_TOPAGGRO)

    @staticmethod
    def handle_hostile_last_aggro(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_BOTTOMAGGRO)

    @staticmethod
    def handle_hostile_random(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOM)

    @staticmethod
    def handle_hostile_random_not_top(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOMNOTTOP)

    @staticmethod
    def handle_owner_or_self(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.get_charmer_or_summoner(include_self=True)

    @staticmethod
    def handle_owner(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.get_charmer_or_summoner()

    @staticmethod
    def handle_nearest_creature_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param1
        targets = ScriptManager._get_surrounding_units(caster, friends_only=False, include_players=False)
        if not targets:
            return None
        # Sort by distance.
        targets.sort(key=lambda unit_target: caster.location.distance(unit_target.location))
        for target in targets:
            if target.entry != entry:
                continue
            return target
        return None

    @staticmethod
    def handle_random_creature_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        entry: Optional[int] = param2
        units = ScriptManager._get_surrounding_units(caster, search_range=search_range, include_players=False)
        if not units:
            return None
        shuffle(units)
        for unit in units:
            if unit.entry != entry:
                continue
            return unit
        return None

    @staticmethod
    def handle_creature_with_guid(caster, target=None, param1=None, param2=None, spell_template=None):
        spawn_id: Optional[int] = param1
        spawn = MapManager.get_surrounding_creature_spawn_by_spawn_id(caster, spawn_id)
        if not spawn or not spawn.creature_instance or not spawn.creature_instance.is_alive:
            return None
        return spawn.creature_instance

    @staticmethod
    def handle_creature_instance_data(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_creature_instance_data.')
        return None

    @staticmethod
    def handle_nearest_gameobject_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param1
        go_objects = list(MapManager.get_surrounding_gameobjects(caster).values())
        if not go_objects:
            return None
        # Sort by distance.
        go_objects.sort(key=lambda go_target: caster.location.distance(go_target.location))
        for target in go_objects:
            if target.entry != entry:
                continue
            return target
        return None

    @staticmethod
    def handle_random_gameobject_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param2
        go_objects = list(MapManager.get_surrounding_gameobjects(caster).values())
        if not go_objects:
            return None
        shuffle(go_objects)
        for go_object in go_objects:
            if go_object.entry != entry:
                continue
            return go_object
        return None

    @staticmethod
    def handle_gameobject_with_guid(caster, target=None, param1=None, param2=None, spell_template=None):
        spawn_id: Optional[int] = param1
        spawn = MapManager.get_surrounding_gameobject_by_spawn_id(caster, spawn_id)
        if not spawn or not spawn.gameobject_instance or not spawn.gameobject_instance.is_spawned:
            return None
        return spawn.gameobject_instance

    @staticmethod
    def handle_gameobject_from_instance_data(caster, target, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_gameobject_from_instance_data.')
        return None

    @staticmethod
    def handle_fiendly(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        exclude_target: Optional[UnitManager] = param2

        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)

        friendlies = ScriptManager._get_surrounding_units(caster,
                                                          search_range=search_range,
                                                          friends_only=True,
                                                          exclude_unit=exclude_target)
        # Did not find any friendlies.
        if not friendlies:
            return None

        # Return 1 randomly picked friendly unit.
        return choice(friendlies)

    @staticmethod
    def handle_friendly_injured(caster, target=None, param1=None, param2=None, spell_template=None):
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

    @staticmethod
    def handle_friendly_injured_except(caster, target=None, param1=None, param2=None, spell_template=None):
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

    @staticmethod
    def handle_friendly_missing_buf(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        spell_id: int = param2
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        surrounding_units = ScriptManager._get_surrounding_units(caster,
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

    @staticmethod
    def handle_friendly_missing_buf_except(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        spell_id: int = param2
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        surrounding_units = ScriptManager._get_surrounding_units(caster,
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

    @staticmethod
    def handle_friendly_cc(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_friendly_cc.')
        return None

    @staticmethod
    def handle_map_event_source(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_map_event_source.')
        return None

    @staticmethod
    def handle_map_event_target(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_map_event_target.')
        return None

    @staticmethod
    def handle_map_event_extra_target(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_map_event_extra_target.')
        return None

    @staticmethod
    def handle_nearest_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding units.
        players = ScriptManager._get_surrounding_units(caster, search_range)
        # No surrounding units found.
        if not players:
            return None
        # Sort by distance.
        players.sort(key=lambda player: caster.location.distance(player.location))
        return players[0]

    @staticmethod
    def handle_nearest_hostile_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding enemy units.
        enemy_players = ScriptManager._get_surrounding_players(caster, search_range, enemies_only=True)
        # No surrounding units found.
        if not enemy_players:
            return None
        # Sort by distance.
        enemy_players.sort(key=lambda player: caster.location.distance(player.location))
        return enemy_players[0]

    @staticmethod
    def handle_nearest_friendly_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        friendly_players = ScriptManager._get_surrounding_players(caster, search_range, friends_only=True)
        # No surrounding units found.
        if not friendly_players:
            return None
        # Sort by distance.
        friendly_players.sort(key=lambda player: caster.location.distance(player.location))
        return friendly_players[0]

    @staticmethod
    def _get_search_range(search_range=None, spell_template=None):
        if search_range:
            return search_range
        if not spell_template:
            return 30.0
        range_index = spell_template.RangeIndex
        range_entry = DbcDatabaseManager.spell_range_get_by_id(range_index)
        return range_entry.RangeMax

    @staticmethod
    def _validate_is_unit(world_object):
        return world_object and world_object.get_type_id() == ObjectTypeIds.ID_UNIT

    @staticmethod
    def _get_unit_hp_percent(unit_caller):
        return unit_caller.health * 100 / unit_caller.max_health

    @staticmethod
    def _get_injured_friendly_units(caster, radius, hp_threshold, exclude_unit=None) -> Optional[list[UnitManager]]:
        # Surrounding friendly units within range, including players.
        surrounding_units_and_players = ScriptManager._get_surrounding_units(caster, radius,
                                                                             friends_only=True,
                                                                             exclude_unit=exclude_unit)
        # Did not find any injured friendly.
        if not surrounding_units_and_players:
            return []

        # Units below hp_threshold.
        injured_friendly_units = [unit for unit in surrounding_units_and_players if ScriptManager._get_unit_hp_percent(
            unit) < hp_threshold]

        # No units below hp_threshold found.
        if not injured_friendly_units:
            return []

        # Sort them by lowest hp percentage.
        injured_friendly_units.sort(key=lambda unit: ScriptManager._get_unit_hp_percent(unit))
        return injured_friendly_units

    @staticmethod
    def _filter_units(unit_caller, units_list, search_range=0.0, friends_only=False, enemies_only=False,
                      exclude_unit=None):
        # Only within search range, if given.
        if search_range > 0:
            units_list = [unit for unit in units_list if unit_caller.location.distance(unit.location) < search_range]
        # Only friendly units, if requested.
        if friends_only:
            units_list = [unit for unit in units_list if not unit_caller.is_hostile_to(unit)]
        # Only enemies, if requested.
        if enemies_only:
            units_list = [unit for unit in units_list if unit_caller.is_hostile_to(unit)]
        # Exclude unit, if provided.
        if exclude_unit:
            units_list = [unit for unit in units_list if unit != exclude_unit]

        return units_list

    @staticmethod
    def _get_surrounding_players(unit_caller, search_range=0.0, friends_only=False,
                                 enemies_only=False) -> Optional[list[UnitManager]]:
        surrounding_players_list = list(MapManager.get_surrounding_players(unit_caller).values())

        # Did not find surrounding players.
        if not surrounding_players_list:
            return []

        surrounding_players_list = ScriptManager._filter_units(unit_caller, surrounding_players_list, search_range,
                                                               friends_only, enemies_only, None)

        return surrounding_players_list if surrounding_players_list else []

    @staticmethod
    def _get_surrounding_units(unit_caller, search_range=0.0, friends_only=False, enemies_only=False,
                               exclude_unit=None, include_players=True) -> list[UnitManager]:
        # Surrounding units including players.
        surrounding_units = MapManager.get_surrounding_units(unit_caller, include_players=include_players)
        # Merge if needed.
        if include_players:
            surrounding_units_list = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
        else:
            surrounding_units_list = list(surrounding_units.values())

        # Did not find surrounding units.
        if len(surrounding_units_list) == 0:
            return []

        surrounding_units_list = ScriptManager._filter_units(unit_caller, surrounding_units_list, search_range,
                                                             friends_only, enemies_only, exclude_unit)

        return surrounding_units_list if surrounding_units_list else []


SCRIPT_TARGETS = {
    ScriptTarget.TARGET_T_PROVIDED_TARGET: ScriptManager.handle_provided_target,
    ScriptTarget.TARGET_T_HOSTILE: ScriptManager.handle_hostile,
    ScriptTarget.TARGET_T_HOSTILE_SECOND_AGGRO: ScriptManager.handle_hostile_second_aggro,
    ScriptTarget.TARGET_T_HOSTILE_LAST_AGGRO: ScriptManager.handle_hostile_last_aggro,
    ScriptTarget.TARGET_T_HOSTILE_RANDOM: ScriptManager.handle_hostile_random,
    ScriptTarget.TARGET_T_HOSTILE_RANDOM_NOT_TOP: ScriptManager.handle_hostile_random_not_top,
    ScriptTarget.TARGET_T_OWNER_OR_SELF: ScriptManager.handle_owner_or_self,
    ScriptTarget.TARGET_T_OWNER: ScriptManager.handle_owner,
    ScriptTarget.TARGET_T_NEAREST_CREATURE_WITH_ENTRY: ScriptManager.handle_nearest_creature_with_entry,
    ScriptTarget.TARGET_T_CREATURE_WITH_GUID: ScriptManager.handle_creature_with_guid,
    ScriptTarget.TARGET_T_CREATURE_FROM_INSTANCE_DATA: ScriptManager.handle_creature_instance_data,
    ScriptTarget.TARGET_T_NEAREST_GAMEOBJECT_WITH_ENTRY: ScriptManager.handle_nearest_gameobject_with_entry,
    ScriptTarget.TARGET_T_GAMEOBJECT_WITH_GUID: ScriptManager.handle_gameobject_with_guid,
    ScriptTarget.TARGET_T_FRIENDLY: ScriptManager.handle_fiendly,
    ScriptTarget.TARGET_T_FRIENDLY_INJURED: ScriptManager.handle_friendly_injured,
    ScriptTarget.TARGET_T_FRIENDLY_INJURED_EXCEPT: ScriptManager.handle_friendly_injured_except,
    ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF: ScriptManager.handle_friendly_missing_buf,
    ScriptTarget.TARGET_T_FRIENDLY_CC: ScriptManager.handle_friendly_cc,
    ScriptTarget.TARGET_T_MAP_EVENT_SOURCE: ScriptManager.handle_map_event_source,
    ScriptTarget.TARGET_T_MAP_EVENT_TARGET: ScriptManager.handle_map_event_target,
    ScriptTarget.TARGET_T_MAP_EVENT_EXTRA_TARGET: ScriptManager.handle_map_event_extra_target,
    ScriptTarget.TARGET_T_NEAREST_PLAYER: ScriptManager.handle_nearest_player,
    ScriptTarget.TARGET_T_NEAREST_HOSTILE_PLAYER: ScriptManager.handle_nearest_hostile_player,
    ScriptTarget.TARGET_T_NEAREST_FRIENDLY_PLAYER: ScriptManager.handle_nearest_friendly_player,
    ScriptTarget.TARGET_T_RANDOM_CREATURE_WITH_ENTRY: ScriptManager.handle_random_creature_with_entry,
    ScriptTarget.TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY: ScriptManager.handle_random_gameobject_with_entry
}