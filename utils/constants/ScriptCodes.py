from enum import IntEnum


class CastFlags(IntEnum):
    CF_INTERRUPT_PREVIOUS = 0x001  # Interrupt any spell casting.
    CF_TRIGGERED = 0x002  # Triggered (this makes spell cost zero mana and have no cast time).
    CF_FORCE_CAST = 0x004  # Bypasses extra checks in Creature::TryToCast.
    CF_MAIN_RANGED_SPELL = 0x008  # To be used by ranged mobs only. Creature will not chase target until cast fails.
    CF_TARGET_UNREACHABLE = 0x010  # Will only use the ability if creature cannot currently get to target.
    CF_AURA_NOT_PRESENT = 0x020  # Only casts the spell if the target does not have an aura from the spell.
    CF_ONLY_IN_MELEE = 0x040  # Only casts if the creature is in melee range of the target.
    CF_NOT_IN_MELEE = 0x080  # Only casts if the creature is not in melee range of the target.
    CF_TARGET_CASTING = 0x100  # Only casts if the target is currently casting a spell.


# Selection method used by SelectAttackingTarget
class AttackingTarget(IntEnum):
    ATTACKING_TARGET_RANDOM = 0  # Just selects a random target.
    ATTACKING_TARGET_TOPAGGRO = 1  # Selects targets from top aggro to bottom.
    ATTACKING_TARGET_BOTTOMAGGRO = 2  # Selects targets from bottom aggro to top.
    ATTACKING_TARGET_NEAREST = 3  # Selects the closest target.
    ATTACKING_TARGET_FARTHEST = 4  # Selects the farthest away target.
    ATTACKING_TARGET_RANDOMNOTTOP = 5  # Selects a random target but not top.


class SelectFlags(IntEnum):
    SELECT_FLAG_IN_LOS = 0x001  # Default Selection Requirement for Spell-targets.
    SELECT_FLAG_PLAYER = 0x002
    SELECT_FLAG_POWER_MANA = 0x004  # For Energy based spells, like manaburn.
    SELECT_FLAG_POWER_RAGE = 0x008
    SELECT_FLAG_POWER_ENERGY = 0x010
    SELECT_FLAG_IN_MELEE_RANGE = 0x040
    SELECT_FLAG_NOT_IN_MELEE_RANGE = 0x080
    SELECT_FLAG_NO_TOTEM = 0x100
    SELECT_FLAG_PLAYER_NOT_GM = 0x200
    SELECT_FLAG_PET = 0x400
    SELECT_FLAG_NOT_PLAYER = 0x800
    SELECT_FLAG_POWER_NOT_MANA = 0x1000  # Used in some dungeon encounters


class ScriptTarget(IntEnum):
    # Object that was provided to the command.
    TARGET_T_PROVIDED_TARGET = 0
    # Our current target (ie: highest aggro).
    TARGET_T_HOSTILE = 1
    # Second-highest aggro (generally used for cleaves and some special attacks).
    TARGET_T_HOSTILE_SECOND_AGGRO = 2
    # Dead last on aggro (no idea what this could be used for).
    TARGET_T_HOSTILE_LAST_AGGRO = 3
    # Just any random target on our threat list.
    TARGET_T_HOSTILE_RANDOM = 4
    # Any random target except top threat.
    TARGET_T_HOSTILE_RANDOM_NOT_TOP = 5
    # Either self or owner if pet or controlled.
    TARGET_T_OWNER_OR_SELF = 6
    # The owner of the source world_object.
    TARGET_T_OWNER = 7
    # Searches for nearby creature with the given entry.
    # Param1 = creature_entry
    # Param2 = search_radius
    TARGET_T_NEAREST_CREATURE_WITH_ENTRY = 8
    # The creature with this database guid.
    # Param1 = db_guid
    TARGET_T_CREATURE_WITH_GUID = 9
    # Find creature by guid stored in instance data.
    # Param1 = instance_data_field
    TARGET_T_CREATURE_FROM_INSTANCE_DATA = 10
    # Searches for nearby gameobject with the given entry.
    # Param1 = gameobject_entry
    # Param2 = search_radius
    TARGET_T_NEAREST_GAMEOBJECT_WITH_ENTRY = 11
    # The gameobject with this database guid.
    # Param1 = db_guid
    TARGET_T_GAMEOBJECT_WITH_GUID = 12
    # Find gameobject by guid stored in instance data.
    # Param1 = instance_data_field
    TARGET_T_GAMEOBJECT_FROM_INSTANCE_DATA = 13
    # Random friendly unit.
    # Param1 = search_radius
    # Param2 = (bool) exclude_target
    TARGET_T_FRIENDLY = 14
    # Friendly unit missing the most health.
    # Param1 = search_radius
    # Param2 = hp_percent
    TARGET_T_FRIENDLY_INJURED = 15
    # Friendly unit missing the most health but not provided target.
    # Param1 = search_radius
    # Param2 = hp_percent
    TARGET_T_FRIENDLY_INJURED_EXCEPT = 16
    # Friendly unit without aura.
    # Param1 = search_radius
    # Param2 = spell_id
    TARGET_T_FRIENDLY_MISSING_BUFF = 17
    # Friendly unit without aura but not provided target.
    # Param1 = search_radius
    TARGET_T_FRIENDLY_MISSING_BUFF_EXCEPT = 18
    # The source WorldObject of a scripted map event.
    # Param1 = eventId
    TARGET_T_FRIENDLY_CC = 19
    # The target WorldObject of a scripted map event.
    # Param1 = eventId
    TARGET_T_MAP_EVENT_SOURCE = 20
    # An additional WorldObject target from a scripted map event.
    # Param1 = eventId
    # Param2 = creature_entry or gameobject_entry
    TARGET_T_MAP_EVENT_TARGET = 21
    # An additional WorldObject target from a scripted map event.
    # Param1 = eventId
    # Param2 = creature_entry or gameobject_entry
    TARGET_T_MAP_EVENT_EXTRA_TARGET = 22
    # Nearest player within range.
    # Param1 = search-radius
    TARGET_T_NEAREST_PLAYER = 23
    # Nearest hostile player within range.
    # Param1 = search-radius
    TARGET_T_NEAREST_HOSTILE_PLAYER = 24
    # Nearest friendly player within range.
    # Param1 = search-radius
    TARGET_T_NEAREST_FRIENDLY_PLAYER = 25
    # Searches for random nearby creature with the given entry. Not Self.
    # Param1 = creature_entry
    # Param2 = search_radius
    TARGET_T_RANDOM_CREATURE_WITH_ENTRY = 26
    # Searches for random nearby gameobject with the given entry.
    # Param1 = gameobject_entry
    # Param2 = search_radius
    TARGET_T_RANDOM_GAMEOBJECT_WITH_ENTRY = 27

class ModifyFlagsOptions(IntEnum):
    SO_MODIFYFLAGS_TOGGLE = 0
    SO_MODIFYFLAGS_SET = 1
    SO_MODIFYFLAGS_REMOVE = 2

class TurnToFacingOptions(IntEnum):
    SO_TURNTO_FACE_TARGET = 0
    SO_TURNTO_PROVIDED_ORIENTATION = 1

class ScriptCommands(IntEnum):
    SCRIPT_COMMAND_TALK = 0
    SCRIPT_COMMAND_EMOTE = 1
    SCRIPT_COMMAND_FIELD_SET = 2
    SCRIPT_COMMAND_MOVE_TO = 3
    SCRIPT_COMMAND_MODIFY_FLAGS = 4
    SCRIPT_COMMAND_INTERRUPT_CASTS = 5
    SCRIPT_COMMAND_TELEPORT_TO = 6
    SCRIPT_COMMAND_QUEST_EXPLORED = 7
    SCRIPT_COMMAND_KILL_CREDIT = 8
    SCRIPT_COMMAND_RESPAWN_GAMEOBJECT = 9
    SCRIPT_COMMAND_TEMP_SUMMON_CREATURE = 10
    SCRIPT_COMMAND_OPEN_DOOR = 11
    SCRIPT_COMMAND_CLOSE_DOOR = 12
    SCRIPT_COMMAND_ACTIVATE_OBJECT = 13
    SCRIPT_COMMAND_REMOVE_AURA = 14
    SCRIPT_COMMAND_CAST_SPELL = 15
    SCRIPT_COMMAND_PLAY_SOUND = 16
    SCRIPT_COMMAND_CREATE_ITEM = 17
    SCRIPT_COMMAND_DESPAWN_CREATURE = 18
    SCRIPT_COMMAND_SET_EQUIPMENT = 19
    SCRIPT_COMMAND_MOVEMENT = 20
    SCRIPT_COMMAND_SET_ACTIVEOBJECT = 21
    SCRIPT_COMMAND_SET_FACTION = 22
    SCRIPT_COMMAND_MORPH_TO_ENTRY_OR_MODEL = 23
    SCRIPT_COMMAND_MOUNT_TO_ENTRY_OR_MODEL = 24
    SCRIPT_COMMAND_SET_RUN = 25
    SCRIPT_COMMAND_ATTACK_START = 26
    SCRIPT_COMMAND_UPDATE_ENTRY = 27
    SCRIPT_COMMAND_STAND_STATE = 28
    SCRIPT_COMMAND_MODIFY_THREAT = 29
    SCRIPT_COMMAND_SEND_TAXI_PATH = 30
    SCRIPT_COMMAND_TERMINATE_SCRIPT = 31
    SCRIPT_COMMAND_TERMINATE_CONDITION = 32
    SCRIPT_COMMAND_ENTER_EVADE_MODE = 33
    SCRIPT_COMMAND_SET_HOME_POSITION = 34
    SCRIPT_COMMAND_TURN_TO = 35
    SCRIPT_COMMAND_MEETINGSTONE = 36
    SCRIPT_COMMAND_SET_INST_DATA = 37
    SCRIPT_COMMAND_SET_INST_DATA64 = 38
    SCRIPT_COMMAND_START_SCRIPT = 39
    SCRIPT_COMMAND_REMOVE_ITEM = 40
    SCRIPT_COMMAND_REMOVE_OBJECT = 41
    SCRIPT_COMMAND_SET_MELEE_ATTACK = 42
    SCRIPT_COMMAND_SET_COMBAT_MOVEMENT = 43
    SCRIPT_COMMAND_SET_PHASE = 44
    SCRIPT_COMMAND_SET_PHASE_RANDOM = 45
    SCRIPT_COMMAND_SET_PHASE_RANGE = 46
    SCRIPT_COMMAND_FLEE = 47
    SCRIPT_COMMAND_DEAL_DAMAGE = 48
    SCRIPT_COMMAND_ZONE_COMBAT_PULSE = 49
    SCRIPT_COMMAND_CALL_FOR_HELP = 50
    SCRIPT_COMMAND_SET_SHEATH = 51
    SCRIPT_COMMAND_INVINCIBILITY = 52
    SCRIPT_COMMAND_GAME_EVENT = 53
    SCRIPT_COMMAND_SET_SERVER_VARIABLE = 54
    SCRIPT_COMMAND_CREATURE_SPELLS = 55
    SCRIPT_COMMAND_REMOVE_GUARDIANS = 56
    SCRIPT_COMMAND_ADD_SPELL_COOLDOWN = 57
    SCRIPT_COMMAND_REMOVE_SPELL_COOLDOWN = 58
    SCRIPT_COMMAND_SET_REACT_STATE = 59
    SCRIPT_COMMAND_START_WAYPOINTS = 60
    SCRIPT_COMMAND_START_MAP_EVENT = 61
    SCRIPT_COMMAND_END_MAP_EVENT = 62
    SCRIPT_COMMAND_ADD_MAP_EVENT_TARGET = 63
    SCRIPT_COMMAND_REMOVE_MAP_EVENT_TARGET = 64
    SCRIPT_COMMAND_SET_MAP_EVENT_DATA = 65
    SCRIPT_COMMAND_SEND_MAP_EVENT = 66
    SCRIPT_COMMAND_SET_DEFAULT_MOVEMENT = 67
    SCRIPT_COMMAND_START_SCRIPT_FOR_ALL = 68
    SCRIPT_COMMAND_EDIT_MAP_EVENT = 69
    SCRIPT_COMMAND_FAIL_QUEST = 70
    SCRIPT_COMMAND_RESPAWN_CREATURE = 71
    SCRIPT_COMMAND_ASSIST_UNIT = 72
    SCRIPT_COMMAND_COMBAT_STOP = 73
    SCRIPT_COMMAND_ADD_AURA = 74
    SCRIPT_COMMAND_ADD_THREAT = 75
    SCRIPT_COMMAND_SUMMON_OBJECT = 76
    SCRIPT_COMMAND_SET_FLY = 77
    SCRIPT_COMMAND_JOIN_CREATURE_GROUP = 78
    SCRIPT_COMMAND_LEAVE_CREATURE_GROUP = 79
    SCRIPT_COMMAND_SET_GO_STATE = 80
    SCRIPT_COMMAND_DESPAWN_GAMEOBJECT = 81
    SCRIPT_COMMAND_LOAD_GAMEOBJECT = 82
    SCRIPT_COMMAND_QUEST_CREDIT = 83
    SCRIPT_COMMAND_SET_GOSSIP_MENU = 84
    SCRIPT_COMMAND_SEND_SCRIPT_EVENT = 85
    SCRIPT_COMMAND_SET_PVP = 86
    SCRIPT_COMMAND_RESET_DOOR_OR_BUTTON = 87
    SCRIPT_COMMAND_SET_COMMAND_STATE = 88
    SCRIPT_COMMAND_PLAY_CUSTOM_ANIM = 89
    SCRIPT_COMMAND_START_SCRIPT_ON_GROUP = 90

class SetHomePositionOptions(IntEnum):
    SET_HOME_PROVIDED_POSITION = 0
    SET_HOME_CURRENT_POSITION = 1
    SET_HOME_DEFAULT_POSITION = 2
