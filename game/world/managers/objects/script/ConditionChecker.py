import datetime
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.ConditionCodes import ConditionType, ConditionFlags, ConditionTargetsInternal, EscortConditionFlags
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, QuestState, ObjectTypeFlags
from utils.constants.UnitCodes import Genders, PowerTypes, UnitFlags

MAX_3368_SPELL_ID = 7913


class ConditionChecker:
    def __init__(self):
        pass

    @staticmethod
    def validate(condition_id, source, target):
        if not condition_id:
            return True
        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)
        return ConditionChecker._validate(condition, source, target)

    # Helper functions.

    @staticmethod
    def _validate(condition, source, target):
        if condition.flags & ConditionFlags.CONDITION_FLAG_SWAP_TARGETS:
            _tmp_old_target = target
            target = source
            source = _tmp_old_target

        if not ConditionChecker._check_param_requirements(condition.type, source, target):
            return False

        if condition.type in CONDITIONS:
            result = CONDITIONS[condition.type](condition, source, target)
            if condition.flags & ConditionFlags.CONDITION_FLAG_REVERSE_RESULT:
                return not result

            return result

        else:
            Logger.warning(f'ConditionChecker: Condition {condition.type} does not exist.')
            return False

    @staticmethod
    def _check_param_requirements(condition_type, source, target):
        internal_condition_target = CONDITIONAL_TARGETS_INTERNAL_MAP.get(condition_type, None)
        if internal_condition_target is not None:  # Can be 0.
            return CONDITIONAL_TARGETS_INTERNAL[internal_condition_target](source, target)
        else:
            Logger.warning(f'Unable to resolve internal condition target for type {condition_type}')

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
        return not ConditionChecker.validate(condition.value1, source, target)

    @staticmethod
    # Returns True if any condition is met.
    def check_condition_or(condition, source, target):
        conditions = ConditionChecker.get_filtered_condition_values(condition)
        return any([ConditionChecker.validate(req_condition, source, target) for req_condition in conditions])

    @staticmethod
    # Returns True if all conditions are met.
    def check_condition_and(condition, source, target):
        conditions = ConditionChecker.get_filtered_condition_values(condition)
        return all([ConditionChecker.validate(req_condition, source, target) for req_condition in conditions])

    @staticmethod
    def check_condition_none(_condition, _source, _target):
        return True

    @staticmethod
    def check_condition_aura(condition, _source, target):
        # Requires Unit target.
        # Returns True if target has aura.
        # Spell_id = condition_value1.
        # Effect_index = condition_value2.
        if not ConditionChecker.is_unit(target):
            return False
        # TODO: Effect index.
        if condition.value1 > MAX_3368_SPELL_ID:
            Logger.error(f'ConditionChecker: Invalid spell id ({condition.value1}), '
                         f'Condition entry {condition.condition_entry}')
        return target.aura_manager.has_aura_by_spell_id(condition.value1)

    @staticmethod
    def check_condition_item(condition, _source, target):
        # Requires Player target.
        # Returns True if target has item.
        # Item_id = condition_value1.
        # Count = condition_value2.
        if not ConditionChecker.is_player(target):
            return False
        return target.inventory.get_item_count(condition.value1) >= condition.value2

    @staticmethod
    def check_condition_item_equipped(condition, _source, target):
        # Requires Player target.
        # Returns True if target has item equipped.
        # Item_id = condition_value1.
        # Unused in 0.5.3.
        if not ConditionChecker.is_player(target):
            return False

        for item in list(target.inventory.get_backpack().sorted_slots.values()):
            if item.entry == condition.value1 and item.is_equipped():
                return True

        return False

    @staticmethod
    def check_condition_area_id(condition, _source, target):
        # Requires WorldObject target or source.
        # Returns True if target is in area.
        # Area_id = condition_value1.
        if not target:
            return False
        # TODO: Check this, we might need to validate parent zone id, also check area condition
        return target.zone == condition.value1  # or target.area

    @staticmethod
    def check_condition_reputation_rank_min(_condition, _source, _target):
        # Requires Player target.
        # Returns True if target has reputation >= rank.
        # Faction_id = condition_value1.
        # Rank = condition_value2.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_REPUTATION_RANK_MIN is not implemented.')
        return False

    @staticmethod
    def check_condition_team(condition, _source, target):
        # Requires Player target.
        # Returns True if target is on team.
        # Team = condition_value1 (469 = alliance, 67 = horde).
        if not ConditionChecker.is_player(target):
            return False
        return target.team == condition.value1

    @staticmethod
    def check_condition_skill(condition, _source, target):
        # Requires Player target.
        # Returns True if target has skill >= value.
        # Skill_id = condition_value1.
        # Value = condition_value2.
        if not ConditionChecker.is_player(target):
            return False
        return target.skill_manager.get_total_skill_value(condition.value1) >= condition.value2

    @staticmethod
    def check_condition_quest_rewarded(condition, _source, target):
        # Requires Player target.
        # Returns True if target has completed quest.
        # Quest_id = condition_value1.
        if not ConditionChecker.is_player(target):
            return False
        return target.quest_manager.get_quest_state(condition.value1) == QuestState.QUEST_REWARD

    @staticmethod
    def check_condition_quest_taken(condition, _source, target):
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
    def check_condition_ad_commission_aura(_condition, _source, _target):
        # Requires Player target.
        # Returns True if player has Argent Dawn Commission aura.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_AD_COMMISSION_AURA is not implemented.')
        return False

    @staticmethod
    def check_condition_saved_variable(_condition, _source, _target):
        # Checks a global saved variable.
        # Index = condition_value1.
        # Value = condition_value2.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_SAVED_VARIABLE is not implemented.')
        return False

    @staticmethod
    def check_condition_active_game_event(_condition, _source, _target):
        # Checks if a game event is active.
        # Event_id = condition_value1.
        Logger.warning('CONDITION_ACTIVE_GAME_EVENT is not implemented.')
        return False

    @staticmethod
    def check_condition_cant_path_to_victim(_condition, source, target):
        # Requires Unit source.
        # Returns True if source cannot path to target.
        # Unused in 0.5.3.
        if not ConditionChecker.is_unit(target):
            return False
        if not ConditionChecker.is_unit(source):
            return False

        return not source.get_map().can_reach_object(source, target)

    @staticmethod
    def check_condition_race_class(condition, _source, target):
        # Requires Player target.
        # Condition_value1 = race mask.
        # Condition_value2 = class mask.
        if not ConditionChecker.is_player(target):
            return False
        return target.race_mask & condition.value1 and target.class_mask & condition.value2

    @staticmethod
    def check_condition_level(condition, _source, target):
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
    def check_condition_source_entry(condition, source, _target):
        # Requires WorldObject source.
        # Checks if the source's entry is among the ones specified.
        # Condition_value1 = entry 1.
        # Condition_value2 = entry 2.
        # Condition_value3 = entry 3.
        # Condition_value4 = entry 4.
        if not source:
            return False

        return any(source.entry == entry for entry in ConditionChecker.get_filtered_condition_values(condition))

    @staticmethod
    def check_condition_spell(condition, _source, target):
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
    def check_condition_instance_script(_condition, _source, _target):
        # Requires Map.
        # Condition_value1 = map id.
        # Condition_value2 = instance condition id.
        Logger.warning('CONDITION_INSTANCE_SCRIPT is not implemented.')
        return False

    @staticmethod
    def check_condition_quest_available(condition, _source, target):
        # Requires Player target.
        # Checks if the player can take the quest.
        # Condition_value1 = quest id.
        if not ConditionChecker.is_player(target):
            return False
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(condition.value1)
        return target.quest_manager.check_quest_requirements(quest) \
            and target.quest_manager.check_quest_level(quest, False)

    @staticmethod
    def check_condition_nearby_creature(condition, _source, target):
        # Requires WorldObject target.
        # Checks if there is a creature nearby.
        # Condition_value1 = creature entry.
        # Condition_value2 = distance.
        # Condition_value3 = dead.
        # Condition_value4 = not self.
        if not target:
            Logger.warning('CONDITION_NEARBY_CREATURE: No target, aborting.')
            return False

        creatures = target.get_map().get_surrounding_units_by_location(target.location, target.map_id,
                                                                       target.instance_id, condition.value2,
                                                                       include_players=False)[0].values()

        for creature in creatures:
            if creature.creature_template.entry != condition.value1:
                continue
            if condition.value3 and creature.is_alive:
                continue
            if condition.value4 and creature == target:
                continue

            return True

        return False

    @staticmethod
    def check_condition_nearby_gameobject(condition, _source, target):
        # Requires WorldObject target.
        # Checks if there is a gameobject nearby.
        # Condition_value1 = gameobject entry.
        # Condition_value2 = distance.
        if not target:
            Logger.warning('CONDITION_NEARBY_GAMEOBJECT: No target, aborting.')
            return False

        for guid, gobject in list(target.get_map().get_surrounding_gameobjects(target).items()):
            distance = target.location.distance(gobject.location)
            if distance <= condition.value2 and gobject.gobject_template.entry == condition.value1:
                return True

        return False

    @staticmethod
    def check_condition_quest_none(condition, _source, target):
        # Requires Player target.
        # Checks if the player has not taken or completed the quest.
        # Condition_value1 = quest id.
        if not ConditionChecker.is_player(target):
            return False
        return condition.value1 not in target.quest_manager.completed_quests and condition.value1 not in \
            target.quest_manager.active_quests

    @staticmethod
    def check_condition_item_with_bank(condition, _source, target):
        # Requires Player target.
        # Checks if the player has the item in inventory or bank.
        # Condition_value1 = item id.
        # Condition_value2 = count.
        if not ConditionChecker.is_player(target):
            return False
        return target.inventory_manager.get_item_count(condition.value1, include_bank=True) >= condition.value2

    @staticmethod
    def check_condition_wow_patch(_condition, _source, _target):
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
            return True

        if condition.value1 & EscortConditionFlags.CF_ESCORT_SOURCE_DEAD and not source.is_alive:
            return True

        if condition.value1 & EscortConditionFlags.CF_ESCORT_TARGET_DEAD and not target.is_alive or not target.online:
            return True

        if condition.value2 and source.location.distance(target.location) >= condition.value2:
            return True

        return False

    @staticmethod
    def check_condition_active_holiday(_condition, _source, _target):
        # Checks if a given holiday is active.
        # Condition_value1 = holiday id.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_ACTIVE_HOLIDAY is not implemented.')
        return False

    @staticmethod
    def check_condition_gender(condition, _source, target):
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
    def check_condition_is_player(condition, _source, target):
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
    def check_condition_skill_below(condition, _source, target):
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
    def check_condition_reputation_rank_max(_condition, _source, _target):
        # Requires Player target.
        # Checks if the player's reputation rank is below or equal to the specified rank.
        # Condition_value1 = faction id.
        # Condition_value2 = reputation rank.
        # Not used in 0.5.3.
        Logger.warning('CONDITION_REPUTATION_RANK_MAX is not implemented.')
        return False

    @staticmethod
    def check_condition_has_flag(_condition, _source, _target):
        # Requires WorldObject source.
        # Checks if the source has the specified flag.
        # Condition_value1 = field_id.
        # Condition_value2 = flag.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_HAS_FLAG is not implemented.')
        return False

    @staticmethod
    def check_condition_last_waypoint(_condition, _source, _target):
        # Requires Creature source.
        # Checks the creature's last waypoint.
        # Condition_value1 = waypoint id.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        # Unused in 0.5.3
        Logger.warning('CONDITION_LAST_WAYPOINT is not implemented.')
        return False

    @staticmethod
    def check_condition_map_id(condition, source, _target):
        # Requires Map.
        # Checks the current Map id.
        # Condition_value1 = map id.
        if not source:
            return False
        return source.map_id == condition.value1

    @staticmethod
    def check_condition_instance_data(_condition, _source, _target):
        # Requires Map.
        # Gets data from Instance script and checks returned value.
        # Condition_value1 = index.
        # Condition_value2 = data.
        # Condition_value3 = 0 equal, 1 equal or higher, 2 equal or lower.
        # Seems to be only used by vMangos C++ scripting.
        Logger.warning('CONDITION_INSTANCE_DATA is not implemented.')
        return False

    @staticmethod
    def check_condition_map_event_data(condition, source, _target):
        # Requires Map.
        # Gets data from a scripted Map event and checks the returned value.
        # Condition_value1 = event id.
        # Condition_value2 = index.
        # Condition_value3 = data.
        # Condition_value4 = 0 equal, 1 equal or higher, 2 equal or lower.
        map_instance = source.get_map()
        if not map_instance:
            return False

        event = map_instance.get_map_event_data(condition.value1)
        if not event:
            return False

        if condition.value4 == 0:
            return event.event_data[condition.value2] == condition.value3
        elif condition.value4 == 1:
            return event.event_data[condition.value2] >= condition.value3
        elif condition.value4 == 2:
            return event.event_data[condition.value2] <= condition.value3
        else:
            return False

    @staticmethod
    def check_condition_map_event_active(condition, source, _target):
        # Requires Map.
        # Checks if a scripted Map event is active.
        # Condition_value1 = event id.
        map_instance = source.get_map()
        if not map_instance:
            return False

        return map_instance.is_event_active(condition.value1)

    @staticmethod
    def check_condition_line_of_sight(_condition, source, target):
        # Requires WorldObject source and target.
        # Checks if the source has line of sight to the target.
        if not source or not target:
            return False
        return source.get_map().los_check(source.location, target.location)

    @staticmethod
    def check_condition_distance_to_target(condition, source, target):
        # Requires Worldobject source and target.
        # Checks the distance between the source and target.
        # Condition_value1 = distance.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        if not source or not target:
            return False

        distance = source.location.distance(target.location)
        if condition.value2 == 0:
            return distance == condition.value1
        elif condition.value2 == 1:
            return distance >= condition.value1
        elif condition.value2 == 2:
            return distance <= condition.value1

        return False

    @staticmethod
    def check_condition_is_moving(_condition, _source, target):
        # Requires WorldObject target.
        # Checks if the target is moving.
        if not ConditionChecker.is_unit(target):
            return False
        return target.is_moving()

    @staticmethod
    def check_condition_has_pet(_condition, _source, target):
        # Requires Unit target.
        # Checks if the target has a pet.
        if not ConditionChecker.is_unit(target):
            return False
        return target.pet_manager.get_active_controlled_pet()

    @staticmethod
    def check_condition_health_percent(condition, _source, target):
        # Requires Unit target.
        # Checks the target's health percentage.
        # Condition_value1 = health percentage.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        if not ConditionChecker.is_unit(target):
            return False

        health_percent = (target.health / target.max_health) * 100
        if condition.value2 == 0:
            return health_percent == condition.value1
        elif condition.value2 == 1:
            return health_percent >= condition.value1
        elif condition.value2 == 2:
            return health_percent <= condition.value1

        return False

    @staticmethod
    def check_condition_mana_percent(condition, _source, target):
        # Requires Unit target.
        # Checks the target's mana percentage.
        # Condition_value1 = mana percentage.
        # Condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower.
        # Unused in 0.5.3
        if not ConditionChecker.is_unit(target) or target.power_type != PowerTypes.TYPE_MANA:
            return False

        mana_percent = (target.power1 / target.max_power1) * 100
        if condition.value2 == 0:
            return mana_percent == condition.value1
        elif condition.value2 == 1:
            return mana_percent >= condition.value1
        elif condition.value2 == 2:
            return mana_percent <= condition.value1

        return False

    @staticmethod
    def check_condition_is_in_combat(_condition, _source, target):
        # Requires Unit target.
        # Checks if the target is in combat.
        if not ConditionChecker.is_unit(target):
            return False
        return target.unit_flags & UnitFlags.UNIT_FLAG_IN_COMBAT

    @staticmethod
    def check_condition_is_hostile_to(_condition, source, target):
        # Requires WorldObject source and target.
        # Checks if the source is hostile to the target.
        # Unused in 0.5.3.
        if not source or not target:
            return False
        return source.is_hostile_to(target)

    @staticmethod
    def check_condition_is_in_group(_condition, _source, target):
        # Requires Player target.
        # Checks if the target is in a group.
        if not ConditionChecker.is_player(target):
            return False
        return target.group_manager

    @staticmethod
    def check_condition_is_alive(_condition, _source, target):
        # Requires Unit target.
        # Checks if the target is alive.
        if not ConditionChecker.is_unit(target):
            return False
        return target.is_alive

    @staticmethod
    def check_condition_map_event_targets(condition, _source, _target):
        # Requires Map.
        # True if all extra targets that are part of the given event satisfy the given condition.
        # Condition_value1 = event id.
        # Condition_value2 = condition id.
        satisfied = True
        unit = _source if _source else _target
        map_ = unit.get_map(unit.map_id, unit.instance_id)
        if not map_:
            return False
        scripted_event = map_.get_map_event_data(condition.value1)
        if scripted_event:
            for event_target in scripted_event.event_targets:
                satisfied = satisfied and ConditionChecker.validate(condition.value2, _source, event_target)
                if not satisfied:
                    return False
        return satisfied

    @staticmethod
    def check_condition_object_is_spawned(_condition, _source, target):
        # Requires GameObject target.
        # Checks if the target is spawned.
        if not ConditionChecker.is_gameobject(target):
            return False
        return target.is_spawned

    @staticmethod
    def check_condition_object_loot_state(_condition, _source, _target):
        # Requires GameObject target.
        # Checks the target's loot state.
        # Condition_value1 = loot state (LootState enum).
        # Unused in 0.5.3.
        Logger.warning('CONDITION_OBJECT_LOOT_STATE is not implemented.')
        return False

    @staticmethod
    def check_condition_object_fit_condition(_condition, _source, _target):
        # Requires Map.
        # Check if the target object with guid exists and satisfies the given condition.
        # Condition_value1 = object guid.
        # Condition_value2 = condition id.
        # Unused in 0.5.3.
        Logger.warning('CONDITION_OBJECT_FIT_CONDITION is not implemented.')
        return False

    @staticmethod
    def check_condition_pvp_rank(_condition, _source, _target):
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
    def check_condition_local_time(condition, _source, _target):
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
        return source.location.distance(condition.value1, condition.value2, condition.value3) <= condition.value4

    @staticmethod
    def check_condition_object_go_state(condition, _source, target):
        # Requires GameObject target.
        # Checks the target's GO state.
        # Condition_value1 = GO state (GameObjectStates enum).
        if not ConditionChecker.is_gameobject(target):
            return False
        return target.state == condition.value1

    @staticmethod
    def check_condition_nearby_player(condition, _source, target):
        # Requires Unit target.
        # Checks if a player is within radius.
        # Condition_value1 = 0 any, 1 hostile, 2 friendly.
        # Condition_value2 = radius.
        if not ConditionChecker.is_unit(target):
            return False
        radius = condition.value2
        for guid, player in list(target.get_map().get_surrounding_players(target).items()):
            if condition.value1 == 0 and player.location.distance(target.location) <= radius:
                return True
            elif condition.value1 == 1 and player.is_hostile_to(target) and \
                    player.location.distance(target.location) <= radius:
                return True
            elif condition.value1 == 2 and player.is_friendly_to(target) \
                    and player.location.distance(target.location) <= radius:
                return True
        return False

    @staticmethod
    def check_condition_creature_group_member(condition, _source, target):
        # Checks if creature is part of a group.
        # Requirement: Creature Source.
        # Condition_value1 = leader_guid (optional).
        if not ConditionChecker.is_unit(target):
            return False

        if not target.creature_group:
            return False

        return not condition.value2 or target.creature_group.original_leader_spawn_id == condition.value2

    @staticmethod
    def check_condition_creature_group_dead(_condition, _source, target):
        # Checks if creature's group is dead.
        # Requirement: Creature Source
        if not ConditionChecker.is_unit(target):
            return True

        if not target.creature_group:
            return True

        return target.creature_group.get_alive_count() == 0

    # Target Internal Check
    @staticmethod
    def check_target_none(_source, _target):
        return True

    @staticmethod
    def check_target_unit(_source, target):
        return target and target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT

    @staticmethod
    def check_target_player(_source, target):
        return target and target.get_type_id() == ObjectTypeIds.ID_PLAYER

    @staticmethod
    def check_target_any_worldobject(source, target):
        return (source and source.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT) \
            or (target and target.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT)

    @staticmethod
    def check_target_source_unit(source, _target):
        return source and source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT

    @staticmethod
    def check_target_source_worldobject(source, _target):
        return source and source.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT

    @staticmethod
    def check_target_map_or_worldobject(source, target):
        return (source and source.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT) \
            or (target and target.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT)

    @staticmethod
    def check_target_worldobject(_source, target):
        return target and target.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT

    @staticmethod
    def check_target_source_creature(source, _target):
        return source and source.get_type_id() == ObjectTypeIds.ID_UNIT

    @staticmethod
    def check_target_both_worldobjects(source, target):
        return (source and source.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT) \
            and (target and target.get_type_mask() & ObjectTypeFlags.TYPE_OBJECT)

    @staticmethod
    def check_target_gameobject(_source, target):
        return target and target.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT


CONDITIONAL_TARGETS_INTERNAL_MAP = {
    -3: ConditionTargetsInternal.CONDITION_REQ_NONE,
    -2: ConditionTargetsInternal.CONDITION_REQ_NONE,
    -1: ConditionTargetsInternal.CONDITION_REQ_NONE,
    0: ConditionTargetsInternal.CONDITION_REQ_NONE,
    11: ConditionTargetsInternal.CONDITION_REQ_NONE,
    12: ConditionTargetsInternal.CONDITION_REQ_NONE,
    24: ConditionTargetsInternal.CONDITION_REQ_NONE,
    25: ConditionTargetsInternal.CONDITION_REQ_NONE,
    26: ConditionTargetsInternal.CONDITION_REQ_NONE,
    53: ConditionTargetsInternal.CONDITION_REQ_NONE,
    1: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    15: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    40: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    41: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    42: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    43: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    46: ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT,
    2: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    3: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    5: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    6: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    7: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    8: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    9: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    10: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    14: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    17: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    19: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    22: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    23: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    29: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    30: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    45: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    51: ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER,
    4: ConditionTargetsInternal.CONDITION_REQ_ANY_WORLDOBJECT,
    13: ConditionTargetsInternal.CONDITION_REQ_SOURCE_UNIT,
    16: ConditionTargetsInternal.CONDITION_REQ_SOURCE_WORLDOBJECT,
    31: ConditionTargetsInternal.CONDITION_REQ_SOURCE_WORLDOBJECT,
    52: ConditionTargetsInternal.CONDITION_REQ_SOURCE_WORLDOBJECT,
    18: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    33: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    34: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    35: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    36: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    47: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    50: ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT,
    20: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    21: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    27: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    28: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    39: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    54: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    56: ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT,
    32: ConditionTargetsInternal.CONDITION_REQ_SOURCE_CREATURE,
    57: ConditionTargetsInternal.CONDITION_REQ_SOURCE_CREATURE,
    58: ConditionTargetsInternal.CONDITION_REQ_SOURCE_CREATURE,
    37: ConditionTargetsInternal.CONDITION_REQ_BOTH_WORLDOBJECTS,
    38: ConditionTargetsInternal.CONDITION_REQ_BOTH_WORLDOBJECTS,
    44: ConditionTargetsInternal.CONDITION_REQ_BOTH_WORLDOBJECTS,
    48: ConditionTargetsInternal.CONDITION_REQ_TARGET_GAMEOBJECT,
    49: ConditionTargetsInternal.CONDITION_REQ_TARGET_GAMEOBJECT,
    55: ConditionTargetsInternal.CONDITION_REQ_TARGET_GAMEOBJECT
}


CONDITIONAL_TARGETS_INTERNAL = {
    ConditionTargetsInternal.CONDITION_REQ_NONE: ConditionChecker.check_target_none,
    ConditionTargetsInternal.CONDITION_REQ_TARGET_UNIT: ConditionChecker.check_target_unit,
    ConditionTargetsInternal.CONDITION_REQ_TARGET_PLAYER: ConditionChecker.check_target_player,
    ConditionTargetsInternal.CONDITION_REQ_ANY_WORLDOBJECT: ConditionChecker.check_target_any_worldobject,
    ConditionTargetsInternal.CONDITION_REQ_SOURCE_UNIT: ConditionChecker.check_target_source_unit,
    ConditionTargetsInternal.CONDITION_REQ_SOURCE_WORLDOBJECT: ConditionChecker.check_target_source_worldobject,
    ConditionTargetsInternal.CONDITION_REQ_MAP_OR_WORLDOBJECT: ConditionChecker.check_target_map_or_worldobject,
    ConditionTargetsInternal.CONDITION_REQ_TARGET_WORLDOBJECT: ConditionChecker.check_target_worldobject,
    ConditionTargetsInternal.CONDITION_REQ_SOURCE_CREATURE: ConditionChecker.check_target_source_creature,
    ConditionTargetsInternal.CONDITION_REQ_BOTH_WORLDOBJECTS: ConditionChecker.check_target_both_worldobjects,
    ConditionTargetsInternal.CONDITION_REQ_TARGET_GAMEOBJECT: ConditionChecker.check_target_gameobject
}


CONDITIONS = {
    ConditionType.CONDITION_NOT: ConditionChecker.check_condition_not,
    ConditionType.CONDITION_OR: ConditionChecker.check_condition_or,
    ConditionType.CONDITION_AND: ConditionChecker.check_condition_and,
    ConditionType.CONDITION_NONE: ConditionChecker.check_condition_none,
    ConditionType.CONDITION_AURA: ConditionChecker.check_condition_aura,
    ConditionType.CONDITION_ITEM: ConditionChecker.check_condition_item,
    ConditionType.CONDITION_ITEM_EQUIPPED: ConditionChecker.check_condition_item_equipped,
    ConditionType.CONDITION_AREAID: ConditionChecker.check_condition_area_id,
    ConditionType.CONDITION_REPUTATION_RANK_MIN: ConditionChecker.check_condition_reputation_rank_min,
    ConditionType.CONDITION_TEAM: ConditionChecker.check_condition_team,
    ConditionType.CONDITION_SKILL: ConditionChecker.check_condition_skill,
    ConditionType.CONDITION_QUEST_NONE: ConditionChecker.check_condition_quest_none,
    ConditionType.CONDITION_QUESTAVAILABLE: ConditionChecker.check_condition_quest_available,
    ConditionType.CONDITION_QUESTREWARDED: ConditionChecker.check_condition_quest_rewarded,
    ConditionType.CONDITION_QUESTTAKEN: ConditionChecker.check_condition_quest_taken,
    ConditionType.CONDITION_AD_COMMISSION_AURA: ConditionChecker.check_condition_ad_commission_aura,
    ConditionType.CONDITION_SAVED_VARIABLE: ConditionChecker.check_condition_saved_variable,
    ConditionType.CONDITION_ACTIVE_GAME_EVENT: ConditionChecker.check_condition_active_game_event,
    ConditionType.CONDITION_CANT_PATH_TO_VICTIM: ConditionChecker.check_condition_cant_path_to_victim,
    ConditionType.CONDITION_RACE_CLASS: ConditionChecker.check_condition_race_class,
    ConditionType.CONDITION_LEVEL: ConditionChecker.check_condition_level,
    ConditionType.CONDITION_SOURCE_ENTRY: ConditionChecker.check_condition_source_entry,
    ConditionType.CONDITION_SPELL: ConditionChecker.check_condition_spell,
    ConditionType.CONDITION_INSTANCE_SCRIPT: ConditionChecker.check_condition_instance_script,

    ConditionType.CONDITION_NEARBY_CREATURE: ConditionChecker.check_condition_nearby_creature,
    ConditionType.CONDITION_NEARBY_GAMEOBJECT: ConditionChecker.check_condition_nearby_gameobject,

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
