from utils.constants.ConditionCodes import ConditionType
from utils.constants.ItemCodes import LootState


class ConditionChecker:

    @staticmethod
    def check_condition(condition_id, source, target):        
        pass

    @staticmethod
    def check_condition_not(condition_id, source, target):
        # deprecated but still used in some scripts
        return False
    
    @staticmethod
    def check_condition_or(condition_id, source, target):
        # returns true if any of the conditions are true
        return False
    
    @staticmethod
    def check_condition_and(condition_id, source, target):
        # returns true if all of the conditions are true
        return False
    
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
        return False
    
    @staticmethod
    def check_condition_item(condition_id, source, target):
        # requires Player target
        # returns True if target has item
        # item_id = condition_value1
        # count = condition_value2
        return False
    
    @staticmethod
    def check_condition_item_equipped(condition_id, source, target):
        # requires Player target
        # returns True if target has item equipped
        # item_id = condition_value1
        return False
    
    @staticmethod
    def check_condition_areaid(condition_id, source, target):
        # requires WorldObject target or source
        # returns True if target is in area
        # area_id = condition_value1
        return False
    
    @staticmethod
    def check_condition_reputation_rank_min(condition_id, source, target):
        # requires Player target
        # returns True if target has reputation >= rank
        # faction_id = condition_value1
        # rank = condition_value2
        return False
    
    @staticmethod
    def check_condition_team(condition_id, source, target):
        # requires Player target
        # returns True if target is on team
        # team = condition_value1 (469 = alliance, 67 = horde)
        return False
    
    @staticmethod
    def check_condition_skill(condition_id, source, target):
        # requires Player target
        # returns True if target has skill >= value
        # skill_id = condition_value1
        # value = condition_value2
        return False
    
    @staticmethod
    def check_condition_questrewarded(condition_id, source, target):
        # requires Player target
        # returns True if target has completed quest
        # quest_id = condition_value1
        return False
    
    @staticmethod
    def check_condition_questtaken(condition_id, source, target):
        # requires Player target
        # returns True if target has taken quest
        # quest_id = condition_value1
        # condition_value2: 0 any state, 1 incomplete, 2 complete
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
        return False
    
    @staticmethod
    def check_condition_active_game_event(condition_id, source, target):
        # checks if a game event is active
        # event_id = condition_value1
        return False
    
    @staticmethod
    def check_condition_cant_path_to_victim(condition_id, source, target):
        # requires Unit source
        # returns True if source cannot path to target
        return False
    
    @staticmethod
    def check_condition_race_class(condition_id, source, target):
        # requires Player target
        # condition_value1 = race mask
        # condition_value2 = class mask
        return False
    
    @staticmethod
    def check_condition_level(condition_id, source, target):
        # requires Unit target        
        # value = condition_value1
        # condition_value2: 0 any state, 1 equal or higher, 2 equal or lower
        return False
    
    @staticmethod
    def check_condition_source_entry(condition_id, source, target):
        # requires WorldObject source
        # checks if the source's entry is among the ones specified
        # condition_value1 = entry 1
        # condition_value2 = entry 2
        # condition_value3 = entry 3
        # condition_value4 = entry 4
        return False
    
    @staticmethod
    def check_condition_spell(condition_id, source, target):
        # requires Player target
        # checks if the player has learned the spell
        # condition_value1 = spell id
        # condition_value2 = 0 has spell, 1 hasn't spell
        return False
    
    @staticmethod
    def check_condition_instance_script(condition_id, source, target):
        # requires Map
        # condition_value1 = map id
        # condition_value2 = instance condition id
        return False
    
    @staticmethod
    def check_condition_questavailable(condition_id, source, target):
        # requires Player target
        # checks if the player can take the quest
        # condition_value1 = quest id
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
        return False
    
    @staticmethod
    def check_condition_item_with_bank(condition_id, source, target):
        # requires Player target
        # checks if the player has the item in inventory or bank
        # condition_value1 = item id
        # condition_value2 = count
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
        return False
    
    @staticmethod
    def check_condition_is_player(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is a player
        # condition_value1 = 0 player, 1 player or owned by a player
        return False

    @staticmethod
    def check_condition_skill_below(condition_id, source, target):
        # requires Player target
        # checks if the player has learned the skill 
        # and the skill is below the specified value
        # condition_value1 = skill id
        # condition_value2 = skill value (if 1 then True if the player does not know the skill)
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
        return False
    
    @staticmethod
    def check_condition_distance_to_target(condition_id, source, target):
        # requires Worldobject source and target
        # checks the distance between the source and target
        # condition_value1 = distance
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower

    @staticmethod
    def check_condition_is_moving(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is moving
        return False
    
    @staticmethod
    def check_condition_has_pet(condition_id, source, target):
        # requires Unit target
        # checks if the target has a pet
        return False
         
    @staticmethod
    def check_condition_health_percent(condition_id, source, target):
        # requires Unit target
        # checks the target's health percentage
        # condition_value1 = health percentage
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower
        return False

    @staticmethod
    def check_condition_mana_percent(condition_id, source, target):
        # requires Unit target
        # checks the target's mana percentage
        # condition_value1 = mana percentage
        # condition_value2 = 0 equal, 1 equal or higher, 2 equal or lower
        return False
    
    @staticmethod
    def check_condition_is_in_combat(condition_id, source, target):
        # requires Unit target
        # checks if the target is in combat
        return False
    
    @staticmethod
    def check_condition_is_hostile_to(condition_id, source, target):
        # requires WorldObject source and target
        # checks if the source is hostile to the target
        return False
    
    @staticmethod
    def check_condition_is_in_group(condition_id, source, target):
        # requires Player target
        # checks if the target is in a group
        return False
    
    @staticmethod
    def check_condition_is_alive(condition_id, source, target):
        # requires Unit target
        # checks if the target is alive
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
        return False
    
    @staticmethod
    def check_condition_local_time(condition_id, source, target):
        # checks if the local time is in the given range
        # condition_value1 = start hour
        # condition_value2 = start minute
        # condition_value3 = end hour
        # condition_value4 = end minute
        return False
    
    @staticmethod
    def check_condition_distance_to_position(condition_id, source, target):
        # requires WorldObject target
        # checks if the target is within distance of the given coords
        # condition_value1 = x
        # condition_value2 = y
        # condition_value3 = z
        # condition_value4 = distance
        return False
    
    @staticmethod
    def check_condition_object_go_state(condition_id, source, target):
        # requires GameObject target
        # checks the target's GO state
        # condition_value1 = GO state (GameObjectStates enum)
        return False

    @staticmethod
    def check_condition_nearby_players(condition_id, source, target):
        # requires Unit target
        # checks if a player is within radius
        # condition_value1 = 0 any, 1 hostile, 2 friendly
        # condition_value2 = radius
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