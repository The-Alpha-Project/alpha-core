from enum import IntEnum
from struct import pack, unpack
from typing import NamedTuple

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSkill
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.ItemCodes import ItemClasses, ItemSubClasses
from utils.constants.ObjectCodes import SkillCategories, Languages
from utils.constants.UpdateFields import PlayerFields


class SkillTypes(IntEnum):
    SKILL_NONE = 0

    SKILL_FROST = 6
    SKILL_FIRE = 8
    SKILL_COMBAT_MANEUVERS = 26
    SKILL_STREET_FIGHTING = 38
    SKILL_DECEPTION = 39
    SKILL_POISONS = 40
    SKILL_SWORDS = 43
    SKILL_AXES = 44
    SKILL_BOWS = 45
    SKILL_GUNS = 46
    SKILL_BEAST_MASTERY = 50
    SKILL_SURVIVAL = 51
    SKILL_MACES = 54
    SKILL_2H_SWORDS = 55
    SKILL_HOLY = 56
    SKILL_SHADOW = 78
    SKILL_DEFENSE = 95
    SKILL_LANG_COMMON = 98
    SKILL_RACIAL_DWARVEN = 101
    SKILL_LANG_ORCISH = 109
    SKILL_LANG_DWARVEN = 111
    SKILL_LANG_DARNASSIAN = 113
    SKILL_LANG_TAURAHE = 115
    SKILL_DUAL_WIELD = 118
    SKILL_RACIAL_TAUREN = 124
    SKILL_ORC_RACIAL = 125
    SKILL_RACIAL_NIGHT_ELF = 126
    SKILL_FIRST_AID = 129
    SKILL_FERAL_COMBAT = 134
    SKILL_STAVES = 136
    SKILL_LANG_THALASSIAN = 137
    SKILL_LANG_DRACONIC = 138
    SKILL_LANG_DEMON_TONGUE = 139
    SKILL_LANG_TITAN = 140
    SKILL_LANG_OLD_TONGUE = 141
    SKILL_SURVIVAL2 = 142
    SKILL_RIDING_HORSE = 148
    SKILL_RIDING_WOLF = 149
    SKILL_RIDING_TIGER = 150
    SKILL_RIDING_RAM = 152
    SKILL_SWIMING = 155
    SKILL_2H_MACES = 160
    SKILL_UNARMED = 162
    SKILL_MARKSMANSHIP = 163
    SKILL_BLACKSMITHING = 164
    SKILL_LEATHERWORKING = 165
    SKILL_ALCHEMY = 171
    SKILL_2H_AXES = 172
    SKILL_DAGGERS = 173
    SKILL_THROWN = 176
    SKILL_HERBALISM = 182
    SKILL_GENERIC_DND = 183
    SKILL_RETRIBUTION = 184
    SKILL_COOKING = 185
    SKILL_MINING = 186
    SKILL_PET_IMP = 188
    SKILL_PET_FELHUNTER = 189
    SKILL_TAILORING = 197
    SKILL_ENGINEERING = 202
    SKILL_PET_SPIDER = 203
    SKILL_PET_VOIDWALKER = 204
    SKILL_PET_SUCCUBUS = 205
    SKILL_PET_INFERNAL = 206
    SKILL_PET_DOOMGUARD = 207
    SKILL_PET_WOLF = 208
    SKILL_PET_CAT = 209
    SKILL_PET_BEAR = 210
    SKILL_PET_BOAR = 211
    SKILL_PET_CROCILISK = 212
    SKILL_PET_CARRION_BIRD = 213
    SKILL_PET_CRAB = 214
    SKILL_PET_GORILLA = 215
    SKILL_PET_RAPTOR = 217
    SKILL_PET_TALLSTRIDER = 218
    SKILL_RACIAL_UNDEAD = 220
    SKILL_CROSSBOWS = 226
    SKILL_WANDS = 228
    SKILL_POLEARMS = 229
    SKILL_PET_SCORPID = 236
    SKILL_ARCANE = 237
    SKILL_PET_TURTLE = 251
    SKILL_ASSASSINATION = 253
    SKILL_FURY = 256
    SKILL_PROTECTION = 257
    SKILL_BEAST_TRAINING = 261
    SKILL_PROTECTION2 = 267
    SKILL_PET_TALENTS = 270
    SKILL_PLATE_MAIL = 293
    SKILL_LANG_GNOMISH = 313
    SKILL_LANG_TROLL = 315
    SKILL_ENCHANTING = 333
    SKILL_DEMONOLOGY = 354
    SKILL_AFFLICTION = 355
    SKILL_FISHING = 356


class LanguageDesc(NamedTuple):
    lang_id: int
    spell_id: int
    skill_id: int


LANG_DESCRIPTION = {
    Languages.LANG_UNIVERSAL: LanguageDesc(Languages.LANG_UNIVERSAL, 0, 0),
    Languages.LANG_ORCISH: LanguageDesc(Languages.LANG_ORCISH, 669, SkillTypes.SKILL_LANG_ORCISH.value),
    Languages.LANG_DARNASSIAN: LanguageDesc(Languages.LANG_DARNASSIAN, 671, SkillTypes.SKILL_LANG_DARNASSIAN.value),
    Languages.LANG_TAURAHE: LanguageDesc(Languages.LANG_TAURAHE, 670, SkillTypes.SKILL_LANG_TAURAHE.value),
    Languages.LANG_DWARVISH: LanguageDesc(Languages.LANG_DWARVISH, 672, SkillTypes.SKILL_LANG_DWARVEN.value),
    Languages.LANG_COMMON: LanguageDesc(Languages.LANG_COMMON, 668, SkillTypes.SKILL_LANG_COMMON.value),
    Languages.LANG_DEMONIC: LanguageDesc(Languages.LANG_DEMONIC, 815, SkillTypes.SKILL_LANG_DEMON_TONGUE.value),
    Languages.LANG_TITAN: LanguageDesc(Languages.LANG_TITAN, 816, SkillTypes.SKILL_LANG_TITAN.value),
    Languages.LANG_THALASSIAN: LanguageDesc(Languages.LANG_THALASSIAN, 813, SkillTypes.SKILL_LANG_THALASSIAN.value),
    Languages.LANG_DRACONIC: LanguageDesc(Languages.LANG_DRACONIC, 814, SkillTypes.SKILL_LANG_DRACONIC.value),
    Languages.LANG_KALIMAG: LanguageDesc(Languages.LANG_KALIMAG, 817, SkillTypes.SKILL_LANG_OLD_TONGUE.value),
    Languages.LANG_GNOMISH: LanguageDesc(Languages.LANG_GNOMISH, 7340, SkillTypes.SKILL_LANG_GNOMISH.value),
    Languages.LANG_TROLL: LanguageDesc(Languages.LANG_TROLL, 7341, SkillTypes.SKILL_LANG_TROLL.value)
}


class SpellSkillDesc(NamedTuple):
    spell_id: int
    skill_id: int


EQUIPMENT_DESCRIPTION = {
    ItemClasses.ITEM_CLASS_WEAPON: {
        ItemSubClasses.ITEM_SUBCLASS_AXE: SpellSkillDesc(196, SkillTypes.SKILL_AXES.value),
        ItemSubClasses.ITEM_SUBCLASS_TWOHAND_AXE: SpellSkillDesc(197, SkillTypes.SKILL_2H_AXES.value),
        ItemSubClasses.ITEM_SUBCLASS_BOW: SpellSkillDesc(264, SkillTypes.SKILL_BOWS.value),
        ItemSubClasses.ITEM_SUBCLASS_GUN: SpellSkillDesc(266, SkillTypes.SKILL_GUNS.value),
        ItemSubClasses.ITEM_SUBCLASS_MACE: SpellSkillDesc(198, SkillTypes.SKILL_MACES.value),
        ItemSubClasses.ITEM_SUBCLASS_TWOHAND_MACE: SpellSkillDesc(199, SkillTypes.SKILL_2H_MACES.value),
        ItemSubClasses.ITEM_SUBCLASS_POLEARM: SpellSkillDesc(3386, SkillTypes.SKILL_POLEARMS.value),
        ItemSubClasses.ITEM_SUBCLASS_SWORD: SpellSkillDesc(201, SkillTypes.SKILL_SWORDS.value),
        ItemSubClasses.ITEM_SUBCLASS_TWOHAND_SWORD: SpellSkillDesc(202, SkillTypes.SKILL_2H_SWORDS.value),
        ItemSubClasses.ITEM_SUBCLASS_STAFF: SpellSkillDesc(227, SkillTypes.SKILL_STAVES.value),
        ItemSubClasses.ITEM_SUBCLASS_DAGGER: SpellSkillDesc(1180, SkillTypes.SKILL_DAGGERS.value),
        ItemSubClasses.ITEM_SUBCLASS_THROWN: SpellSkillDesc(2567, SkillTypes.SKILL_THROWN.value),
        ItemSubClasses.ITEM_SUBCLASS_CROSSBOW: SpellSkillDesc(5011, SkillTypes.SKILL_CROSSBOWS.value),
        ItemSubClasses.ITEM_SUBCLASS_WAND: SpellSkillDesc(5009, SkillTypes.SKILL_WANDS.value),
        ItemSubClasses.ITEM_SUBCLASS_FIST_WEAPON: SpellSkillDesc(0, SkillTypes.SKILL_UNARMED.value)
    },
    ItemClasses.ITEM_CLASS_ARMOR: {
        ItemSubClasses.ITEM_SUBCLASS_PLATE: SpellSkillDesc(750, SkillTypes.SKILL_PLATE_MAIL.value)
    }
}


class SkillManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.skills = {}

    def load_skills(self):
        for skill in RealmDatabaseManager.character_get_skills(self.player_mgr.guid):
            self.skills[skill.skill] = skill
        self.build_skill_update()

    def add_skill(self, skill_id):
        # Skill already learnt
        if skill_id in self.skills:
            return

        skill = DbcDatabaseManager.skill_get_by_id(skill_id)
        if not skill:
            return

        start_rank_value = 1
        if skill.CategoryID == SkillCategories.MAX_SKILL:
            start_rank_value = skill.MaxRank

        skill_to_set = CharacterSkill()
        skill_to_set.guid = self.player_mgr.guid
        skill_to_set.skill = skill_id
        skill_to_set.value = start_rank_value
        skill_to_set.max = skill.MaxRank

        RealmDatabaseManager.character_add_skill(skill_to_set)

        self.skills[skill_id] = skill_to_set

    def set_skill(self, skill_id, current_value, max_value=-1):
        if skill_id not in self.skills:
            return

        skill = self.skills[skill_id]
        skill.value = current_value
        if max_value > 0:
            skill.max = max_value

        RealmDatabaseManager.character_update_skill(skill)

    def update_skills_max_value(self):
        for skill_id, skill in self.skills.items():
            self.set_skill(skill_id, skill.value, SkillManager.get_max_rank(self.player_mgr.level, skill_id))

    @staticmethod
    def get_skill_by_language(language_id):
        if language_id in LANG_DESCRIPTION:
            return LANG_DESCRIPTION[language_id].skill_id
        return -1

    @staticmethod
    def get_skill_by_item_class(item_class, item_subclass):
        if item_class in EQUIPMENT_DESCRIPTION:
            class_ = EQUIPMENT_DESCRIPTION[item_class]
            if item_subclass in class_:
                return class_[item_subclass].skill_id
            return -1
        return -1

    @staticmethod
    def get_max_rank(player_level, skill_id):
        skill = DbcDatabaseManager.skill_get_by_id(skill_id)
        if not skill:
            return 0

        # Weapon, Defense, Spell
        if skill.SkillType == 0:
            return player_level * 5
        # Language, Riding, Secondary profs
        elif skill.SkillType == 4:
            # Language, Riding
            if skill.CategoryID == SkillCategories.MAX_SKILL:
                return skill.MaxRank
            else:
                return (player_level * 5) + 25

        return 0

    def can_dual_wield(self):
        return SkillTypes.SKILL_DUAL_WIELD in self.skills and self.player_mgr.level >= 10

    def build_skill_update(self):
        count = 0
        for skill_id, skill in self.skills.items():
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3),
                                       unpack('<I', pack('<2H', skill_id, skill.value))[0])
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 1,
                                       unpack('<I', pack('<2H', skill.max, 0))[0])  # max_rank, skill_mod
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 2,
                                       unpack('<I', pack('<2H', 0, 0))[0])  # skill_step, padding
            count += 1
