from enum import IntEnum


class ObjectFields(IntEnum):
    OBJECT_FIELD_GUID = 0x0                                                     # 0x000 - Size: 2 - Type: GUID - Flags: PUBLIC
    OBJECT_FIELD_TYPE = 0x2                                                     # 0x002 - Size: 1 - Type: INT - Flags: PUBLIC
    OBJECT_FIELD_ENTRY = 0x3                                                    # 0x003 - Size: 1 - Type: INT - Flags: PUBLIC
    OBJECT_FIELD_SCALE_X = 0x4                                                  # 0x004 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    OBJECT_FIELD_PADDING = 0x5                                                  # 0x005 - Size: 1 - Type: INT - Flags: PUBLIC
    OBJECT_END = 0x6


class ItemFields(IntEnum):
    ITEM_FIELD_OWNER = ObjectFields.OBJECT_END + 0x0                            # 0x006 - Size: 2 - Type: GUID - Flags: PUBLIC
    ITEM_FIELD_CONTAINED = ObjectFields.OBJECT_END + 0x2                        # 0x008 - Size: 2 - Type: GUID - Flags: PUBLIC
    ITEM_FIELD_CREATOR = ObjectFields.OBJECT_END + 0x4                          # 0x00A - Size: 2 - Type: GUID - Flags: PUBLIC
    ITEM_FIELD_STACK_COUNT = ObjectFields.OBJECT_END + 0x6                      # 0x00C - Size: 1 - Type: INT - Flags: OWNER_ONLY + UNK2
    ITEM_FIELD_DURATION = ObjectFields.OBJECT_END + 0x7                         # 0x00D - Size: 1 - Type: INT - Flags: OWNER_ONLY + UNK2
    ITEM_FIELD_SPELL_CHARGES = ObjectFields.OBJECT_END + 0x8                    # 0x00E - Size: 5 - Type: INT - Flags: OWNER_ONLY + UNK2
    ITEM_FIELD_FLAGS = ObjectFields.OBJECT_END + 0xD                            # 0x013 - Size: 1 - Type: TWO_SHORT - Flags: PUBLIC
    ITEM_FIELD_ENCHANTMENT = ObjectFields.OBJECT_END + 0xE                      # 0x014 - Size: 15 - Type: INT - Flags: PUBLIC
    ITEM_FIELD_PAD = ObjectFields.OBJECT_END + 0x1D                             # 0x023 - Size: 1 - Type: INT - Flags: NONE
    ITEM_END = ObjectFields.OBJECT_END + 0x1E                                   # 0x024


class ContainerFields(IntEnum):
    CONTAINER_FIELD_NUM_SLOTS = ItemFields.ITEM_END + 0x0                       # 0x01E - Size: 1 - Type: INT - Flags: PUBLIC
    CONTAINER_ALIGN_PAD = ItemFields.ITEM_END + 0x1                             # 0x01F - Size: 1 - Type: BYTES - Flags: NONE
    CONTAINER_FIELD_SLOT_1 = ItemFields.ITEM_END + 0x2                          # 0x020 - Size: 40 - Type: GUID - Flags: PUBLIC
    CONTAINER_END = ItemFields.ITEM_END + 0x2A                                  # 0x048


class UnitFields(IntEnum):
    UNIT_FIELD_CHARM = ObjectFields.OBJECT_END + 0x0                            # 0x006 - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_SUMMON = ObjectFields.OBJECT_END + 0x2                           # 0x008 - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_CHARMEDBY = ObjectFields.OBJECT_END + 0x4                        # 0x00A - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_SUMMONEDBY = ObjectFields.OBJECT_END + 0x6                       # 0x00C - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_CREATEDBY = ObjectFields.OBJECT_END + 0x8                        # 0x00E - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_TARGET = ObjectFields.OBJECT_END + 0xA                           # 0x010 - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_COMBO_TARGET = ObjectFields.OBJECT_END + 0xC                     # 0x012 - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_CHANNEL_OBJECT = ObjectFields.OBJECT_END + 0xE                   # 0x014 - Size: 2 - Type: GUID - Flags: PUBLIC
    UNIT_FIELD_HEALTH = ObjectFields.OBJECT_END + 0x10                          # 0x016 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_POWER1 = ObjectFields.OBJECT_END + 0x11                          # 0x017 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_POWER2 = ObjectFields.OBJECT_END + 0x12                          # 0x018 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_POWER3 = ObjectFields.OBJECT_END + 0x13                          # 0x019 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_POWER4 = ObjectFields.OBJECT_END + 0x14                          # 0x01A - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MAXHEALTH = ObjectFields.OBJECT_END + 0x15                       # 0x01B - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MAXPOWER1 = ObjectFields.OBJECT_END + 0x16                       # 0x01C - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MAXPOWER2 = ObjectFields.OBJECT_END + 0x17                       # 0x01D - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MAXPOWER3 = ObjectFields.OBJECT_END + 0x18                       # 0x01E - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MAXPOWER4 = ObjectFields.OBJECT_END + 0x19                       # 0x01F - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_LEVEL = ObjectFields.OBJECT_END + 0x1A                           # 0x020 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_FACTIONTEMPLATE = ObjectFields.OBJECT_END + 0x1B                 # 0x021 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_BYTES_0 = ObjectFields.OBJECT_END + 0x1C                         # 0x022 - Size: 1 - Type: BYTES - Flags: PUBLIC
    UNIT_FIELD_STAT0 = ObjectFields.OBJECT_END + 0x1D                           # 0x023 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_STAT1 = ObjectFields.OBJECT_END + 0x1E                           # 0x024 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_STAT2 = ObjectFields.OBJECT_END + 0x1F                           # 0x025 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_STAT3 = ObjectFields.OBJECT_END + 0x20                           # 0x026 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_STAT4 = ObjectFields.OBJECT_END + 0x21                           # 0x027 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASESTAT0 = ObjectFields.OBJECT_END + 0x22                       # 0x028 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASESTAT1 = ObjectFields.OBJECT_END + 0x23                       # 0x029 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASESTAT2 = ObjectFields.OBJECT_END + 0x24                       # 0x02A - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASESTAT3 = ObjectFields.OBJECT_END + 0x25                       # 0x02B - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASESTAT4 = ObjectFields.OBJECT_END + 0x26                       # 0x02C - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_VIRTUAL_ITEM_SLOT_DISPLAY = ObjectFields.OBJECT_END + 0x27             # 0x02D - Size: 3 - Type: INT - Flags: PUBLIC
    UNIT_VIRTUAL_ITEM_INFO = ObjectFields.OBJECT_END + 0x2A                     # 0x030 - Size: 6 - Type: BYTES - Flags: PUBLIC
    UNIT_FIELD_FLAGS = ObjectFields.OBJECT_END + 0x30                           # 0x036 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_COINAGE = ObjectFields.OBJECT_END + 0x31                         # 0x037 - Size: 1 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_AURA = ObjectFields.OBJECT_END + 0x32                            # 0x038 - Size: 56 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_AURAFLAGS = ObjectFields.OBJECT_END + 0x6A                       # 0x070 - Size: 7 - Type: BYTES - Flags: PUBLIC
    UNIT_FIELD_AURASTATE = ObjectFields.OBJECT_END + 0x71                       # 0x077 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MOD_DAMAGE_DONE = ObjectFields.OBJECT_END + 0x72                 # 0x078 - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_MOD_DAMAGE_TAKEN = ObjectFields.OBJECT_END + 0x78                # 0x07E - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_MOD_CREATURE_DAMAGE_DONE = ObjectFields.OBJECT_END + 0x7E        # 0x084 - Size: 8 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BASEATTACKTIME = ObjectFields.OBJECT_END + 0x86                  # 0x08C - Size: 2 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_RESISTANCES = ObjectFields.OBJECT_END + 0x88                     # 0x08E - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BOUNDINGRADIUS = ObjectFields.OBJECT_END + 0x8E                  # 0x094 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    UNIT_FIELD_COMBATREACH = ObjectFields.OBJECT_END + 0x8F                     # 0x095 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    UNIT_FIELD_WEAPONREACH = ObjectFields.OBJECT_END + 0x90                     # 0x096 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    UNIT_FIELD_DISPLAYID = ObjectFields.OBJECT_END + 0x91                       # 0x097 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_MOUNTDISPLAYID = ObjectFields.OBJECT_END + 0x92                  # 0x098 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_DAMAGE = ObjectFields.OBJECT_END + 0x93                          # 0x099 - Size: 1 - Type: TWO_SHORT - Flags: PUBLIC
    UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE = ObjectFields.OBJECT_END + 0x94      # 0x09A - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE = ObjectFields.OBJECT_END + 0x9A      # 0x0A0 - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_RESISTANCEITEMMODS = ObjectFields.OBJECT_END + 0xA0              # 0x0A6 - Size: 6 - Type: INT - Flags: PRIVATE
    UNIT_FIELD_BYTES_1 = ObjectFields.OBJECT_END + 0xA6                         # 0x0AC - Size: 1 - Type: BYTES - Flags: PUBLIC
    UNIT_FIELD_PETNUMBER = ObjectFields.OBJECT_END + 0xA7                       # 0x0AD - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_PET_NAME_TIMESTAMP = ObjectFields.OBJECT_END + 0xA8              # 0x0AE - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_PETEXPERIENCE = ObjectFields.OBJECT_END + 0xA9                   # 0x0AF - Size: 1 - Type: INT - Flags: OWNER_ONLY
    UNIT_FIELD_PETNEXTLEVELEXP = ObjectFields.OBJECT_END + 0xAA                 # 0x0B0 - Size: 1 - Type: INT - Flags: OWNER_ONLY
    UNIT_DYNAMIC_FLAGS = ObjectFields.OBJECT_END + 0xAB                         # 0x0B1 - Size: 1 - Type: INT - Flags: DYNAMIC
    UNIT_EMOTE_STATE = ObjectFields.OBJECT_END + 0xAC                           # 0x0B2 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_CHANNEL_SPELL = ObjectFields.OBJECT_END + 0xAD                         # 0x0B3 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_MOD_CAST_SPEED = ObjectFields.OBJECT_END + 0xAE                        # 0x0B4 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_CREATED_BY_SPELL = ObjectFields.OBJECT_END + 0xAF                      # 0x0B5 - Size: 1 - Type: INT - Flags: PUBLIC
    UNIT_FIELD_BYTES_2 = ObjectFields.OBJECT_END + 0xB0                         # 0x0B6 - Size: 1 - Type: BYTES - Flags: PRIVATE
    UNIT_FIELD_PADDING = ObjectFields.OBJECT_END + 0xB1                         # 0x0B7 - Size: 1 - Type: INT - Flags: NONE
    UNIT_END = ObjectFields.OBJECT_END + 0xB2                                   # 0x0B8


class PlayerFields(IntEnum):
    PLAYER_FIELD_INV_SLOT_1 = UnitFields.UNIT_END + 0x0                         # 0x0B2 - Size: 46 - Type: GUID - Flags: PUBLIC
    PLAYER_FIELD_PACK_SLOT_1 = UnitFields.UNIT_END + 0x2E                       # 0x0E0 - Size: 32 - Type: GUID - Flags: PRIVATE + UNK2
    PLAYER_FIELD_BANK_SLOT_1 = UnitFields.UNIT_END + 0x4E                       # 0x100 - Size: 48 - Type: GUID - Flags: PRIVATE
    PLAYER_FIELD_BANKBAG_SLOT_1 = UnitFields.UNIT_END + 0x7E                    # 0x130 - Size: 12 - Type: GUID - Flags: PRIVATE
    PLAYER_SELECTION = UnitFields.UNIT_END + 0x8A                               # 0x13C - Size: 2 - Type: GUID - Flags: PUBLIC
    PLAYER_FARSIGHT = UnitFields.UNIT_END + 0x8C                                # 0x13E - Size: 2 - Type: GUID - Flags: PRIVATE
    PLAYER_DUEL_ARBITER = UnitFields.UNIT_END + 0x8E                            # 0x140 - Size: 2 - Type: GUID - Flags: PUBLIC
    PLAYER_FIELD_NUM_INV_SLOTS = UnitFields.UNIT_END + 0x90                     # 0x142 - Size: 1 - Type: INT - Flags: PUBLIC
    PLAYER_GUILDID = UnitFields.UNIT_END + 0x91                                 # 0x143 - Size: 1 - Type: INT - Flags: PUBLIC
    PLAYER_GUILDRANK = UnitFields.UNIT_END + 0x92                               # 0x144 - Size: 1 - Type: INT - Flags: PUBLIC
    PLAYER_BYTES = UnitFields.UNIT_END + 0x93                                   # 0x145 - Size: 1 - Type: BYTES - Flags: PUBLIC
    PLAYER_XP = UnitFields.UNIT_END + 0x94                                      # 0x146 - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_NEXT_LEVEL_XP = UnitFields.UNIT_END + 0x95                           # 0x147 - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_SKILL_INFO_1_1 = UnitFields.UNIT_END + 0x96                          # 0x148 - Size: 192 - Type: TWO_SHORT - Flags: PRIVATE
    PLAYER_BYTES_2 = UnitFields.UNIT_END + 0x156                                # 0x208 - Size: 1 - Type: BYTES - Flags: PUBLIC
    PLAYER_QUEST_LOG_1_1 = UnitFields.UNIT_END + 0x157                          # 0x209 - Size: 96 - Type: INT - Flags: PRIVATE
    PLAYER_CHARACTER_POINTS1 = UnitFields.UNIT_END + 0x1B7                      # 0x269 - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_CHARACTER_POINTS2 = UnitFields.UNIT_END + 0x1B8                      # 0x26A - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_TRACK_CREATURES = UnitFields.UNIT_END + 0x1B9                        # 0x26B - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_TRACK_RESOURCES = UnitFields.UNIT_END + 0x1BA                        # 0x26C - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_CHAT_FILTERS = UnitFields.UNIT_END + 0x1BB                           # 0x26D - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_DUEL_TEAM = UnitFields.UNIT_END + 0x1BC                              # 0x26E - Size: 1 - Type: INT - Flags: PUBLIC
    PLAYER_BLOCK_PERCENTAGE = UnitFields.UNIT_END + 0x1BD                       # 0x26F - Size: 1 - Type: FLOAT - Flags: PRIVATE
    PLAYER_DODGE_PERCENTAGE = UnitFields.UNIT_END + 0x1BE                       # 0x270 - Size: 1 - Type: FLOAT - Flags: PRIVATE
    PLAYER_PARRY_PERCENTAGE = UnitFields.UNIT_END + 0x1BF                       # 0x271 - Size: 1 - Type: FLOAT - Flags: PRIVATE
    PLAYER_BASE_MANA = UnitFields.UNIT_END + 0x1C0                              # 0x272 - Size: 1 - Type: INT - Flags: PRIVATE
    PLAYER_GUILD_TIMESTAMP = UnitFields.UNIT_END + 0x1C1                        # 0x273 - Size: 1 - Type: INT - Flags: PUBLIC
    PLAYER_END = UnitFields.UNIT_END + 0x1C2                                    # 0x274


class GameObjectFields(IntEnum):
    GAMEOBJECT_DISPLAYID = ObjectFields.OBJECT_END + 0x0                        # 0x006 - Size: 1 - Type: INT - Flags: PUBLIC
    GAMEOBJECT_FLAGS = ObjectFields.OBJECT_END + 0x1                            # 0x007 - Size: 1 - Type: INT - Flags: PUBLIC
    GAMEOBJECT_ROTATION = ObjectFields.OBJECT_END + 0x2                         # 0x008 - Size: 4 - Type: FLOAT - Flags: PUBLIC
    GAMEOBJECT_STATE = ObjectFields.OBJECT_END + 0x6                            # 0x00C - Size: 1 - Type: INT - Flags: PUBLIC
    GAMEOBJECT_TIMESTAMP = ObjectFields.OBJECT_END + 0x7                        # 0x00D - Size: 1 - Type: INT - Flags: PUBLIC
    GAMEOBJECT_POS_X = ObjectFields.OBJECT_END + 0x8                            # 0x00E - Size: 1 - Type: FLOAT - Flags: PUBLIC
    GAMEOBJECT_POS_Y = ObjectFields.OBJECT_END + 0x9                            # 0x00F - Size: 1 - Type: FLOAT - Flags: PUBLIC
    GAMEOBJECT_POS_Z = ObjectFields.OBJECT_END + 0xA                            # 0x010 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    GAMEOBJECT_FACING = ObjectFields.OBJECT_END + 0xB                           # 0x011 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    GAMEOBJECT_DYN_FLAGS = ObjectFields.OBJECT_END + 0xC                        # 0x012 - Size: 1 - Type: INT - Flags: DYNAMIC
    GAMEOBJECT_FACTION = ObjectFields.OBJECT_END + 0xD                          # 0x013 - Size: 1 - Type: INT - Flags: PUBLIC
    GAMEOBJECT_END = ObjectFields.OBJECT_END + 0xE                              # 0x014


class DynamicObjectFields(IntEnum):
    DYNAMICOBJECT_CASTER = ObjectFields.OBJECT_END + 0x0                        # 0x006 - Size: 2 - Type: GUID - Flags: PUBLIC
    DYNAMICOBJECT_BYTES = ObjectFields.OBJECT_END + 0x2                         # 0x008 - Size: 1 - Type: BYTES - Flags: PUBLIC
    DYNAMICOBJECT_SPELLID = ObjectFields.OBJECT_END + 0x3                       # 0x009 - Size: 1 - Type: INT - Flags: PUBLIC
    DYNAMICOBJECT_RADIUS = ObjectFields.OBJECT_END + 0x4                        # 0x00A - Size: 1 - Type: FLOAT - Flags: PUBLIC
    DYNAMICOBJECT_POS_X = ObjectFields.OBJECT_END + 0x5                         # 0x00B - Size: 1 - Type: FLOAT - Flags: PUBLIC
    DYNAMICOBJECT_POS_Y = ObjectFields.OBJECT_END + 0x6                         # 0x00C - Size: 1 - Type: FLOAT - Flags: PUBLIC
    DYNAMICOBJECT_POS_Z = ObjectFields.OBJECT_END + 0x7                         # 0x00D - Size: 1 - Type: FLOAT - Flags: PUBLIC
    DYNAMICOBJECT_FACING = ObjectFields.OBJECT_END + 0x8                        # 0x00E - Size: 1 - Type: FLOAT - Flags: PUBLIC
    DYNAMICOBJECT_PAD = ObjectFields.OBJECT_END + 0x9                           # 0x00F - Size: 1 - Type: BYTES - Flags: PUBLIC
    DYNAMICOBJECT_END = ObjectFields.OBJECT_END + 0xA                           # 0x010


class CorpseFields(IntEnum):
    CORPSE_FIELD_OWNER = ObjectFields.OBJECT_END + 0x0                          # 0x006 - Size: 2 - Type: GUID - Flags: PUBLIC
    CORPSE_FIELD_FACING = ObjectFields.OBJECT_END + 0x2                         # 0x008 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    CORPSE_FIELD_POS_X = ObjectFields.OBJECT_END + 0x3                          # 0x009 - Size: 1 - Type: FLOAT - Flags: PUBLIC
    CORPSE_FIELD_POS_Y = ObjectFields.OBJECT_END + 0x4                          # 0x00A - Size: 1 - Type: FLOAT - Flags: PUBLIC
    CORPSE_FIELD_POS_Z = ObjectFields.OBJECT_END + 0x5                          # 0x00B - Size: 1 - Type: FLOAT - Flags: PUBLIC
    CORPSE_FIELD_DISPLAY_ID = ObjectFields.OBJECT_END + 0x6                     # 0x00C - Size: 1 - Type: INT - Flags: PUBLIC
    CORPSE_FIELD_ITEM = ObjectFields.OBJECT_END + 0x7                           # 0x00D - Size: 19 - Type: INT - Flags: PUBLIC
    CORPSE_FIELD_BYTES_1 = ObjectFields.OBJECT_END + 0x1A                       # 0x020 - Size: 1 - Type: BYTES - Flags: PUBLIC
    CORPSE_FIELD_BYTES_2 = ObjectFields.OBJECT_END + 0x1B                       # 0x021 - Size: 1 - Type: BYTES - Flags: PUBLIC
    CORPSE_FIELD_GUILD = ObjectFields.OBJECT_END + 0x1C                         # 0x022 - Size: 1 - Type: INT - Flags: PUBLIC
    CORPSE_FIELD_LEVEL = ObjectFields.OBJECT_END + 0x1D                         # 0x023 - Size: 1 - Type: INT - Flags: PUBLIC
    CORPSE_END = ObjectFields.OBJECT_END + 0x1E                                 # 0x024
