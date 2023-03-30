import datetime
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.ConditionCodes import ConditionType, ConditionFlags
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, QuestState, ObjectTypeFlags
from utils.constants.UnitCodes import Genders, PowerTypes, UnitFlags


class ConditionChecker:
    def __init__(self):
        pass

    @staticmethod
    def check_condition(condition_id, source, target):
        if not condition_id:
            return True
        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)
        return ConditionChecker._check_condition(condition, source, target)

    # Helper functions.

    @staticmethod
    def _check_condition(condition, source, target):
        if condition.flags & ConditionFlags.CONDITION_FLAG_SWAP_TARGETS:
            _target = target
            _source = target
            source = _target
            target = _source

        if condition.type in CONDITIONS:
            result = CONDITIONS[condition.type](condition, source, target)
            if condition.flags & ConditionFlags.CONDITION_FLAG_REVERSE_RESULT:
                return not result

            return result

        else:
            Logger.warning(f'ConditionChecker: Condition {condition.type} does not exist.')
            return False

    @staticmethod
    def is_player(target):
        return target and target.get_type_id() == ObjectTypeIds.ID_PLAYER

    @staticmethod
    def is_creature(target):
        return target and target.get_type_id() == ObjectTypeIds.ID_UNIT

    @staticmethod
    def is_unit(target):
        return target and target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT

    @staticmethod
    def is_gameobject(target):
        return target and target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT

    @staticmethod
    def time_in_range(start, end, current):
        return start <= current <= end

    @staticmethod
    def get_filtered_condition_values(condition):
        return list(filter((0).__ne__, [condition.value1, condition.value2, condition.value3, condition.value4]))

    @staticmethod
    # Deprecated but still used in some scripts.
    def check_condition_not(condition, source, target):
        return not ConditionChecker.check_condition(condition.value1, source, target)

    @staticmethod
    # Returns True if any condition is met.
    def check_condition_or(condition, source, target):
        condition_values = ConditionChecker.get_filtered_condition_values(condition)
        return any([ConditionChecker.check_condition(condition_value, source, target)
                    for condition_value in condition_values])

    @staticmethod
    # Returns True if all conditions are met.
    def check_condition_and(condition, source, target):
        condition_values = ConditionChecker.get_filtered_condition_values(condition)
        return all([ConditionChecker.check_condition(condition_value, source, target)
                    for condition_value in condition_values])

    @staticmethod
    def check_condition_none(condition, source, target):
        return True

    @staticmethod
    def check_condition_aura(condition, source, target):
        # Requires Unit target.
        # Returns True if target has aura.
        # Spell_id = condition_value1.
        # Effect_index = condition_value2.
        if not ConditionChecker.is_unit(target):
            return False
        # TODO: Effect index.
        return target.aura_manager.has_aura_by_spell_id(condition.value1)

    @staticmethod
    def check_condition_item(condition, source, target):
        # Requires Player target.
        # Returns True if target has item.
        # Item_id = condition_value1.
        # Count = condition_value2.
        if not ConditionChecker.is_player(target):
            return False
        return target.inventory.get_item_count(condition.value1) > condition.value2

    @staticmethod
    def check_condition_item_equipped(condition, source, target):
        # Requires Player target.
        # Returns True if target has item equipped.
        # Item_id = condition_value1.
        if not ConditionChecker.is_player(target):
            return False

        for item in list(target.inventory.get_backpack().sorted_slots.values()):
            if item.entry == condition.value1 and item.is_equipped():
                return True

        return False

    @staticmethod
    def check_condition_areaid(condition, source, target):
        # Requires WorldObject target or source.
        # Returns True if target is in area.
        # Area_id = condition_value1.
        if not target:
            return False
        # TODO: Check this, we might need to validate parent zone id.
        return target.zone_id == condition.value1

    @staticmethod
    def check_condition_reputation_rank_min(condition, source, target):
        # Requires Player target.
        # Returns True if target has reputation >= rank.
        # Faction_id = condition_value1.
        # Rank = condition_value2.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_REPUTATION_RANK_MIN is not implemented.')
        return False

    @staticmethod
    def check_condition_team(condition, source, target):
        # Requires Player target.
        # Returns True if target is on team.
        # Team = condition_value1 (469 = alliance, 67 = horde).
        if not ConditionChecker.is_player(target):
            return False
        return target.team == condition.value1

    @staticmethod
    def check_condition_skill(condition, source, target):
        # Requires Player target.
        # Returns True if target has skill >= value.
        # Skill_id = condition_value1.
        # Value = condition_value2.
        if not ConditionChecker.is_player(target):
            return False
        return target.skill_manager.get_total_skill_value(condition.value1) >= condition.value2

    @staticmethod
    def check_condition_questrewarded(condition, source, target):
        # Requires Player target.
        # Returns True if target has completed quest.
        # Quest_id = condition_value1.
        if not ConditionChecker.is_player(target):
            return False
        return target.quest_manager.get_quest_state(condition.value1) == QuestState.QUEST_REWARD

    @staticmethod
    def check_condition_questtaken(condition, source, target):
        # Requires Player target.
        # Returns True if target has taken quest.
        # Quest_id = condition_value1.
        # Condition_value2: 0 any state, 1 incomplete, 2 complete.
        if not ConditionChecker.is_player(target):
            return False
        quest_state = target.quest_manager.get_quest_state(condition.value1)
        if condition.value2 == 0:
            return quest_state == QuestState.QUEST_ACCEPTED or quest_state == QuestState.QUEST_REWARD
        elif condition.value2 == 1:
            return quest_state == QuestState.QUEST_ACCEPTED and not quest_state == QuestState.QUEST_REWARD
        elif condition.value2 == 2:
            return quest_state == QuestState.QUEST_REWARD

        return False

    @staticmethod
    def check_condition_ad_commission_aura(condition, source, target):
        # Requires Player target.
        # Returns True if player has Argent Dawn Commission aura.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_AD_COMMISSION_AURA is not implemented.')
        return False

    @staticmethod
    def check_condition_saved_variable(condition, source, target):
        # Checks a global saved variable.
        # Index = condition_value1.
        # Value = condition_value2.
        Logger.warning('CONDITION_SAVED_VARIABLE is not implemented.')
        return False

    @staticmethod
    def check_condition_active_game_event(condition, source, target):
        # Checks if a game event is active.
        # Event_id = condition_value1.
        Logger.warning('CONDITION_ACTIVE_GAME_EVENT is not implemented.')
        return False

    @staticmethod
    def check_condition_cant_path_to_victim(condition, source, target):
        from game.world.managers.maps.MapManager import MapManager
        # Requires Unit source.
        # Returns True if source cannot path to target.
        if not ConditionChecker.is_unit(target):
            return False
        if not ConditionChecker.is_unit(source):
            return False

        return not MapManager.can_reach_object(source, target)

    @staticmethod
    def check_condition_race_class(condition, source, target):
        # Requires Player target.
        # Condition_value1 = race mask.
        # Condition_value2 = class mask.
        if not ConditionChecker.is_player(target):
            return False
        return target.race_mask & condition.value1 and target.class_mask & condition.value2

    @staticmethod
    def check_condition_level(condition, source, target):
        # Requires Unit target.
        # Value = condition_value1.
        # Condition_value2: 0 any state, 1 equal or higher, 2 equal or lower.
        if not ConditionChecker.is_unit(target):
            return False

        if condition.value2 == 0:
            return target.level == condition.value1
        elif condition.value2 == 1:
            return target.level >= condition.value1
        elif condition.value2 == 2:
            return target.level <= condition.value1

        return False

    @staticmethod
    def check_condition_source_entry(condition, source, target):
        # Requires WorldObject source.
        # Checks if the source's entry is among the ones specified.
        # Condition_value1 = entry 1.
        # Condition_value2 = entry 2.
        # Condition_value3 = entry 3.
        # Condition_value4 = entry 4.
        if not source:
            return False

        return source.entry == condition.value1 or source.entry == condition.value2 \
            or source.entry == condition.value3 or source.entry == condition.value4

    @staticmethod
    def check_condition_spell(condition, source, target):
        # Requires Player target.
        # Checks if the player has learned the spell.
        # Condition_value1 = spell id.
        # Condition_value2 = 0 has spell, 1 hasn't spell.
        if not ConditionChecker.is_player(target):
            return False

        if condition.value2 == 0:
            return condition.value1 in target.spell_manager.spells
        elif condition.value2 == 1:
            return condition.value1 not in target.spell_manager.spells

        return False

    @staticmethod
    def check_condition_instance_script(condition, source, target):
        # Requires Map.
        # Condition_value1 = map id.
        # Condition_value2 = instance condition id.
        Logger.warning('CONDITION_INSTANCE_SCRIPT is not implemented.')
        return False

    @staticmethod
    def check_condition_quest_available(condition, source, target):
        # Requires Player target.
        # Checks if the player can take the quest.
        # Condition_value1 = quest id.
        if not ConditionChecker.is_player(target):
            return False
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(condition.value1)
        return target.quest_manager.check_quest_requirements(quest) \
            and target.quest_manager.check_quest_level(quest, False)

    @staticmethod
    def check_condition_nearby_creature(condition, source, target):
        # Requires WorldObject target.
        # Checks if there is a creature nearby.
        # Condition_value1 = creature entry.
        # Condition_value2 = distance.
        # Condition_value3 = dead.
        # Condition_value4 = not self.
        if not target:
            Logger.warning('CONDITION_NEARBY_CREATURE: No target, aborting.')
            return False

        from game.world.managers.maps.MapManager import MapManager
        creatures = MapManager.get_surrounding_units_by_location(target.location, target.map_id, target.instance_id, condition.value2)
        good_creatures = {}
        for creature in creatures[0].values():
            if creature.creature_template.entry == condition.value1:
                if condition.value4:
                    if creature == target:
                        continue
                    else:
                        good_creatures.append(creature)
                else:
                    good_creatures.append(creature)

        if len(good_creatures) == 0:
            return False

        for creature in good_creatures:
            if condition.value3 and not creature.is_alive:
                return True
            else:
                return True

        return False

    @staticmethod
    def check_condition_nearby_gameobject(condition, source, target):
        # Requires WorldObject target.
        # Checks if there is a gameobject nearby.
        # Condition_value1 = gameobject entry.
        # Condition_value2 = distance.
        Logger.warning('CONDITION_NEARBY_GAMEOBJECT is not implemented.')
        return False

    @staticmethod
    def check_condition_quest_none(condition, source, target):
        # Requires Player target.
        # Checks if the player has not taken or completed the quest.
        # Condition_value1 = quest id.
        if not ConditionChecker.is_player(target):
            return False
        return condition.value1 not in target.quest_manager.completed_quests and condition.value1 not in target.quest_manager.active_quests

    @staticmethod
    def check_condition_item_with_bank(condition, source, target):
        # Requires Player target.
        # Checks if the player has the item in inventory or bank.
        # Condition_value1 = item id.
        # Condition_value2 = count.
        if not ConditionChecker.is_player(target):
            return False
        return target.inventory_manager.get_item_count(condition.value1) >= condition.value2

    @staticmethod
    def check_condition_wow_patch(condition, source, target):
        # Checks if the client is running a specific patch.
        # Condition_value1 = patch id.
        # Condition_value2 = 0 equal, 1 equal and higher, 2 equal and lower.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_WOW_PATCH is not implemented.')
        return False

    @staticmethod
    def check_condition_escort(condition, source, target):
        # Requirements: None, optionally player target, creature source.
        # Checks if the source and target are alive and the distance between them.
        # Condition_value1 = EscortConditionFlags.
        # Condition_value2 = distance.
        if not ConditionChecker.is_creature(source) or not ConditionChecker.is_player(target):
            return False

        if source.position.distance(target.position) <= condition.value2 and source.is_alive and target.is_alive:
            return True

        # TODO: implement EscortConditionFlags + handle optional source/target.
        return False

    @staticmethod
    def check_condition_active_holiday(condition, source, target):
        # Checks if a given holiday is active.
        # Condition_value1 = holiday id.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_ACTIVE_HOLIDAY is not implemented.')
        return False

    @staticmethod
    def check_condition_gender(condition, source, target):
        # Requires Unit target.
        # Checks the target's gender.
        # Condition_value1 = gender (0 male, 1 female, 2 none).
        if not ConditionChecker.is_unit(target):
            return False

        if condition.value1 == 0:
            return target.gender == Genders.GENDER_MALE
        elif condition.value1 == 1:
            return target.gender == Genders.GENDER_FEMALE
        else:
            return target.gender not in (Genders.GENDER_MALE, Genders.GENDER_FEMALE)

    @staticmethod
    def check_condition_is_player(condition, source, target):
        # Requires WorldObject target.
        # Checks if the target is a player.
        # Condition_value1 = 0 player, 1 player or owned by a player.
        if not target:
            return False

        if condition.value1 == 0:
            return ConditionChecker.is_player(target)
        elif condition.value1 == 1:
            charmer_or_summoner = target.get_charmer_or_summoner()
            return ConditionChecker.is_player(target) or ConditionChecker.is_player(charmer_or_summoner)

        return False

    @staticmethod
    def check_condition_skill_below(condition, source, target):
        # Requires Player target.
        # Checks if the player has learned the skill.
        # And the skill is below the specified value.
        # Condition_value1 = skill id.
        # Condition_value2 = skill value (if 1 then True if the player does not know the skill).
        if not ConditionChecker.is_player(target):
            return False

        if condition.value2 == 1 and condition.value1 not in target.skill_manager.skills:
            return True
        else:
            return target.skill_manager.get_total_skill_value(condition.value1) < condition.value2

    @staticmethod
    def check_condition_reputation_rank_max(condition, source, target):
        # Requires Player target.
        # Checks if the player's reputation rank is below or equal to the specified rank.
        # Condition_value1 = faction id.
        # Condition_value2 = reputation rank.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_REPUTATION_RANK_MAX is not implemented.')
        return False

    @staticmethod
    def check_condition_has_flag(condition, source, target):
        # Requires WorldObject source.
        # Checks if the source has the specified flag.
        # Condition_value1 = field_id.
        # Condition_value2 = flag.
        Logger.warning('CONDITION_HAS_FLAG is not implemented.')
        return False

    @staticmethod
    def check_condition_last_waypoint(condition, source, target):
        # Requires Creature source.
        # Checks the creature's last waypoint.
        # Condition_value1 = waypoint id.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        Logger.warning('CONDITION_LAST_WAYPOINT is not implemented.')
        return False

    @staticmethod
    def check_condition_map_id(condition, source, target):
        # Requires Map.
        # Checks the current Map id.
        # Condition_value1 = map id.
        if not source:
            return False
        return source.map_id == condition.value1

    @staticmethod
    def check_condition_instance_data(condition, source, target):
        # Requires Map.
        # Gets data from Instance script and checks returned value.
        # Condition_value1 = index.
        # Condition_value2 = data.
        # Condition_value3 = 0 equal, 1 equal or higher, 2 equal or lower.
        Logger.warning('CONDITION_INSTANCE_DATA is not implemented.')
        return False

    @staticmethod
    def check_condition_map_event_data(condition, source, target):
        from game.world.managers.maps.MapManager import MapManager
        # Requires Map.
        # Gets data from a scripted Map event and checks the returned value.
        # Condition_value1 = event id.
        # Condition_value2 = index.
        # Condition_value3 = data.
        # Condition_value4 = 0 equal, 1 equal or higher, 2 equal or lower.
        map_instance = MapManager.get_map(source.map_id, source.instance_id)
        if map_instance:
            event = map_instance.map_event_manager.get_map_event_data(condition.value1)
            if event:
                if condition.value4 == 0:
                    return event.event_data[condition.value2] == condition.value3
                elif condition.value4 == 1:
                    return event.event_data[condition.value2] >= condition.value3
                elif condition.value4 == 2:
                    return event.event_data[condition.value2] <= condition.value3

            return False

    @staticmethod
    def check_condition_map_event_active(condition, source, target):
        from game.world.managers.maps.MapManager import MapManager
        # Requires Map.
        # Checks if a scripted Map event is active.
        # Condition_value1 = event id.
        map_instance = MapManager.get_map(source.map_id, source.instance_id)
        if map_instance:
            return map_instance.map_event_manager.is_event(condition.value1)

        return False

    @staticmethod
    def check_condition_line_of_sight(condition, source, target):
        from game.world.managers.maps.MapManager import MapManager
        # Requires WorldObject source and target.
        # Checks if the source has line of sight to the target.
        if not source or not target:
            return False
        return MapManager.los_check(source.map_id, source.position, target.position)

    @staticmethod
    def check_condition_distance_to_target(condition, source, target):
        # Requires Worldobject source and target.
        # Checks the distance between the source and target.
        # Condition_value1 = distance.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        if not source or not target:
            return False

        distance = source.position.distance(target.position)
        if condition.value2 == 0:
            return distance == condition.value1
        elif condition.value2 == 1:
            return distance >= condition.value1
        elif condition.value2 == 2:
            return distance <= condition.value1

        return False

    @staticmethod
    def check_condition_is_moving(condition, source, target):
        # Requires WorldObject target.
        # Checks if the target is moving.
        if not ConditionChecker.is_unit(target):
            return False
        return target.is_moving()

    @staticmethod
    def check_condition_has_pet(condition, source, target):
        # Requires Unit target.
        # Checks if the target has a pet.
        if not ConditionChecker.is_unit(target):
            return False
        return target.pet_manager.get_active_controlled_pet()

    @staticmethod
    def check_condition_health_percent(condition, source, target):
        # Requires Unit target.
        # Checks the target's health percentage.
        # Condition_value1 = health percentage.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        if not ConditionChecker.is_unit(target):
            return False

        health_percent = target.health / target.max_health * 100
        if condition.value2 == 0:
            return health_percent == condition.value1
        elif condition.value2 == 1:
            return health_percent >= condition.value1
        elif condition.value2 == 2:
            return health_percent <= condition.value1

        return False

    @staticmethod
    def check_condition_mana_percent(condition, source, target):
        # Requires Unit target.
        # Checks the target's mana percentage.
        # Condition_value1 = mana percentage.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        if not ConditionChecker.is_unit(target) or target.power_type != PowerTypes.TYPE_MANA:
            return False

        mana_percent = target.power1 / target.max_power1 * 100
        if condition.value2 == 0:
            return mana_percent == condition.value1
        elif condition.value2 == 1:
            return mana_percent >= condition.value1
        elif condition.value2 == 2:
            return mana_percent <= condition.value1

        return False

    @staticmethod
    def check_condition_is_in_combat(condition, source, target):
        # Requires Unit target.
        # Checks if the target is in combat.
        if not ConditionChecker.is_unit(target):
            return False
        return target.unit_flags & UnitFlags.UNIT_FLAG_IN_COMBAT

    @staticmethod
    def check_condition_is_hostile_to(condition, source, target):
        # Requires WorldObject source and target.
        # Checks if the source is hostile to the target.
        if not source or not target:
            return False
        return source.is_hostile_to(target)

    @staticmethod
    def check_condition_is_in_group(condition, source, target):
        # Requires Player target.
        # Checks if the target is in a group.
        if not ConditionChecker.is_player(target):
            return False
        return target.group_manager

    @staticmethod
    def check_condition_is_alive(condition, source, target):
        # Requires Unit target.
        # Checks if the target is alive.
        if not ConditionChecker.is_unit(target):
            return False
        return target.is_alive

    @staticmethod
    def check_condition_map_event_targets(condition, source, target):
        # Requires Map.
        # True if all extra targets that are part of the given event satisfy the given condition.
        # Condition_value1 = event id.
        # Condition_value2 = condition id.
        Logger.warning('CONDITION_MAP_EVENT_TARGETS is not implemented.')
        return False

    @staticmethod
    def check_condition_object_is_spawned(condition, source, target):
        # Requires GameObject target.
        # Checks if the target is spawned.
        if not ConditionChecker.is_gameobject(target):
            return False
        return target.is_spawned

    @staticmethod
    def check_condition_object_loot_state(condition, source, target):
        # Requires GameObject target.
        # Checks the target's loot state.
        # Condition_value1 = loot state (LootState enum).
        Logger.warning('CONDITION_OBJECT_LOOT_STATE is not implemented.')
        return False

    @staticmethod
    def check_condition_object_fit_condition(condition, source, target):
        # Requires Map.
        # Check if the target object with guid exists and satisfies the given condition.
        # Condition_value1 = object guid.
        # Condition_value2 = condition id.
        Logger.warning('CONDITION_OBJECT_FIT_CONDITION is not implemented.')
        return False

    @staticmethod
    def check_condition_pvp_rank(condition, source, target):
        # Requires Player target.
        # Checks the target's pvp rank.
        # Condition_value1 = pvp rank.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_PVP_RANK is not implemented.')
        return False

    @staticmethod
    def check_condition_db_guid(condition, source, target):
        # Requires WorldObject source.
        # Checks the source's db guid.
        # Condition_value1 = db guid.
        # Condition_value2 = db_guid (optional).
        # Condition_value3 = db_guid (optional).
        # Condition_value4 = db_guid (optional).
        if not ConditionChecker.is_gameobject(source) or not ConditionChecker.is_creature(target):
            return False

        if condition.value1 == source.spawn_id:
            return True
        elif condition.value2 == source.spawn_id:
            return True
        elif condition.value3 == source.spawn_id:
            return True
        elif condition.value4 == source.spawn_id:
            return True

        return False

    @staticmethod
    def check_condition_local_time(condition, source, target):
        # Checks if the local time is i.n the given range.
        # Condition_value1 = start hour.
        # Condition_value2 = start minute.
        # Condition_value3 = end hour.
        # Condition_value4 = end minute.
        current_time = datetime.datetime.now().time()
        start_time = datetime.time(condition.value1, condition.value2, 0)
        end_time = datetime.time(condition.value3, condition.value4, 0)
        return ConditionChecker.time_in_range(start_time, end_time, current_time)

    @staticmethod
    def check_condition_distance_to_position(condition, source, target):
        # Requires WorldObject target.
        # Checks if the target is within distance of the given coords.
        # Condition_value1 = x.
        # Condition_value2 = y.
        # Condition_value3 = z.
        # Condition_value4 = distance.
        if not target:
            return False
        return source.position.distance(condition.value1, condition.value2, condition.value3) <= condition.value4

    @staticmethod
    def check_condition_object_go_state(condition, source, target):
        # Requires GameObject target.
        # Checks the target's GO state.
        # Condition_value1 = GO state (GameObjectStates enum).
        if not ConditionChecker.is_gameobject(target):
            return False
        return target.state == condition.value1

    @staticmethod
    def check_condition_nearby_player(condition, source, target):
        from game.world.managers.maps.MapManager import MapManager
        # Requires Unit target.
        # Checks if a player is within radius.
        # Condition_value1 = 0 any, 1 hostile, 2 friendly.
        # Condition_value2 = radius.
        if not ConditionChecker.is_unit(target):
            return False
        radius = condition.value2
        units = MapManager.get_surrounding_players(target)
        for player in units:
            if condition.value1 == 0 and player.position.distance(target.position) <= radius:
                return True
            elif condition.value1 == 1 and player.is_hostile_to(target) and \
                    player.position.distance(target.position) <= radius:
                return True
            elif condition.value1 == 2 and player.is_friendly_to(target) \
                    and player.position.distance(target.position) <= radius:
                return True
        return False

    @staticmethod
    def check_condition_creature_group_member(condition, source, target):
        # Checks if creature is part of a group.
        # Requirement: Creature Source.
        # Condition_value1 = leader_guild (optional).
        Logger.warning('CONDITION_CREATURE_GROUP_MEMBER is not implemented.')
        return False

    @staticmethod
    def check_condition_creature_group_dead(condition, source, target):
        # Checks if creature's group is dead.
        # Requirement: Creature Source
        Logger.warning('CONDITION_CREATURE_GROUP_DEAD is not implemented.')
        return False


CONDITIONS = {
    ConditionType.CONDITION_NOT: ConditionChecker.check_condition_not,
    ConditionType.CONDITION_OR: ConditionChecker.check_condition_or,
    ConditionType.CONDITION_AND: ConditionChecker.check_condition_and,
    ConditionType.CONDITION_NONE: ConditionChecker.check_condition_none,
    ConditionType.CONDITION_AURA: ConditionChecker.check_condition_aura,
    ConditionType.CONDITION_ITEM: ConditionChecker.check_condition_item,
    ConditionType.CONDITION_ITEM_EQUIPPED: ConditionChecker.check_condition_item_equipped,
    ConditionType.CONDITION_AREAID: ConditionChecker.check_condition_areaid,
    ConditionType.CONDITION_REPUTATION_RANK_MIN: ConditionChecker.check_condition_reputation_rank_min,
    ConditionType.CONDITION_TEAM: ConditionChecker.check_condition_team,
    ConditionType.CONDITION_SKILL: ConditionChecker.check_condition_skill,
    ConditionType.CONDITION_QUESTREWARDED: ConditionChecker.check_condition_questrewarded,
    ConditionType.CONDITION_QUESTTAKEN: ConditionChecker.check_condition_questtaken,
    ConditionType.CONDITION_AD_COMMISSION_AURA: ConditionChecker.check_condition_ad_commission_aura,
    ConditionType.CONDITION_SAVED_VARIABLE: ConditionChecker.check_condition_saved_variable,
    ConditionType.CONDITION_ACTIVE_GAME_EVENT: ConditionChecker.check_condition_active_game_event,
    ConditionType.CONDITION_CANT_PATH_TO_VICTIM: ConditionChecker.check_condition_cant_path_to_victim,
    ConditionType.CONDITION_RACE_CLASS: ConditionChecker.check_condition_race_class,
    ConditionType.CONDITION_LEVEL: ConditionChecker.check_condition_level,
    ConditionType.CONDITION_SOURCE_ENTRY: ConditionChecker.check_condition_source_entry,
    ConditionType.CONDITION_SPELL: ConditionChecker.check_condition_spell,
    ConditionType.CONDITION_INSTANCE_SCRIPT: ConditionChecker.check_condition_instance_script,
    ConditionType.CONDITION_QUESTAVAILABLE: ConditionChecker.check_condition_quest_available,
    ConditionType.CONDITION_NEARBY_CREATURE: ConditionChecker.check_condition_nearby_creature,
    ConditionType.CONDITION_NEARBY_GAMEOBJECT: ConditionChecker.check_condition_nearby_gameobject,
    ConditionType.CONDITION_QUEST_NONE: ConditionChecker.check_condition_quest_none,
    ConditionType.CONDITION_ITEM_WITH_BANK: ConditionChecker.check_condition_item_with_bank,
    ConditionType.CONDITION_WOW_PATCH: ConditionChecker.check_condition_wow_patch,
    ConditionType.CONDITION_ESCORT: ConditionChecker.check_condition_escort,
    ConditionType.CONDITION_ACTIVE_HOLIDAY: ConditionChecker.check_condition_active_holiday,
    ConditionType.CONDITION_GENDER: ConditionChecker.check_condition_gender,
    ConditionType.CONDITION_IS_PLAYER: ConditionChecker.check_condition_is_player,
    ConditionType.CONDITION_SKILL_BELOW: ConditionChecker.check_condition_skill_below,
    ConditionType.CONDITION_REPUTATION_RANK_MAX: ConditionChecker.check_condition_reputation_rank_max,
    ConditionType.CONDITION_HAS_FLAG: ConditionChecker.check_condition_has_flag,
    ConditionType.CONDITION_LAST_WAYPOINT: ConditionChecker.check_condition_last_waypoint,
    ConditionType.CONDITION_MAPID: ConditionChecker.check_condition_map_id,
    ConditionType.CONDITION_INSTANCE_DATA: ConditionChecker.check_condition_instance_data,
    ConditionType.CONDITION_MAP_EVENT_DATA: ConditionChecker.check_condition_map_event_data,
    ConditionType.CONDITION_MAP_EVENT_ACTIVE: ConditionChecker.check_condition_map_event_active,
    ConditionType.CONDITION_LINE_OF_SIGHT: ConditionChecker.check_condition_line_of_sight,
    ConditionType.CONDITION_DISTANCE_TO_TARGET: ConditionChecker.check_condition_distance_to_target,
    ConditionType.CONDITION_IS_MOVING: ConditionChecker.check_condition_is_moving,
    ConditionType.CONDITION_HAS_PET: ConditionChecker.check_condition_has_pet,
    ConditionType.CONDITION_HEALTH_PERCENT: ConditionChecker.check_condition_health_percent,
    ConditionType.CONDITION_MANA_PERCENT: ConditionChecker.check_condition_mana_percent,
    ConditionType.CONDITION_IS_IN_COMBAT: ConditionChecker.check_condition_is_in_combat,
    ConditionType.CONDITION_IS_HOSTILE_TO: ConditionChecker.check_condition_is_hostile_to,
    ConditionType.CONDITION_IS_IN_GROUP: ConditionChecker.check_condition_is_in_group,
    ConditionType.CONDITION_IS_ALIVE: ConditionChecker.check_condition_is_alive,
    ConditionType.CONDITION_MAP_EVENT_TARGETS: ConditionChecker.check_condition_map_event_targets,
    ConditionType.CONDITION_OBJECT_IS_SPAWNED: ConditionChecker.check_condition_object_is_spawned,
    ConditionType.CONDITION_OBJECT_LOOT_STATE: ConditionChecker.check_condition_object_loot_state,
    ConditionType.CONDITION_OBJECT_FIT_CONDITION: ConditionChecker.check_condition_object_fit_condition,
    ConditionType.CONDITION_PVP_RANK: ConditionChecker.check_condition_pvp_rank,
    ConditionType.CONDITION_DB_GUID: ConditionChecker.check_condition_db_guid,
    ConditionType.CONDITION_LOCAL_TIME: ConditionChecker.check_condition_local_time,
    ConditionType.CONDITION_DISTANCE_TO_POSITION: ConditionChecker.check_condition_distance_to_position,
    ConditionType.CONDITION_OBJECT_GO_STATE: ConditionChecker.check_condition_object_go_state,
    ConditionType.CONDITION_NEARBY_PLAYER: ConditionChecker.check_condition_nearby_player,
    ConditionType.CONDITION_CREATURE_GROUP_MEMBER: ConditionChecker.check_condition_creature_group_member,
    ConditionType.CONDITION_CREATURE_GROUP_DEAD: ConditionChecker.check_condition_creature_group_dead
}
