from enum import IntEnum, Enum


class EncapsulationType(IntEnum):
    PRIVATE = 0
    PUBLIC = 1
    DYNAMIC = 3
    IGNORE = 4


class ObjectFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return None

    OBJECT_FIELD_GUID = (0x0, EncapsulationType.PUBLIC, 2)     # 0x000 - Type: GUID
    OBJECT_FIELD_TYPE = (0x2, EncapsulationType.PUBLIC, 1)     # 0x002 - Type: INT
    OBJECT_FIELD_ENTRY = (0x3, EncapsulationType.PUBLIC, 1)    # 0x003 - Type: INT
    OBJECT_FIELD_SCALE_X = (0x4, EncapsulationType.PUBLIC, 1)  # 0x004 - Type: FLOAT
    OBJECT_FIELD_PADDING = (0x5, EncapsulationType.PUBLIC, 1)  # 0x005 - Type: INT
    END = (0x6, EncapsulationType.IGNORE, 1)                   # 0x006 - Internal, needs size 1.


class ItemFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ObjectFields

    ITEM_FIELD_OWNER = (ObjectFields.END + 0x0, EncapsulationType.PUBLIC, 2)           # 0x006 - Type: GUID
    ITEM_FIELD_CONTAINED = (ObjectFields.END + 0x2, EncapsulationType.PUBLIC, 2)       # 0x008 - Type: GUID
    ITEM_FIELD_CREATOR = (ObjectFields.END + 0x4, EncapsulationType.PUBLIC, 2)         # 0x00A - Type: GUID
    ITEM_FIELD_STACK_COUNT = (ObjectFields.END + 0x6, EncapsulationType.PRIVATE, 1)    # 0x00C - Type: INT
    ITEM_FIELD_DURATION = (ObjectFields.END + 0x7, EncapsulationType.PRIVATE, 1)       # 0x00D - Type: INT
    ITEM_FIELD_SPELL_CHARGES = (ObjectFields.END + 0x8, EncapsulationType.PRIVATE, 5)  # 0x00E - Type: INT
    ITEM_FIELD_FLAGS = (ObjectFields.END + 0xD, EncapsulationType.PUBLIC, 1)           # 0x013 - Type: TWO_SHORT
    ITEM_FIELD_ENCHANTMENT = (ObjectFields.END + 0xE, EncapsulationType.PUBLIC, 15)    # 0x014 - Type: INT
    ITEM_FIELD_PAD = (ObjectFields.END + 0x1D, EncapsulationType.PUBLIC, 1)            # 0x023 - Type: INT
    END = (ObjectFields.END + 0x1E, EncapsulationType.IGNORE, 1)                       # 0x024 - Internal, needs size 1.


class ContainerFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ItemFields

    CONTAINER_FIELD_NUM_SLOTS = (ItemFields.END + 0x0, EncapsulationType.PUBLIC, 1)  # 0x01E - Type: INT
    CONTAINER_ALIGN_PAD = (ItemFields.END + 0x1, EncapsulationType.PUBLIC, 1)        # 0x01F - Type: BYTES
    CONTAINER_FIELD_SLOT_1 = (ItemFields.END + 0x2, EncapsulationType.PUBLIC, 40)    # 0x020 - Type: GUID
    END = (ItemFields.END + 0x2A, EncapsulationType.IGNORE, 1)                       # 0x048 - Internal, needs size 1.


class UnitFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ObjectFields

    UNIT_FIELD_CHARM = (ObjectFields.END + 0x0, EncapsulationType.PUBLIC, 2)                   # 6 - GUID
    UNIT_FIELD_SUMMON = (ObjectFields.END + 0x2, EncapsulationType.PUBLIC, 2)                  # 8 - GUID
    UNIT_FIELD_CHARMEDBY = (ObjectFields.END + 0x4, EncapsulationType.PUBLIC, 2)              # 10 - GUID
    UNIT_FIELD_SUMMONEDBY = (ObjectFields.END + 0x6, EncapsulationType.PUBLIC, 2)             # 12 - GUID
    UNIT_FIELD_CREATEDBY = (ObjectFields.END + 0x8, EncapsulationType.PUBLIC, 2)              # 14 - GUID
    UNIT_FIELD_TARGET = (ObjectFields.END + 0xA, EncapsulationType.PUBLIC, 2)                 # 16 - GUID
    UNIT_FIELD_COMBO_TARGET = (ObjectFields.END + 0xC, EncapsulationType.PUBLIC, 2)           # 18 - GUID
    UNIT_FIELD_CHANNEL_OBJECT = (ObjectFields.END + 0xE, EncapsulationType.PUBLIC, 2)         # 20 - GUID
    UNIT_FIELD_HEALTH = (ObjectFields.END + 0x10, EncapsulationType.PUBLIC, 1)                # 22 - INT
    UNIT_FIELD_POWER1 = (ObjectFields.END + 0x11, EncapsulationType.PUBLIC, 1)                # 23 - INT
    UNIT_FIELD_POWER2 = (ObjectFields.END + 0x12, EncapsulationType.PUBLIC, 1)                # 24 - INT
    UNIT_FIELD_POWER3 = (ObjectFields.END + 0x13, EncapsulationType.PUBLIC, 1)                # 25 - INT
    UNIT_FIELD_POWER4 = (ObjectFields.END + 0x14, EncapsulationType.PUBLIC, 1)                # 26 - INT
    UNIT_FIELD_MAXHEALTH = (ObjectFields.END + 0x15, EncapsulationType.PUBLIC, 1)             # 27 - INT
    UNIT_FIELD_MAXPOWER1 = (ObjectFields.END + 0x16, EncapsulationType.PUBLIC, 1)             # 28 - INT
    UNIT_FIELD_MAXPOWER2 = (ObjectFields.END + 0x17, EncapsulationType.PUBLIC, 1)             # 29 - INT
    UNIT_FIELD_MAXPOWER3 = (ObjectFields.END + 0x18, EncapsulationType.PUBLIC, 1)             # 30 - INT
    UNIT_FIELD_MAXPOWER4 = (ObjectFields.END + 0x19, EncapsulationType.PUBLIC, 1)             # 31 - INT
    UNIT_FIELD_LEVEL = (ObjectFields.END + 0x1A, EncapsulationType.PUBLIC, 1)                 # 32 - INT
    UNIT_FIELD_FACTIONTEMPLATE = (ObjectFields.END + 0x1B, EncapsulationType.PUBLIC, 1)       # 33 - INT
    UNIT_FIELD_BYTES_0 = (ObjectFields.END + 0x1C, EncapsulationType.PUBLIC, 1)               # 34 - BYTES
    UNIT_FIELD_STAT0 = (ObjectFields.END + 0x1D, EncapsulationType.PRIVATE, 1)                # 35 - INT
    UNIT_FIELD_STAT1 = (ObjectFields.END + 0x1E, EncapsulationType.PRIVATE, 1)                # 36 - INT
    UNIT_FIELD_STAT2 = (ObjectFields.END + 0x1F, EncapsulationType.PRIVATE, 1)                # 37 - INT
    UNIT_FIELD_STAT3 = (ObjectFields.END + 0x20, EncapsulationType.PRIVATE, 1)                # 38 - INT
    UNIT_FIELD_STAT4 = (ObjectFields.END + 0x21, EncapsulationType.PRIVATE, 1)                # 39 - INT
    UNIT_FIELD_BASESTAT0 = (ObjectFields.END + 0x22, EncapsulationType.PRIVATE, 1)            # 40 - INT
    UNIT_FIELD_BASESTAT1 = (ObjectFields.END + 0x23, EncapsulationType.PRIVATE, 1)            # 41 - INT
    UNIT_FIELD_BASESTAT2 = (ObjectFields.END + 0x24, EncapsulationType.PRIVATE, 1)            # 42 - INT
    UNIT_FIELD_BASESTAT3 = (ObjectFields.END + 0x25, EncapsulationType.PRIVATE, 1)            # 43 - INT
    UNIT_FIELD_BASESTAT4 = (ObjectFields.END + 0x26, EncapsulationType.PRIVATE, 1)            # 44 - INT
    UNIT_VIRTUAL_ITEM_SLOT_DISPLAY = (ObjectFields.END + 0x27, EncapsulationType.PUBLIC, 3)   # 45 - INT
    UNIT_VIRTUAL_ITEM_INFO = (ObjectFields.END + 0x2A, EncapsulationType.PUBLIC, 6)           # 48 - BYTES
    UNIT_FIELD_FLAGS = (ObjectFields.END + 0x30, EncapsulationType.PUBLIC, 1)                 # 54 - INT
    UNIT_FIELD_COINAGE = (ObjectFields.END + 0x31, EncapsulationType.PRIVATE, 1)              # 55 - INT
    UNIT_FIELD_AURA = (ObjectFields.END + 0x32, EncapsulationType.PUBLIC, 56)                 # 56 - INT
    UNIT_FIELD_AURAFLAGS = (ObjectFields.END + 0x6A, EncapsulationType.PUBLIC, 7)            # 112 - BYTES
    UNIT_FIELD_AURASTATE = (ObjectFields.END + 0x71, EncapsulationType.PUBLIC, 1)            # 119 - INT
    UNIT_FIELD_MOD_DAMAGE_DONE = (ObjectFields.END + 0x72, EncapsulationType.PRIVATE, 6)     # 120 - INT
    UNIT_FIELD_MOD_DAMAGE_TAKEN = (ObjectFields.END + 0x78, EncapsulationType.PRIVATE, 6)    # 126 - INT
    UNIT_FIELD_MOD_CREATURE_DAMAGE_DONE = (ObjectFields.END + 0x7E, EncapsulationType.PRIVATE, 8)  # 132 - INT
    UNIT_FIELD_BASEATTACKTIME = (ObjectFields.END + 0x86, EncapsulationType.PUBLIC, 2)       # 140 - INT
    UNIT_FIELD_RESISTANCES = (ObjectFields.END + 0x88, EncapsulationType.PRIVATE, 6)         # 142 - INT
    UNIT_FIELD_BOUNDINGRADIUS = (ObjectFields.END + 0x8E, EncapsulationType.PUBLIC, 1)       # 148 - FLOAT
    UNIT_FIELD_COMBATREACH = (ObjectFields.END + 0x8F, EncapsulationType.PUBLIC, 1)          # 149 - FLOAT
    UNIT_FIELD_WEAPONREACH = (ObjectFields.END + 0x90, EncapsulationType.PUBLIC, 1)          # 150 - FLOAT
    UNIT_FIELD_DISPLAYID = (ObjectFields.END + 0x91, EncapsulationType.PUBLIC, 1)            # 151 - INT
    UNIT_FIELD_MOUNTDISPLAYID = (ObjectFields.END + 0x92, EncapsulationType.PUBLIC, 1)       # 152 - INT
    UNIT_FIELD_DAMAGE = (ObjectFields.END + 0x93, EncapsulationType.PUBLIC, 1)               # 153 - TWO_SHORT
    UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE = (ObjectFields.END + 0x94, EncapsulationType.PRIVATE, 6)  # 154 - INT
    UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE = (ObjectFields.END + 0x9A, EncapsulationType.PRIVATE, 6)  # 160 - INT
    UNIT_FIELD_RESISTANCEITEMMODS = (ObjectFields.END + 0xA0, EncapsulationType.PRIVATE, 6)  # 166 - INT
    UNIT_FIELD_BYTES_1 = (ObjectFields.END + 0xA6, EncapsulationType.PUBLIC, 1)              # 172 - BYTES
    UNIT_FIELD_PETNUMBER = (ObjectFields.END + 0xA7, EncapsulationType.PUBLIC, 1)            # 173 - INT
    UNIT_FIELD_PET_NAME_TIMESTAMP = (ObjectFields.END + 0xA8, EncapsulationType.PUBLIC, 1)   # 174 - INT
    UNIT_FIELD_PETEXPERIENCE = (ObjectFields.END + 0xA9, EncapsulationType.PRIVATE, 1)       # 175 - INT
    UNIT_FIELD_PETNEXTLEVELEXP = (ObjectFields.END + 0xAA, EncapsulationType.PRIVATE, 1)     # 176 - INT
    UNIT_DYNAMIC_FLAGS = (ObjectFields.END + 0xAB, EncapsulationType.DYNAMIC, 1)             # 177 - INT
    UNIT_EMOTE_STATE = (ObjectFields.END + 0xAC, EncapsulationType.PUBLIC, 1)                # 178 - INT
    UNIT_CHANNEL_SPELL = (ObjectFields.END + 0xAD, EncapsulationType.PUBLIC, 1)              # 179 - INT
    UNIT_MOD_CAST_SPEED = (ObjectFields.END + 0xAE, EncapsulationType.PUBLIC, 1)             # 180 - INT
    UNIT_CREATED_BY_SPELL = (ObjectFields.END + 0xAF, EncapsulationType.PUBLIC, 1)           # 181 - INT
    UNIT_FIELD_BYTES_2 = (ObjectFields.END + 0xB0, EncapsulationType.PRIVATE, 1)             # 182 - BYTES
    UNIT_FIELD_PADDING = (ObjectFields.END + 0xB1, EncapsulationType.PUBLIC, 1)              # 183 - INT
    END = (ObjectFields.END + 0xB2, EncapsulationType.IGNORE, 1)                        # 184 - Internal, needs size 1.


class PlayerFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return UnitFields

    PLAYER_FIELD_INV_SLOT_1 = (UnitFields.END + 0x0, EncapsulationType.PUBLIC, 46)        # 0x0B2 - Type: GUID
    PLAYER_FIELD_PACK_SLOT_1 = (UnitFields.END + 0x2E, EncapsulationType.PRIVATE, 32)     # 0x0E0 - Type: GUID
    PLAYER_FIELD_BANK_SLOT_1 = (UnitFields.END + 0x4E, EncapsulationType.PRIVATE, 48)     # 0x100 - Type: GUID
    PLAYER_FIELD_BANKBAG_SLOT_1 = (UnitFields.END + 0x7E, EncapsulationType.PRIVATE, 12)  # 0x130 - Type: GUID
    PLAYER_SELECTION = (UnitFields.END + 0x8A, EncapsulationType.PUBLIC, 2)               # 0x13C - Type: GUID
    PLAYER_FARSIGHT = (UnitFields.END + 0x8C, EncapsulationType.PRIVATE, 2)               # 0x13E - Type: GUID
    PLAYER_DUEL_ARBITER = (UnitFields.END + 0x8E, EncapsulationType.PUBLIC, 2)            # 0x140 - Type: GUID
    PLAYER_FIELD_NUM_INV_SLOTS = (UnitFields.END + 0x90, EncapsulationType.PUBLIC, 1)     # 0x142 - Type: INT
    PLAYER_GUILDID = (UnitFields.END + 0x91, EncapsulationType.PUBLIC, 1)                 # 0x143 - Type: INT
    PLAYER_GUILDRANK = (UnitFields.END + 0x92, EncapsulationType.PUBLIC, 1)               # 0x144 - Type: INT
    PLAYER_BYTES = (UnitFields.END + 0x93, EncapsulationType.PUBLIC, 1)                   # 0x145 - Type: BYTES
    PLAYER_XP = (UnitFields.END + 0x94, EncapsulationType.PRIVATE, 1)                     # 0x146 - Type: INT
    PLAYER_NEXT_LEVEL_XP = (UnitFields.END + 0x95, EncapsulationType.PRIVATE, 1)          # 0x147 - Type: INT
    PLAYER_SKILL_INFO_1_1 = (UnitFields.END + 0x96, EncapsulationType.PRIVATE, 192)       # 0x148 - Type: TWO_SHORT
    PLAYER_BYTES_2 = (UnitFields.END + 0x156, EncapsulationType.PUBLIC, 1)                # 0x208 - Type: BYTES
    PLAYER_QUEST_LOG_1_1 = (UnitFields.END + 0x157, EncapsulationType.PRIVATE, 96)        # 0x209 - Type: INT
    PLAYER_CHARACTER_POINTS1 = (UnitFields.END + 0x1B7, EncapsulationType.PRIVATE, 1)     # 0x269 - Type: INT
    PLAYER_CHARACTER_POINTS2 = (UnitFields.END + 0x1B8, EncapsulationType.PRIVATE, 1)     # 0x26A - Type: INT
    PLAYER_TRACK_CREATURES = (UnitFields.END + 0x1B9, EncapsulationType.PRIVATE, 1)       # 0x26B - Type: INT
    PLAYER_TRACK_RESOURCES = (UnitFields.END + 0x1BA, EncapsulationType.PRIVATE, 1)       # 0x26C - Type: INT
    PLAYER_CHAT_FILTERS = (UnitFields.END + 0x1BB, EncapsulationType.PRIVATE, 1)          # 0x26D - Type: INT
    PLAYER_DUEL_TEAM = (UnitFields.END + 0x1BC, EncapsulationType.PUBLIC, 1)              # 0x26E - Type: INT
    PLAYER_BLOCK_PERCENTAGE = (UnitFields.END + 0x1BD, EncapsulationType.PRIVATE, 1)      # 0x26F - Type: FLOAT
    PLAYER_DODGE_PERCENTAGE = (UnitFields.END + 0x1BE, EncapsulationType.PRIVATE, 1)      # 0x270 - Type: FLOAT
    PLAYER_PARRY_PERCENTAGE = (UnitFields.END + 0x1BF, EncapsulationType.PRIVATE, 1)      # 0x271 - Type: FLOAT
    PLAYER_BASE_MANA = (UnitFields.END + 0x1C0, EncapsulationType.PRIVATE, 1)             # 0x272 - Type: INT
    PLAYER_GUILD_TIMESTAMP = (UnitFields.END + 0x1C1, EncapsulationType.PUBLIC, 1)        # 0x273 - Type: INT
    END = (UnitFields.END + 0x1C2, EncapsulationType.IGNORE, 1)                       # 0x274 - Internal, needs size 1.


class GameObjectFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ObjectFields

    GAMEOBJECT_DISPLAYID = (ObjectFields.END + 0x0, EncapsulationType.PUBLIC, 1)   # 0x006 - Type: INT
    GAMEOBJECT_FLAGS = (ObjectFields.END + 0x1, EncapsulationType.PUBLIC, 1)       # 0x007 - Type: INT
    GAMEOBJECT_ROTATION = (ObjectFields.END + 0x2, EncapsulationType.PUBLIC, 4)    # 0x008 - Type: FLOAT
    GAMEOBJECT_STATE = (ObjectFields.END + 0x6, EncapsulationType.PUBLIC, 1)       # 0x00C - Type: INT
    GAMEOBJECT_TIMESTAMP = (ObjectFields.END + 0x7, EncapsulationType.PUBLIC, 1)   # 0x00D - Type: INT
    GAMEOBJECT_POS_X = (ObjectFields.END + 0x8, EncapsulationType.PUBLIC, 1)       # 0x00E - Type: FLOAT
    GAMEOBJECT_POS_Y = (ObjectFields.END + 0x9, EncapsulationType.PUBLIC, 1)       # 0x00F - Type: FLOAT
    GAMEOBJECT_POS_Z = (ObjectFields.END + 0xA, EncapsulationType.PUBLIC, 1)       # 0x010 - Type: FLOAT
    GAMEOBJECT_FACING = (ObjectFields.END + 0xB, EncapsulationType.PUBLIC, 1)      # 0x011 - Type: FLOAT
    GAMEOBJECT_DYN_FLAGS = (ObjectFields.END + 0xC, EncapsulationType.DYNAMIC, 1)  # 0x012 - Type: INT
    GAMEOBJECT_FACTION = (ObjectFields.END + 0xD, EncapsulationType.PUBLIC, 1)     # 0x013 - Type: INT
    END = (ObjectFields.END + 0xE, EncapsulationType.IGNORE, 1)                    # 0x014 - Internal, needs size 1.


class DynamicObjectFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ObjectFields

    DYNAMICOBJECT_CASTER = (ObjectFields.END + 0x0, EncapsulationType.PUBLIC, 2)   # 0x006 - Type: GUID
    DYNAMICOBJECT_BYTES = (ObjectFields.END + 0x2, EncapsulationType.PUBLIC, 1)    # 0x008 - Type: BYTES
    DYNAMICOBJECT_SPELLID = (ObjectFields.END + 0x3, EncapsulationType.PUBLIC, 1)  # 0x009 - Type: INT
    DYNAMICOBJECT_RADIUS = (ObjectFields.END + 0x4, EncapsulationType.PUBLIC, 1)   # 0x00A - Type: FLOAT
    DYNAMICOBJECT_POS_X = (ObjectFields.END + 0x5, EncapsulationType.PUBLIC, 1)    # 0x00B - Type: FLOAT
    DYNAMICOBJECT_POS_Y = (ObjectFields.END + 0x6, EncapsulationType.PUBLIC, 1)    # 0x00C - Type: FLOAT
    DYNAMICOBJECT_POS_Z = (ObjectFields.END + 0x7, EncapsulationType.PUBLIC, 1)    # 0x00D - Type: FLOAT
    DYNAMICOBJECT_FACING = (ObjectFields.END + 0x8, EncapsulationType.PUBLIC, 1)   # 0x00E - Type: FLOAT
    DYNAMICOBJECT_PAD = (ObjectFields.END + 0x9, EncapsulationType.PUBLIC, 1)      # 0x00F - Type: BYTES
    END = (ObjectFields.END + 0xA, EncapsulationType.IGNORE, 1)                    # 0x010 - Internal, needs size 1.


class CorpseFields(int, Enum):
    def __new__(cls, value, flags, size):
        obj = int.__new__(cls, value)
        obj._value_ = value
        obj._flags_ = flags
        obj._size_ = size
        return obj

    @property
    def flags(self):
        return self._flags_

    @property
    def size(self):
        return self._size_

    @staticmethod
    def parent_fields():
        return ObjectFields

    CORPSE_FIELD_OWNER = (ObjectFields.END + 0x0, EncapsulationType.PUBLIC, 2)       # 0x006 - Type: GUID
    CORPSE_FIELD_FACING = (ObjectFields.END + 0x2, EncapsulationType.PUBLIC, 1)      # 0x008 - Type: FLOAT
    CORPSE_FIELD_POS_X = (ObjectFields.END + 0x3, EncapsulationType.PUBLIC, 1)       # 0x009 - Type: FLOAT
    CORPSE_FIELD_POS_Y = (ObjectFields.END + 0x4, EncapsulationType.PUBLIC, 1)       # 0x00A - Type: FLOAT
    CORPSE_FIELD_POS_Z = (ObjectFields.END + 0x5, EncapsulationType.PUBLIC, 1)       # 0x00B - Type: FLOAT
    CORPSE_FIELD_DISPLAY_ID = (ObjectFields.END + 0x6, EncapsulationType.PUBLIC, 1)  # 0x00C - Type: INT
    CORPSE_FIELD_ITEM = (ObjectFields.END + 0x7, EncapsulationType.PUBLIC, 19)       # 0x00D - Type: INT
    CORPSE_FIELD_BYTES_1 = (ObjectFields.END + 0x1A, EncapsulationType.PUBLIC, 1)    # 0x020 - Type: BYTES
    CORPSE_FIELD_BYTES_2 = (ObjectFields.END + 0x1B, EncapsulationType.PUBLIC, 1)    # 0x021 - Type: BYTES
    CORPSE_FIELD_GUILD = (ObjectFields.END + 0x1C, EncapsulationType.PUBLIC, 1)      # 0x022 - Type: INT
    CORPSE_FIELD_LEVEL = (ObjectFields.END + 0x1D, EncapsulationType.PUBLIC, 1)      # 0x023 - Type: INT
    END = (ObjectFields.END + 0x1E, EncapsulationType.IGNORE, 1)                     # 0x024 - Internal, needs size 1.
