from random import choice
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.units.UnitManager import UnitManager
from utils.Logger import Logger
from utils.constants.ScriptCodes import ScriptTarget, AttackingTarget


VMANGOS_SHIFTED_TARGET_ALIASES = {
    # TODO: VMaNGOS inserted target types 6/7 and migrated data with +2 for target_type > 5.
    #  Our current world data is still mostly in pre-shift numbering, but some rows may
    #  leak in with shifted values. These aliases keep those rows functional.
    28: ScriptTarget.TARGET_T_RANDOM_CREATURE_WITH_ENTRY,
    29: ScriptTarget.TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY
}


class ScriptManager:

    @staticmethod
    # This can return either UnitManager or GameObjectManager. (Both have spell managers and aura managers)
    def get_target_by_type(caster, target, target_type, param1=None, param2=None, spell_template=None):
        resolver = SCRIPT_TARGETS.get(target_type)
        if not resolver:
            aliased_target_type = VMANGOS_SHIFTED_TARGET_ALIASES.get(target_type)
            if aliased_target_type is not None:
                Logger.debug(f'Remapping shifted script target type {target_type} -> {aliased_target_type}.')
                resolver = SCRIPT_TARGETS.get(aliased_target_type)

        if resolver:
            return resolver(caster, target, param1, param2, spell_template)

        Logger.warning(f'Unknown target type {target_type}.')
        return None

    @staticmethod
    def resolve_provided_target(caster, target=None, param1=None, param2=None, spell_template=None):
        return target

    @staticmethod
    def resolve_hostile(caster, target=None, param1=None, param2=None, spell_template=None):
        if caster.combat_target:
            return caster.combat_target
        if caster.threat_manager:
            return caster.threat_manager.get_hostile_target()
        return None

    @staticmethod
    def resolve_hostile_second_aggro(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_TOPAGGRO)

    @staticmethod
    def resolve_hostile_last_aggro(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_BOTTOMAGGRO)

    @staticmethod
    def resolve_hostile_random(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOM)

    @staticmethod
    def resolve_hostile_random_not_top(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.threat_manager.select_attacking_target(AttackingTarget.ATTACKING_TARGET_RANDOMNOTTOP)

    @staticmethod
    def resolve_owner_or_self(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.get_charmer_or_summoner(include_self=True)

    @staticmethod
    def resolve_owner(caster, target=None, param1=None, param2=None, spell_template=None):
        return caster.get_charmer_or_summoner(include_self=True)

    @staticmethod
    def resolve_nearest_creature_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param1
        radius = param2 if param2 else 0
        targets = ScriptManager._get_surrounding_units(caster, search_range=radius, friends_only=False,
                                                       include_players=False, alive=True)
        if not targets:
            return None

        # Only with given entry.
        matching_units = [unit for unit in targets if unit.entry == entry]
        if not matching_units:
            return None

        # Sort by distance.
        matching_units.sort(key=lambda unit_target: caster.location.distance(unit_target.location))
        return matching_units[0]

    @staticmethod
    def resolve_random_creature_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param1
        search_range: Optional[float] = param2

        units = ScriptManager._get_surrounding_units(caster, search_range=search_range, include_players=False,
                                                     alive=True)
        if not units:
            return None

        matching_units = [unit for unit in units if unit.entry == entry]
        if not matching_units:
            return None

        return choice(matching_units)

    @staticmethod
    def resolve_creature_with_guid(caster, target=None, param1=None, param2=None, spell_template=None):
        spawn_id: Optional[int] = param1
        surrounding_units = caster.get_map().get_surrounding_units(world_object=caster, include_players=False)

        # Find the first unit with matching spawn_id.
        found_unit = next((unit for unit in surrounding_units.values() if unit.spawn_id == spawn_id), None)

        if not found_unit or not found_unit.is_alive:
            Logger.warning(f'Creature lookup by guid failed, {caster.get_name()} search location {caster.location}')
            return None

        return found_unit

    @staticmethod
    def resolve_creature_instance_data(caster, target=None, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_creature_instance_data.')
        return None

    @staticmethod
    def resolve_nearest_gameobject_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param1

        go_objects = list(caster.get_map().get_surrounding_gameobjects(caster).values())
        if not go_objects:
            return None

        # Only with given entry.
        matching_objects = [obj for obj in go_objects if obj.entry == entry]
        if not matching_objects:
            return None

        # Sort by distance.
        matching_objects.sort(key=lambda go_target: caster.location.distance(go_target.location))
        return matching_objects[0]

    @staticmethod
    def resolve_random_gameobject_with_entry(caster, target=None, param1=None, param2=None, spell_template=None):
        entry: Optional[int] = param2
        go_objects = list(caster.get_map().get_surrounding_gameobjects(caster).values())
        if not go_objects:
            return None

        matching_objects = [obj for obj in go_objects if obj.entry == entry]
        if not matching_objects:
            return None

        return choice(matching_objects)

    @staticmethod
    def resolve_gameobject_with_guid(caster, target=None, param1=None, param2=None, spell_template=None):
        spawn_id: Optional[int] = param1
        spawn = caster.get_map().get_surrounding_gameobject_spawn_by_spawn_id(caster, spawn_id)
        if not spawn or not spawn.gameobject_instance or not spawn.gameobject_instance.is_spawned:
            Logger.warning(f'Gameobject lookup by guid failed, source {caster.get_name()} search location {caster.location}')
            return None
        return spawn.gameobject_instance

    @staticmethod
    def resolve_gameobject_from_instance_data(caster, target, param1=None, param2=None, spell_template=None):
        Logger.warning(f'Unimplemented script target: handle_gameobject_from_instance_data.')
        return None

    @staticmethod
    def resolve_friendly(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        exclude_target: Optional[UnitManager] = param2

        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)

        friendlies = ScriptManager._get_surrounding_units(caster,
                                                          search_range=search_range,
                                                          friends_only=True,
                                                          exclude_unit=exclude_target,
                                                          alive=True,
                                                          in_combat=True)
        # Did not find any friendlies.
        if not friendlies:
            return None

        # Return 1 randomly picked friendly unit.
        return choice(friendlies)

    @staticmethod
    def resolve_friendly_injured(caster, target=None, param1=None, param2=None, spell_template=None, is_percent=True):
        search_range: Optional[float] = param1
        hp_percent: Optional[float] = param2
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        if not hp_percent:
            hp_percent = 50.0
        injured_friendlies = ScriptManager._get_injured_friendly_units(caster,
                                                                       radius=search_range,
                                                                       hp_threshold=hp_percent,
                                                                       is_percent=is_percent)
        return injured_friendlies[0] if injured_friendlies else None

    @staticmethod
    def resolve_friendly_injured_except(caster, target=None, param1=None, param2=None, spell_template=None):
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
    def resolve_friendly_missing_buf(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        spell_id: int = param2
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        surrounding_units = ScriptManager._get_surrounding_units(caster,
                                                                 search_range,
                                                                 friends_only=True,
                                                                 alive=True,
                                                                 exclude_unit=caster)
        # No surrounding units found.
        if not surrounding_units:
            return None

        for friendly_unit in surrounding_units:
            if not friendly_unit.aura_manager.has_aura_by_spell_id(spell_id):
                return friendly_unit
        # No suitable target found.
        return None

    @staticmethod
    def resolve_friendly_missing_buf_except(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        spell_id: int = param2
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        surrounding_units = ScriptManager._get_surrounding_units(caster,
                                                                 search_range,
                                                                 alive=True,
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
    def resolve_friendly_cc(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        surrounding_units = ScriptManager._get_surrounding_units(caster,
                                                                 search_range,
                                                                 alive=True,
                                                                 friends_only=True,
                                                                 exclude_unit=caster)
        # No surrounding units found.
        if not surrounding_units:
            return None

        for friendly_unit in surrounding_units:
            if friendly_unit.is_charmed():
                return friendly_unit

        # No suitable target found.
        return None

    @staticmethod
    def resolve_map_event_source(caster, target=None, param1=None, param2=None, spell_template=None):
        target = caster if caster else target
        if not target:
            Logger.error(f'TARGET_T_MAP_EVENT_SOURCE, Unable to resolve target for event {param1}.')
            return None
        map_ = target.get_map()
        if not map_:
            Logger.error(f'TARGET_T_MAP_EVENT_SOURCE, Unable to resolve map for event {param1}.')
            return None
        scripted_event = map_.get_map_event_data(param1)
        if not scripted_event:
            Logger.error(f'TARGET_T_MAP_EVENT_SOURCE, Unable to resolve scripted_event {param1}.')
            return None
        target = scripted_event.get_source()
        if not target:
            Logger.error(f'TARGET_T_MAP_EVENT_SOURCE, Unable to resolve source for scripted_event {param1}.')
            return None
        return target

    @staticmethod
    def resolve_map_event_target(caster, target=None, param1=None, param2=None, spell_template=None):
        target = caster if caster else target
        if not target:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve target for event {param1}.')
            return None
        map_ = target.get_map()
        if not map_:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve map for event {param1}.')
            return None
        scripted_event = map_.get_map_event_data(param1)
        if not scripted_event:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve scripted_event {param1}.')
            return None
        target = scripted_event.get_target()
        if not target:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve target for scripted_event {param1}.')
            return None
        return target

    @staticmethod
    def resolve_map_event_extra_target(caster, target=None, param1=None, param2=None, spell_template=None):
        target = caster if caster else target
        if not target:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve target for event {param1}.')
            return None
        map_ = target.get_map()
        if not map_:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve map for event {param1}.')
            return None
        scripted_event = map_.get_map_event_data(param1)
        if not scripted_event:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve scripted_event {param1}.')
            return None
        extra_target = scripted_event.get_target(entry=param2)
        if not extra_target:
            Logger.error(f'TARGET_T_MAP_EVENT_TARGET, Unable to resolve scripted_event extra target {param2}.')
            return None
        return extra_target

    @staticmethod
    def resolve_nearest_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding units.
        players = ScriptManager._get_surrounding_units(caster, search_range, alive=True)
        # No surrounding units found.
        if not players:
            return None
        # Sort by distance.
        players.sort(key=lambda player: caster.location.distance(player.location))
        return players[0]

    @staticmethod
    def resolve_nearest_hostile_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding enemy units.
        enemy_players = ScriptManager._get_surrounding_players(caster, search_range, enemies_only=True, alive=True)
        # No surrounding units found.
        if not enemy_players:
            return None
        # Sort by distance.
        enemy_players.sort(key=lambda player: caster.location.distance(player.location))
        return enemy_players[0]

    @staticmethod
    def resolve_nearest_friendly_player(caster, target=None, param1=None, param2=None, spell_template=None):
        search_range: Optional[float] = param1
        # Set range if not provided.
        search_range = ScriptManager._get_search_range(search_range, spell_template)
        # Surrounding friendly units.
        friendly_players = ScriptManager._get_surrounding_players(caster, search_range, friends_only=True, alive=True)
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
        return world_object and world_object.is_unit()

    @staticmethod
    def _get_injured_friendly_units(caster, radius, hp_threshold, exclude_unit=None, is_percent=True) -> Optional[list[UnitManager]]:
        # Surrounding friendly units within range, including players.
        surrounding_units_and_players = ScriptManager._get_surrounding_units(caster, radius,
                                                                             friends_only=True,
                                                                             alive=True,
                                                                             exclude_unit=exclude_unit)
        # Did not find any injured friendly.
        if not surrounding_units_and_players:
            return []

        if is_percent:
            # Units below hp_threshold.
            injured_friendly_units = [unit for unit in surrounding_units_and_players if unit.hp_percent < hp_threshold]
        else:
            # HP Deficit.
            injured_friendly_units = [unit for unit in surrounding_units_and_players if abs(unit.health - unit.max_health) >= hp_threshold]

        # No units below hp_threshold found.
        if not injured_friendly_units:
            return []

        # Sort them by lowest hp percentage.
        injured_friendly_units.sort(key=lambda unit: unit.hp_percent)
        return injured_friendly_units

    @staticmethod
    def _filter_units(unit_caller, units_list, search_range=0.0, friends_only=False, enemies_only=False,
                      exclude_unit=None, alive=False, in_combat=False):
        # Start with the original list
        filtered_units = units_list

        # Filter by range if specified
        if search_range > 0:
            max_distance = search_range * 2 if search_range <= 30 else search_range
            filtered_units = [
                unit for unit in filtered_units
                if unit_caller.location.distance(unit.location) < max_distance
            ]

        # Filter by hostility
        if friends_only:
            filtered_units = [unit for unit in filtered_units if not unit_caller.is_hostile_to(unit)]
        elif enemies_only:
            filtered_units = [unit for unit in filtered_units if unit_caller.is_hostile_to(unit)]

        # Exclude specific unit
        if exclude_unit:
            filtered_units = [unit for unit in filtered_units if unit != exclude_unit]

        # Filter alive units
        if alive:
            filtered_units = [unit for unit in filtered_units if unit.is_alive]

        # Filter units in combat
        if in_combat:
            filtered_units = [unit for unit in filtered_units if unit.in_combat]

        return filtered_units

    @staticmethod
    def _get_surrounding_players(unit_caller, search_range=0.0, friends_only=False,
                                 enemies_only=False, alive=False) -> Optional[list[UnitManager]]:
        surrounding_players_list = list(unit_caller.get_map().get_surrounding_players(unit_caller).values())

        # Did not find surrounding players.
        if not surrounding_players_list:
            return []

        surrounding_players_list = ScriptManager._filter_units(unit_caller, surrounding_players_list, search_range,
                                                               friends_only, enemies_only, None, alive)

        return surrounding_players_list if surrounding_players_list else []

    @staticmethod
    def _get_surrounding_units(unit_caller, search_range=0.0, friends_only=False, enemies_only=False,
                               exclude_unit=None, include_players=True, alive=False, in_combat=False) -> list[UnitManager]:
        # Surrounding units including players.
        surrounding_units = unit_caller.get_map().get_surrounding_units(unit_caller, include_players=include_players)
        # Merge if needed.
        if include_players:
            surrounding_units_list = list(surrounding_units[0].values()) + list(surrounding_units[1].values())
        else:
            surrounding_units_list = list(surrounding_units.values())

        # Did not find surrounding units.
        if len(surrounding_units_list) == 0:
            return []

        surrounding_units_list = ScriptManager._filter_units(unit_caller, surrounding_units_list, search_range,
                                                             friends_only, enemies_only, exclude_unit, alive, in_combat)

        return surrounding_units_list if surrounding_units_list else []


SCRIPT_TARGETS = {
    ScriptTarget.TARGET_T_PROVIDED_TARGET: ScriptManager.resolve_provided_target,
    ScriptTarget.TARGET_T_HOSTILE: ScriptManager.resolve_hostile,
    ScriptTarget.TARGET_T_HOSTILE_SECOND_AGGRO: ScriptManager.resolve_hostile_second_aggro,
    ScriptTarget.TARGET_T_HOSTILE_LAST_AGGRO: ScriptManager.resolve_hostile_last_aggro,
    ScriptTarget.TARGET_T_HOSTILE_RANDOM: ScriptManager.resolve_hostile_random,
    ScriptTarget.TARGET_T_HOSTILE_RANDOM_NOT_TOP: ScriptManager.resolve_hostile_random_not_top,
    ScriptTarget.TARGET_T_OWNER_OR_SELF: ScriptManager.resolve_owner_or_self,
    ScriptTarget.TARGET_T_OWNER: ScriptManager.resolve_owner,
    ScriptTarget.TARGET_T_NEAREST_CREATURE_WITH_ENTRY: ScriptManager.resolve_nearest_creature_with_entry,
    ScriptTarget.TARGET_T_CREATURE_WITH_GUID: ScriptManager.resolve_creature_with_guid,
    ScriptTarget.TARGET_T_CREATURE_FROM_INSTANCE_DATA: ScriptManager.resolve_creature_instance_data,
    ScriptTarget.TARGET_T_NEAREST_GAMEOBJECT_WITH_ENTRY: ScriptManager.resolve_nearest_gameobject_with_entry,
    ScriptTarget.TARGET_T_GAMEOBJECT_WITH_GUID: ScriptManager.resolve_gameobject_with_guid,
    ScriptTarget.TARGET_T_FRIENDLY: ScriptManager.resolve_friendly,
    ScriptTarget.TARGET_T_FRIENDLY_INJURED: ScriptManager.resolve_friendly_injured,
    ScriptTarget.TARGET_T_FRIENDLY_INJURED_EXCEPT: ScriptManager.resolve_friendly_injured_except,
    ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF: ScriptManager.resolve_friendly_missing_buf,
    ScriptTarget.TARGET_T_FRIENDLY_MISSING_BUFF_EXCEPT: ScriptManager.resolve_friendly_missing_buf_except,
    ScriptTarget.TARGET_T_FRIENDLY_CC: ScriptManager.resolve_friendly_cc,
    ScriptTarget.TARGET_T_MAP_EVENT_SOURCE: ScriptManager.resolve_map_event_source,
    ScriptTarget.TARGET_T_MAP_EVENT_TARGET: ScriptManager.resolve_map_event_target,
    ScriptTarget.TARGET_T_MAP_EVENT_EXTRA_TARGET: ScriptManager.resolve_map_event_extra_target,
    ScriptTarget.TARGET_T_NEAREST_PLAYER: ScriptManager.resolve_nearest_player,
    ScriptTarget.TARGET_T_NEAREST_HOSTILE_PLAYER: ScriptManager.resolve_nearest_hostile_player,
    ScriptTarget.TARGET_T_NEAREST_FRIENDLY_PLAYER: ScriptManager.resolve_nearest_friendly_player,
    ScriptTarget.TARGET_T_RANDOM_CREATURE_WITH_ENTRY: ScriptManager.resolve_random_creature_with_entry,
    ScriptTarget.TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY: ScriptManager.resolve_random_gameobject_with_entry
}
