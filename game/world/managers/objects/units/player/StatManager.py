import math
import random
from enum import auto, IntFlag
from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from game.world.managers.objects.units.player.SkillManager import SkillTypes
from utils.Formulas import UnitFormulas
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats, ItemSubClasses, ItemEnchantmentType
from utils.constants.MiscCodes import AttackTypes, HitInfo, ObjectTypeIds
from utils.constants.SpellCodes import SpellSchools, ShapeshiftForms, SpellImmunity, SpellHitFlags
from utils.constants.UnitCodes import PowerTypes, Classes, Races, UnitFlags


# Stats that are modified by aura effects and items.
# Use auto indexing to make expanding much easier.
class UnitStats(IntFlag):
    STRENGTH = auto()
    AGILITY = auto()
    STAMINA = auto()
    INTELLECT = auto()
    SPIRIT = auto()
    HEALTH = auto()
    MANA = auto()
    ENERGY = auto()

    RESISTANCE_PHYSICAL = auto()  # Armor
    RESISTANCE_HOLY = auto()
    RESISTANCE_FIRE = auto()
    RESISTANCE_NATURE = auto()
    RESISTANCE_FROST = auto()
    RESISTANCE_SHADOW = auto()

    MAIN_HAND_DAMAGE_MIN = auto()
    MAIN_HAND_DAMAGE_MAX = auto()
    MAIN_HAND_DELAY = auto()

    OFF_HAND_DAMAGE_MIN = auto()
    OFF_HAND_DAMAGE_MAX = auto()
    OFF_HAND_DELAY = auto()

    RANGED_DAMAGE_MIN = auto()
    RANGED_DAMAGE_MAX = auto()
    RANGED_DELAY = auto()

    PARRY_CHANCE = auto()
    DODGE_CHANCE = auto()
    BLOCK_CHANCE = auto()
    # Note: Block value did not exist in 0.5.3

    PROC_CHANCE = auto()

    CRITICAL = auto()
    SPELL_CRITICAL = auto()
    SPELL_CASTING_SPEED_NON_STACKING = auto()
    SCHOOL_CRITICAL = auto()
    SCHOOL_POWER_COST = auto()

    DAMAGE_DONE = auto()
    DAMAGE_DONE_SCHOOL = auto()
    DAMAGE_DONE_WEAPON = auto()
    DAMAGE_DONE_CREATURE_TYPE = auto()
    DAMAGE_TAKEN_SCHOOL = auto()

    HEALTH_REGENERATION_PER_5 = auto()
    POWER_REGENERATION_PER_5 = auto()

    ATTACK_SPEED = auto()
    THREAT_GENERATION = auto()
    STEALTH = auto()
    STEALTH_DETECTION = auto()
    INVISIBILITY = auto()
    INVISIBILITY_DETECTION = auto()
    SPEED_RUNNING = auto()
    SPEED_SWIMMING = auto()
    SPEED_MOUNTED = auto()

    SKILL = auto()

    ATTRIBUTE_START = STRENGTH
    RESISTANCE_START = RESISTANCE_PHYSICAL

    ALL_ATTRIBUTES = STRENGTH | AGILITY | STAMINA | INTELLECT | SPIRIT
    # Exclude armor
    ALL_RESISTANCES = RESISTANCE_HOLY | RESISTANCE_FIRE | RESISTANCE_NATURE | RESISTANCE_FROST | RESISTANCE_SHADOW


class StatManager(object):

    # Player base stats and stats scaling off base attributes (block value, weapon damage bonus from attributes etc.)
    base_stats: dict[UnitStats, float]  # Floats for defensive chances

    # Stat gain from items
    item_stats: dict[UnitStats, int]

    # Managed by AuraManager. [Aura index, (Stat, bonus, misc value)]
    # Misc value can contain power/weapon/creature type etc. depending on the stat
    aura_stats_flat: dict[int, (UnitStats, int, int)]
    aura_stats_percentual: dict[int, (UnitStats, float, int, int)]

    weapon_reach: float

    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr

        self.weapon_reach = 0

        self.base_stats = {}
        self.item_stats = {}

        self.aura_stats_flat = {}
        self.aura_stats_percentual = {}

    def init_stats(self):
        base_stats = WorldDatabaseManager.player_get_class_level_stats(self.unit_mgr.class_, self.unit_mgr.level)

        if not base_stats:
            if self.unit_mgr.level > 60:
                # Default to max available base stats, level 60.
                base_stats = WorldDatabaseManager.player_get_class_level_stats(self.unit_mgr.class_, 60)
                Logger.warning(f'Unsupported base stats for level ({self.unit_mgr.level})'
                               f' Unit class ({Classes(self.unit_mgr.class_).name})'
                               f' Unit type ({ObjectTypeIds(self.unit_mgr.get_type_id()).name})'
                               f' Using level 60 base stats.')
            else:
                Logger.error(
                    f'Unsupported base stats for level ({self.unit_mgr.level})'
                    f' Unit class ({Classes(self.unit_mgr.class_).name})'
                    f' Unit type ({ObjectTypeIds(self.unit_mgr.get_type_id()).name}).')
                return

        # Player specific.
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            base_attrs = WorldDatabaseManager.player_get_level_stats(self.unit_mgr.class_,
                                                                     self.unit_mgr.level,
                                                                     self.unit_mgr.race)
            if not base_attrs:
                if self.unit_mgr.level > 60:
                    # Default to max available attributes, level 60.
                    base_attrs = WorldDatabaseManager.player_get_level_stats(self.unit_mgr.class_,
                                                                             60,
                                                                             self.unit_mgr.race)
                    Logger.warning(f'Unsupported base attributes for level ({self.unit_mgr.level})'
                                   f' Unit type ({ObjectTypeIds(self.unit_mgr.get_type_id()).name})'
                                   f' Unit class ({Classes(self.unit_mgr.class_).name})'
                                   f' Unit race ({Races(self.unit_mgr.race).name})'
                                   f' Using level 60 attributes.')
                else:
                    Logger.error(f'Unsupported base attributes for level ({self.unit_mgr.level})'
                                 f' Unit type ({ObjectTypeIds(self.unit_mgr.get_type_id()).name})'
                                 f' Unit class ({Classes(self.unit_mgr.class_).name})'
                                 f' Unit race ({Races(self.unit_mgr.race).name})')
                    return

            self.base_stats[UnitStats.HEALTH] = base_stats.basehp
            self.base_stats[UnitStats.MANA] = base_stats.basemana
            self.base_stats[UnitStats.STRENGTH] = base_attrs.str
            self.base_stats[UnitStats.AGILITY] = base_attrs.agi
            self.base_stats[UnitStats.STAMINA] = base_attrs.sta
            self.base_stats[UnitStats.INTELLECT] = base_attrs.inte
            self.base_stats[UnitStats.SPIRIT] = base_attrs.spi
            self.base_stats[UnitStats.SPELL_CRITICAL] = BASE_SPELL_CRITICAL_CHANCE / 100
            self.unit_mgr.base_hp = base_stats.basehp
            self.unit_mgr.base_mana = base_stats.basemana
        # Creatures.
        else:
            self.base_stats[UnitStats.HEALTH] = self.unit_mgr.max_health
            self.base_stats[UnitStats.MANA] = self.unit_mgr.max_power_1
            self.base_stats[UnitStats.SPIRIT] = 1
            # Players don't have a flat dodge/block chance.
            self.base_stats[UnitStats.DODGE_CHANCE] = BASE_DODGE_CHANCE_CREATURE / 100
            # Players have block scaling, assign flat 5% to creatures.
            self.base_stats[UnitStats.BLOCK_CHANCE] = BASE_BLOCK_PARRY_CHANCE / 100
            self.base_stats[UnitStats.CRITICAL] = BASE_MELEE_CRITICAL_CHANCE / 100
            self.base_stats[UnitStats.SPELL_CRITICAL] = BASE_SPELL_CRITICAL_CHANCE / 100
            self.unit_mgr.base_hp = self.unit_mgr.max_health
            self.unit_mgr.base_mana = self.unit_mgr.max_power_1

        # Don't overwrite base speed if it has been modified.
        self.base_stats[UnitStats.SPEED_RUNNING] = self.base_stats.get(UnitStats.SPEED_RUNNING, config.Unit.Defaults.run_speed)

        # Players and creatures have an unchanging base 5% chance to block and parry (before defense skill differences).
        # As block chance also scales with strength, the value is calculated in update_base_block_chance.
        self.base_stats[UnitStats.PARRY_CHANCE] = BASE_BLOCK_PARRY_CHANCE / 100

        self.send_attributes()

        self.update_base_health_regen()
        self.update_base_mana_regen()

        self.update_base_proc_chance()
        self.update_base_melee_critical_chance()
        self.update_defense_bonuses()

    def get_base_stat(self, stat_type: UnitStats) -> int:
        return self.base_stats.get(stat_type, 0)

    def get_item_stat(self, stat_type: UnitStats) -> int:
        return self.item_stats.get(stat_type, 0)

    def get_stat_gain_from_aura_bonuses(self, stat_type: UnitStats, misc_value=-1) -> int:
        # Note: bonus can be negative due to harmful effects.
        base_stats = self.get_base_stat(stat_type)
        item_stats = self.get_item_stat(stat_type)
        bonus_stats = self.get_aura_stat_bonus(stat_type, misc_value=misc_value)

        total = int((base_stats + item_stats + bonus_stats) * self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value))

        return total - base_stats - item_stats

    def get_total_stat(self, stat_type: UnitStats, misc_value=-1, accept_negative=False, accept_float=False, misc_value_is_mask=False) -> int:
        base_stats = self.get_base_stat(stat_type)
        bonus_stats = self.item_stats.get(stat_type, 0) + \
            self.get_aura_stat_bonus(stat_type, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)

        total = (base_stats + bonus_stats) * \
            self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)

        if not accept_float:
            total = int(total)

        if accept_negative:
            return total

        return max(0, total)

    def get_stat_skill_bonus(self, skill_type):  # Avoids circular import with SkillManager
        return self.get_total_stat(UnitStats.SKILL, misc_value=skill_type)

    def apply_bonuses(self, replenish=False):
        # Don't apply bonuses for players that haven't completed login.
        # Sending a speed change before entering the world crashes the client.
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER and not self.unit_mgr.online:
            return

        self.calculate_item_stats()

        # Always update base attack since unarmed damage should update.
        self.update_base_weapon_attributes(attack_type=AttackTypes.BASE_ATTACK)

        if self.unit_mgr.has_offhand_weapon():
            self.update_base_weapon_attributes(attack_type=AttackTypes.OFFHAND_ATTACK)
        if self.unit_mgr.has_ranged_weapon():  # TODO Are ranged formulas different?
            self.update_base_weapon_attributes(attack_type=AttackTypes.RANGED_ATTACK)

        # Only send base speed - change_speed will apply total value.
        self.unit_mgr.change_speed(self.get_base_stat(UnitStats.SPEED_RUNNING))

        hp_diff = self.update_max_health()
        mana_diff = self.update_max_mana()

        self.update_base_mana_regen()
        self.update_base_health_regen()

        self.update_defense_bonuses()

        self.send_attributes()
        self.send_melee_attributes()
        self.send_damage_bonuses()
        self.send_resistances()
        self.send_defense_bonuses()

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.unit_mgr.skill_manager.build_update()

        # Set health and power (if it's not Rage and Focus) to their max values.
        if replenish:
            self.unit_mgr.set_health(self.unit_mgr.max_health)
            if self.unit_mgr.power_type != PowerTypes.TYPE_RAGE and self.unit_mgr.power_type != PowerTypes.TYPE_FOCUS:
                self.unit_mgr.recharge_power()

        return hp_diff, mana_diff

    def apply_bonuses_for_value(self, value: int, stat_type: UnitStats, misc_value=-1, misc_value_is_mask=False):
        flat = self.get_aura_stat_bonus(stat_type, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)
        percentual = self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)
        return int((value + flat) * percentual)

    def apply_aura_stat_bonus(self, index: int, stat_type: UnitStats, amount: int, misc_value=-1, percentual=False):
        # Note: percentual modifiers should be passed as ints (ie. 50 -> +50% -> *1.5, -20 -> -20% -> *0.8).
        if percentual:
            self.aura_stats_percentual[index] = (stat_type, amount, misc_value)
        else:
            self.aura_stats_flat[index] = (stat_type, amount, misc_value)

        self.apply_bonuses()

    def remove_aura_stat_bonus(self, index: int, percentual=False):
        if percentual:
            self.aura_stats_percentual.pop(index, None)
        else:
            self.aura_stats_flat.pop(index, None)

        self.apply_bonuses()

    def get_aura_stat_bonus(self, stat_type: UnitStats, percentual=False, misc_value=-1, misc_value_is_mask=False):
        if percentual:
            bonus = 1
        else:
            bonus = 0

        for stat_bonus in self.get_aura_stat_bonuses(stat_type, percentual, misc_value, misc_value_is_mask):
            if not percentual:
                bonus += stat_bonus
            else:
                bonus *= stat_bonus / 100 + 1

        return bonus

    # Returns a list of bonuses for a stat from auras. Needed for separating negative and positive resistance bonuses for the client.
    def get_aura_stat_bonuses(self, stat_type: UnitStats, percentual=False, misc_value=-1, misc_value_is_mask=False) -> list[int]:
        bonuses = []
        if percentual:
            target_bonuses = self.aura_stats_percentual
        else:
            target_bonuses = self.aura_stats_flat

        for stat_bonus in target_bonuses.values():
            if not stat_bonus[0] & stat_type:
                # Stat bonus type or misc value don't match
                continue

            if misc_value != -1 or stat_bonus[2] != -1:
                if misc_value_is_mask and not misc_value & stat_bonus[2] or \
                        (not misc_value_is_mask and misc_value != stat_bonus[2]):
                    continue

            bonuses.append(stat_bonus[1])
        return bonuses

    def calculate_item_stats(self):
        # Creature-only calculations.
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_UNIT:
            min_damage, max_damage = unpack('<2H', pack('<I', self.unit_mgr.damage))
            main_min_dmg = min_damage
            main_max_dmg = max_damage
            weapon_reach = 0

            if self.unit_mgr.has_mainhand_weapon():
                # Disarm effects. Only applies to mobs with a weapon equipped. Sources suggest a
                # ~60% damage reduction on mobs which can be disarmed and have a weapon
                # http://wowwiki.wikia.com/wiki/Attumen_the_Huntsman?oldid=1377353
                # http://wowwiki.wikia.com/wiki/Disarm?direction=prev&oldid=200198
                if self.unit_mgr.unit_flags & UnitFlags.UNIT_FLAG_DISARMED:
                    main_min_dmg = math.ceil(main_min_dmg * 0.4)
                    main_max_dmg = math.ceil(main_max_dmg * 0.4)
                else:
                    creature_equip_template = WorldDatabaseManager.CreatureEquipmentHolder.creature_get_equipment_by_id(
                        self.unit_mgr.creature_template.equipment_id)
                    if creature_equip_template:
                        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(
                            creature_equip_template.equipentry1)
                        if item_template:
                            weapon_reach = UnitFormulas.get_reach_for_weapon(item_template)
            self.weapon_reach = weapon_reach

            # Main hand.
            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = main_min_dmg
            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = main_max_dmg
            self.item_stats[UnitStats.MAIN_HAND_DELAY] = self.unit_mgr.base_attack_time

            # Off hand.
            if self.unit_mgr.has_offhand_weapon():
                dual_wield_penalty = 0.5
                self.item_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = math.ceil(min_damage * dual_wield_penalty)
                self.item_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = math.ceil(max_damage * dual_wield_penalty)
                self.item_stats[UnitStats.OFF_HAND_DELAY] = self.unit_mgr.base_attack_time

            # Ranged.
            if self.unit_mgr.has_ranged_weapon():
                self.item_stats[UnitStats.RANGED_DAMAGE_MIN] = self.unit_mgr.ranged_dmg_min
                self.item_stats[UnitStats.RANGED_DAMAGE_MAX] = self.unit_mgr.ranged_dmg_max
                self.item_stats[UnitStats.RANGED_DELAY] = self.unit_mgr.ranged_attack_time

        # Player-only calculations.
        else:
            self.item_stats = {UnitStats.MAIN_HAND_DELAY: config.Unit.Defaults.base_attack_time,
                               UnitStats.OFF_HAND_DELAY: config.Unit.Defaults.offhand_attack_time}  # Clear item stats

            if self.unit_mgr.is_in_feral_form():
                # Druids in feral form don't use their weapon to attack.
                # Use weapon damage values for paw damage instead.
                # VMaNGOS values.

                # Base attack delay for the two forms.
                attack_delay = 1000 if self.unit_mgr.has_form(ShapeshiftForms.SHAPESHIFT_FORM_CAT) else 2500

                self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = self.unit_mgr.level * 0.85 * (attack_delay / 1000)
                self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = self.unit_mgr.level * 1.25 * (attack_delay / 1000)
                self.item_stats[UnitStats.MAIN_HAND_DELAY] = attack_delay

            # Reset weapon reach.
            self.weapon_reach = 0

            # Regenerate item stats.
            for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
                # Check equipped items.
                if item.current_slot <= InventorySlots.SLOT_TABARD:
                    # Handle normal item stats.
                    for stat in item.stats:
                        stat_type = INVENTORY_STAT_TO_UNIT_STAT[stat.stat_type]
                        if stat.value != 0:
                            current = self.item_stats.get(stat_type, 0)
                            self.item_stats[stat_type] = current + stat.value

                    # Add resistances/block.
                    separate_stats = {UnitStats.RESISTANCE_PHYSICAL: item.item_template.armor,
                                      UnitStats.RESISTANCE_HOLY: item.item_template.holy_res,
                                      UnitStats.RESISTANCE_FIRE: item.item_template.fire_res,
                                      UnitStats.RESISTANCE_NATURE: item.item_template.nature_res,
                                      UnitStats.RESISTANCE_FROST: item.item_template.frost_res,
                                      UnitStats.RESISTANCE_SHADOW: item.item_template.shadow_res}
                    for stat, value in separate_stats.items():
                        self.item_stats[stat] = self.item_stats.get(stat, 0) + value

                    # Ignore weapon damage stats for feral druids.
                    if InventorySlots.SLOT_MAINHAND <= item.current_slot <= InventorySlots.SLOT_RANGED and \
                            self.unit_mgr.is_in_feral_form():
                        continue

                    if item.current_slot != InventorySlots.SLOT_MAINHAND and \
                        item.current_slot != InventorySlots.SLOT_OFFHAND and \
                            item.current_slot != InventorySlots.SLOT_RANGED:
                        continue  # Not a weapon.

                    # Handle weapon damage stats.
                    weapon_min_damage = int(item.item_template.dmg_min1)
                    weapon_max_damage = int(item.item_template.dmg_max1)
                    weapon_delay = item.item_template.delay if item.item_template.delay != 0 and \
                        not self.unit_mgr.unit_flags & UnitFlags.UNIT_FLAG_DISARMED \
                        else config.Unit.Defaults.base_attack_time

                    # Damage increase weapon enchants.
                    weapon_enchant_bonus = EnchantmentManager.get_effect_value_for_enchantment_type(
                        item, ItemEnchantmentType.DAMAGE)

                    weapon_min_damage += weapon_enchant_bonus
                    weapon_max_damage += weapon_enchant_bonus

                    if item.current_slot == InventorySlots.SLOT_MAINHAND:
                        if self.unit_mgr.unit_flags & UnitFlags.UNIT_FLAG_DISARMED:
                            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = 0
                            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = 0
                            self.item_stats[UnitStats.MAIN_HAND_DELAY] = weapon_delay
                            self.weapon_reach = 0
                        else:
                            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = weapon_min_damage
                            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = weapon_max_damage
                            self.item_stats[UnitStats.MAIN_HAND_DELAY] = weapon_delay
                            self.weapon_reach = UnitFormulas.get_reach_for_weapon(item.item_template)
                    elif item.current_slot == InventorySlots.SLOT_OFFHAND:
                        dual_wield_penalty = 0.5
                        self.item_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = math.ceil(weapon_min_damage *
                                                                                   dual_wield_penalty)
                        self.item_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = math.ceil(weapon_max_damage *
                                                                                   dual_wield_penalty)
                        self.item_stats[UnitStats.OFF_HAND_DELAY] = weapon_delay
                    elif item.current_slot == InventorySlots.SLOT_RANGED:
                        self.item_stats[UnitStats.RANGED_DAMAGE_MIN] = weapon_min_damage
                        self.item_stats[UnitStats.RANGED_DAMAGE_MAX] = weapon_max_damage
                        self.item_stats[UnitStats.RANGED_DELAY] = weapon_delay
        self.unit_mgr.set_weapon_reach(self.weapon_reach)

    def update_max_health(self):
        total_stamina = self.get_total_stat(UnitStats.STAMINA)
        total_health = self.get_total_stat(UnitStats.HEALTH)

        current_hp = self.unit_mgr.health
        current_total_hp = self.unit_mgr.max_health
        new_hp = int(self.get_health_bonus_from_stamina(total_stamina) + total_health)

        hp_diff = new_hp - current_total_hp
        if new_hp > 0:
            # Update current health if the new total value is lower and health is currently greater than the new total.
            if current_hp > new_hp < current_total_hp:
                self.unit_mgr.set_health(new_hp)
            self.unit_mgr.set_max_health(new_hp)

        return max(0, hp_diff)

    def update_max_mana(self):
        if self.unit_mgr.power_type != PowerTypes.TYPE_MANA:
            return 0

        total_intellect = self.get_total_stat(UnitStats.INTELLECT)
        total_mana = self.get_total_stat(UnitStats.MANA)

        current_mana = self.unit_mgr.power_1
        current_total_mana = self.unit_mgr.max_power_1
        new_mana = int(self.get_mana_bonus_from_intellect(total_intellect) + total_mana)

        mana_diff = new_mana - current_total_mana
        if new_mana > 0:
            # Update current mana if the new total value is lower and mana is currently greater than the new total.
            if current_mana > new_mana < current_total_mana:
                self.unit_mgr.set_mana(new_mana)
            self.unit_mgr.set_max_mana(new_mana)

        return max(0, mana_diff)

    def update_base_health_regen(self):
        unit_class = self.unit_mgr.class_
        spirit = self.get_total_stat(UnitStats.SPIRIT)
        self.base_stats[UnitStats.HEALTH_REGENERATION_PER_5] = int(CLASS_BASE_REGEN_HEALTH[unit_class] + spirit * CLASS_SPIRIT_SCALING_HP5[unit_class])

    def update_base_mana_regen(self):
        unit_class = self.unit_mgr.class_
        if unit_class not in CLASS_SPIRIT_SCALING_MANA:
            return

        spirit = self.get_total_stat(UnitStats.SPIRIT)
        regen = CLASS_BASE_REGEN_MANA[unit_class] + spirit * CLASS_SPIRIT_SCALING_MANA[unit_class]
        self.base_stats[UnitStats.POWER_REGENERATION_PER_5] = int(regen / 2)

    def update_base_melee_critical_chance(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        player_class = self.unit_mgr.class_
        strength = self.get_total_stat(UnitStats.STRENGTH)
        scaling = CLASS_STRENGTH_SCALING_CRITICAL[player_class]
        class_rate = (scaling[0] * (60 - self.unit_mgr.level) +
                      scaling[1] * (self.unit_mgr.level - 1)) / 59
        critical_bonus = strength / class_rate / 100
        self.base_stats[UnitStats.CRITICAL] = critical_bonus

    def update_base_dodge_chance(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return  # Base dodge can't change for creatures - set on init.

        player_class = self.unit_mgr.class_
        agility = self.get_total_stat(UnitStats.AGILITY)
        scaling = CLASS_AGILITY_SCALING_DODGE[player_class]
        class_rate = (scaling[0] * (60 - self.unit_mgr.level) +
                      scaling[1] * (self.unit_mgr.level - 1)) / 59

        class_base_dodge = CLASS_BASE_DODGE[player_class] / 100 if player_class in CLASS_BASE_DODGE else 0
        agility_bonus = agility / class_rate / 100

        base_dodge = class_base_dodge + agility_bonus

        self.base_stats[UnitStats.DODGE_CHANCE] = base_dodge

    def update_base_block_chance(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        player_class = self.unit_mgr.class_

        # Strength increases chance to block according to the stat sheet tooltip.
        strength = self.get_total_stat(UnitStats.STRENGTH)

        # TODO Using dodge formula because of missing information - tune if needed.

        scaling = CLASS_AGILITY_SCALING_DODGE[player_class]
        class_rate = (scaling[0] * (60 - self.unit_mgr.level) +
                      scaling[1] * (self.unit_mgr.level - 1)) / 59

        # Since players have a base block chance of 5% unlike dodge, subtract this base from the placeholder scaling.
        strength_scaling = max(0, strength / class_rate / 100 - 0.05)
        base_block_chance = BASE_BLOCK_PARRY_CHANCE / 100

        self.base_stats[UnitStats.BLOCK_CHANCE] = strength_scaling + base_block_chance

    def update_base_proc_chance(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        player_class = self.unit_mgr.class_

        agility = self.get_total_stat(UnitStats.AGILITY)

        # TODO Using dodge formula because of missing information - tune if needed.
        scaling = CLASS_AGILITY_SCALING_DODGE[player_class]
        class_rate = (scaling[0] * (60 - self.unit_mgr.level) +
                      scaling[1] * (self.unit_mgr.level - 1)) / 59

        agility_scaling = agility / class_rate / 100

        self.base_stats[UnitStats.PROC_CHANCE] = agility_scaling

    # Auto attack/shoot base damage
    def get_base_attack_base_min_max_damage(self, attack_type: AttackTypes):
        if attack_type == AttackTypes.BASE_ATTACK:
            weapon_min_damage = self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MIN)
            weapon_max_damage = self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MAX)
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            weapon_min_damage = self.get_total_stat(UnitStats.OFF_HAND_DAMAGE_MIN)
            weapon_max_damage = self.get_total_stat(UnitStats.OFF_HAND_DAMAGE_MAX)
        else:
            weapon_min_damage = self.get_total_stat(UnitStats.RANGED_DAMAGE_MIN)
            weapon_max_damage = self.get_total_stat(UnitStats.RANGED_DAMAGE_MAX)

        return max(1, weapon_min_damage), max(1, weapon_max_damage)

    def apply_bonuses_for_damage(self, damage, attack_school: SpellSchools, victim,
                                 weapon_type: ItemSubClasses = -1) -> float:
        if weapon_type != -1:
            weapon_type = 1 << weapon_type
        else:
            weapon_type = 0

        target_creature_type = victim.creature_type

        flat_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, percentual=False, misc_value=attack_school) + \
            self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, percentual=False, misc_value=weapon_type, misc_value_is_mask=True) + \
            self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_CREATURE_TYPE, percentual=False, misc_value=target_creature_type)

        percentual_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, percentual=True, misc_value=attack_school) * \
            self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, percentual=True, misc_value=weapon_type, misc_value_is_mask=True) * \
            self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_CREATURE_TYPE, percentual=True, misc_value=target_creature_type)

        damage_dealt = (damage + flat_bonuses) * percentual_bonuses

        # Add victim buffs/debuffs after calculations to not scale them.
        damage_dealt += victim.stat_manager.get_total_stat(UnitStats.DAMAGE_TAKEN_SCHOOL, 1 << attack_school,
                                                           accept_negative=True, misc_value_is_mask=True)

        # Last, account for armor mitigation if applicable.
        # TODO Should bleed spells ignore armor?
        #  Effect mechanic fields aren't present in 0.5.3, but are referenced by SPELL_AURA_MECHANIC_IMMUNITY
        if attack_school == SpellSchools.SPELL_SCHOOL_NORMAL:
            total_armor = victim.stat_manager.get_total_stat(UnitStats.RESISTANCE_PHYSICAL)

            # Using an old formula found on Thottbot.
            # https://web.archive.org/web/20041010045455/http://www.thottbot.com:80/?formula=1
            reduction = (0.3 * (total_armor - 1)) / (10 * self.unit_mgr.level + 89)

            # Vanilla cap. The formula can go over 1 in some extreme cases (400 armor, level 1 for example)
            mitigation_cap = 0.75

            damage_dealt *= 1 - max(0.0, min(mitigation_cap, reduction))

            # Vanilla formula:
            # reduction = total_armor / (total_armor + 400 + 85 * self.unit_mgr.level)
            # reduction = min(0.75, reduction)
            # damage_dealt *= 1 - reduction

        # Damage taken reduction can bring damage to negative, limit to 0.
        return max(0, int(damage_dealt))

    def roll_proc_chance(self, base_chance: float) -> bool:
        chance = base_chance/100 + self.get_total_stat(UnitStats.PROC_CHANCE)
        return random.random() < chance

    def get_intellect_stat_gain_chance_bonus(self):
        gain = self.get_total_stat(UnitStats.INTELLECT) * 0.0002
        return gain if gain <= 0.10 else 0.10  # Cap at 10% (Guessed in VMaNGOS)

    def get_attack_result_against_self(self, attacker, attack_type, dual_wield_penalty=0):
        # TODO Based on vanilla calculations.
        # Evading, return miss and handle on calling method.
        if self.unit_mgr.is_evading:
            return HitInfo.MISS

        # Immunity.
        if self.unit_mgr.handle_immunity(attacker, SpellImmunity.IMMUNITY_DAMAGE, SpellSchools.SPELL_SCHOOL_NORMAL):
            return HitInfo.ABSORBED

        # Note: Bear and cat form attacks don't use a weapon, and instead have max attack rating.
        if attacker.get_type_id() == ObjectTypeIds.ID_PLAYER and not attacker.is_in_feral_form():
            attack_weapon = attacker.get_current_weapon_for_attack_type(attack_type)
            attack_weapon_template = attack_weapon.item_template if attack_weapon is not None else None

            skill_id = attacker.skill_manager.get_skill_id_for_weapon(attack_weapon_template)
            attack_rating = attacker.skill_manager.get_total_skill_value(skill_id)
        else:
            attack_rating = -1

        rating_difference = self._get_combat_rating_difference(attacker.level, attack_rating)

        base_miss = 0.05 + dual_wield_penalty
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # 0.04% Bonus against players when the defender has a higher combat rating,
            # 0.02% Bonus when the attacker has a higher combat rating.
            miss_chance = base_miss + rating_difference * 0.0004 if rating_difference > 0 else base_miss + rating_difference * 0.0002
        else:
            #  0.4% if defense rating is >10 points higher than attack rating, otherwise 0.1%.
            miss_chance = base_miss + rating_difference * 0.001 if rating_difference <= 10 \
                else base_miss + 1 + (rating_difference - 10) * 0.004

        # Prior to version 1.8, dual wield's miss chance had a hard cap of 19%,
        # meaning that all dual-wield auto-attacks had a minimum 19% miss chance
        # regardless of how much +hit% gear was equipped.
        miss_chance = max(dual_wield_penalty, miss_chance)

        roll = random.random()
        if roll < miss_chance:
            return HitInfo.MISS

        # Dodge/parry/block receive a 0.04% bonus/penalty for each skill point difference.
        dodge_chance = self.get_total_stat(UnitStats.DODGE_CHANCE, accept_float=True) + rating_difference * 0.0004
        roll = random.random()
        if self.unit_mgr.can_dodge(attacker.location) and roll < dodge_chance:
            return HitInfo.DODGE

        parry_chance = self.get_total_stat(UnitStats.PARRY_CHANCE, accept_float=True) + rating_difference * 0.0004
        roll = random.random()
        if self.unit_mgr.can_parry(attacker.location) and roll < parry_chance:
            return HitInfo.PARRY

        rating_difference_block = self._get_combat_rating_difference(attacker.level, attack_rating,
                                                                     use_block=self.unit_mgr.can_block())

        block_chance = self.get_total_stat(UnitStats.BLOCK_CHANCE, accept_float=True) + rating_difference_block * 0.0004
        roll = random.random()
        if self.unit_mgr.can_block(attacker.location) and roll < block_chance:
            return HitInfo.BLOCK

        attacker_critical_chance = attacker.stat_manager.get_total_stat(UnitStats.CRITICAL, accept_float=True)
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Player: +- 0.04% for each rating difference.
            # For example with defender player level 60 and attacker mob level 63:
            # 5% - (300-315) * 0.04 = 5.6% crit chance (mob).
            critical_chance = attacker_critical_chance - rating_difference * 0.0004
        else:
            # Mob: +- 0.2% for each rating difference OR 0.04% if attacker weapon skill is higher than mob defense.
            # For example with defender mob level 63 and attacker player level 60 (assuming player has 10% crit chance):
            # 10% - (315-300) * 0.2 = 7% crit chance (player).
            multiplier = 0.002 if rating_difference > 0 else 0.0004
            critical_chance = attacker_critical_chance - rating_difference * multiplier

        hit_info = HitInfo.SUCCESS
        if attack_type == AttackTypes.OFFHAND_ATTACK:
            hit_info |= HitInfo.OFFHAND
        if random.random() < critical_chance:
            hit_info |= HitInfo.CRITICAL_HIT
        
        return hit_info

    def get_spell_attack_result_against_self(self, attacker, spell_school: SpellSchools, is_periodic=False):
        if is_periodic:
            return SpellHitFlags.DAMAGE

        is_normal_school = spell_school == SpellSchools.SPELL_SCHOOL_NORMAL
        critical_type = UnitStats.CRITICAL if is_normal_school else UnitStats.SPELL_CRITICAL
        attacker_critical_chance = attacker.stat_manager.get_total_stat(critical_type, accept_float=True)

        roll = random.random()
        if roll < attacker_critical_chance:
            return SpellHitFlags.CRIT

        return SpellHitFlags.DAMAGE

    def update_base_weapon_attributes(self, attack_type=0):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        # TODO: Using Vanilla formula, AP was not present in Alpha

        dual_wield_penalty = 1 if attack_type != AttackTypes.OFFHAND_ATTACK else 0.5

        attack_power = 0
        strength = self.get_total_stat(UnitStats.STRENGTH)
        agility = self.get_total_stat(UnitStats.AGILITY)
        level = self.unit_mgr.level
        class_ = self.unit_mgr.class_

        if class_ == Classes.CLASS_WARRIOR or \
                class_ == Classes.CLASS_PALADIN:
            attack_power = (strength * 2) + (level * 3) - 20
        elif class_ == Classes.CLASS_DRUID:
            attack_power = (strength * 2) - 20
        elif class_ == Classes.CLASS_HUNTER:
            attack_power = strength + agility + (level * 2) - 20
        elif class_ == Classes.CLASS_MAGE or \
                class_ == Classes.CLASS_PRIEST or \
                class_ == Classes.CLASS_WARLOCK:
            attack_power = strength - 10
        elif class_ == Classes.CLASS_ROGUE:
            attack_power = strength + ((agility * 2) - 20) + (level * 2) - 20
        elif class_ == Classes.CLASS_SHAMAN:
            attack_power = strength - 10 + ((agility * 2) - 20) + (level * 2)

        final_min_damage = attack_power / 14 * dual_wield_penalty
        final_max_damage = attack_power / 14 * dual_wield_penalty

        if attack_type == AttackTypes.BASE_ATTACK:
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = final_min_damage
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = final_max_damage
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            self.base_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = final_min_damage
            self.base_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = final_max_damage
        else:
            self.base_stats[UnitStats.RANGED_DAMAGE_MIN] = final_min_damage
            self.base_stats[UnitStats.RANGED_DAMAGE_MAX] = final_max_damage

    def update_defense_bonuses(self):
        self.update_base_dodge_chance()
        self.update_base_block_chance()

    def send_melee_attributes(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        # Weapon enchant bonuses are included in the weapon's damage internally,
        # but should be displayed as a bonus.
        enchant_bonus = EnchantmentManager.get_effect_value_for_enchantment_type(
            self.unit_mgr.inventory.get_main_hand(), ItemEnchantmentType.DAMAGE
        )
        self.unit_mgr.set_melee_damage(self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MIN) - enchant_bonus,
                                       self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MAX) - enchant_bonus)

        self.unit_mgr.set_melee_attack_time(self.get_total_stat(UnitStats.MAIN_HAND_DELAY))
        self.unit_mgr.set_offhand_attack_time(self.get_total_stat(UnitStats.OFF_HAND_DELAY))

    def send_resistances(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        self.unit_mgr.set_armor(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_PHYSICAL))
        self.unit_mgr.set_holy_res(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_HOLY))
        self.unit_mgr.set_fire_res(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_FIRE))
        self.unit_mgr.set_nature_res(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_NATURE))
        self.unit_mgr.set_frost_res(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_FROST))
        self.unit_mgr.set_shadow_res(*self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_SHADOW))

        self.unit_mgr.set_bonus_armor(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_PHYSICAL))
        self.unit_mgr.set_bonus_holy_res(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_HOLY))
        self.unit_mgr.set_bonus_fire_res(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_FIRE))
        self.unit_mgr.set_bonus_nature_res(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_NATURE))
        self.unit_mgr.set_bonus_frost_res(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_FROST))
        self.unit_mgr.set_bonus_shadow_res(*self._get_positive_negative_bonus(UnitStats.RESISTANCE_SHADOW))

    def _get_positive_negative_bonus(self, stat_type: UnitStats):
        aura_bonuses = self.get_aura_stat_bonuses(stat_type)
        percentual = self.get_aura_stat_bonuses(stat_type, percentual=True)

        negative = 0
        positive = 0
        for aura_bonus in aura_bonuses:
            if aura_bonus > 0:
                positive += aura_bonus
                continue
            negative += aura_bonus

        for percentual_bonus in percentual:
            positive *= percentual_bonus
        return negative, positive

    def _get_total_and_item_stat_bonus(self, stat_type: UnitStats):
        return self.get_total_stat(stat_type, accept_negative=True), self.get_item_stat(stat_type)

    def send_attributes(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        self.unit_mgr.set_base_str(self.get_base_stat(UnitStats.STRENGTH))
        self.unit_mgr.set_base_agi(self.get_base_stat(UnitStats.AGILITY))
        self.unit_mgr.set_base_sta(self.get_base_stat(UnitStats.STAMINA))
        self.unit_mgr.set_base_int(self.get_base_stat(UnitStats.INTELLECT))
        self.unit_mgr.set_base_spi(self.get_base_stat(UnitStats.SPIRIT))

        self.unit_mgr.set_str(self.get_total_stat(UnitStats.STRENGTH, accept_negative=True))
        self.unit_mgr.set_agi(self.get_total_stat(UnitStats.AGILITY, accept_negative=True))
        self.unit_mgr.set_sta(self.get_total_stat(UnitStats.STAMINA, accept_negative=True))
        self.unit_mgr.set_int(self.get_total_stat(UnitStats.INTELLECT, accept_negative=True))
        self.unit_mgr.set_spi(self.get_total_stat(UnitStats.SPIRIT, accept_negative=True))

    def send_damage_bonuses(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        main_hand = self.unit_mgr.inventory.get_main_hand()
        subclass_mask = 0
        if main_hand:
            subclass_mask = 1 << main_hand.item_template.subclass

        for school in SpellSchools:
            flat_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, misc_value=school) + \
                self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, misc_value=subclass_mask, misc_value_is_mask=True)

            # Check weapons enchantments.
            if school == SpellSchools.SPELL_SCHOOL_NORMAL:
                main_hand_bonus = EnchantmentManager.get_effect_value_for_enchantment_type(main_hand,
                                                                                           ItemEnchantmentType.DAMAGE)
                flat_bonuses += main_hand_bonus

            percentual_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, misc_value=school, percentual=True) * \
                self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, misc_value=subclass_mask, percentual=True, misc_value_is_mask=True)

            self.unit_mgr.set_bonus_damage_done_for_school(int(flat_bonuses * percentual_bonuses), school)

    def send_defense_bonuses(self):
        self.send_block_percentage()
        self.send_parry_percentage()
        self.send_dodge_percentage()

    def send_block_percentage(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        if not self.unit_mgr.can_block():
            self.unit_mgr.set_block_chance(0)
            return

        # Percentual bonuses are stored as 100% = 1, client expects 100% = 100
        value = self.get_total_stat(UnitStats.BLOCK_CHANCE, accept_float=True) * 100

        # Penalty against player of same level with max skill.
        value += self._get_combat_rating_difference(use_block=True) * 0.04

        value = max(0, value)
        self.unit_mgr.set_block_chance(value)

    def send_parry_percentage(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        if not self.unit_mgr.can_parry():
            self.unit_mgr.set_parry_chance(0)
            return

        value = self.get_total_stat(UnitStats.PARRY_CHANCE, accept_float=True) * 100

        # Penalty against player of same level with max skill
        value += self._get_combat_rating_difference() * 0.04
        value = max(0, value)
        self.unit_mgr.set_parry_chance(value)

    def send_dodge_percentage(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        if not self.unit_mgr.can_dodge():
            self.unit_mgr.set_dodge_chance(0)
            return

        value = self.get_total_stat(UnitStats.DODGE_CHANCE, accept_float=True) * 100

        # Penalty against player of same level with max skill
        value += self._get_combat_rating_difference() * 0.04
        value = max(0, value)
        self.unit_mgr.set_dodge_chance(value)

    # Arguments greater than 0 if defense is higher.
    def _get_combat_rating_difference(self, attacker_level=-1, attacker_rating=-1, use_block=False):
        # Client displays percentages against enemies of equal level and max attack rating.
        if attacker_level == -1:
            attacker_level = self.unit_mgr.level
        if attacker_rating == -1:  # Use max defense skill since it follows the same values as max weapon skill
            attacker_rating = attacker_level * 5

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # TODO It's unclear what the block skill is used for based on patch notes.
            # Use Shields/Block or Defense, depending on the class.
            own_defense_rating = self.unit_mgr.skill_manager.get_defense_skill_value(use_block=use_block)
        else:
            own_defense_rating = self.unit_mgr.level * 5

        return own_defense_rating - attacker_rating

    @staticmethod
    def get_health_bonus_from_stamina(stamina):
        # The first 20 points of Stamina grant only 1 health point per unit.
        base_sta = stamina if stamina < 20 else 20
        more_sta = stamina - base_sta
        return base_sta + (more_sta * 10.0)

    @staticmethod
    def get_mana_bonus_from_intellect(intellect):
        # The first 20 points of Intellect grant only 1 mana point per unit.
        base_int = intellect if intellect < 20 else 20
        more_int = intellect - base_int
        return base_int + (more_int * 15.0)


BASE_BLOCK_PARRY_CHANCE = 5
BASE_DODGE_CHANCE_CREATURE = 5
BASE_MELEE_CRITICAL_CHANCE = 5
BASE_SPELL_CRITICAL_CHANCE = 5

CLASS_SPIRIT_SCALING_HP5 = {
    Classes.CLASS_WARRIOR: 1.26,
    Classes.CLASS_PALADIN: 0.25,
    Classes.CLASS_HUNTER: 0.43,
    Classes.CLASS_ROGUE: 0.84,
    Classes.CLASS_PRIEST: 0.15,
    Classes.CLASS_SHAMAN: 0.28,
    Classes.CLASS_MAGE: 0.11,
    Classes.CLASS_WARLOCK: 0.12,
    Classes.CLASS_DRUID: 0.11
}

CLASS_SPIRIT_SCALING_MANA = {
    Classes.CLASS_PALADIN: 0.20,
    Classes.CLASS_PRIEST: 0.25,
    Classes.CLASS_SHAMAN: 0.20,
    Classes.CLASS_MAGE: 0.25,
    Classes.CLASS_WARLOCK: 0.2,
    Classes.CLASS_DRUID: 0.2
}

CLASS_BASE_REGEN_HEALTH = {
    Classes.CLASS_WARRIOR: -22.6,
    Classes.CLASS_PALADIN: 0.0,
    Classes.CLASS_HUNTER: -5.5,
    Classes.CLASS_ROGUE: -13,
    Classes.CLASS_PRIEST: 1.4,
    Classes.CLASS_SHAMAN: -3.6,
    Classes.CLASS_MAGE: 1.0,
    Classes.CLASS_WARLOCK: 1.5,
    Classes.CLASS_DRUID: 1.0
}

CLASS_BASE_REGEN_MANA = {
    Classes.CLASS_PALADIN: 15.0,
    Classes.CLASS_PRIEST: 12.5,
    Classes.CLASS_SHAMAN: 17.0,
    Classes.CLASS_MAGE: 12.5,
    Classes.CLASS_WARLOCK: 15.0,
    Classes.CLASS_DRUID: 15.0
}

# VMaNGOS
CLASS_BASE_DODGE = {
    Classes.CLASS_DRUID: 0.9,
    Classes.CLASS_MAGE: 3.2,
    Classes.CLASS_PALADIN: 0.7,
    Classes.CLASS_PRIEST: 3.0,
    Classes.CLASS_SHAMAN: 1.7,
    Classes.CLASS_WARLOCK: 2.0
}

# VMaNGOS (level 1, level 60)
CLASS_AGILITY_SCALING_DODGE = {
    Classes.CLASS_DRUID: (4.6, 20.0),
    Classes.CLASS_PALADIN: (4.6, 20.0),
    Classes.CLASS_SHAMAN: (4.6, 20.0),
    Classes.CLASS_MAGE: (12.9, 20.0),
    Classes.CLASS_ROGUE: (1.1, 14.5),
    Classes.CLASS_HUNTER: (1.8, 26.5),
    Classes.CLASS_PRIEST: (11.0, 20.0),
    Classes.CLASS_WARLOCK: (8.4, 20.0),
    Classes.CLASS_WARRIOR: (3.9, 20.0)
}

# In 0.5.3, Strength improves critical strike chance.
# TODO: This is a guess, it uses VMaNGOS agility bonus but doubles it for Warriors instead of Hunters.
CLASS_STRENGTH_SCALING_CRITICAL = {
    Classes.CLASS_DRUID: (4.6, 20.0),
    Classes.CLASS_PALADIN: (4.6, 20.0),
    Classes.CLASS_SHAMAN: (4.6, 20.0),
    Classes.CLASS_MAGE: (12.9, 20.0),
    Classes.CLASS_ROGUE: (2.2, 29.0),
    Classes.CLASS_HUNTER: (1.8, 26.5),
    Classes.CLASS_PRIEST: (11.0, 20.0),
    Classes.CLASS_WARLOCK: (8.4, 20.0),
    Classes.CLASS_WARRIOR: (7.8, 40.0)
}

INVENTORY_STAT_TO_UNIT_STAT = {
    InventoryStats.MANA: UnitStats.MANA,
    InventoryStats.HEALTH: UnitStats.HEALTH,
    InventoryStats.AGILITY: UnitStats.AGILITY,
    InventoryStats.STRENGTH: UnitStats.STRENGTH,
    InventoryStats.INTELLECT: UnitStats.INTELLECT,
    InventoryStats.SPIRIT: UnitStats.SPIRIT,
    InventoryStats.STAMINA: UnitStats.STAMINA
}
