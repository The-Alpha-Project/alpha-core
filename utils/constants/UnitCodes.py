from enum import IntEnum


class Classes(IntEnum):
    CLASS_WARRIOR = 1
    CLASS_PALADIN = 2
    CLASS_HUNTER = 3
    CLASS_ROGUE = 4
    CLASS_PRIEST = 5
    CLASS_SHAMAN = 7
    CLASS_MAGE = 8
    CLASS_WARLOCK = 9
    CLASS_DRUID = 11


class Races(IntEnum):
    RACE_HUMAN = 1
    RACE_ORC = 2
    RACE_DWARF = 3
    RACE_NIGHT_ELF = 4
    RACE_UNDEAD = 5
    RACE_TAUREN = 6
    RACE_GNOME = 7
    RACE_TROLL = 8


class CreatureTypes(IntEnum):
    BEAST = 1
    DRAGON = 2
    DEMON = 3
    ELEMENTAL = 4
    GIANT = 5
    UNDEAD = 6
    HUMANOID = 7
    AMBIENT = 8  # Critter
    MECHANICAL = 9
    NOT_SPECIFIED = 10


class CreatureReactStates(IntEnum):
    REACT_PASSIVE = 0
    REACT_DEFENSIVE = 1
    REACT_AGGRESSIVE = 2


class AIReactionStates(IntEnum):
    AI_REACT_ALERT = 0
    AI_REACT_FRIENDLY = 1
    AI_REACT_HOSTILE = 2
    AI_REACT_AFRAID = 3


class CreatureTypeFlags(IntEnum):
    # Tameable by any hunter.
    CREATURE_TYPEFLAGS_TAMEABLE = 0x00000001
    # Used in CanInteract function by client, can't be attacked.
    CREATURE_TYPEFLAGS_GHOST_VISIBLE = 0x00000002
    # Changes creature's visible level to "??" in the creature's portrait.
    CREATURE_TYPEFLAGS_BOSS = 0x00000004
    # Disables "wounded" animations at spell taken.
    CREATURE_TYPEFLAGS_NO_WOUND_ANIM = 0x00000008
    # Controls something in client tooltip related to creature faction.
    CREATURE_TYPEFLAGS_HIDE_FACTION_TOOLTIP = 0x00000010
    # May be sound related.
    CREATURE_TYPEFLAGS_UNK6 = 0x00000020
    # May be related to attackable / not attackable creatures with spells.
    CREATURE_TYPEFLAGS_SPELL_ATTACKABLE = 0x00000040


class CreatureFamily(IntEnum):
    CREATURE_FAMILY_WOLF = 1
    CREATURE_FAMILY_CAT = 2
    CREATURE_FAMILY_SPIDER = 3
    CREATURE_FAMILY_BEAR = 4
    CREATURE_FAMILY_BOAR = 5
    CREATURE_FAMILY_CROCOLISK = 6
    CREATURE_FAMILY_CARRION_BIRD = 7
    CREATURE_FAMILY_CRAB = 8
    CREATURE_FAMILY_GORILLA = 9
    CREATURE_FAMILY_HORSE = 10
    CREATURE_FAMILY_RAPTOR = 11
    CREATURE_FAMILY_TALLSTRIDER = 12
    CREATURE_FAMILY_FELHUNTER = 15
    CREATURE_FAMILY_VOIDWALKER = 16
    CREATURE_FAMILY_SUCCUBUS = 17
    CREATURE_FAMILY_DOOMGUARD = 19
    CREATURE_FAMILY_SCORPID = 20
    CREATURE_FAMILY_TURTLE = 21
    CREATURE_FAMILY_IMP = 23


class CreatureEliteType(IntEnum):
    CREATURE_ELITE_NORMAL = 0
    CREATURE_ELITE_ELITE = 1
    CREATURE_ELITE_RAREELITE = 2
    CREATURE_ELITE_WORLDBOSS = 3
    CREATURE_ELITE_RARE = 4


class CreatureFlagsExtra(IntEnum):
    # 1        Killing this creature will bind players to the raid.
    CREATURE_FLAG_EXTRA_INSTANCE_BIND = 0x00000001
    # 2        Creature is defensive and does not attack nearby hostile targets.
    CREATURE_FLAG_EXTRA_NO_AGGRO = 0x00000002
    # 4        Creature can't parry
    CREATURE_FLAG_EXTRA_NO_PARRY = 0x00000004
    # 8        Creature summons a guard if an opposite faction player gets near or attacks.
    CREATURE_FLAG_EXTRA_SUMMON_GUARD = 0x00000008
    # 16       Creature can't block.
    CREATURE_FLAG_EXTRA_NO_BLOCK = 0x00000010
    # 32       Creature can't do crush attacks.
    CREATURE_FLAG_EXTRA_NO_CRUSH = 0x00000020
    # 64       Creature does not fall.
    CREATURE_FLAG_EXTRA_FIXED_Z = 0x00000040
    # 128      Creature is always invisible for player (mostly trigger creatures).
    CREATURE_FLAG_EXTRA_INVISIBLE = 0x00000080
    # 256      Creature is immune to taunt auras and effect attack me.
    CREATURE_FLAG_EXTRA_NOT_TAUNTABLE = 0x00000100
    # 512      Creature sets itself in combat with zone on aggro.
    CREATURE_FLAG_EXTRA_AGGRO_ZONE = 0x00000200
    # 1024     Creature is a guard.
    CREATURE_FLAG_EXTRA_GUARD = 0x00000400
    # 2048     Creature does not select targets based on threat.
    CREATURE_FLAG_EXTRA_NO_THREAT_LIST = 0x00000800
    # 4096     Creature keeps positive auras at reset.
    CREATURE_FLAG_EXTRA_KEEP_POSITIVE_AURAS_ON_EVADE = 0x00001000
    # 8192     Creature always roll a crushing melee outcome when not miss/crit/dodge/parry/block.
    CREATURE_FLAG_EXTRA_ALWAYS_CRUSH = 0x00002000
    # 16384    Creature is immune to AoE.
    CREATURE_FLAG_EXTRA_IMMUNE_AOE = 0x00004000
    # 32768    Creature does not move back when target is within bounding radius.
    CREATURE_FLAG_EXTRA_CHASE_GEN_NO_BACKING = 0x00008000
    # 65536    Creature does not aggro when nearby creatures aggro.
    CREATURE_FLAG_EXTRA_NO_ASSIST = 0x00010000
    # 131072   Creature is passive and does not acquire targets.
    CREATURE_FLAG_EXTRA_NO_TARGET = 0x00020000
    # 262144   Creature can only be seen by friendly units.
    CREATURE_FLAG_EXTRA_ONLY_VISIBLE_TO_FRIENDLY = 0x00040000
    # 524288   Creature has pvp unit flag set by default.
    CREATURE_FLAG_EXTRA_PVP = 0x00080000
    # 1048576  CREATURE_TYPEFLAGS_CAN_ASSIST from TBC.
    CREATURE_FLAG_EXTRA_CAN_ASSIST = 0x00100000
    # 2097152  CREATURE_DIFFICULTYFLAGS_LARGE_AOI (200 yards).
    CREATURE_FLAG_EXTRA_LARGE_AOI = 0x00200000
    # 4194304  CREATURE_DIFFICULTYFLAGS_3_GIGANTIC_AOI (400 yards).
    CREATURE_FLAG_EXTRA_GIGANTIC_AOI = 0x00400000
    # 8388606  CREATURE_DIFFICULTYFLAGS_3_INFINITE_AOI.
    CREATURE_FLAG_EXTRA_INFINITE_AOI = 0x00800000
    # 16777216 Creature will not pause movement when player talks to it.
    CREATURE_FLAG_EXTRA_NO_MOVEMENT_PAUSE = 0x01000000
    # 33554432 Creature will use run speed out of combat.
    CREATURE_FLAG_EXTRA_ALWAYS_RUN = 0x02000000
    # 67108864 Creature will not evade due to target being unreachable.
    CREATURE_FLAG_EXTRA_NO_UNREACHABLE_EVADE = 0x04000000


# Also known as CreatureDifficultyFlags.
# Used internally but Blizzlike.
class CreatureStaticFlags(IntEnum):
    MOUNTABLE = 1  # Has proper mount points?
    NO_XP = 2  # Gives no XP on death.
    NO_LOOT = 4  # Generates no loot on death.
    UNKILLABLE = 8  # Can't be killed.
    TAMEABLE = 16  # Is tameable.
    IMMUNE_PLAYER = 32  # Is immune to player attacks.
    IMMUNE_NPC = 64  # Is immune to other NPC attacks.
    CAN_WIELD_LOOT = 128
    SESSILE = 256  # Creature always rooted?
    UNSELECTABLE = 512
    NO_AUTO_REGEN = 1024  # Shouldn't regenerate health and power on evade?
    CORPSE_NONE = 2048  # Don't leave corpse?
    CORPSE_RAID = 4096
    CREATOR_LOOT = 8192  # Lootable only by creator (like dummies).
    NO_DEFENSE = 16384  # No defense to melee attacks?
    NO_SPELL_DEFENSE = 32768  # No defense to spell attacks?
    TABARD_VENDOR = 65536  # Flag carried by Tabard Vendor NPCS? Was later reused as "Raid Boss".
    COMBAT_PING = 131072  # Seems to be only used by Sentry Totem NPC. Flashing circle on owner's minimap if attacked.
    AQUATIC = 262144  # Can only move in water.
    AMPHIBIOUS = 524288  # Can enter water and walk on terrain.
    NO_MELEE = 1048576  # Prevents melee, mostly used by totems.
    IGNORE_COMBAT = 33554432  # React State = Passive


class Genders(IntEnum):
    GENDER_MALE = 0
    GENDER_FEMALE = 1


class Teams(IntEnum):
    TEAM_NONE = 0
    TEAM_CROSSFACTION = 1
    TEAM_HORDE = 67
    TEAM_ALLIANCE = 469


class PowerTypes(IntEnum):
    TYPE_HEALTH = -2
    TYPE_MANA = 0
    TYPE_RAGE = 1
    TYPE_FOCUS = 2
    TYPE_ENERGY = 3


class UnitFlags(IntEnum):
    UNIT_FLAG_STANDARD = 0x00000000
    UNIT_FLAG_FROZEN4 = 0x00000001
    UNIT_FLAG_FROZEN = 0x00000004
    UNIT_FLAG_PLAYER_CONTROLLED = 0x00000008
    UNIT_FLAG_PET_CAN_RENAME = 0x00000010
    UNIT_FLAG_PET_CAN_ABANDON = 0x00000020
    UNIT_FLAG_PLUS_MOB = 0x00000040
    UNIT_FLAG_IMMUNE_TO_PLAYER = 0x00000100
    UNIT_FLAG_IMMUNE_TO_NPC = 0x00000200
    UNIT_FLAG_LOOTING = 0x00000400
    UNIT_FLAG_PET_IN_COMBAT = 0x00000800
    UNIT_FLAG_MOUNT_ICON = 0x00001000
    UNIT_FLAG_MOUNT = 0x00002000
    UNIT_FLAG_DEAD = 0x00004000
    UNIT_FLAG_SNEAK = 0x00008000
    UNIT_FLAG_GHOST = 0x000010000
    UNIT_FLAG_PACIFIED = 0x000020000
    UNIT_FLAG_DISABLE_ROTATE = 0x00040000
    UNIT_FLAG_IN_COMBAT = 0x00080000
    UNIT_FLAG_TAXI_FLIGHT = 0x00100000
    UNIT_FLAG_DISARMED = 0x00200000
    UNIT_FLAG_CONFUSED = 0x00400000
    UNIT_FLAG_FLEEING = 0x00800000
    UNIT_FLAG_POSSESSED = 0x01000000
    UNIT_FLAG_DEBUG_COMBAT_LOGGING = 0x02000000  # Client uses this to toggle PlayerCombatLog debug file.
    UNIT_FLAG_SKINNABLE = 0x04000000
    UNIT_FLAG_SHEATHE = 0x40000000

    UNIT_MASK_MOUNTED = UNIT_FLAG_MOUNT_ICON | UNIT_FLAG_MOUNT
    UNIT_MASK_DEAD = UNIT_FLAG_DEAD | UNIT_FLAG_PACIFIED | UNIT_FLAG_DISABLE_ROTATE
    UNIT_MASK_NON_ATTACKABLE = UNIT_FLAG_IMMUNE_TO_PLAYER | UNIT_FLAG_IMMUNE_TO_NPC


class StandState(IntEnum):
    UNIT_STANDING = 0x0
    UNIT_SITTING = 0x1
    UNIT_SITTINGCHAIR = 0x2
    UNIT_SLEEPING = 0x3
    UNIT_SITTINGCHAIRLOW = 0x4
    UNIT_FIRSTCHAIRSIT = 0x4
    UNIT_SITTINGCHAIRMEDIUM = 0x5
    UNIT_SITTINGCHAIRHIGH = 0x6
    UNIT_LASTCHAIRSIT = 0x6
    UNIT_DEAD = 0x7
    UNIT_KNEEL = 0x8


class UnitReaction(IntEnum):
    UNIT_REACTION_HATED = 0
    UNIT_REACTION_HOSTILE = 1
    UNIT_REACTION_UNFRIENDLY = 2
    UNIT_REACTION_NEUTRAL = 3
    UNIT_REACTION_AMIABLE = 4
    UNIT_REACTION_FRIENDLY = 5
    UNIT_REACTION_REVERED = 6


class UnitSummonType(IntEnum):
    UNIT_SUMMON_PET = 0
    UNIT_SUMMON_MINION = 1
    UNIT_SUMMON_CHARM = 2
    UNIT_SUMMON_GUARDIAN = 3
    UNIT_SUMMON_CREATION = 4


class RegenStatsFlags(IntEnum):
    NO_REGENERATION = 0
    REGEN_FLAG_HEALTH = 1
    REGEN_FLAG_POWER = 2


class SheatAttachPoints(IntEnum):
    SHEATHATTACH_NONE = 0x0
    SHEATHATTACH_MAINHAND = 0x1
    SHEATHATTACH_OFFHAND = 0x2
    SHEATHATTACH_LARGEWEAPONLEFT = 0x3
    SHEATHATTACH_LARGEWEAPONRIGHT = 0x4
    SHEATHATTACH_HIPWEAPONLEFT = 0x5
    SHEATHATTACH_HIPWEAPONRIGHT = 0x6
    SHEATHATTACH_SHIELD = 0x7
    SHEATHATTACH_NUM_SAVESSHEATHATTACHPOINTS = 0x8


class WeaponMode(IntEnum):
    NORMALMODE = 0x0
    SHEATHEDMODE = 0x1
    RANGEDMODE = 0x2
    NUMMODES = 0x3


class MovementTypes(IntEnum):
    IDLE = 0x0
    WANDER = 0x1
    WAYPOINT = 0x2


# This is from 1.12, might be wrong
class ObjectSpawnFlags(IntEnum):
    SPAWN_FLAG_ACTIVE = 0x01
    SPAWN_FLAG_DISABLED = 0x02
    SPAWN_FLAG_RANDOM_RESPAWN_TIME = 0x04
    SPAWN_FLAG_DYNAMIC_RESPAWN_TIME = 0x08
    SPAWN_FLAG_FORCE_DYNAMIC_ELITE = 0x10  # creature only
    SPAWN_FLAG_EVADE_OUT_HOME_AREA = 0x20  # creature only
    SPAWN_FLAG_NOT_VISIBLE = 0x40  # creature only


# Used in SMSG_MONSTER_MOVE
class SplineFlags(IntEnum):
    SPLINEFLAG_NONE = 0x00000000
    SPLINEFLAG_DONE = 0x000000001
    SPLINEFLAG_FALLING = 0x000000002  # Affects elevation computation
    SPLINEFLAG_RUNMODE = 0x00000100
    SPLINEFLAG_FLYING = 0x00000200  # Smooth movement(Catmullrom interpolation mode), flying animation
    SPLINEFLAG_NOSPLINE = 0x00000400
    SPLINEFLAG_SPLINE = 0x00002000  # Spline n * (float xyz)
    SPLINEFLAG_SPOT = 0x00010000
    SPLINEFLAG_TARGET = 0x00020000
    SPLINEFLAG_FACING = 0x00040000
    SPLINEFLAG_CYCLIC = 0x00100000  # Movement by cycled spline
    SPLINEFLAG_ENTER_CYCLE = 0x00200000  # Appears with cyclic flag in monster move packet, erases first spline vertex after first cycle done
    SPLINEFLAG_FROZEN = 0x00400000  # Will never arrive


# Used in SMSG_MONSTER_MOVE
class SplineType(IntEnum):
    SPLINE_TYPE_NORMAL = 0
    SPLINE_TYPE_STOP = 1
    SPLINE_TYPE_FACING_SPOT = 2
    SPLINE_TYPE_FACING_TARGET = 3
    SPLINE_TYPE_FACING_ANGLE = 4


# Internal usage, custom values.
class UnitStates(IntEnum):
    NONE = 0x00000000
    ROOTED = 0x00000001
    STUNNED = 0x00000002
    POSSESSED = 0x00000004
    DISTRACTED = 0x00000008
    CONFUSED = 0x00000010
    FOLLOWING = 0x00000020
    FLEEING = 0x00000040
    SANCTUARY = 0x00000080
    SILENCED = 0x00000100
    SPELL_MOUNTED = 0x00000200
