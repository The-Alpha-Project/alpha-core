from enum import IntEnum, IntFlag


class ObjectTypeFlags(IntEnum):
    TYPE_OBJECT = 1
    TYPE_ITEM = 2
    TYPE_CONTAINER = 4
    TYPE_UNIT = 8
    TYPE_PLAYER = 16
    TYPE_GAMEOBJECT = 32
    TYPE_DYNAMICOBJECT = 64
    TYPE_CORPSE = 128
    TYPE_AIGROUP = 256
    TYPE_AREATRIGGER = 512
    HIER_TYPE_OBJECT = 1
    HIER_TYPE_ITEM = 3
    HIER_TYPE_CONTAINER = 7
    HIER_TYPE_UNIT = 9
    HIER_TYPE_PLAYER = 25
    HIER_TYPE_GAMEOBJECT = 33
    HIER_TYPE_DYNAMICOBJECT = 65
    HIER_TYPE_CORPSE = 129
    HIER_TYPE_AIGROUP = 257
    HIER_TYPE_AREATRIGGER = 513


class ObjectTypeIds(IntEnum):
    ID_OBJECT = 0
    ID_ITEM = 1
    ID_CONTAINER = 2
    ID_UNIT = 3
    ID_PLAYER = 4
    ID_GAMEOBJECT = 5
    ID_DYNAMICOBJECT = 6
    ID_CORPSE = 7
    NUM_CLIENT_OBJECT_TYPES = 8
    ID_AIGROUP = 8
    ID_AREATRIGGER = 9
    NUM_OBJECT_TYPES = 10


class DynamicObjectTypes(IntEnum):
    DYNAMIC_OBJECT_PORTAL = 0x0,
    DYNAMIC_OBJECT_AREA_SPELL = 0x1,
    DYNAMIC_OBJECT_FARSIGHT_FOCUS = 0x2,


class UpdateTypes(IntEnum):
    # Client treats FAR/NEAR as in-range toggles only:
    # FAR_OBJECTS -> UpdateOutOfRangeObjects (moves known objects out of range, not destroy).
    # NEAR_OBJECTS -> UpdateInRangeObjects (marks cached objects in range, does not create).
    PARTIAL = 0
    MOVEMENT = 1
    CREATE_OBJECT = 2
    FAR_OBJECTS = 3
    NEAR_OBJECTS = 4


class UpdateFlags(IntFlag):
    NONE = 0
    CHANGES = 1 << 0
    INVENTORY = 1 << 1
    DYNAMIC_FLAGS = 1 << 2


# Some might be unused on Alpha
class HighGuid(IntEnum):

    @classmethod
    def has_value(cls, value):
        return value in cls._value2member_map_

    HIGHGUID_PLAYER = 0x0000 << 48
    HIGHGUID_ITEM = 0x4000 << 48
    HIGHGUID_CONTAINER = 0x4000 << 48
    HIGHGUID_GAMEOBJECT = 0xF110 << 48
    HIGHGUID_TRANSPORT = 0xF120 << 48
    HIGHGUID_UNIT = 0xF130 << 48
    HIGHGUID_PET = 0xF140 << 48
    HIGHGUID_VEHICLE = 0xF150 << 48
    HIGHGUID_DYNAMICOBJECT = 0xF100 << 48
    HIGHGUID_CORPSE = 0xF101 << 48
    HIGHGUID_MO_TRANSPORT = 0x1FC0 << 48
    HIGHGUID_GROUP = 0x1F50 << 48
    HIGHGUID_GUILD = 0x1FF6 << 48


class Factions(IntEnum):
    ALLIANCE = 4
    HORDE = 6


class NpcFlags(IntEnum):
    NPC_FLAG_NONE = 0x0
    NPC_FLAG_VENDOR = 0x1
    NPC_FLAG_QUESTGIVER = 0x2
    NPC_FLAG_FLIGHTMASTER = 0x4
    NPC_FLAG_TRAINER = 0x8
    NPC_FLAG_BINDER = 0x10  # Binders were used to bind players to a meeting stone. You appeared there on death respawn.
    NPC_FLAG_BANKER = 0x20
    NPC_FLAG_TABARDDESIGNER = 0x40  # This will bring up the tabard design window only.
    NPC_FLAG_PETITIONER = 0x80  # Guild Master NPCs need 0x40 | 0x80 to properly show the dialog window.


# COMBAT INFORMATION
class HitInfo(IntFlag):
    DAMAGE = 0x00000000
    MISS = 0x00000001
    SUCCESS = 0x00000002
    UNIT_DEAD = 0x00000004  # Unit died because of this attack (victim animation hint).
    CRITICAL_HIT = 0x00000008
    STUN = 0x00000010  # Advanced logging flag (stun roll info).
    PARRY = 0x00000020
    DODGE = 0x00000040
    BLOCK = 0x00000080
    COOLDOWN = 0x00000100  # Advanced logging flag (stun cooldown).
    OFFHAND = 0x00000200
    CRUSHING = 0x0000400
    UNKNOWN1 = 0x0000800
    DEFERRED_LOGGING = 0x0001000
    ADVANCED_LOGGING = 0x0002000
    PREVENT_LOGGING = 0x0004000  # receives no damage and voids attack?
    OFFHAND_FAILED = 0x0008000  # uncertain
    ABSORBED = 0x0010000
    HIDE_MISSED_TEXT = 0x0020000  # ? CGUnit_C::ShowWorldText
    DEFLECT = 0x0040000  # ? CGUnit_C::ShowWorldText

    """
    HandleGeneralCombatLogging (ATTACKROUNDINFO) - NOTE: 0x2000 and 0x4000 both supress player logs
    HandleGeneralCombatLoggingMissed = 0x1 : any misses
    HandleGeneralCombatOrSpellHitLogging = VS_WOUND, 0x8 for crits : standard successful combat/combat spell log
    HandleGeneralCombatEvadeLogging = uses VictimState : use for everything else
    """


class AttackSwingError(IntEnum):
    NONE = 0x0000
    # NOTE: it appears you can't melee attack whilst moving - Blizz was initially very anti-kiting so may be the reason
    # the client prevents attack animations whilst moving and there's always a delay in Blizzcon 2003 gameplay footage.
    # This is just a guess though.
    MOVING = 0x0001
    NOTINRANGE = 0x0138
    BADFACING = 0x0139
    NOTSTANDING = 0x013A
    DEADTARGET = 0x013B
    CANTATTACK = 0x013C


class VictimStates(IntEnum):
    VS_NONE = 0  # set when attacker misses
    VS_WOUND = 1  # victim got clear/blocked hit
    VS_DODGE = 2
    VS_PARRY = 3
    VS_INTERRUPT = 4
    VS_BLOCK = 5
    VS_EVADE = 6
    VS_IMMUNE = 7
    VS_DEFLECT = 8


class ProcFlags(IntEnum):
    NONE = 0x0
    DEAL_COMBAT_DMG = 0x1
    TAKE_COMBAT_DMG = 0x2
    KILL = 0x4
    HEARTBEAT = 0x8
    DODGE = 0x10
    PARRY = 0x20
    BLOCK = 0x40
    SWING = 0x80
    SPELL_CAST = 0x100  # Only used by zzOLDMind Bomb
    SPELL_CAST_SCHOOL = 0x200  # Not yet implemented by the client
    SPELL_HIT = 0x400
    SPELL_HIT_SCHOOL = 0x800  # Not yet implemented by the client


class ProcFlagsExLegacy(IntEnum):
    NONE = 0x0000000  # If none can tigger on Hit/Crit only (passive spells MUST defined by SpellFamily flag)
    NORMAL_HIT = 0x0000001  # If set only from normal hit (only damage spells)
    CRITICAL_HIT = 0x0000002
    MISS = 0x0000004
    RESIST = 0x0000008
    DODGE = 0x0000010
    PARRY = 0x0000020
    BLOCK = 0x0000040
    EVADE = 0x0000080
    IMMUNE = 0x0000100
    DEFLECT = 0x0000200
    ABSORB = 0x0000400
    REFLECT = 0x0000800
    INTERRUPT = 0x0001000  # Melee hit result can be Interrupt (not used)
    FULL_BLOCK = 0x0002000  # block al attack damage
    RESERVED2 = 0x0004000
    NOT_ACTIVE_SPELL = 0x0008000  # Spell mustn't do damage/heal to proc
    EX_TRIGGER_ALWAYS = 0x0010000  # If set trigger always no matter of hit result
    EX_ONE_TIME_TRIGGER = 0x0020000  # If set trigger always but only one time (not implemented yet)
    ONLY_ACTIVE_SPELL = 0x0040000  # Spell has to do damage/heal to proc

    # Flags for internal use - do not use these in db!
    INTERNAL_CANT_PROC = 0x0800000
    INTERNAL_DOT = 0x1000000
    INTERNAL_HOT = 0x2000000
    INTERNAL_TRIGGERED = 0x4000000
    INTERNAL_REQ_FAMILY = 0x8000000


class AttackTypes(IntEnum):
    BASE_ATTACK = 0
    OFFHAND_ATTACK = 1
    RANGED_ATTACK = 2


class TradeSkillCategories(IntEnum):
    TRADESKILL_OPTIMAL = 0x0
    TRADESKILL_MEDIUM = 0x1
    TRADESKILL_EASY = 0x2
    TRADESKILL_TRIVIAL = 0x3
    NUM_TRADESKILL_CATEGORIES = 0x4


class TradeStatus(IntEnum):
    TRADE_STATUS_PLAYER_BUSY = 0x0
    TRADE_STATUS_PROPOSED = 0x1
    TRADE_STATUS_INITIATED = 0x2
    TRADE_STATUS_CANCELLED = 0x3
    TRADE_STATUS_ACCEPTED = 0x4
    TRADE_STATUS_ALREADY_TRADING = 0x5
    TRADE_STATUS_PLAYER_NOT_FOUND = 0x6
    TRADE_STATUS_STATE_CHANGED = 0x7
    TRADE_STATUS_COMPLETE = 0x8
    TRADE_STATUS_UNACCEPTED = 0x9
    TRADE_STATUS_TOO_FAR_AWAY = 0xA
    TRADE_STATUS_WRONG_FACTION = 0xB
    TRADE_STATUS_FAILED = 0xC
    TRADE_STATUS_DEAD = 0xD
    TRADE_STATUS_PETITION = 0xE
    TRADE_STATUS_PLAYER_IGNORED = 0xF


class CraftLevelCategories(IntEnum):
    CRAFT_NONE = 0x0
    CRAFT_OPTIMAL = 0x1
    CRAFT_MEDIUM = 0x2
    CRAFT_EASY = 0x3
    CRAFT_TRIVIAL = 0x4
    NUM_CRAFT_CATEGORIES = 0x5


class TrainerServices(IntEnum):
    TRAINER_SERVICE_AVAILABLE = 0x0
    TRAINER_SERVICE_UNAVAILABLE = 0x1
    TRAINER_SERVICE_USED = 0x2
    TRAINER_SERVICE_NOT_SHOWN = 0x3
    TRAINER_SERVICE_NEVER = 0x4
    TRAINER_SERVICE_NO_PET = 0x5
    NUM_TRAINER_SERVICE_TYPES = 0x6


class TrainerTypes(IntEnum):
    TRAINER_TYPE_GENERAL = 0x0
    TRAINER_TYPE_TALENTS = 0x1
    TRAINER_TYPE_TRADESKILLS = 0x2
    TRAINER_TYPE_PET = 0x3


class TrainingFailReasons(IntEnum):
    TRAIN_FAIL_UNAVAILABLE = 0x0
    TRAIN_FAIL_NOT_ENOUGH_MONEY = 0x1
    TRAIN_FAIL_NOT_ENOUGH_POINTS = 0x2


class UnitDynamicTypes(IntEnum):
    UNIT_DYNAMIC_NONE = 0x0000
    UNIT_DYNAMIC_LOOTABLE = 0x0001
    UNIT_DYNAMIC_TRACK_UNIT = 0x0002
    UNIT_DYNAMIC_TAPPED = 0x0004  # Lua_UnitIsTapped - Indicates the target as grey for the client.
    UNIT_DYNAMIC_ROOTED = 0x0008
    UNIT_DYNAMIC_SPECIALINFO = 0x0010
    UNIT_DYNAMIC_DEAD = 0x0020


class MountResults(IntEnum):
    MOUNTRESULT_INVALID_MOUNTEE = 0  # You can't mount that unit!
    MOUNTRESULT_TOO_FARA_WAY = 1  # That mount is too far away!
    MOUNTRESULT_ALREADY_MOUNTED = 2  # You're already mounted!
    MOUNTRESULT_NOT_MOUNTABLE = 3  # That unit can't be mounted!
    MOUNTRESULT_NOT_YOUR_PET = 4  # That mount isn't your pet!
    MOUNTRESULT_OTHER = 5  # Internal.
    MOUNTRESULT_LOOTING = 6  # You can't mount while looting!
    MOUNTRESULT_RACE_CANT_MOUNT = 7  # You can't mount because of your race!
    MOUNTRESULT_SHAPESHIFTED = 8  # You can't mount while shapeshifted!
    MOUNTRESULT_FORCED_DISMOUNT = 9  # You dismount before continuing.


class DismountResults(IntEnum):
    DISMOUNT_RESULT_NO_PET = 0
    DISMOUNT_RESULT_NOT_MOUNTED = 1
    DISMOUNT_RESULT_NOT_YOUR_PET = 2


class LootTypes(IntEnum):
    LOOT_TYPE_NOTALLOWED = 0
    LOOT_TYPE_CORPSE = 1
    LOOT_TYPE_PICKLOCK = 2
    LOOT_TYPE_FISHING = 3


class ReputationFlag(IntEnum):
    HIDDEN = 0
    VISIBLE = 1
    ATWAR = 2


class QuestMethod(IntEnum):
    QUEST_AUTOCOMPLETE = 0
    QUEST_DISABLED = 1
    QUEST_ENABLED = 2


class QuestState(IntEnum):
    QUEST_GREETING = 0
    QUEST_OFFER = 1
    QUEST_ACCEPTED = 2
    QUEST_REWARD = 3
    QUEST_STATE_NUM_TYPES = 4


class QuestGiverStatus(IntEnum):
    QUEST_GIVER_NONE = 0
    QUEST_GIVER_TRIVIAL = 1
    QUEST_GIVER_FUTURE = 2
    QUEST_GIVER_REWARD = 3
    QUEST_GIVER_QUEST = 4
    QUEST_GIVER_NUMITEMS = 5


class QuestSpecialFlags(IntEnum):
    QUEST_SPECIAL_FLAG_NONE = 0
    QUEST_SPECIAL_FLAG_REPEATABLE = 1
    QUEST_SPECIAL_FLAG_SCRIPT = 2


class QuestFlags(IntEnum):
    QUEST_FLAGS_NONE = 0x00000000
    QUEST_FLAGS_STAY_ALIVE = 0x00000001  # Not used currently
    QUEST_FLAGS_PARTY_ACCEPT = 0x00000002  # If player in party, all players that can accept this quest will receive confirmation box to accept quest CMSG_QUEST_CONFIRM_ACCEPT/SMSG_QUEST_CONFIRM_ACCEPT
    QUEST_FLAGS_EXPLORATION = 0x00000004  # Not used currently
    QUEST_FLAGS_SHARABLE = 0x00000008  # Can be shared: Player::CanShareQuest()
    QUEST_FLAGS_EPIC = 0x00000020  # Not used currently: Unsure of content
    QUEST_FLAGS_RAID = 0x00000040  # Not used currently
    QUEST_FLAGS_HIDDEN_REWARDS = 0x00000200  # Items and money rewarded only sent in SMSG_QUESTGIVER_OFFER_REWARD (not in SMSG_QUESTGIVER_QUEST_DETAILS or in client quest log(SMSG_QUEST_QUERY_RESPONSE))
    QUEST_FLAGS_AUTO_REWARDED = 0x00000400  # These quests are automatically rewarded on quest complete and they will never appear in quest log client side.


class QuestFailedReasons(IntEnum):
    QUEST_MISSING_REQ = 0  # Missing requirements
    QUEST_FAILED_LOW_LEVEL = 1  # You are not high enough level for that quest.
    QUEST_FAILED_WRONG_RACE = 6  # That quest is not available to your race.
    QUEST_ONLY_ONE_TIMED = 12  # You can only be on one timed quest at a time.
    QUEST_ALREADY_ON = 13  # You are already on that quest
    QUEST_FAILED_MISSING_ITEMS = 21  # You don't have the required items with you. Check storage.
    QUEST_FAILED_NOT_ENOUGH_MONEY = 23  # You don't have enough money for that quest.


class QuestCantTakeReason(IntEnum):
    QUEST_CANT_TAKE_LOW_LEVEL = 1
    QUEST_CANT_TAKE_MISSING_ITEMS = 15


class SkillCategories(IntEnum):
    MAX_SKILL = 1  # These are always max when added i.e. language/riding
    COMBAT_SKILL = 2
    CLASS_SKILL = 3
    SECONDARY_SKILL = 4


class GameObjectTypes(IntEnum):
    TYPE_DOOR = 0x0
    TYPE_BUTTON = 0x1
    TYPE_QUESTGIVER = 0x2
    TYPE_CHEST = 0x3
    TYPE_BINDER = 0x4
    TYPE_GENERIC = 0x5
    TYPE_TRAP = 0x6
    TYPE_CHAIR = 0x7
    TYPE_SPELL_FOCUS = 0x8
    TYPE_TEXT = 0x9
    TYPE_GOOBER = 0xA
    TYPE_TRANSPORT = 0xB
    TYPE_AREADAMAGE = 0xC
    TYPE_CAMERA = 0xD
    TYPE_MAP_OBJECT = 0xE
    TYPE_MO_TRANSPORT = 0xF
    TYPE_DUEL_ARBITER = 0x10
    TYPE_FISHINGNODE = 0x11
    TYPE_RITUAL = 0x12
    NUM_GAMEOBJECT_TYPE = 0x13


class GameObjectStates(IntEnum):
    GO_STATE_ACTIVE = 0  # show in world as used and not reset (closed door open)
    GO_STATE_READY = 1  # show in world as ready (closed door close)
    GO_STATE_ACTIVE_ALTERNATIVE = 2  # show in world as used in alt way and not reset (closed door open by cannon fire)


class GameObjectCustomAnim(IntEnum):
    CUSTOM_0 = 0
    CUSTOM_1 = 1
    CUSTOM_2 = 2
    CUSTOM_3 = 3


class Emotes(IntEnum):
    NONE = 0
    AGREE = 1
    AMAZE = 2
    ANGRY = 3
    APOLOGIZE = 4
    APPLAUD = 5
    BASHFUL = 6
    BECKON = 7
    BEG = 8
    BITE = 9
    BLEED = 10
    BLINK = 11
    BLUSH = 12
    BONK = 13
    BORED = 14
    BOUNCE = 15
    BRB = 16
    BOW = 17
    BURP = 18
    BYE = 19
    CACKLE = 20
    CHEER = 21
    CHICKEN = 22
    CHUCKLE = 23
    CLAP = 24
    CONFUSED = 25
    CONGRATULATE = 26
    COUGH = 27
    COWER = 28
    CRACK = 29
    CRINGE = 30
    CRY = 31
    CURIOUS = 32
    CURTSEY = 33
    DANCE = 34
    DRINK = 35
    DROOL = 36
    EAT = 37
    EYE = 38
    FART = 39
    FIDGET = 40
    FLEX = 41
    FROWN = 42
    GASP = 43
    GAZE = 44
    GIGGLE = 45
    GLARE = 46
    GLOAT = 47
    GREET = 48
    GRIN = 49
    GROAN = 50
    GROVEL = 51
    GUFFAW = 52
    HAIL = 53
    HAPPY = 54
    HELLO = 55
    HUG = 56
    HUNGRY = 57
    KISS = 58
    KNEEL = 59
    LAUGH = 60
    LAYDOWN = 61
    MASSAGE = 62
    MOAN = 63
    MOON = 64
    MOURN = 65
    NO = 66
    NOD = 67
    NOSEPICK = 68
    PANIC = 69
    PEER = 70
    PLEAD = 71
    POINT = 72
    POKE = 73
    PRAY = 74
    ROAR = 75
    ROFL = 76
    RUDE = 77
    SALUTE = 78
    SCRATCH = 79
    SEXY = 80
    SHAKE = 81
    SHOUT = 82
    SHRUG = 83
    SHY = 84
    SIGH = 85
    SIT = 86
    SLEEP = 87
    SNARL = 88
    SPIT = 89
    STARE = 90
    SURPRISED = 91
    SURRENDER = 92
    TALK = 93
    TALKEX = 94
    TALKQ = 95
    TAP = 96
    THANK = 97
    THREATEN = 98
    TIRED = 99
    VICTORY = 100
    WAVE = 101
    WELCOME = 102
    WHINE = 103
    WHISTLE = 104
    WORK = 105
    YAWN = 106
    BOGGLE = 107
    CALM = 108
    COLD = 109
    COMFORT = 110
    CUDDLE = 111
    DUCK = 112
    INSULT = 113
    INTRODUCE = 114
    JK = 115
    LICK = 116
    LISTEN = 117
    LOST = 118
    MOCK = 119
    PONDER = 120
    POUNCE = 121
    PRAISE = 122
    PURR = 123
    PUZZLE = 124
    RAISE = 125
    READY = 126
    SHIMMY = 127
    SHIVER = 128
    SHOO = 129
    SLAP = 130
    SMIRK = 131
    SNIFF = 132
    SNUB = 133
    SOOTHE = 134
    STINK = 135
    TAUNT = 136
    TEASE = 137
    THIRSTY = 138
    VETO = 139
    SNICKER = 140
    STAND = 141
    TICKLE = 142
    VIOLIN = 143
    SMILE = 163


class EmoteUnitState(IntEnum):
    NONE = 0
    TALK = 1
    BOW = 2
    CURTSEY = 2
    BYE = 3
    GREET = 3
    HAIL = 3
    HELLO = 3
    WAVE = 3
    WELCOME = 3
    CHEER = 4
    VICTORY = 4
    GASP = 5
    TALKEX = 5
    TALKQ = 5
    CONFUSED = 6
    CURIOUS = 6
    SHRUG = 6
    BOGGLE = 6
    LOST = 6
    PONDER = 6
    PUZZLE = 6
    DRINK = 7
    EAT = 7
    DANCE = 10
    CACKLE = 11
    CHUCKLE = 11
    GIGGLE = 11
    GLOAT = 11
    GUFFAW = 11
    LAUGH = 11
    ROFL = 11
    LAYDOWN = 12
    SLEEP = 12
    SIT = 13
    ANGRY = 14
    RUDE = 14
    INSULT = 14
    ROAR = 15
    PRAY = 16
    KISS = 17
    CRY = 18
    MOURN = 18
    VIOLIN = 18
    CHICKEN = 19
    TAUNT = 19
    BEG = 20
    GROVEL = 20
    PLEAD = 20
    SURRENDER = 20
    APPLAUD = 21
    CLAP = 21
    CONGRATULATE = 21
    SHOUT = 22
    FLEX = 23
    BASHFUL = 24
    BLUSH = 24
    SHY = 24
    POINT = 25
    STAND = 26
    SALUTE = 66
    KNEEL = 68


class ChatMsgs(IntEnum):
    CHAT_MSG_SAY = 0x00
    CHAT_MSG_PARTY = 0x01
    CHAT_MSG_GUILD = 0x02
    CHAT_MSG_OFFICER = 0x03
    CHAT_MSG_YELL = 0x04
    CHAT_MSG_WHISPER = 0x05
    CHAT_MSG_WHISPER_INFORM = 0x06
    CHAT_MSG_EMOTE = 0x07
    CHAT_MSG_TEXT_EMOTE = 0x08
    CHAT_MSG_SYSTEM = 0x09
    CHAT_MSG_MONSTER_SAY = 0x0A
    CHAT_MSG_MONSTER_YELL = 0x0B
    CHAT_MSG_MONSTER_EMOTE = 0x0C
    CHAT_MSG_CHANNEL = 0x0D
    CHAT_MSG_CHANNEL_JOIN = 0x0E
    CHAT_MSG_CHANNEL_LEAVE = 0xF
    CHAT_MSG_CHANNEL_LIST = 0x10
    CHAT_MSG_CHANNEL_NOTICE = 0x11
    CHAT_MSG_CHANNEL_NOTICE_USER = 0x12
    CHAT_MSG_AFK = 0x13
    CHAT_MSG_DND = 0x14
    CHAT_MSG_IGNORED = 0x16
    CHAT_MSG_SKILL = 0x17
    CHAT_MSG_LOOT = 0x18


class ChatFlags(IntEnum):
    CHAT_TAG_NONE = 0
    CHAT_TAG_AFK = 1
    CHAT_TAG_DND = 2
    CHAT_TAG_GM = 3


class Languages(IntEnum):
    LANG_UNIVERSAL = 0
    LANG_ORCISH = 1
    LANG_DARNASSIAN = 2
    LANG_TAURAHE = 3
    LANG_DWARVISH = 6
    LANG_COMMON = 7
    LANG_DEMONIC = 8
    LANG_TITAN = 9
    LANG_THALASSIAN = 10
    LANG_DRACONIC = 11
    LANG_KALIMAG = 12
    LANG_GNOMISH = 13
    LANG_TROLL = 14


class CreatureGroupFlags(IntEnum):
    OPTION_FORMATION_MOVE = 0x001
    OPTION_AGGRO_TOGETHER = 0x002
    OPTION_EVADE_TOGETHER = 0x004
    OPTION_RESPAWN_TOGETHER = 0x008
    OPTION_RESPAWN_ALL_ON_MASTER_EVADE = 0x010
    OPTION_RESPAWN_ALL_ON_ANY_EVADE = 0x020
    OPTION_INFORM_LEADER_ON_MEMBER_DIED = 0x040
    OPTION_INFORM_MEMBERS_ON_ANY_DIED = 0x080


class SummonCreatureFlags(IntEnum):
    SF_SUMMON_CREATURE_SET_RUN     = 0x01    # Makes creature move at run speed.
    SF_SUMMON_CREATURE_ACTIVE      = 0x02    # Active creatures are always updated.
    SF_SUMMON_CREATURE_UNIQUE      = 0x04    # Not actually unique, just checks for same entry in certain range.
    SF_SUMMON_CREATURE_UNIQUE_TEMP = 0x08    # Same as 0x10 but check for TempSummon only creatures.
    SF_SUMMON_CREATURE_NULL_AI     = 0x10    # Use Null AI instead of the normal creature script.


class TempSummonType(IntEnum):
    TEMP_SUMMON_DEFAULT = 0
    # Despawns after a specified time (out of combat) OR when the creature disappears.
    TEMP_SUMMON_TIMED_OR_DEAD_DESPAWN = 1
    # Despawns after a specified time (out of combat) OR when the creature dies.
    TEMP_SUMMON_TIMED_OR_CORPSE_DESPAWN = 2
    # Despawns after a specified time.
    TEMP_SUMMON_TIMED_DESPAWN = 3
    # Despawns after a specified time after the creature is out of combat.
    TEMP_SUMMON_TIMED_DESPAWN_OUT_OF_COMBAT = 4
    # Despawns instantly after death.
    TEMP_SUMMON_CORPSE_DESPAWN = 5
    # Despawns after a specified time after death.
    TEMP_SUMMON_CORPSE_TIMED_DESPAWN = 6
    # Despawns when the creature disappears.
    TEMP_SUMMON_DEAD_DESPAWN = 7
    # Despawns when UnSummon() is called.
    TEMP_SUMMON_MANUAL_DESPAWN = 8
    # Despawns after a specified time (in or out of combat) OR when the creature disappears.
    TEMP_SUMMON_TIMED_COMBAT_OR_DEAD_DESPAWN = 9
    # Despawns after a specified time (in or out of combat) OR when the creature dies.
    TEMP_SUMMON_TIMED_COMBAT_OR_CORPSE_DESPAWN = 10
    # Dies after a specified time (in or out of combat) and despawns when creature disappears.
    TEMP_SUMMON_TIMED_DEATH_AND_DEAD_DESPAWN = 11


class MapTileStates(IntEnum):
    READY = 0
    LOADING = 1
    UNUSABLE = 2


class ZSource(IntEnum):
    CURRENT_Z = 0
    NAVS = 1
    TERRAIN = 2
    WMO = 3


class MoveType(IntEnum):
    INSTANT = 0
    IDLE = 1
    WANDER = 2
    WAYPOINTS = 3
    CHASE = 4
    FLIGHT = 5
    EVADE = 6
    FEAR = 7
    DISTRACTED = 8
    GROUP = 9
    PET = 10
    CONFUSED = 11
    FOLLOW = 12


class MoveFlags(IntEnum):
    MOVEFLAG_NONE = 0x0
    MOVEFLAG_FORWARD = 0x1
    MOVEFLAG_BACKWARD = 0x2
    MOVEFLAG_STRAFE_LEFT = 0x4
    MOVEFLAG_STRAFE_RIGHT = 0x8
    MOVEFLAG_LEFT = 0x10
    MOVEFLAG_RIGHT = 0x20
    MOVEFLAG_PITCH_UP = 0x40
    MOVEFLAG_PITCH_DOWN = 0x80
    MOVEFLAG_WALK = 0x100
    MOVEFLAG_TIME_VALID = 0x200
    MOVEFLAG_IMMOBILIZED = 0x400
    MOVEFLAG_DONTCOLLIDE = 0x800
    MOVEFLAG_REDIRECTED = 0x1000
    MOVEFLAG_ROOTED = 0x2000
    MOVEFLAG_FALLING = 0x4000
    MOVEFLAG_FALLEN_FAR = 0x8000
    MOVEFLAG_PENDING_STOP = 0x10000
    MOVEFLAG_PENDING_UNSTRAFE = 0x20000
    MOVEFLAG_PENDING_FALL = 0x40000
    MOVEFLAG_PENDING_FORWARD = 0x80000
    MOVEFLAG_PENDING_BACKWARD = 0x100000
    MOVEFLAG_PENDING_STR_LEFT = 0x200000
    MOVEFLAG_PENDING_STR_RGHT = 0x400000
    MOVEFLAG_PEND_MOVE_MASK = 0x180000
    MOVEFLAG_PEND_STRAFE_MASK = 0x600000
    MOVEFLAG_PENDING_MASK = 0x7F0000
    MOVEFLAG_MOVED = 0x800000
    MOVEFLAG_SLIDING = 0x1000000
    MOVEFLAG_SWIMMING = 0x2000000
    MOVEFLAG_SPLINE_MOVER = 0x4000000
    MOVEFLAG_SPEED_DIRTY = 0x8000000
    MOVEFLAG_HALTED = 0x10000000
    MOVEFLAG_NUDGE = 0x20000000
    MOVEFLAG_FALL_MASK = 0x100C000
    MOVEFLAG_LOCAL = 0x500F400
    MOVEFLAG_MOVE_MASK = 0x3
    MOVEFLAG_TURN_MASK = 0x30
    MOVEFLAG_PITCH_MASK = 0xC0
    MOVEFLAG_STRAFE_MASK = 0xC
    MOVEFLAG_MOTION_MASK = 0xFF
    MOVEFLAG_STOPPED_MASK = 0x3100F


class SpeedType(IntEnum):
    WALK = 0
    RUN = 1
    SWIM = 2
    TURN = 3


class BuyResults(IntEnum):
    BUY_ERR_ITEM_SOLD_OUT = 1
    BUY_ERR_NOT_ENOUGH_MONEY = 2
    BUY_ERR_SELLER_DONT_LIKE_YOU = 4
    BUY_ERR_DISTANCE_TOO_FAR = 5
    BUY_ERR_CANT_CARRY_MORE = 8
    BUY_ERR_CANT_FIND_ITEM = 11


class SellResults(IntEnum):
    SELL_ERR_CANT_FIND_ITEM = 1
    SELL_ERR_VENDOR_NOT_INTERESTED = 2
    SELL_ERR_VENDOR_HATES_YOU = 3
    SELL_ERR_YOU_DONT_OWN_THAT_ITEM = 4
    SELL_ERR_ONLY_EMPTY_BAG = 5  # Not actually handled in the client, but needed to unlock the bag.


class ItemBondingTypes(IntEnum):
    NO_BIND = 0
    BIND_WHEN_PICKED_UP = 1
    BIND_WHEN_EQUIPPED = 2
    BIND_WHEN_USE = 3
    BIND_QUEST_ITEM = 4


class LootMethods(IntEnum):
    LOOT_METHOD_FREEFORALL = 0x0
    LOOT_METHOD_ROUNDROBIN = 0x1
    LOOT_METHOD_MASTERLOOTER = 0x2
    LOOT_METHOD_MAX = 0x3


class ActionButtonTypes(IntEnum):
    ACTION_BUTTON_SPELL = 0x00
    ACTION_BUTTON_ITEM = 0xFF


class PlayerFlags(IntEnum):
    PLAYER_FLAGS_NONE = 0x0
    PLAYER_FLAGS_GROUP_LEADER = 0x1
    PLAYER_FLAGS_AFK = 0x4
    PLAYER_FLAGS_DND = 0x8
    PLAYER_FLAGS_GM = 0x10


class BankSlots(IntEnum):
    BANK_SLOT_ITEM_START = 39
    BANK_SLOT_ITEM_END = 63
    BANK_SLOT_BAG_START = 63
    BANK_SLOT_BAG_END = 69


class BankSlotErrors(IntEnum):
    BANKSLOT_ERROR_FAILED_TOO_MANY = 0
    BANKSLOT_ERROR_INSUFFICIENT_FUNDS = 1
    BANKSLOT_ERROR_NOTBANKER = 2
    BANKSLOT_ERROR_OK = 3


class ChannelMemberFlags(IntEnum):
    NONE = 0x0
    OWNER = 0x1
    MODERATOR = 0x2
    VOICE = 0x4


class ChannelNotifications(IntEnum):
    PLAYER_JOINED = 0x00
    PLAYER_LEFT = 0x01
    YOU_JOINED = 0x02
    YOU_LEFT = 0x03
    WRONG_PASSWORD = 0x04
    NOT_MEMBER = 0x05
    NOT_MODERATOR = 0x06
    PASSWORD_CHANGED = 0x07
    OWNER_CHANGED = 0x08
    PLAYER_NOT_FOUND = 0x09
    NOT_OWNER = 0x0A
    CHANNEL_OWNER = 0x0B
    MEMBER_FLAG_CHANGE = 0x0C
    MODERATOR = 0x0C
    ANNOUNCEMENTS_ON = 0x0D
    ANNOUNCEMENTS_OFF = 0x0E
    MODERATION_ON = 0x0F
    MODERATION_OFF = 0x10
    SELF_MUTED = 0x11
    KICKED = 0x12
    PLAYER_BANNED = 0x13
    BANNED = 0x14
    UNBANNED = 0x15
    PLAYER_NOT_BANNED = 0x16
    PLAYER_ALREADY_MEMBER = 0x17
    INVITE = 0x18
    INVITE_WRONG_FACTION = 0x19
    WRONG_FACTION = 0x1A


class GuildTypeCommand(IntEnum):
    GUILD_CREATE_S = 0x00
    GUILD_INVITE_S = 0x01
    GUILD_QUIT_S = 0x02
    GUILD_FOUNDER_S = 0x0C


class GuildCommandResults(IntEnum):
    GUILD_U_HAVE_INVITED = 0x00
    GUILD_INTERNAL = 0x01
    GUILD_ALREADY_IN_GUILD = 0x02
    ALREADY_IN_GUILD = 0x03
    INVITED_TO_GUILD = 0x04
    ALREADY_INVITED_TO_GUILD = 0x05
    GUILD_NAME_INVALID = 0x06
    GUILD_NAME_EXISTS = 0x07
    GUILD_LEADER_LEAVE = 0x08
    GUILD_PERMISSIONS = 0x08
    GUILD_PLAYER_NOT_IN_GUILD = 0x09
    GUILD_PLAYER_NOT_IN_GUILD_S = 0x0A
    GUILD_PLAYER_NOT_FOUND = 0x0B
    GUILD_NOT_ALLIED = 0x0C


class GuildEvents(IntEnum):
    GUILD_EVENT_PROMOTION = 0x0
    GUILD_EVENT_DEMOTION = 0x1
    GUILD_EVENT_MOTD = 0x2
    GUILD_EVENT_JOINED = 0x3
    GUILD_EVENT_LEFT = 0x4
    GUILD_EVENT_REMOVED = 0x5
    GUILD_EVENT_LEADER_IS = 0x6
    GUILD_EVENT_LEADER_CHANGED = 0x7
    GUILD_EVENT_DISBANDED = 0x8
    GUILD_EVENT_TABARDCHANGE = 0x9  # Not implemented client-side.


class GuildChatMessageTypes(IntEnum):
    G_MSGTYPE_ALL = 0
    G_MSGTYPE_ALLBUTONE = 1
    G_MSGTYPE_PUBLICCHAT = 2
    G_MSGTYPE_OFFICERCHAT = 3


class GuildRank(IntEnum):
    GUILDRANK_GUILD_MASTER = 0
    GUILDRANK_OFFICER = 1
    GUILDRANK_VETERAN = 2
    GUILDRANK_MEMBER = 3
    GUILDRANK_INITIATE = 4
    GUILDRANK_LOWEST = 9


class GuildEmblemResult(IntEnum):
    ERR_GUILDEMBLEM_SUCCESS = 0
    ERR_GUILDEMBLEM_INVALID_TABARD_COLORS = 1
    ERR_GUILDEMBLEM_NOGUILD = 2
    ERR_GUILDEMBLEM_NOTGUILDMASTER = 3
    ERR_GUILDEMBLEM_NOTENOUGHMONEY = 4
    ERR_GUILDEMBLEM_INVALIDVENDOR = 5


class FriendResults(IntEnum):
    FRIEND_DB_ERROR = 0x0
    FRIEND_LIST_FULL = 0x1
    FRIEND_ONLINE = 0x2
    FRIEND_OFFLINE = 0x3
    FRIEND_NOT_FOUND = 0x4
    FRIEND_REMOVED = 0x5
    FRIEND_ADDED_ONLINE = 0x6
    FRIEND_ADDED_OFFLINE = 0x7
    FRIEND_ALREADY = 0x8
    FRIEND_SELF = 0x9
    FRIEND_ENEMY = 0xA
    FRIEND_IGNORE_FULL = 0xB
    FRIEND_IGNORE_SELF = 0xC
    FRIEND_IGNORE_NOT_FOUND = 0xD
    FRIEND_IGNORE_ALREADY = 0xE
    FRIEND_IGNORE_ADDED = 0xF
    FRIEND_IGNORE_REMOVED = 0x10


class FriendStatus(IntEnum):
    FRIEND_STATUS_OFFLINE = 0
    FRIEND_STATUS_ONLINE = 1


class WhoPartyStatus(IntEnum):
    WHO_PARTY_STATUS_NOT_IN_PARTY = 0x0
    WHO_PARTY_STATUS_IN_PARTY = 0x1
    WHO_PARTY_STATUS_LFG = 0x2


class WhoSortTypes(IntEnum):
    WHO_SORT_ZONE = 0x0
    WHO_SORT_LEVEL = 0x1
    WHO_SORT_CLASS = 0x2
    WHO_SORT_GROUP = 0x3
    WHO_SORT_NAME = 0x4
    WHO_SORT_RACE = 0x5
    WHO_SORT_GUILD = 0x6


class ActivateTaxiReplies(IntEnum):
    ERR_TAXIOK = 0
    ERR_TAXIUNSPECIFIEDSERVERERROR = 1
    ERR_TAXINOSUCHPATH = 2
    ERR_TAXINOTENOUGHMONEY = 3
    ERR_TAXITOOFARAWAY = 4
    ERR_TAXINOVENDORNEARBY = 5
    ERR_TAXINOTVISITED = 6
    ERR_TAXIPLAYERBUSY = 7
    ERR_TAXIPLAYERALREADYMOUNTED = 8
    ERR_TAXIPLAYERSHAPESHIFTED = 9
    ERR_TAXIPLAYERMOVING = 10
    ERR_TAXISAMENODE = 11
    ERR_TAXINOTSTANDING = 12


class EnvironmentalDamageTypes(IntEnum):
    INVALID = 0
    HOLY = 1
    FIRE = 2
    NATURE = 3
    FROST = 4
    SHADOW = 5


class LiquidTypes(IntEnum):
    NONE = 0
    SHADOW = 1
    IMPASS = 2
    RIVER = 4
    OCEAN = 8
    MAGMA = 10
    DEEP = 20


class MirrorTimerTypes(IntEnum):
    FATIGUE = 0
    BREATH = 1
    FEIGNDEATH = 2
    SLIME = 3
    MAGMA = 4


class LogoutResponseCodes(IntEnum):
    LOGOUT_CANCEL = 0
    LOGOUT_PROCEED = 1


class LockKeyTypes(IntEnum):
    LOCK_KEY_NONE = 0
    LOCK_KEY_ITEM = 1
    LOCK_KEY_SKILL = 2


class LockTypes(IntEnum):
    LOCKTYPE_NONE = 0
    LOCKTYPE_PICKLOCK = 1
    LOCKTYPE_HERBALISM = 2
    LOCKTYPE_MINING = 3
    LOCKTYPE_DISARM_TRAP = 4
    LOCKTYPE_OPEN = 5
    LOCKTYPE_TREASURE = 6
    LOCKTYPE_CALCIFIED_ELVEN_GEMS = 7
    LOCKTYPE_CLOSE = 8
    LOCKTYPE_ARM_TRAP = 9
    LOCKTYPE_QUICK_OPEN = 10
    LOCKTYPE_QUICK_CLOSE = 11
    LOCKTYPE_OPEN_TINKERING = 12
    LOCKTYPE_OPEN_KNEELING = 13
    LOCKTYPE_OPEN_ATTACKING = 14
    LOCKTYPE_GAHZRIDIAN = 15
    LOCKTYPE_BLASTING = 16
    LOCKTYPE_SLOW_OPEN = 17
    LOCKTYPE_SLOW_CLOSE = 18
    LOCKTYPE_FISHING = 19


class ReputationSourceGain(IntEnum):
    REPUTATION_SOURCE_KILL = 0
    REPUTATION_SOURCE_QUEST = 1
    REPUTATION_SOURCE_SPELL = 2


class ScriptTypes(IntEnum):
    SCRIPT_TYPE_QUEST_START = 0
    SCRIPT_TYPE_QUEST_END = 1
    SCRIPT_TYPE_CREATURE_MOVEMENT = 2
    SCRIPT_TYPE_CREATURE_SPELL = 3
    SCRIPT_TYPE_GAMEOBJECT = 4
    SCRIPT_TYPE_GENERIC = 5
    SCRIPT_TYPE_GOSSIP = 6
    SCRIPT_TYPE_SPELL = 7
    SCRIPT_TYPE_AI = 8
    SCRIPT_TYPE_EVENT_SCRIPT = 9
    SCRIPT_TYPE_AREA_TRIGGER = 10


class TeleportToOptions(IntEnum):
    TELE_TO_GM_MODE = 0x01
    TELE_TO_NOT_LEAVE_TRANSPORT = 0x02
    TELE_TO_NOT_LEAVE_COMBAT = 0x04
    TELE_TO_NOT_UNSUMMON_PET = 0x08
    TELE_TO_SPELL = 0x10
    TELE_TO_FORCE_MAP_CHANGE = 0x20


# VMaNGOS MotionTypes.
class MotionTypes(IntEnum):
    IDLE_MOTION_TYPE = 0  # IdleMovementGenerator.h
    RANDOM_MOTION_TYPE = 1  # RandomMovementGenerator.h
    WAYPOINT_MOTION_TYPE = 2  # WaypointMovementGenerator.h
    MAX_DB_MOTION_TYPE = 3  # *** this and below motion types can't be set in DB.

    CONFUSED_MOTION_TYPE = 4  # ConfusedMovementGenerator.h
    CHASE_MOTION_TYPE = 5  # TargetedMovementGenerator.h
    HOME_MOTION_TYPE = 6  # HomeMovementGenerator.h
    FLIGHT_MOTION_TYPE = 7  # WaypointMovementGenerator.h
    POINT_MOTION_TYPE = 8  # PointMovementGenerator.h
    FLEEING_MOTION_TYPE = 9  # FleeingMovementGenerator.h
    DISTRACT_MOTION_TYPE = 10  # IdleMovementGenerator.h
    ASSISTANCE_MOTION_TYPE = 11  # PointMovementGenerator.h (first part of flee for assistance)
    ASSISTANCE_DISTRACT_MOTION_TYPE = 12  # IdleMovementGenerator.h (second part of flee for assistance)
    TIMED_FLEEING_MOTION_TYPE = 13  # FleeingMovementGenerator.h (alt.second part of flee for assistance)
    FOLLOW_MOTION_TYPE = 14  # TargetedMovementGenerator.h
    EFFECT_MOTION_TYPE = 15
    PATROL_MOTION_TYPE = 16
    CHARGE_MOTION_TYPE = 17
    DISTANCING_MOTION_TYPE = 18


class UnitInLosReaction(IntEnum):
    ULR_ANY = 0
    ULR_HOSTILE = 1
    ULR_NON_HOSTILE = 2


class PoolType(IntEnum):
    CREATURE = 0
    GAMEOBJECT = 1


class MapsNoNavs(IntEnum):

    @classmethod
    def has_value(cls, value):
        return value in cls._value2member_map_

    UnderMine = 2
    Test = 13
    ScottTest = 25
    Test2 = 29
    PVPZone1 = 30
    PVPZone2 = 37
    Collin = 42
    SunkenTemple = 109


class CreatureAIEventTypes(IntEnum):
    # TODO: (Taken as-is from VMaNGOS) Finish moving all of these to our naming.
    #     EVENT_T_TIMER                   = 0,                    // InitialMin, InitialMax, RepeatMin, RepeatMax
    #     EVENT_T_TIMER_OOC               = 1,                    // InitialMin, InitialMax, RepeatMin, RepeatMax
    #     EVENT_T_HP                      = 2,                    // HPMax%, HPMin%, RepeatMin, RepeatMax
    #     EVENT_T_MANA                    = 3,                    // ManaMax%,ManaMin% RepeatMin, RepeatMax
    #     EVENT_T_AGGRO                   = 4,                    // NONE
    #     EVENT_T_KILL                    = 5,                    // RepeatMin, RepeatMax, PlayerOnly
    #     EVENT_T_DEATH                   = 6,                    // NONE
    #     EVENT_T_EVADE                   = 7,                    // NONE
    #     EVENT_T_SPELLHIT                = 8,                    // SpellID, School, RepeatMin, RepeatMax
    #     EVENT_T_RANGE                   = 9,                    // MinDist, MaxDist, RepeatMin, RepeatMax
    #     EVENT_T_OOC_LOS                 = 10,                   // NoHostile, MaxRnage, RepeatMin, RepeatMax
    #     EVENT_T_SPAWNED                 = 11,                   // NONE
    #     EVENT_T_TARGET_HP               = 12,                   // HPMax%, HPMin%, RepeatMin, RepeatMax
    #     EVENT_T_TARGET_CASTING          = 13,                   // RepeatMin, RepeatMax
    #     EVENT_T_FRIENDLY_HP             = 14,                   // HPDeficit, Radius, RepeatMin, RepeatMax
    #     EVENT_T_FRIENDLY_IS_CC          = 15,                   // DispelType, Radius, RepeatMin, RepeatMax
    #     EVENT_T_FRIENDLY_MISSING_BUFF   = 16,                   // SpellId, Radius, RepeatMin, RepeatMax
    #     EVENT_T_SUMMONED_UNIT           = 17,                   // CreatureId, RepeatMin, RepeatMax
    #     EVENT_T_TARGET_MANA             = 18,                   // ManaMax%, ManaMin%, RepeatMin, RepeatMax
    #     EVENT_T_QUEST_ACCEPT            = 19,                   // QuestID
    #     EVENT_T_QUEST_COMPLETE          = 20,                   //
    #     EVENT_T_REACHED_HOME            = 21,                   // NONE
    #     EVENT_T_RECEIVE_EMOTE           = 22,                   // EmoteId, Condition, CondValue1, CondValue2
    #     EVENT_T_AURA                    = 23,                   // Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max
    #     EVENT_T_TARGET_AURA             = 24,                   // Param1 = SpellID, Param2 = Number of time stacked, Param3/4 Repeat Min/Max
    #     EVENT_T_SUMMONED_JUST_DIED      = 25,                   // CreatureId, RepeatMin, RepeatMax
    #     EVENT_T_SUMMONED_JUST_DESPAWN   = 26,                   // CreatureId, RepeatMin, RepeatMax
    #     EVENT_T_MISSING_AURA            = 27,                   // Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max
    #     EVENT_T_TARGET_MISSING_AURA     = 28,                   // Param1 = SpellID, Param2 = Number of time stacked expected, Param3/4 Repeat Min/Max
    #     EVENT_T_MOVEMENT_INFORM         = 29,                   // Param1 = motion type, Param2 = point ID, RepeatMin, RepeatMax
    #     EVENT_T_LEAVE_COMBAT            = 30,                   // NONE
    #     EVENT_T_MAP_SCRIPT_EVENT        = 31,                   // Param1 = EventID, Param2 = Data
    #     EVENT_T_GROUP_MEMBER_DIED       = 32,                   // Param1 = CreatureId, Param2 = IsLeader
    #     EVENT_T_VICTIM_ROOTED           = 33,                   // RepeatMin, RepeatMax

    AI_EVENT_TYPE_TIMER_IN_COMBAT = 0
    AI_EVENT_TYPE_OUT_OF_COMBAT = 1
    AI_EVENT_TYPE_HP = 2
    AI_EVENT_TYPE_MANA = 3
    AI_EVENT_TYPE_ON_ENTER_COMBAT = 4
    AI_EVENT_TYPE_ON_KILL_UNIT = 5
    AI_EVENT_TYPE_ON_DEATH = 6
    AI_EVENT_TYPE_ON_EVADE = 7
    AI_EVENT_TYPE_SPELL_HIT = 8
    AI_EVENT_TYPE_RANGE = 9
    AI_EVENT_TYPE_OOC_LOS = 10
    AI_EVENT_TYPE_ON_SPAWN = 11
    AI_EVENT_TYPE_TARGET_HP = 12
    AI_EVENT_TYPE_TARGET_CASTING = 13
    AI_EVENT_TYPE_FRIENDLY_HP = 14
    AI_EVENT_TYPE_FRIENDLY_MISSING_BUFF = 16
    AI_EVENT_TYPE_SUMMONED_UNIT = 17
    AI_EVENT_TYPE_TARGET_MANA = 18
    AI_EVENT_TYPE_QUEST_ACCEPT = 19
    AI_EVENT_TYPE_QUEST_COMPLETE = 20
    AI_EVENT_TYPE_REACHED_HOME = 21
    AI_EVENT_TYPE_RECEIVE_EMOTE = 22
    AI_EVENT_TYPE_TARGET_AURA = 24
    AI_EVENT_TYPE_MISSING_AURA = 27
    AI_EVENT_TYPE_TARGET_MISSING_AURA = 28
    # AI_EVENT_TYPE_MOVEMENT_INFORM = 29
    AI_EVENT_TYPE_LEAVE_COMBAT = 30
    AI_EVENT_TYPE_SCRIPT_EVENT = 31
    AI_EVENT_TYPE_GROUP_MEMBER_DIED = 32
    AI_EVENT_TYPE_TARGET_ROOTED = 33


class BroadcastMessageType(IntEnum):
    BROADCAST_MSG_SAY = 0
    BROADCAST_MSG_YELL = 1
    BROADCAST_MSG_EMOTE = 2
