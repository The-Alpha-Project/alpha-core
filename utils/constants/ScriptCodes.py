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
    TARGET_T_CREATURE_WITH_ENTRY = 8
    # The creature with this database guid.
    # Param1 = db_guid
    TARGET_T_CREATURE_WITH_GUID = 9
    # Find creature by guid stored in instance data.
    # Param1 = instance_data_field
    TARGET_T_CREATURE_FROM_INSTANCE_DATA = 10
    # Searches for nearby gameobject with the given entry.
    # Param1 = gameobject_entry
    # Param2 = search_radius
    TARGET_T_GAMEOBJECT_WITH_ENTRY = 11
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
