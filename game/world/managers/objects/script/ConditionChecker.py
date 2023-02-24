import datetime
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps import MapManager
from utils.constants.ConditionCodes import ConditionType
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, QuestState
from utils.constants.UnitCodes import Genders, PowerTypes, UnitFlags

class ConditionChecker:

    @staticmethod
    def check_condition(condition_id, source, target): 

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if condition.type in CONDITIONS: 
            return CONDITIONS[condition.type](condition_id, source, target)
        else:
            Logger.warning(f'ConditionChecker: Condition {condition.type} not implemented')
            return False

    # Helper functions
    @staticmethod
    def is_player(target):
        return target and target.get_type_id() == ObjectTypeIds.ID_PLAYER
    
    def is_unit(target):
        return target and target.get_type_id() == ObjectTypeIds.ID_UNIT
    
    # https://blog.finxter.com/how-to-check-if-the-current-time-is-in-a-range-in-python/
    def time_in_range(start, end, current):
        return start <= current <= end

    @staticmethod
    def check_condition_not(condition_id, source, target):
        # deprecated but still used in some scripts

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        return not ConditionChecker.check_condition(condition.value1, source, target)
    
    @staticmethod
    def check_condition_or(condition_id, source, target):
        # returns true if any of the conditions are true

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        return ConditionChecker.check_condition(condition.value1, source, target) or \
            ConditionChecker.check_condition(condition.value2, source, target) or \
            ConditionChecker.check_condition(condition.value3, source, target)   
    
    @staticmethod
    def check_condition_and(condition_id, source, target):
        # returns true if all of the conditions are true

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        return ConditionChecker.check_condition(condition.value1, source, target) and \
            ConditionChecker.check_condition(condition.value2, source, target) and \
            ConditionChecker.check_condition(condition.value3, source, target)

    @staticmethod
    def check_condition_none(condition_id, source, target):
        # always true
        return True
    
    @staticmethod
    def check_condition_aura(condition_id, source, target):
        # requires Unit target
        # returns True if target has aura 
        # spell_id = condition_value1
        # effect_index = condition_value2

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_unit(target) and target.aura_manager:
            return target.aura_manager.has_aura_by_spell_id(condition.value1)
            # no idea what effect_index is so we'll just skip it for now            

        return False
    
    @staticmethod
    def check_condition_item(condition_id, source, target):
        # requires Player target
        # returns True if target has item
        # item_id = condition_value1
        # count = condition_value2

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.inventory:
            return target.inventory.get_item_count(condition.value1) > condition.value2

        return False
    
    @staticmethod
    def check_condition_item_equipped(condition_id, source, target):
        # requires Player target
        # returns True if target has item equipped
        # item_id = condition_value1

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.inventory:
            containers = target.inventory.containers
            for container in containers:
                for item in container.items:
                    if item.entry == condition.value1 and item.is_equipped():
                        return True

        return False
    
    @staticmethod
    def check_condition_areaid(condition_id, source, target):
        # requires WorldObject target or source
        # returns True if target is in area
        # area_id = condition_value1
        # TODO: implement
        return False
    
    @staticmethod
    def check_condition_reputation_rank_min(condition_id, source, target):
        # requires Player target
        # returns True if target has reputation >= rank
        # faction_id = condition_value1
        # rank = condition_value2
        # not used in 0.5.3
        return False
    
    @staticmethod
    def check_condition_team(condition_id, source, target):
        # requires Player target
        # returns True if target is on team
        # team = condition_value1 (469 = alliance, 67 = horde)
        
        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target):
            return target.team == condition.value1
        
        return False
    
    @staticmethod
    def check_condition_skill(condition_id, source, target):
        # requires Player target
        # returns True if target has skill >= value
        # skill_id = condition_value1
        # value = condition_value2

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.skill_manager:
            return target.skill_manager.get_total_skill_value(condition.value1) >= condition.value2
        
        return False
    
    @staticmethod
    def check_condition_questrewarded(condition_id, source, target):
        # requires Player target
        # returns True if target has completed quest
        # quest_id = condition_value1

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.quest_manager:
            return target.quest_manager.get_quest_state(condition.value1) == QuestState.QUEST_REWARD

        return False
    
    @staticmethod
    def check_condition_questtaken(condition_id, source, target):
        # requires Player target
        # returns True if target has taken quest
        # quest_id = condition_value1
        # condition_value2: 0 any state, 1 incomplete, 2 complete

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.quest_manager:
            quest_state = target.quest_manager.get_quest_state(condition.value1)
            if condition.value2 == 0:
                return quest_state == QuestState.QUEST_ACCEPTED or quest_state == QuestState.QUEST_REWARD
            elif condition.value2 == 1:
                return quest_state == QuestState.QUEST_ACCEPTED and not quest_state == QuestState.QUEST_REWARD
            elif condition.value2 == 2:
                return quest_state == QuestState.QUEST_REWARD

        return False
    
    @staticmethod
    def check_condition_ad_commission_aura(condition_id, source, target):
        # requires Player target
        # returns True if player has Argent Dawn Commission aura
        # unused in 0.5.3
        return False
    
    @staticmethod
    def check_condition_saved_variable(condition_id, source, target):
        # checks a global saved variable
        # index = condition_value1
        # value = condition_value2
        # TODO: implement if the need ever arises. We don't have any saved variables yet.
        return False
    
    @staticmethod
    def check_condition_active_game_event(condition_id, source, target):
        # checks if a game event is active
        # event_id = condition_value1
        # TODO: implement if needed
        return False
    
    @staticmethod
    def check_condition_cant_path_to_victim(condition_id, source, target):
        # requires Unit source
        # returns True if source cannot path to target
        
        if source and ConditionChecker.is_unit(source) and target and ConditionChecker.is_unit(target):
            return MapManager.can_reach_object(source, target)[0]

        return False
    
    @staticmethod
    def check_condition_race_class(condition_id, source, target):
        # requires Player target
        # condition_value1 = race mask
        # condition_value2 = class mask

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target):
            # this may be wrong?
            return target.race_mask & condition.value1 and target.class_mask & condition.value2

        return False
    
    @staticmethod
    def check_condition_level(condition_id, source, target):
        # requires Unit target        
        # value = condition_value1
        # condition_value2: 0 any state, 1 equal or higher, 2 equal or lower

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_unit(target):
            if condition.value2 == 0:
                return target.level == condition.value1
            elif condition.value2 == 1:
                return target.level >= condition.value1
            elif condition.value2 == 2:
                return target.level <= condition.value1

        return False
    
    @staticmethod
    def check_condition_source_entry(condition_id, source, target):
        # requires WorldObject source
        # checks if the source's entry is among the ones specified
        # condition_value1 = entry 1
        # condition_value2 = entry 2
        # condition_value3 = entry 3
        # condition_value4 = entry 4

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if source and source.entry:
            return source.entry == condition.value1 or source.entry == condition.value2 or source.entry == condition.value3 \
                or source.entry == condition.value4

        return False
    
    @staticmethod
    def check_condition_spell(condition_id, source, target):
        # requires Player target
        # checks if the player has learned the spell
        # condition_value1 = spell id
        # condition_value2 = 0 has spell, 1 hasn't spell

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.spell_manager:
            if condition.value2 == 0:
                return condition.value1 in target.spell_manager.spells
            elif condition.value2 == 1:
                return condition.value1 not in target.spell_manager.spells
            
        return False
    
    @staticmethod
    def check_condition_instance_script(condition_id, source, target):
        # requires Map
        # condition_value1 = map id
        # condition_value2 = instance condition id
        # TODO: implement if needed
        return False
    
    @staticmethod
    def check_condition_questavailable(condition_id, source, target):
        # requires Player target
        # checks if the player can take the quest
        # condition_value1 = quest id

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.quest_manager:
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(condition.value1)
            return target.quest_manager.get_quest_requirements(quest) and target.quest_manager.get_quest_level(quest) <= target.level

        return False
    
    @staticmethod
    def check_condition_nearby_creature(condition_id, source, target):
        # requires WorldObject target
        # checks if there is a creature nearby
        # condition_value1 = creature entry
        # condition_value2 = distance
        # condition_value3 = dead
        # condition_value4 = not self
        return False
    
    @staticmethod
    def check_condition_nearby_gameobject(condition_id, source, target):
        # requires WorldObject target
        # checks if there is a gameobject nearby
        # condition_value1 = gameobject entry
        # condition_value2 = distance
        return False
    
    @staticmethod
    def check_condition_quest_none(condition_id, source, target):
        # requires Player target
        # checks if the player has not taken or completed the quest
        # condition_value1 = quest id

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.quest_manager:
            return condition.value1 not in target.quest_manager.completed_quests
        
        return False
    
    @staticmethod
    def check_condition_item_with_bank(condition_id, source, target):
        # requires Player target
        # checks if the player has the item in inventory or bank
        # condition_value1 = item id
        # condition_value2 = count

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.inventory_manager:
            return target.inventory_manager.get_item_count(condition.value1) >= condition.value2
        
        return False
    
    @staticmethod
    def check_condition_wow_patch(condition_id, source, target):
        # checks if the client is running a specific patch
        # condition_value1 = patch id
        # condition_value2 = 0 equal, 1 equal and higher, 2 equal and lower
        # not used in 0.5.3
        return False
    
    @staticmethod
    def check_condition_escort(condition_id, source, target):
        # requirements: None, optionally player target, creature source
        # checks if the source and target are alive and the distance between them
        # condition_value1 = EscortConditionFlags
        # condition_value2 = distance
        return False
    
    @staticmethod
    def check_condition_active_holiday(condition_id, source, target):
        # checks if a given holiday is active
        # condition_value1 = holiday id
        # not used in 0.5.3
        return False
    
    @staticmethod
    def check_condition_gender(condition_id, source, target):
        # requires WorldObject target
        # checks the target's gender
        # condition_value1 = gender (0 male, 1 female, 2 none)

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and target.gender:
            match condition.value1:
                case 0:
                    return target.gender == Genders.GENDER_MALE
                case 1:
                    return target.gender == Genders.GENDER_FEMALE
                case 2: 
                    return not target.gender == Genders.GENDER_MALE and not target.gender == Genders.GENDER_FEMALE
                
        return False
    
    @staticmethod
    def check_condition_is_player(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is a player
        # condition_value1 = 0 player, 1 player or owned by a player

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target:
            if condition.value1 == 0:
                return ConditionChecker.is_player(target)
            elif condition.value1 == 1:
                return ConditionChecker.is_player(target) or ConditionChecker.is_player(target.summoner)
            
        return False

    @staticmethod
    def check_condition_skill_below(condition_id, source, target):
        # requires Player target
        # checks if the player has learned the skill 
        # and the skill is below the specified value
        # condition_value1 = skill id
        # condition_value2 = skill value (if 1 then True if the player does not know the skill)

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and ConditionChecker.is_player(target) and target.skill_manager:
            if condition.value2 == 1:
                if condition.value1 not in target.skill_manager.skills:
                    return True
            else:                
                return target.skill_manager.get_skill_value_for_spell_id(condition.value1) < condition.value2
            
        return False
    
    @staticmethod
    def check_condition_reputation_rank_max(condition_id, source, target):
        # requires Player target
        # checks if the player's reputation rank is below or equal to the specified rank
        # condition_value1 = faction id
        # condition_value2 = reputation rank
        # not used in 0.5.3
        return False
    
    @staticmethod
    def check_condition_has_flag(condition_id, source, target):
        # requires WorldObject source
        # checks if the source has the specified flag
        # condition_value1 = field_id
        # condition_value2 = flag
        # almost certainly unused in 0.5.3
        return False
    
    @staticmethod
    def check_condition_last_waypoint(condition_id, source, target):
        # requires Creature source
        # checks the creature's last waypoint
        # condition_value1 = waypoint id
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower
        return False
    
    @staticmethod
    def check_condition_mapid(condition_id, source, target):
        # requires Map
        # checks the current Map id
        # condition_value1 = map id

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if source:
            return MapManager.get_map_by_object(source).id == condition.value1
        
        return False
    
    @staticmethod
    def check_condition_instance_data(condition_id, source, target):
        # requires Map
        # gets data from Instance script and checks returned value
        # condition_value1 = index
        # condition_value2 = data
        # condition_value3 = 0 equal, 1 equal or higher, 2 equal or lower
        return False
    
    @staticmethod
    def check_condition_map_event_data(condition_id, source, target):
        # requires Map
        # gets data from a scripted Map event and checks the returned value
        # condition_value1 = event id
        # condition_value2 = index
        # condition_value3 = data
        # condition_value4 = 0 equal, 1 equal or higher, 2 equal or lower
        return False
    
    @staticmethod
    def check_condition_map_event_active(condition_id, source, target):
        # requires Map
        # checks if a scripted Map event is active
        # condition_value1 = event id
        return False
    
    @staticmethod
    def check_condition_line_of_sight(condition_id, source, target):
        # requires WorldObject source and target
        # checks if the source has line of sight to the target

        if source and target:
            return MapManager.los_check(MapManager.get_map_by_object(source), source.position, target.position)            
            
        return False
    
    @staticmethod
    def check_condition_distance_to_target(condition_id, source, target):
        # requires Worldobject source and target
        # checks the distance between the source and target
        # condition_value1 = distance
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if source and target:
            distance = source.position.distance(target.position)
            match condition.value2:
                case 0:
                    return distance == condition.value1
                case 1:
                    return distance >= condition.value1
                case 2:
                    return distance <= condition.value1
                
        return False

    @staticmethod
    def check_condition_is_moving(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is moving

        if target:
            return target.is_moving()
        
        return False
    
    @staticmethod
    def check_condition_has_pet(condition_id, source, target):
        # requires Unit target
        # checks if the target has a pet

        if target and target.pet_manager:
            return target.pet_manager.active_pet is not None
        
        return False
         
    @staticmethod
    def check_condition_health_percent(condition_id, source, target):
        # requires Unit target
        # checks the target's health percentage
        # condition_value1 = health percentage
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target:
            health_percent = target.health / target.max_health * 100
            match condition.value2:
                case 0:
                    return health_percent == condition.value1
                case 1:
                    return health_percent >= condition.value1
                case 2:
                    return health_percent <= condition.value1
                
        return False

    @staticmethod
    def check_condition_mana_percent(condition_id, source, target):
        # requires Unit target
        # checks the target's mana percentage
        # condition_value1 = mana percentage
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target and target.power_type == PowerTypes.TYPE_MANA:
            mana_percent = target.power1 / target.max_power1 * 100
            match condition.value2:
                case 0:
                    return mana_percent == condition.value1
                case 1:
                    return mana_percent >= condition.value1
                case 2:
                    return mana_percent <= condition.value1
                
        return False
    
    @staticmethod
    def check_condition_is_in_combat(condition_id, source, target):
        # requires Unit target
        # checks if the target is in combat

        if target:
            return target.unit_flags & UnitFlags.UNIT_FLAG_IN_COMBAT
        
        return False
    
    @staticmethod
    def check_condition_is_hostile_to(condition_id, source, target):
        # requires WorldObject source and target
        # checks if the source is hostile to the target

        if source and target:
            return source.is_hostile_to(target)
        
        return False
    
    @staticmethod
    def check_condition_is_in_group(condition_id, source, target):
        # requires Player target
        # checks if the target is in a group

        if target and ConditionChecker.is_player(target):
            return target.group_manager is not None
        
        return False
    
    @staticmethod
    def check_condition_is_alive(condition_id, source, target):
        # requires Unit target
        # checks if the target is alive

        if target:
            return target.is_alive
        
        return False
    
    @staticmethod
    def check_condition_map_event_targets(condition_id, source, target):
        # requires Map
        # true if all extra targets that are part of the given event
        # satisfy the given condition
        # condition_value1 = event id
        # condition_value2 = condition id
        return False

    @staticmethod
    def check_condition_object_is_spawned(condition_id, source, target):
        # requires GameObject target
        # checks if the target is spawned

        if target:
            return target.is_spawned
        
        return False
    
    @staticmethod
    def check_condition_object_loot_state(condition_id, source, target):
        # requires GameObject target
        # checks the target's loot state
        # condition_value1 = loot state (LootState enum)
        return False
    
    @staticmethod
    def check_condition_object_fit_condition(condition_id, source, target):
        # requires Map
        # check if the target object with guid exists and satisfies the given condition
        # condition_value1 = object guid
        # condition_value2 = condition id
        return False
    
    @staticmethod
    def check_condition_pvp_rank(condition_id, source, target):
        # requires Player target
        # checks the target's pvp rank
        # condition_value1 = pvp rank
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower
        # unused in 0.5.3
        return False

    @staticmethod
    def check_condition_db_guid(condition_id, source, target):
        # requires WorldObject source
        # checks the source's db guid
        # condition_value1 = db guid
        # condition_value2 = db_guid (optional)
        # condition_value3 = db_guid (optional)
        # condition_value4 = db_guid (optional)

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if source:
            if condition.value1 == source.guid:
                return True
            elif condition.value2 == source.guid:
                return True
            elif condition.value3 == source.guid:
                return True
            elif condition.value4 == source.guid:
                return True
            
        return False
    
    @staticmethod
    def check_condition_local_time(condition_id, source, target):
        # checks if the local time is in the given range
        # condition_value1 = start hour
        # condition_value2 = start minute
        # condition_value3 = end hour
        # condition_value4 = end minute

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        current_time = datetime.datetime.now().time()
        start_time = datetime.time(condition.value1, condition.value2, 0)
        end_time = datetime.time(condition.value3, condition.value4, 0)

        return ConditionChecker.time_in_range(start_time, end_time, current_time)
    
    @staticmethod
    def check_condition_distance_to_position(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is within distance of the given coords
        # condition_value1 = x
        # condition_value2 = y
        # condition_value3 = z
        # condition_value4 = distance

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target:
            return source.position.distance(condition.value1, condition.value2, condition.value3) <= condition.value4

        return False
    
    @staticmethod
    def check_condition_object_go_state(condition_id, source, target):
        # requires GameObject target
        # checks the target's GO state
        # condition_value1 = GO state (GameObjectStates enum)

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target:
            return target.state == condition.value1
        
        return False

    @staticmethod
    def check_condition_nearby_player(condition_id, source, target):
        # requires Unit target
        # checks if a player is within radius
        # condition_value1 = 0 any, 1 hostile, 2 friendly
        # condition_value2 = radius

        condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(condition_id)

        if target:
            units = MapManager.get_surrounding_players(target)
            for unit in units:
                if condition.value1 == 0 and unit.position.distance(target.position) <= condition.value2:
                    return True
                elif condition.value1 == 1 and unit.is_hostile_to(target) and unit.position.distance(target.position) <= condition.value2:
                    return True
                elif condition.value1 == 2 and unit.is_friendly_to(target) and unit.position.distance(target.position) <= condition.value2:
                    return True
                
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
    ConditionType.CONDITION_QUESTAVAILABLE: ConditionChecker.check_condition_questavailable,
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
    ConditionType.CONDITION_MAPID: ConditionChecker.check_condition_mapid,
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
    ConditionType.CONDITION_NEARBY_PLAYER: ConditionChecker.check_condition_nearby_player
}