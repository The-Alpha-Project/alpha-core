import random
from enum import IntEnum
from struct import pack
from typing import NamedTuple, Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSkill
from database.world.WorldDatabaseManager import WorldDatabaseManager, ItemTemplate
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.spell import ExtendedSpellData
from network.packet.PacketWriter import PacketWriter
from utils.ByteUtils import ByteUtils
from utils.ConfigManager import config
from utils.Formulas import PlayerFormulas
from utils.Logger import Logger
from utils.constants.ItemCodes import ItemClasses, ItemSubClasses, InventoryError
from utils.constants.MiscCodes import SkillCategories, Languages, AttackTypes, LockTypes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellCheckCastResult, SpellEffects
from utils.constants.UpdateFields import PlayerFields


class SkillTypes(IntEnum):
    NONE = 0
    FROSTMAGIC = 0x6
    FIREMAGIC = 0x8
    COMBATMANEUVERS = 0x1A
    STREETFIGHTING = 0x26
    DECEPTION = 0x27
    POISONS = 0x28
    SWORDS = 0x2B
    AXES = 0x2C
    BOWS = 0x2D
    GUNS = 0x2E
    BEASTHANDLING = 0x32
    TRACKING = 0x33
    MACES = 0x36
    TWOHANDEDSWORDS = 0x37
    HOLYMAGIC = 0x38
    FEIGNDEATH = 0x4A
    SHADOWMAGIC = 0x4E
    DEFENSE = 0x5F
    NATUREMAGIC = 0x60
    LANGUAGE_COMMON = 0x62
    LANGUAGE_COMMON_TEMP = 0x63
    DWARVENRACIAL = 0x65
    LANGUAGE_ORCISH = 0x6D
    LANGUAGE_ORCISH_TEMP = 0x6E
    LANGUAGE_DWARVEN = 0x6F
    LANGUAGE_DWARVEN_TEMP = 0x70
    LANGUAGE_DARNASSIAN = 0x71
    LANGUAGE_DARNASSIAN_TEMP = 0x72
    LANGUAGE_TAURAHE = 0x73
    LANGUAGE_TAURAHE_TEMP = 0x74
    DUALWIELD = 0x76
    SUMMONING = 0x78
    TAURENRACIAL = 0x7C
    ORCRACIAL = 0x7D
    NIGHTELFRACIAL = 0x7E
    FIRSTAID = 0x81
    CONJURATION = 0x82
    SHAPESHIFTING = 0x86
    STAVES = 0x88
    THALASSIAN = 0x89
    DRACONIC = 0x8A
    DEMONTONGUE = 0x8B
    TITAN = 0x8C
    OLDTONGUE = 0x8D
    SURVIVAL = 0x8E
    HORSERIDING = 0x94
    WOLFRIDING = 0x95
    TIGERRIDING = 0x96
    NIGHTMARERIDING = 0x97
    RAMRIDING = 0x98
    SWIMMING = 0x9B
    TWOHANDEDMACES = 0xA0
    UNARMED = 0xA2
    COMBATSHOTS = 0xA3
    BLACKSMITHING = 0xA4
    LEATHERWORKING = 0xA5
    ALCHEMY = 0xAB
    TWOHANDEDAXES = 0xAC
    DAGGERS = 0xAD
    THROWN = 0xB0
    LOCKPICKING_TEMP = 0xB5
    HERBALISM = 0xB6
    GENERIC = 0xB7
    HOLYSTRIKES = 0xB8
    COOKING = 0xB9
    MINING = 0xBA
    PET_IMP = 0xBC
    PET_FELHUNTER = 0xBD
    TAILORING = 0xC5
    SEALS = 0xC6
    SPIRITCOMBAT = 0xC7
    ENGINEERING = 0xCA
    PET_SPIDER = 0xCB
    PET_VOIDWALKER = 0xCC
    PET_SUCCUBUS = 0xCD
    PET_INFERNAL = 0xCE
    PET_DOOMGUARD = 0xCF
    PET_WOLF = 0xD0
    PET_CAT = 0xD1
    PET_BEAR = 0xD2
    PET_BOAR = 0xD3
    PET_CROCILISK = 0xD4
    PET_CARRIONBIRD = 0xD5
    PET_CRAB = 0xD6
    PET_GORILLA = 0xD7
    PET_HORSE = 0xD8
    PET_RAPTOR = 0xD9
    PET_TALLSTRIDER = 0xDA
    RACIAL_UNDEAD = 0xDC
    WEAPONTALENTS = 0xDE
    CROSSBOWS = 0xE2
    SPEARS = 0xE3
    WANDS = 0xE4
    POLEARMS = 0xE5
    ATTRIBUTEENHANCEMENTS = 0xE6
    SLAYERTALENTS = 0xE7
    MAGICTALENTS = 0xE9
    DEFENSIVETALENTS = 0xEA
    PET_SCORPION = 0xEC
    ARCANEMAGIC = 0xED
    PICKPOCKETS = 0xEE
    STEALTH = 0xEF
    DISARMTRAPS = 0xF1
    LOCKPICKING = 0xF2
    STANCES = 0xF3
    SHOUTS = 0xF4
    ADVANCEDCOMBAT = 0xF5
    UNDEADMASTERY = 0xF6
    SNEAKING = 0xF7
    DISENGAGE = 0x111
    FORAGE = 0xF9
    PET_TURTLE = 0xFB
    RANGEDCOMBAT = 0xFC
    ASSASSINATION = 0xFD
    ACROBATICS = 0xFE
    DUELING = 0xFF
    SAVAGECOMBAT = 0x100
    SHIELDS = 0x101
    TAUNT = 0x102
    TOTEMS = 0x103
    MENDPET = 0x104
    BEASTTRAINING = 0x105
    EXPERTSHOTS = 0x106
    FIRESHOTS = 0x107
    FROSTSHOTS = 0x108
    PLATEMAIL = 0x125
    AURAS = 0x10B
    BLOCK = 0x10C
    JUSTICE = 0x10D
    PET_TALENTS = 0x10E
    MAGICUNLOCK = 0x10F
    GROWL = 0x110
    LANGUAGE_GNOMISH = 0x139
    LANGUAGE_GNOMISH_TEMP = 0x13A
    LANGUAGE_TROLL = 0x13B
    LANGUAGE_TROLL_TEMP = 0x13C
    ENCHANTING = 0x14D
    SOULCRAFT = 0x161
    DEMONMASTERY = 0x162
    CURSES = 0x163
    FISHING = 0x164


class SkillLineType(IntEnum):
    PRIMARY = 0
    RACIAL = 2
    TALENTS = 3
    SECONDARY = 4


class LanguageDesc(NamedTuple):
    lang_id: int
    spell_id: int
    skill_id: int


LANG_DESCRIPTION = {
    Languages.LANG_UNIVERSAL: LanguageDesc(Languages.LANG_UNIVERSAL, 0, SkillTypes.NONE),
    Languages.LANG_ORCISH: LanguageDesc(Languages.LANG_ORCISH, 669, SkillTypes.LANGUAGE_ORCISH.value),
    Languages.LANG_DARNASSIAN: LanguageDesc(Languages.LANG_DARNASSIAN, 671, SkillTypes.LANGUAGE_DARNASSIAN.value),
    Languages.LANG_TAURAHE: LanguageDesc(Languages.LANG_TAURAHE, 670, SkillTypes.LANGUAGE_TAURAHE.value),
    Languages.LANG_DWARVISH: LanguageDesc(Languages.LANG_DWARVISH, 672, SkillTypes.LANGUAGE_DWARVEN.value),
    Languages.LANG_COMMON: LanguageDesc(Languages.LANG_COMMON, 668, SkillTypes.LANGUAGE_COMMON.value),
    Languages.LANG_DEMONIC: LanguageDesc(Languages.LANG_DEMONIC, 815, SkillTypes.DEMONTONGUE.value),
    Languages.LANG_TITAN: LanguageDesc(Languages.LANG_TITAN, 816, SkillTypes.TITAN.value),
    Languages.LANG_THALASSIAN: LanguageDesc(Languages.LANG_THALASSIAN, 813, SkillTypes.THALASSIAN.value),
    Languages.LANG_DRACONIC: LanguageDesc(Languages.LANG_DRACONIC, 814, SkillTypes.DRACONIC.value),
    Languages.LANG_KALIMAG: LanguageDesc(Languages.LANG_KALIMAG, 817, SkillTypes.OLDTONGUE.value),
    Languages.LANG_GNOMISH: LanguageDesc(Languages.LANG_GNOMISH, 7340, SkillTypes.LANGUAGE_GNOMISH.value),
    Languages.LANG_TROLL: LanguageDesc(Languages.LANG_TROLL, 7341, SkillTypes.LANGUAGE_TROLL.value)
}


class ProficiencyAcquireMethod(IntEnum):
    ON_TRAINER_LEARN = 0
    ON_CHAR_CREATE = 1


class Proficiency:
    item_class: int
    item_subclass_mask: int
    related_skill_ids: dict  # {subclass_mask, skill_id}. -1 if no proficiency exists.

    def __init__(self, item_class, item_subclass_mask, skill_id=-1):
        self.item_class = item_class
        self.item_subclass_mask = item_subclass_mask
        self.related_skill_ids = {item_subclass_mask: skill_id}

    def add_subclass(self, item_subclass_mask, skill_id):
        self.item_subclass_mask |= item_subclass_mask
        self.related_skill_ids[item_subclass_mask] = skill_id

    def matches(self, item_class, item_subclass):
        return self.item_class == item_class and \
               (self.item_subclass_mask & 1 << item_subclass)

    def get_skill_id_for_subclass(self, item_subclass):
        return self.related_skill_ids.get(1 << item_subclass, -1)


class SkillManager(object):
    MAX_PROFESSION_SKILL = 225
    MAX_SKILLS = 64

    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.skills = {}
        self.proficiencies = {}

        # Dictionary for all equipment proficiencies the player can learn.
        # Used to determine which talents should be excluded from the player (ie. 2H talents from rogues).
        self.full_proficiency_masks = {}

    def load_skills(self):
        for skill in RealmDatabaseManager.character_get_skills(self.player_mgr.guid):
            self.skills[skill.skill] = skill
        self.update_skills_max_value()

    # Apply armor proficiencies and populate full_proficiency_masks.
    # noinspection PyUnusedLocal
    def load_proficiencies(self):
        base_info = DbcDatabaseManager.CharBaseInfoHolder.char_base_info_get(self.player_mgr.race,
                                                                             self.player_mgr.class_)
        if not base_info:
            return

        chr_proficiency = base_info.proficiency
        for x in range(1, 17):
            acquire_method = getattr(chr_proficiency, f'Proficiency_AcquireMethod_{x}')
            if acquire_method == -1:
                break

            item_class = getattr(chr_proficiency, f'Proficiency_ItemClass_{x}')
            item_subclass_mask = getattr(chr_proficiency, f'Proficiency_ItemSubClassMask_{x}')

            curr_mask = self.full_proficiency_masks.get(item_class, 0)
            curr_mask |= item_subclass_mask
            self.full_proficiency_masks[item_class] = curr_mask

            # Learned proficiencies are applied through passive spells.
            if acquire_method != ProficiencyAcquireMethod.ON_CHAR_CREATE:
                continue

            # All weapon proficiencies except misc weapons have passive proficiency spells.
            # Armor proficiencies learned on character creation do not have associated spells.
            if item_class == ItemClasses.ITEM_CLASS_WEAPON:
                misc_weapon_mask = 1 << ItemSubClasses.ITEM_SUBCLASS_MISC_WEAPON
                if item_subclass_mask & misc_weapon_mask == 0:
                    continue
                item_subclass_mask = misc_weapon_mask

            self.add_proficiency(item_class, item_subclass_mask, -1)

    def add_proficiency(self, item_class, item_subclass_mask, skill_id):
        if item_class in self.proficiencies:
            proficiency = self.proficiencies[item_class]
            proficiency.add_subclass(item_subclass_mask, skill_id)
        else:
            proficiency = Proficiency(item_class, item_subclass_mask, skill_id)
            self.proficiencies[item_class] = proficiency

        self.send_set_proficiency(proficiency)

    def send_set_proficiency(self, proficiency):
        packet = PacketWriter.get_packet(OpCode.SMSG_SET_PROFICIENCY, pack('<bI', proficiency.item_class, proficiency.item_subclass_mask))
        self.player_mgr.enqueue_packet(packet)

    def init_proficiencies(self):
        for proficiency in self.proficiencies.values():
            self.send_set_proficiency(proficiency)

    def has_skill(self, skill_id):
        return skill_id in self.skills

    def has_reached_skills_limit(self):
        return len(self.skills) >= SkillManager.MAX_SKILLS

    def add_skill(self, skill_id):
        if self.has_reached_skills_limit():
            Logger.warning(f'Player {self.player_mgr.get_name()} with guid {self.player_mgr.guid} reached max skills.')
            return False

        # Skill already learned.
        if skill_id in self.skills:
            return False

        skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id)
        if not skill:
            return False

        start_rank_value = 1
        if skill.CategoryID == SkillCategories.MAX_SKILL and skill.ID != SkillTypes.LOCKPICKING_TEMP:
            start_rank_value = skill.MaxRank

        skill_to_set = CharacterSkill()
        skill_to_set.guid = self.player_mgr.guid
        skill_to_set.skill = skill_id
        skill_to_set.value = start_rank_value
        skill_to_set.max = self.get_max_rank(skill_id)

        RealmDatabaseManager.character_add_skill(skill_to_set)

        self.skills[skill_id] = skill_to_set
        self.build_update()
        return True

    def set_skill(self, skill_id, current_value, max_value=-1):
        if skill_id not in self.skills:
            return False

        skill = self.skills[skill_id]
        skill.value = current_value

        if max_value > 0:
            skill.max = max_value

        RealmDatabaseManager.character_update_skill(skill)
        return True

    def update_skills_max_value(self):
        for skill_id, skill in self.skills.items():
            # For cases like non-default languages, they should remain at max 1 unless forcefully set
            if skill.max == 1:
                new_max = 1
            else:
                new_max = self.get_max_rank(skill_id)

            self.set_skill(skill_id, skill.value, new_max)

        self.build_update()

    def handle_defense_skill_gain_chance(self, damage_info):
        # Vanilla formula.
        target_skill_type = self.get_defense_skill()
        skill = self.skills.get(target_skill_type, None)
        if not skill:
            return False

        current_unmodified_skill = skill.value
        maximum_skill = self.get_max_rank(target_skill_type)

        if current_unmodified_skill >= maximum_skill:
            return False

        own_level = self.player_mgr.level
        gray_level = PlayerFormulas.get_gray_level(own_level)
        attacker_level = damage_info.attacker.level

        if attacker_level > own_level + 5:
            attacker_level = own_level + 5

        level_difference = max(3, attacker_level - gray_level)
        chance = 0.03 * level_difference * (maximum_skill - current_unmodified_skill) / own_level

        if random.random() > chance:
            return False

        # TODO Skill gain config value?
        self.set_skill(target_skill_type, current_unmodified_skill + 1)
        self.build_update()

        # Dodge/Parry/Block chance displayed in the player's abilities depends on selected defense skill.
        self.player_mgr.stat_manager.send_defense_bonuses()

        return True

    def handle_weapon_skill_gain_chance(self, attack_type: AttackTypes):
        skill_id = self._get_skill_id_for_current_weapon(attack_type)
        if skill_id == -1:
            return False

        skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id)
        # Skip Professions.
        if skill.SkillType == SkillLineType.SECONDARY and skill.CategoryID == SkillCategories.CLASS_SKILL:
            return False

        self.handle_offense_skill_gain_chance(skill_id)

    def handle_spell_cast_skill_gain(self, casting_spell):
        if not casting_spell:
            return False

        character_skill, skill, skill_line_ability = self.get_skill_info_for_spell_id(casting_spell.spell_entry.ID)

        if not character_skill:
            return False

        # Gathering skill gain.
        if casting_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_OPEN_LOCK,
                                            SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM):
            self.handle_gather_skill_gain(casting_spell)
            return True

        # Profession cast skill gain.
        if skill.SkillType == SkillLineType.SECONDARY or skill_line_ability.TrivialSkillLineRankHigh != 0:
            # Special case of casting enchants on items in trade window.
            #  TODO: enchanting materials are still consumed on cast.
            effect = casting_spell.get_effect_by_type(SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_PERMANENT,
                                                      SpellEffects.SPELL_EFFECT_ENCHANT_ITEM_TEMPORARY)
            if effect:
                targets = effect.targets.get_resolved_effect_targets_by_type(ItemManager)
                if not len(targets) or targets[0].get_owner_guid() != self.player_mgr.guid:
                    return False

            self.handle_profession_skill_gain(casting_spell.spell_entry.ID)
            return True

        if casting_spell.is_weapon_attack() and \
                skill.ID == self._get_skill_id_for_current_weapon(casting_spell.get_attack_type()):
            return False  # Don't reward weapon skill for base attack spells - skill is rewarded on hit instead.

        self.handle_offense_skill_gain_chance(skill.ID)
        return True

    def _get_skill_id_for_current_weapon(self, attack_type):
        equipped_weapon = self.player_mgr.get_current_weapon_for_attack_type(attack_type)

        if not equipped_weapon:
            if self.player_mgr.is_in_feral_form():
                return -1  # Feral form attacks don't use a weapon.

            return self.get_skill_id_for_weapon(None)
        else:
            return self.get_skill_id_for_weapon(equipped_weapon.item_template)

    def handle_offense_skill_gain_chance(self, skill_id):
        # Vanilla melee formulae.
        skill = self.skills.get(skill_id, None)
        if not skill:
            return False

        current_unmodified_skill = skill.value
        maximum_skill = self.get_max_rank(skill_id)

        if current_unmodified_skill >= maximum_skill:
            return False

        # Magic values from VMaNGOS.
        if maximum_skill * 0.9 > current_unmodified_skill:
            chance = (maximum_skill * 0.9 * 0.5) / current_unmodified_skill
        else:
            level_modifier = self.get_max_rank(skill_id, level=config.Unit.Player.Defaults.max_level) / maximum_skill

            chance = 0.5 - level_modifier * (0.0168966 * current_unmodified_skill - 0.0152069 * maximum_skill)
            skill_diff_from_max = maximum_skill - current_unmodified_skill
            if skill_diff_from_max <= 3:
                chance *= (0.5 / (4 - skill_diff_from_max))

        # Can't find information in patch notes on intellect affecting skill gain, but it's implemented in VMaNGOS.
        chance += self.player_mgr.stat_manager.get_intellect_stat_gain_chance_bonus()

        if random.random() > chance:
            return False

        # TODO Skill gain config value?
        self.set_skill(skill_id, current_unmodified_skill + 1)
        self.build_update()
        return True

    def handle_profession_skill_gain(self, spell_id):
        skill_gain_factor = 1

        # Should always resolve to one for professions.
        character_skill, skill, skill_line_ability = self.get_skill_info_for_spell_id(spell_id)
        # Character does not have the skill.
        if not character_skill:
            return False

        if character_skill.value >= character_skill.max:
            return True

        gray_threshold = skill_line_ability.TrivialSkillLineRankHigh
        yellow_threshold = skill_line_ability.TrivialSkillLineRankLow
        chance = SkillManager._get_skill_gain_chance(character_skill.value, gray_threshold,
                                                     (gray_threshold + yellow_threshold) / 2,
                                                     yellow_threshold)

        self._roll_profession_skill_gain_chance(skill.ID, chance, skill_gain_factor)
        self.build_update()
        return True

    def handle_gather_skill_gain(self, casting_spell):
        effect = casting_spell.get_effect_by_type(SpellEffects.SPELL_EFFECT_OPEN_LOCK,
                                                  SpellEffects.SPELL_EFFECT_OPEN_LOCK_ITEM)
        lock_type = effect.misc_value
        target = casting_spell.initial_target

        lock_id = target.lock
        bonus_points = effect.get_effect_simple_points()

        # Use can_open_lock to fetch lock info.
        from game.world.managers.objects.locks.LockManager import LockManager
        lock_result = LockManager.can_open_lock(self.player_mgr, lock_type, lock_id,
                                                cast_item=casting_spell.source_item,
                                                bonus_points=bonus_points)

        if target.is_gameobject():
            # Handle unique skill gain per herb node.
            if lock_result.skill_type == SkillTypes.HERBALISM and self.player_mgr.guid in target.unlocked_by:
                return
            target.unlocked_by.add(self.player_mgr.guid)

        gather_skill_gain_factor = 1  # TODO: configurable.
        if lock_result.skill_type not in self.skills:
            return False

        skill = self.skills[lock_result.skill_type]
        if skill.value >= skill.max:
            return False

        chance = SkillManager._get_skill_gain_chance(skill.value,
                                                     lock_result.required_skill_value + 100,
                                                     lock_result.required_skill_value + 50,
                                                     lock_result.required_skill_value + 25)

        if lock_result.skill_type == SkillTypes.MINING:
            mining_skill_chance_steps = 75  # TODO: configurable.
            chance = chance >> int(skill.value / mining_skill_chance_steps)

        self._roll_profession_skill_gain_chance(lock_result.skill_type, chance, gather_skill_gain_factor)

    @staticmethod
    def get_skill_and_skill_line_for_spell_id(spell_id, race, class_):
        skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell_race_and_class(
            spell_id, race, class_)

        if not skill_line_ability:
            return 0, None

        skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_line_ability.SkillLine)
        return skill, skill_line_ability

    def get_skill_info_for_spell_id(self, spell_id):
        race = self.player_mgr.race
        class_ = self.player_mgr.class_
        skill, skill_line_ability = SkillManager.get_skill_and_skill_line_for_spell_id(spell_id, race, class_)

        if not skill:
            return None, None, None

        if skill.ID not in self.skills:
            return None, skill, skill_line_ability

        character_skill = self.skills[skill.ID]

        if character_skill.value >= character_skill.max:
            return None, skill, skill_line_ability

        return character_skill, skill, skill_line_ability

    @staticmethod
    def _get_skill_gain_chance(skill_value, gray_level, green_level, yellow_level):
        if skill_value >= gray_level:
            return 0 * 10
        elif skill_value >= green_level:
            return 25 * 10
        elif skill_value >= yellow_level:
            return 75 * 10
        return 100 * 10

    def _roll_profession_skill_gain_chance(self, skill_type, chance, step):
        if not skill_type or chance <= 0:
            return False

        skill = self.skills.get(skill_type, None)
        if not skill:
            return False

        roll = random.randint(1, 1000)
        if roll < chance:
            self.set_skill(skill_type, skill.value + step)
            self.build_update()

    def handle_fishing_attempt_chance(self):
        skill = self.skills.get(SkillTypes.FISHING, None)
        if not skill:
            return False

        # Search the skill zone by parent zone id.
        parent_zone_id = self.player_mgr.get_map().get_parent_zone_id(self.player_mgr.zone)
        zone_skill = WorldDatabaseManager.fishing_skill_get_by_entry(parent_zone_id)
        if not zone_skill:
            return False

        # Get zone skill value.
        zone_skill_value = zone_skill.skill

        # Consider bonus for roll.
        skill_total = self.get_total_skill_value(SkillTypes.FISHING)
        chance = skill_total - zone_skill_value + 5
        roll = random.randint(1, 100)

        # Hook chance.
        success = skill_total >= zone_skill_value and chance >= roll
        if not success:
            return False

        # Skill gain chance.
        gain_chance = 100 if skill.value < 75 else 2500 / (skill.value - 50)
        if skill.value >= skill.max:
            return True

        self._roll_profession_skill_gain_chance(SkillTypes.FISHING, gain_chance * 10, 1)
        return True

    def get_unlocking_attempt_result(self, lock_type: LockTypes, lock_id: int,
                                     used_item: Optional[ItemManager] = None,
                                     bonus_skill: int = 0) -> SpellCheckCastResult:
        from game.world.managers.objects.locks.LockManager import LockManager
        lock_result = LockManager.can_open_lock(self.player_mgr, lock_type, lock_id,
                                                cast_item=used_item,
                                                bonus_points=bonus_skill)

        if lock_result.result != SpellCheckCastResult.SPELL_NO_ERROR:
            return lock_result.result

        skill_value = lock_result.skill_value
        bonus_skill_value = lock_result.bonus_skill_value
        required_skill_value = lock_result.required_skill_value
        skill_type = lock_result.skill_type

        # Chance for fail at orange mining, herbs or lock picking.
        if (skill_type == SkillTypes.HERBALISM or skill_type == SkillTypes.MINING
                or lock_result.skill_type in (SkillTypes.LOCKPICKING, SkillTypes.LOCKPICKING_TEMP)):
            can_fail_at_max_skill = skill_type != SkillTypes.HERBALISM and skill_type != SkillTypes.MINING
            can_fail = can_fail_at_max_skill or skill_value < SkillManager.MAX_PROFESSION_SKILL
            if can_fail and required_skill_value > random.randint(bonus_skill_value - 25, bonus_skill_value + 37):
                return SpellCheckCastResult.SPELL_FAILED_TRY_AGAIN

        return SpellCheckCastResult.SPELL_NO_ERROR

    def get_equip_result_for(self, item_template) -> InventoryError:
        item_class = item_template.class_
        req_skill = item_template.required_skill

        if req_skill:
            req_skill_value = item_template.required_skill_rank
            if self.get_total_skill_value(req_skill) < req_skill_value:
                return InventoryError.BAG_SKILL_MISMATCH

        if item_class not in {ItemClasses.ITEM_CLASS_WEAPON, ItemClasses.ITEM_CLASS_ARMOR} or \
                item_class == ItemClasses.ITEM_CLASS_WEAPON and \
                item_template.subclass == ItemSubClasses.ITEM_SUBCLASS_MISC_WEAPON:
            return InventoryError.BAG_OK  # No proficiency needed for misc. equipment.

        if item_class not in self.proficiencies:
            return InventoryError.BAG_PROFICIENCY_NEEDED

        return InventoryError.BAG_OK if self.proficiencies[item_class].matches(item_class, item_template.subclass) \
            else InventoryError.BAG_PROFICIENCY_NEEDED

    def can_ever_use_equipment(self, item_class, item_subclass_mask):
        if item_class not in self.proficiencies:
            return False

        if self.proficiencies[item_class].item_subclass_mask & item_subclass_mask:
            return True  # Account for case where the player has learned a proficiency with a command.

        return self.full_proficiency_masks.get(item_class, 0) & item_subclass_mask

    def can_use_equipment_now(self, item_class, item_subclass_mask):
        if item_class not in self.proficiencies:
            return False
        return self.proficiencies[item_class].item_subclass_mask & item_subclass_mask

    # Shields and Block do not require an actual block to be gained, randomly pick one upon defense gain.
    # Warriors use the Shield skill, Paladins the Block skill and the rest only the Defense skill.
    def get_defense_skill(self):
        pool = [SkillTypes.DEFENSE]
        if self.player_mgr.can_block(in_combat=True):
            if SkillTypes.SHIELDS in self.skills:
                pool.append(SkillTypes.SHIELDS)
            elif SkillTypes.BLOCK in self.skills:
                pool.append(SkillTypes.BLOCK)
        return random.choice(pool)

    def get_defense_skill_value(self, use_block, no_bonus=False):
        # Shields block.
        if use_block and SkillTypes.SHIELDS in self.skills:
            skill_id = SkillTypes.SHIELDS
            skill = self.skills[skill_id]
        # Normal block.
        elif use_block and SkillTypes.BLOCK in self.skills:
            skill_id = SkillTypes.BLOCK
            skill = self.skills[skill_id]
        # Always fall back to defense.
        elif SkillTypes.DEFENSE in self.skills:
            skill_id = SkillTypes.DEFENSE
            skill = self.skills[skill_id]
        else:
            return 1  # Player is missing defense skill, likely uninitialized.

        bonus_skill = 0 if no_bonus else self.player_mgr.stat_manager.get_stat_skill_bonus(skill_id)
        return skill.value + bonus_skill

    def get_total_skill_value(self, skill_id, no_bonus=False):
        if skill_id not in self.skills:
            return -1
        skill = self.skills[skill_id]
        bonus_skill = 0 if no_bonus else self.player_mgr.stat_manager.get_stat_skill_bonus(skill_id)
        return skill.value + bonus_skill

    def get_skill_value_for_spell_id(self, spell_id):
        skill = self.get_skill_for_spell_id(spell_id)
        if not skill or skill.ID not in self.skills:
            return 0

        return self.get_total_skill_value(skill.ID)

    def get_skill_id_for_weapon(self, item_template: Optional[ItemTemplate]):
        if not item_template:
            # Street fighting replaces unarmed for rogues - prioritize if the player knows it.
            return SkillTypes.STREETFIGHTING if self.skills.get(SkillTypes.STREETFIGHTING, None) else SkillTypes.UNARMED

        item_class = item_template.class_
        if item_class not in self.proficiencies:
            return -1
        prof = self.proficiencies[item_class]
        return prof.get_skill_id_for_subclass(item_template.subclass)

    @staticmethod
    def get_all_languages():
        return LANG_DESCRIPTION.items()

    @staticmethod
    def get_skill_by_language(language_id):
        if language_id in LANG_DESCRIPTION:
            return LANG_DESCRIPTION[language_id].skill_id
        return -1

    @staticmethod
    def get_cast_ui_spells_for_skill_id(skill_id) -> set[int]:
        skill_line_spells = DbcDatabaseManager.SkillLineAbilityHolder.spells_get_by_skill_id(skill_id)
        spells = set()
        for spell_id in skill_line_spells:
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)

            if spell and spell.Effect_1 == SpellEffects.SPELL_EFFECT_SPELL_CAST_UI:
                spells.add(spell.ID)

        return spells

    def get_skill_for_spell_id(self, spell_id):
        skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell_race_and_class(
            spell_id, self.player_mgr.race, self.player_mgr.class_)
        if not skill_line_ability or not skill_line_ability.SkillLine:
            return None
        return DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_line_ability.SkillLine)

    def get_max_rank(self, skill_id, level=-1):
        skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id)
        if not skill:
            return 0

        level = self.player_mgr.level if level == -1 else level

        # Weapon, Defense, Spell
        if skill.SkillType == SkillLineType.PRIMARY:
            return level * 5
        # Language, Riding, Secondary profs
        elif skill.SkillType == SkillLineType.SECONDARY:
            # Language, Riding
            if skill.CategoryID == SkillCategories.MAX_SKILL and skill.ID != SkillTypes.LOCKPICKING_TEMP:
                return skill.MaxRank
            # Secondary skills of other categories are all professions.
            return ExtendedSpellData.ProfessionInfo.get_max_skill_value(skill_id, self.player_mgr)
        return 0

    def can_dual_wield(self):
        return SkillTypes.DUALWIELD in self.skills

    def build_update(self):
        count = 0
        for skill_id, skill in self.skills.items():
            total_value = self.get_total_skill_value(skill_id)
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3),
                                       # skill value, skill id
                                       ByteUtils.shorts_to_int(skill.value, skill_id))
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 1,
                                       # skill mod, max rank
                                       ByteUtils.shorts_to_int(total_value - skill.value, skill.max))
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 2,
                                       # padding, skill step
                                       ByteUtils.shorts_to_int(0, 0))
            count += 1
