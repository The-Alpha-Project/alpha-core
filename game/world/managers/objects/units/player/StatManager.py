import math
import random
from enum import auto, IntFlag

from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from utils.Formulas import UnitFormulas, CreatureFormulas
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats, ItemSubClasses, ItemEnchantmentType
from utils.constants.MiscCodes import AttackTypes, HitInfo, ObjectTypeIds, SkillCategories
from utils.constants.SpellCodes import SpellSchools, SpellImmunity, SpellHitFlags, SpellMissReason
from utils.constants.UnitCodes import PowerTypes, Classes, Races, UnitFlags, UnitStates
from utils.constants.UpdateFields import UnitFields


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

    ATTACK_POWER = auto()
    RANGED_ATTACK_POWER = auto()

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

    HIT_CHANCE = auto()
    MELEE_CRITICAL = auto()
    SPELL_CRITICAL = auto()
    SPELL_SCHOOL_CRITICAL = auto()
    SPELL_SCHOOL_POWER_COST = auto()
    SPELL_CASTING_SPEED = auto()

    DAMAGE_DONE = auto()
    DAMAGE_DONE_SCHOOL = auto()
    DAMAGE_DONE_WEAPON = auto()
    DAMAGE_DONE_CREATURE_TYPE = auto()
    DAMAGE_TAKEN_SCHOOL = auto()

    HEALTH_REGENERATION_PER_5 = auto()
    MANA_REGENERATION_PER_5 = auto()
    RAGE_REGENERATION_PER_5 = auto()
    FOCUS_REGENERATION_PER_5 = auto()
    ENERGY_REGENERATION_PER_5 = auto()

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
    POWER_REGEN_START = MANA_REGENERATION_PER_5

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
        base_stats = WorldDatabaseManager.UnitClassLevelStatsHolder.get_for_class_level(self.unit_mgr.class_,
                                                                                        self.unit_mgr.level)

        if not base_stats:
            if self.unit_mgr.level > 60:
                # Default to max available base stats, level 60.
                base_stats = WorldDatabaseManager.UnitClassLevelStatsHolder.get_for_class_level(
                    self.unit_mgr.class_, 60)
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

            # Focus/energy values are guessed.
            self.base_stats[UnitStats.FOCUS_REGENERATION_PER_5] = 5  # 1 focus/sec
            # Regenerating 4 Energy every 2 seconds instead of 20. This is a guess based on the cost of
            # Sinister Strike in both 1.12 (45 Energy) and 0.5.3 (10 Energy). ((10 * 20) / 45 = 4.44)
            self.base_stats[UnitStats.ENERGY_REGENERATION_PER_5] = 20
            self.base_stats[UnitStats.RAGE_REGENERATION_PER_5] = -50  # Rage decay out of combat.
        # Creatures.
        else:
            self.set_creature_stats()

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

    def set_creature_stats(self):
        creature = self.unit_mgr
        creature_template = creature.creature_template

        # Set stats common between all creatures.
        # Bosses invisibility detection.
        if creature_template.rank == 3:
            self.base_stats[UnitStats.INVISIBILITY_DETECTION] = 1000
        self.base_stats[UnitStats.DODGE_CHANCE] = BASE_DODGE_CHANCE_CREATURE / 100
        self.base_stats[UnitStats.BLOCK_CHANCE] = BASE_BLOCK_PARRY_CHANCE / 100
        self.base_stats[UnitStats.MELEE_CRITICAL] = BASE_MELEE_CRITICAL_CHANCE / 100
        self.base_stats[UnitStats.SPELL_CRITICAL] = BASE_SPELL_CRITICAL_CHANCE / 100

        self.base_stats[UnitStats.RESISTANCE_HOLY] = creature_template.holy_res
        self.base_stats[UnitStats.RESISTANCE_FIRE] = creature_template.fire_res
        self.base_stats[UnitStats.RESISTANCE_NATURE] = creature_template.nature_res
        self.base_stats[UnitStats.RESISTANCE_FROST] = creature_template.frost_res
        self.base_stats[UnitStats.RESISTANCE_SHADOW] = creature_template.shadow_res

        # Get specific base stats for this creature: a distinction must be made for pets.
        base_stats, base_dmg, base_ranged_dmg = self._get_creature_base_stats()
        for base_stat, value in base_stats.items():
            self.base_stats[base_stat] = value

        self.send_resistances()
        self.send_attributes()
        self.update_max_health()
        self.update_max_mana()

        if not creature.get_charmer_or_summoner():
            creature.health = int((creature.health_percent / 100) * creature.max_health)
            creature.power_1 = int((creature.mana_percent / 100) * creature.max_power_1)

        self._set_creature_base_damage(base_dmg[0], base_dmg[1], AttackTypes.BASE_ATTACK)
        self._set_creature_base_damage(base_ranged_dmg[0], base_ranged_dmg[1], AttackTypes.RANGED_ATTACK)
        self.send_melee_attributes()

    def _get_creature_base_stats(self) -> tuple[dict[UnitStats, float], tuple[int, int], tuple[int, int]]:
        creature_template = self.unit_mgr.creature_template
        cls = self.unit_mgr.get_creature_class_level_stats()
        if not self.unit_mgr.is_pet():
            base_dmg_min, base_dmg_max = CreatureFormulas.calculate_min_max_damage(
            cls.melee_damage,
            creature_template.damage_multiplier,
            creature_template.damage_variance
            )

            ranged_dmg_min, ranged_dmg_max = CreatureFormulas.calculate_min_max_damage(
                cls.ranged_damage,
                creature_template.damage_multiplier,
                creature_template.damage_variance
            )

            stat_map = {
                UnitStats.HEALTH: int(max(1, cls.health * creature_template.health_multiplier)),
                UnitStats.MANA: int(cls.mana * creature_template.mana_multiplier),
                UnitStats.STRENGTH: cls.agility,
                UnitStats.AGILITY: cls.strength,
                UnitStats.STAMINA: cls.stamina,
                UnitStats.INTELLECT: cls.intellect,
                UnitStats.SPIRIT: cls.spirit,
                UnitStats.RESISTANCE_PHYSICAL: int(cls.armor * creature_template.armor_multiplier)
            }
        else:
            pet_stats = WorldDatabaseManager.get_pet_level_stats_by_entry_and_level(
                creature_template.entry,
                self.unit_mgr.level)
            if not pet_stats:
                Logger.warning(f'Unable to locate pet level stats for creature entry '
                               f'{creature_template.entry} level {self.unit_mgr.level}, '
                               f'using default stats (capped at level 60).')
                # Use default stats, capped at level 60.
                pet_stats = WorldDatabaseManager.get_pet_level_stats_by_entry_and_level(
                    1, min(self.unit_mgr.level, 60))

            # From VMaNGOS.
            delay_mod = creature_template.base_attack_time / 2000
            damage_base = self.unit_mgr.level * 1.05

            base_dmg_min = int(damage_base * 1.15 * delay_mod)
            base_dmg_max = int(damage_base * 1.45 * delay_mod)
            # Just set ranged damage to base damage for pets. This probably does not matter.
            ranged_dmg_min, ranged_dmg_max = base_dmg_min, base_dmg_max
            stat_map = {
                UnitStats.HEALTH: pet_stats.hp,
                UnitStats.MANA: pet_stats.mana,
                UnitStats.STRENGTH: pet_stats.str,
                UnitStats.AGILITY: pet_stats.agi,
                UnitStats.STAMINA: pet_stats.sta,
                UnitStats.INTELLECT: pet_stats.inte,
                UnitStats.SPIRIT: pet_stats.spi,
                UnitStats.RESISTANCE_PHYSICAL: pet_stats.armor
            }

        # Use same AP values for pets. TODO Unsure if this is correct.
        stat_map[UnitStats.ATTACK_POWER] = cls.attack_power
        stat_map[UnitStats.RANGED_ATTACK_POWER] = cls.ranged_attack_power

        return stat_map, (base_dmg_min, base_dmg_max), (ranged_dmg_min, ranged_dmg_max)

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

    def get_total_stat(self, stat_type: UnitStats, misc_value=-1, accept_negative=False,
                       accept_float=False, misc_value_is_mask=False) -> int:
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
        self.update_attack_base_damage(attack_type=AttackTypes.BASE_ATTACK)

        if self.unit_mgr.has_offhand_weapon():
            self.update_attack_base_damage(attack_type=AttackTypes.OFFHAND_ATTACK)
        if self.unit_mgr.has_ranged_weapon():  # TODO Are ranged formulas different?
            self.update_attack_base_damage(attack_type=AttackTypes.RANGED_ATTACK)

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
        self.send_cast_time_mods()

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.unit_mgr.skill_manager.build_update()

        if replenish:
            self.unit_mgr.replenish_powers()

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

        # Casting speed modifiers shouldn't stack.
        # Instead of multiplying all bonuses, return the product of the highest and lowest bonuses.
        is_stacking = not percentual or stat_type not in NON_STACKING_STATS
        min_mod = 1.0
        max_mod = 1.0

        for stat_bonus in self.get_aura_stat_bonuses(stat_type, percentual, misc_value, misc_value_is_mask):
            if not is_stacking:
                stat_bonus = stat_bonus / 100 + 1
                if stat_bonus < min_mod:
                    min_mod = stat_bonus
                elif stat_bonus > max_mod:
                    max_mod = stat_bonus
                continue

            if not percentual:
                bonus += stat_bonus
            else:
                bonus *= stat_bonus / 100 + 1

        return bonus if is_stacking else min_mod * max_mod

    # Returns a list of bonuses for a stat from auras.
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

    def _set_creature_base_damage(self, base_min, base_max, attack_type):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_UNIT:
            return

        # In vanilla, creatures get a damage bonus of 30% of their bonus attack power.
        #   (vMaNGOS Creature::UpdateDamagePhysical)
        base_ap = self.base_stats[UnitStats.ATTACK_POWER] if attack_type != AttackTypes.RANGED_ATTACK \
            else self.base_stats[UnitStats.RANGED_ATTACK_POWER]
        ap_bonus = self.get_attack_power_from_attributes()
        ap_dmg_multiplier = 0.7 + 0.3 * ((base_ap + ap_bonus) / base_ap) if base_ap else 1

        min_dmg = base_min * ap_dmg_multiplier
        max_dmg = base_max * ap_dmg_multiplier

        weapon_reach = 0

        if self.unit_mgr.has_mainhand_weapon() and attack_type != AttackTypes.RANGED_ATTACK:
            # Disarm effects. Only applies to mobs with a weapon equipped. Sources suggest a
            # ~60% damage reduction on mobs which can be disarmed and have a weapon. (from vMaNGOS)
            # http://wowwiki.wikia.com/wiki/Attumen_the_Huntsman?oldid=1377353
            # http://wowwiki.wikia.com/wiki/Disarm?direction=prev&oldid=200198
            if self.unit_mgr.unit_flags & UnitFlags.UNIT_FLAG_DISARMED:
                min_dmg = math.ceil(min_dmg * 0.4)
                max_dmg = math.ceil(max_dmg * 0.4)
            else:
                creature_equip_template = WorldDatabaseManager.CreatureEquipmentHolder.creature_get_equipment_by_id(
                    self.unit_mgr.creature_template.equipment_id)
                if creature_equip_template:
                    item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(
                        creature_equip_template.equipentry1)
                    if item_template:
                        weapon_reach = UnitFormulas.get_reach_for_weapon(item_template)
        self.weapon_reach = weapon_reach

        if attack_type != AttackTypes.RANGED_ATTACK:
            # Main hand.
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = min_dmg
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = max_dmg
            self.base_stats[UnitStats.MAIN_HAND_DELAY] = self.unit_mgr.creature_template.base_attack_time

            # Off-hand.
            if self.unit_mgr.has_offhand_weapon():
                dual_wield_penalty = 0.5
                self.base_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = math.ceil(min_dmg * dual_wield_penalty)
                self.base_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = math.ceil(max_dmg * dual_wield_penalty)
                self.base_stats[UnitStats.OFF_HAND_DELAY] = self.unit_mgr.creature_template.base_attack_time
            return

        # Ranged.
        if self.unit_mgr.has_ranged_weapon():
            self.base_stats[UnitStats.RANGED_DAMAGE_MIN] = min_dmg
            self.base_stats[UnitStats.RANGED_DAMAGE_MAX] = max_dmg
            self.base_stats[UnitStats.RANGED_DELAY] = self.unit_mgr.ranged_attack_time

    def calculate_item_stats(self):
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_UNIT:
            return

        self.item_stats = {UnitStats.MAIN_HAND_DELAY: config.Unit.Defaults.base_attack_time,
                           UnitStats.OFF_HAND_DELAY: config.Unit.Defaults.offhand_attack_time}  # Clear item stats

        if self.unit_mgr.is_in_feral_form():
            # Druids in feral form don't use their weapon to attack.
            # Use weapon damage values for paw damage instead.
            # VMaNGOS values.

            # Base attack delay for both forms.
            # Cat form provides a haste bonus in alpha - using the same attack delay for both.
            attack_delay = 2500

            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = self.unit_mgr.level * 0.85 * (attack_delay / 1000)
            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = self.unit_mgr.level * 1.25 * (attack_delay / 1000)
            self.item_stats[UnitStats.MAIN_HAND_DELAY] = attack_delay

        # Reset weapon reach.
        self.weapon_reach = 0

        # Regenerate item stats.
        for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
            if item.current_slot > InventorySlots.SLOT_TABARD:
                continue

            # Check equipped items.
            for stat in item.stats:
                stat_type = INVENTORY_STAT_TO_UNIT_STAT[stat.stat_type]
                if stat.value != 0:
                    current = self.item_stats.get(stat_type, 0)
                    self.item_stats[stat_type] = current + stat.value

            # Add resistances.
            separate_stats = {UnitStats.RESISTANCE_PHYSICAL: item.item_template.armor,
                              UnitStats.RESISTANCE_HOLY: item.item_template.holy_res,
                              UnitStats.RESISTANCE_FIRE: item.item_template.fire_res,
                              UnitStats.RESISTANCE_NATURE: item.item_template.nature_res,
                              UnitStats.RESISTANCE_FROST: item.item_template.frost_res,
                              UnitStats.RESISTANCE_SHADOW: item.item_template.shadow_res}

            # Add resistance enchant bonuses (only armor in 0.5.3).
            resistance_enchants = EnchantmentManager.get_enchantments_by_type(item,
                                                                              ItemEnchantmentType.RESISTANCE)

            for res_enchant in resistance_enchants:
                res_stat = UnitStats.RESISTANCE_START << res_enchant.effect_spell
                separate_stats[res_stat] += res_enchant.effect_points

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
                self.unit_mgr.set_weapon_reach(self.weapon_reach)
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

    def update_max_health(self):
        total_stamina = self.get_total_stat(UnitStats.STAMINA)
        total_health = self.get_total_stat(UnitStats.HEALTH)

        current_hp = self.unit_mgr.health
        current_total_hp = self.unit_mgr.max_health
        new_hp = int(self.get_health_bonus_from_stamina(self.unit_mgr.class_, total_stamina) + total_health)

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_UNIT:
            # Creature health already includes bonus from base stamina.
            new_hp -= int(self.get_health_bonus_from_stamina(self.unit_mgr.class_,
                                                             self.get_base_stat(UnitStats.STAMINA)))

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
        new_mana = int(self.get_mana_bonus_from_intellect(self.unit_mgr.class_, total_intellect) + total_mana)

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_UNIT:
            # Creature mana already includes bonus from base intellect.
            new_mana -= int(self.get_mana_bonus_from_intellect(self.unit_mgr.class_,
                                                               self.get_base_stat(UnitStats.INTELLECT)))

        mana_diff = new_mana - current_total_mana
        if new_mana > 0:
            # Update current mana if the new total value is lower and mana is currently greater than the new total.
            if current_mana > new_mana < current_total_mana:
                self.unit_mgr.set_power_value(new_mana)
            self.unit_mgr.set_max_mana(new_mana)

        return max(0, mana_diff)

    def update_base_health_regen(self):
        unit_class = self.unit_mgr.class_
        spirit = self.get_total_stat(UnitStats.SPIRIT)
        spirit_regen = int(CLASS_BASE_REGEN_HEALTH[unit_class] + spirit * CLASS_SPIRIT_SCALING_HP5[unit_class])
        # Values for spirit regen scaling are per tick.
        self.base_stats[UnitStats.HEALTH_REGENERATION_PER_5] = max(0, spirit_regen) * 2.5

    def update_base_mana_regen(self):
        unit_class = self.unit_mgr.class_
        if unit_class not in CLASS_SPIRIT_SCALING_MANA:
            return

        spirit = self.get_total_stat(UnitStats.SPIRIT)
        regen = CLASS_BASE_REGEN_MANA[unit_class] + spirit * CLASS_SPIRIT_SCALING_MANA[unit_class]
        # Values for mana regen scaling are per second.
        self.base_stats[UnitStats.MANA_REGENERATION_PER_5] = regen * 2.5  # Values are per tick (* 5/2).

    def update_base_melee_critical_chance(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        player_class = self.unit_mgr.class_
        strength = self.get_total_stat(UnitStats.STRENGTH)
        scaling = CLASS_STRENGTH_SCALING_CRITICAL[player_class]
        class_rate = (scaling[0] * (60 - self.unit_mgr.level) +
                      scaling[1] * (self.unit_mgr.level - 1)) / 59
        critical_bonus = strength / class_rate / 100
        self.base_stats[UnitStats.MELEE_CRITICAL] = critical_bonus

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

    def get_daze_chance_against_self(self, attacker):
        # 1% chance increase per level difference from base 20%, from VMaNGOS.
        # Resistance will lower this by approximately 1% per 5 skill difference (1 level).
        return min(0.4, 0.2 - 0.002 * self._get_combat_rating_difference(attacker.level))

    def get_attack_result_against_self(self, attacker, attack_type,
                                       dual_wield_penalty=0.0, allow_parry=True,
                                       allow_crit=True, combat_rating=-1) -> HitInfo:
        # TODO Based on vanilla calculations.
        # Evading/Sanctuary.
        if self.unit_mgr.is_evading or self.unit_mgr.unit_state & UnitStates.SANCTUARY:
            return HitInfo.MISS

        # Immunity.
        if self.unit_mgr.has_damage_immunity(SpellSchools.SPELL_SCHOOL_NORMAL):
            return HitInfo.ABSORBED

        if combat_rating == -1:
            combat_rating = attacker.stat_manager.get_combat_rating_for_attack(attack_type=attack_type)

        rating_difference = self._get_combat_rating_difference(attacker.level, combat_rating)

        base_miss = 0.05 + dual_wield_penalty
        miss_chance = base_miss
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # 0.04% Bonus against players when the defender has a higher combat rating,
            # 0.02% Penalty when the attacker has a higher combat rating.
            miss_chance += rating_difference * 0.0004 if rating_difference > 0 else rating_difference * 0.0002
        else:
            #  2% + 0.4% if defense rating is >10 points higher than attack rating, otherwise 0.1%.
            miss_chance += rating_difference * 0.001 if rating_difference <= 10 else \
                0.02 + (rating_difference - 10) * 0.004

        hit_chance_mod = attacker.stat_manager.get_total_stat(UnitStats.HIT_CHANCE, accept_negative=True,
                                                              accept_float=True)
        if hit_chance_mod:
            miss_chance -= hit_chance_mod

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
            return HitInfo.DODGE | HitInfo.SUCCESS

        if allow_parry:
            parry_chance = self.get_total_stat(UnitStats.PARRY_CHANCE, accept_float=True) + rating_difference * 0.0004
            roll = random.random()
            if self.unit_mgr.can_parry(attacker.location) and roll < parry_chance:
                return HitInfo.PARRY | HitInfo.SUCCESS

        rating_difference_block = self._get_combat_rating_difference(attacker.level, combat_rating,
                                                                     use_block=self.unit_mgr.can_block())

        block_chance = self.get_total_stat(UnitStats.BLOCK_CHANCE, accept_float=True) + rating_difference_block * 0.0004
        roll = random.random()
        if self.unit_mgr.can_block(attacker.location) and roll < block_chance:
            return HitInfo.BLOCK | HitInfo.SUCCESS

        if allow_crit:
            critical_chance = self._get_base_crit_chance_against_self(attacker, attack_type)
        else:
            critical_chance = 0

        hit_info = HitInfo.SUCCESS
        if attack_type == AttackTypes.OFFHAND_ATTACK:
            hit_info |= HitInfo.OFFHAND
        if random.random() < critical_chance:
            hit_info |= HitInfo.CRITICAL_HIT
        
        return hit_info

    @staticmethod
    def _get_attack_weapon(attacker, attack_type):
        # Bear and cat form attacks don't use a weapon, and instead have max attack rating.
        if attacker.is_in_feral_form():
            return None

        attack_weapon = attacker.get_current_weapon_for_attack_type(attack_type)
        return attack_weapon

    def get_combat_rating_for_attack(self, attack_type=-1, casting_spell=None):
        skill_value = -1

        # Prioritize spell combat rating.
        if casting_spell and self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            _, skill, _ = self.unit_mgr.skill_manager.get_skill_info_for_spell_id(casting_spell.spell_entry.ID)
            if not skill and casting_spell.triggered_by_spell:
                trigger_spell_id = casting_spell.triggered_by_spell.spell_entry.ID
                # If this spell was triggered by another spell, use the triggering spell's skill.
                _, skill, _ = self.unit_mgr.skill_manager.get_skill_info_for_spell_id(trigger_spell_id)
            # Use skill level if a valid one exists for the spell.
            skill_value = self.unit_mgr.skill_manager.get_total_skill_value(skill.ID) if \
                skill and skill.CategoryID in [SkillCategories.CLASS_SKILL, SkillCategories.COMBAT_SKILL] else -1

        # If attack type is provided and no skill could be resolved by spellcast, resolve off weapon skill.
        if attack_type != -1 and skill_value == -1:
            attack_weapon = self._get_attack_weapon(self.unit_mgr, attack_type)
            if attack_weapon:
                skill_id = self.unit_mgr.skill_manager.get_skill_id_for_weapon(attack_weapon.item_template)
                skill_value = self.unit_mgr.skill_manager.get_total_skill_value(skill_id)
            else:
                skill_value = -1

        # Fall back to max rating if no skill was found.
        return skill_value if skill_value != -1 else self.unit_mgr.level * 5

    def _get_base_crit_chance_against_self(self, attacker, attack_type):
        attack_weapon = self._get_attack_weapon(attacker, attack_type)
        attacker_weapon_mask = 1 << attack_weapon.item_template.subclass if attack_weapon else -1

        attacker_critical_chance = attacker.stat_manager.get_total_stat(UnitStats.MELEE_CRITICAL, accept_float=True,
                                                                        misc_value=attacker_weapon_mask,
                                                                        misc_value_is_mask=attacker_weapon_mask != -1)
        if attack_weapon:
            skill_id = attacker.skill_manager.get_skill_id_for_weapon(attack_weapon.item_template)
            attack_rating = attacker.skill_manager.get_total_skill_value(skill_id)
        else:
            attack_rating = -1

        rating_difference = self._get_combat_rating_difference(attacker.level, attack_rating)

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Player: +- 0.04% for each rating difference.
            # For example with defender player level 60 and attacker mob level 63:
            # 5% - (300-315) * 0.04 = 5.6% crit chance (mob).
            return attacker_critical_chance - rating_difference * 0.0004
        else:
            # Mob: +- 0.2% for each rating difference OR 0.04% if attacker weapon skill is higher than mob defense.
            # For example with defender mob level 63 and attacker player level 60 (assuming player has 10% crit chance):
            # 10% - (315-300) * 0.2 = 7% crit chance (player).
            multiplier = 0.002 if rating_difference > 0 else 0.0004
            return attacker_critical_chance - rating_difference * multiplier

    def get_spell_miss_result_against_self(self, casting_spell) -> (SpellMissReason, SpellHitFlags):
        hit_flags = SpellHitFlags.NONE

        # Evading.
        if self.unit_mgr.is_evading:
            return SpellMissReason.MISS_REASON_EVADED, hit_flags

        spell_school = casting_spell.get_damage_school()
        is_special_damage = spell_school != SpellSchools.SPELL_SCHOOL_NORMAL
        spell_crit_chance = 0
        spell_school = casting_spell.spell_entry.School

        caster = casting_spell.spell_caster

        if casting_spell.is_target_immune_to_effects():
            return SpellMissReason.MISS_REASON_IMMUNE, hit_flags

        # Spells cast on friendly targets should always hit.
        if not caster.can_attack_target(self.unit_mgr) or \
                any([not effect.can_miss() for effect in casting_spell.get_effects()]):
            return SpellMissReason.MISS_REASON_NONE, hit_flags

        # Damage immunity/Sanctuary.
        if self.unit_mgr.unit_state & UnitStates.SANCTUARY or \
                self.unit_mgr.has_damage_immunity(spell_school, casting_spell=casting_spell):
            return SpellMissReason.MISS_REASON_IMMUNE, hit_flags

        is_base_attack_spell = casting_spell.casts_on_swing() or casting_spell.is_ranged_weapon_attack()

        attack_type = casting_spell.get_attack_type() if is_base_attack_spell else -1

        # Spell skill will be prioritized for combat rating if available.
        #   TODO This could use a combination of weapon and spell skill instead.
        attacker_combat_rating = caster.stat_manager.get_combat_rating_for_attack(attack_type=attack_type,
                                                                                  casting_spell=casting_spell)
        if is_base_attack_spell:
            # Use base attack formulas for next melee swing and ranged spells.
            # Note that dual wield penalty is not applied to spells.
            # Ranged attacks can't be parried. Crit is rolled later for special damage (non-normal school) spells.
            result_info = self.get_attack_result_against_self(caster, casting_spell.get_attack_type(),
                                                              allow_parry=not casting_spell.is_ranged_weapon_attack(),
                                                              allow_crit=not is_special_damage,
                                                              combat_rating=attacker_combat_rating)
            if result_info & HitInfo.CRITICAL_HIT:
                hit_flags |= SpellHitFlags.CRIT

            if result_info & HitInfo.PARRY:
                miss_reason = SpellMissReason.MISS_REASON_PARRIED
            elif result_info & HitInfo.DODGE:
                miss_reason = SpellMissReason.MISS_REASON_DODGED
            elif result_info & HitInfo.BLOCK:
                miss_reason = SpellMissReason.MISS_REASON_BLOCKED
            elif result_info & HitInfo.MISS:
                miss_reason = SpellMissReason.MISS_REASON_PHYSICAL
            else:
                miss_reason = SpellMissReason.MISS_REASON_NONE

            if miss_reason != SpellMissReason.MISS_REASON_NONE or not is_special_damage:
                return miss_reason, hit_flags  # Return if spell missed or resistance/spell crit shouldn't be applied.

            # Weapon attack with non-normal school damage. Account for base crit modifiers from weapon mods/rating.
            spell_crit_chance += self._get_base_crit_chance_against_self(caster, casting_spell.get_attack_type())

        # Add base spell crit and school-specific crit modifiers.
        spell_crit_chance += caster.stat_manager.get_total_stat(UnitStats.SPELL_CRITICAL, accept_float=True)
        spell_crit_chance += caster.stat_manager.get_total_stat(UnitStats.SPELL_SCHOOL_CRITICAL,
                                                                misc_value=spell_school, accept_float=True)
        if random.random() < spell_crit_chance:
            hit_flags |= SpellHitFlags.CRIT

        miss_chance = self.get_spell_resist_chance_against_self(casting_spell)

        roll = random.random()
        if roll < miss_chance:
            return SpellMissReason.MISS_REASON_RESIST, hit_flags

        return SpellMissReason.MISS_REASON_NONE, hit_flags

    def get_spell_resist_chance_against_self(self, casting_spell):
        # TODO Research is needed on how resist mechanics worked in alpha.
        # 0.7 patch notes:
        # "Players and some creatures now have the ability to resist damage from offensive spells and abilities
        # based on their total resistance, their level and the level of the person or creature causing the damage."
        # Assuming based on this that partial resistance didn't exist.

        # The below formulas are guesses. They're based on both partial and full resist formulas from VMaNGOS,
        # applied in a way that seems to make sense for our use case.

        # Base spell miss chance from SpellCaster::MagicSpellHitChance.
        # Modified to use spell school skill rating instead of unit levels for the attacker.
        caster = casting_spell.spell_caster
        spell_school = casting_spell.spell_entry.School

        is_base_attack_spell = casting_spell.casts_on_swing() or casting_spell.is_ranged_weapon_attack()
        attack_type = casting_spell.get_attack_type() if is_base_attack_spell else -1
        attacker_combat_rating = caster.stat_manager.get_combat_rating_for_attack(attack_type=attack_type,
                                                                                  casting_spell=casting_spell)
        rating_difference = self.unit_mgr.level * 5 - attacker_combat_rating
        rating_mod = rating_difference / 5 / 100

        miss_chance = 0.04
        level_penalty = 7 if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER else 11

        miss_chance += rating_mod if rating_difference < 15 else \
            0.02 + (rating_mod - 0.02) * level_penalty

        # Resistance application.
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER and spell_school != SpellSchools.SPELL_SCHOOL_NORMAL:
            # Use resistance for players.
            # Our values for creatures are most likely wrong for alpha and are not applied.
            resist_mod = self.get_total_stat(UnitStats.RESISTANCE_START << spell_school)
        else:
            # Calculate resistance for creatures.
            # This is the formula for innate resistance used for partial resists in VMaNGOS,
            # with level adjusted 63->28.
            # (SpellCaster::GetSpellResistChance)
            resist_mod = (8 * rating_difference * attacker_combat_rating) / 5 / 28

        resist_mod *= 0.15 / (attacker_combat_rating / 5)
        resist_mod = max(0.0, min(0.75, resist_mod))

        # Final application of resist mod (SpellCaster::MagicSpellHitChance, reversed for hit->miss).
        if resist_mod:
            miss_chance = 1 - (1 - miss_chance) * (1 - resist_mod)

        return miss_chance

    def update_attack_base_damage(self, attack_type=0):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            base_stats, base_dmg, base_ranged_dmg = self._get_creature_base_stats()
            self._set_creature_base_damage(base_dmg[0], base_dmg[1], AttackTypes.BASE_ATTACK)
            self._set_creature_base_damage(base_ranged_dmg[0], base_ranged_dmg[1], AttackTypes.RANGED_ATTACK)
            return

        base_damage = self.get_attack_power_from_attributes() / 14
        if attack_type == AttackTypes.BASE_ATTACK:
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = base_damage
            self.base_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = base_damage
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            self.base_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = base_damage * 0.5  # Dual wield penalty.
            self.base_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = base_damage * 0.5
        else:
            self.base_stats[UnitStats.RANGED_DAMAGE_MIN] = base_damage
            self.base_stats[UnitStats.RANGED_DAMAGE_MAX] = base_damage

    def get_attack_power_from_attributes(self):
        # TODO: Using Vanilla formulas.

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

        # Creatures have base attack power which includes gain from base stats.
        base_attack_power = self.get_base_stat(UnitStats.ATTACK_POWER)
        return max(attack_power - base_attack_power, 0)

    def update_defense_bonuses(self):
        self.update_base_dodge_chance()
        self.update_base_block_chance()

    def send_melee_attributes(self):
        enchant_bonus = 0
        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
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
        for i in range(0, 6):
            self.unit_mgr.set_resistance(i, *self._get_total_and_item_stat_bonus(UnitStats.RESISTANCE_START << i))
            self.unit_mgr.set_resistance_mods(i, *self._get_positive_negative_bonus(UnitStats.RESISTANCE_START << i))

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

    def send_cast_time_mods(self):
        if self.unit_mgr.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return
        self.unit_mgr.set_float(UnitFields.UNIT_MOD_CAST_SPEED,
                                self.get_total_stat(UnitStats.SPELL_CASTING_SPEED, accept_float=True) * 100)

    # Arguments greater than 0 if defense is higher.
    def _get_combat_rating_difference(self, attacker_level=-1, attacker_rating=-1, use_block=False):
        # Client displays percentages against enemies of equal level and max attack rating.
        if attacker_level == -1:
            attacker_level = self.unit_mgr.level
        if attacker_rating == -1:
            attacker_rating = attacker_level * 5

        if self.unit_mgr.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # TODO It's unclear what the block skill is used for based on patch notes.
            # Use Shields/Block or Defense, depending on the class.
            own_defense_rating = self.unit_mgr.skill_manager.get_defense_skill_value(use_block=use_block)
        else:
            own_defense_rating = self.unit_mgr.level * 5

        return own_defense_rating - attacker_rating

    @staticmethod
    def get_health_bonus_from_stamina(class_, stamina):
        # The first 20 points of Stamina grant 1 health point per unit.
        base_sta = stamina if stamina < 20 else 20
        more_sta = stamina - base_sta
        return base_sta + (more_sta * CLASS_STAMINA_GAIN[class_])

    @staticmethod
    def get_mana_bonus_from_intellect(class_, intellect):
        # The first 20 points of Intellect grant 2 mana point per unit.
        base_int = intellect if intellect < 20 else 20
        more_int = intellect - base_int
        return (base_int * 2) + (more_int * CLASS_INTELLECT_GAIN[class_])


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

# From VMaNGOS.
CLASS_BASE_DODGE = {
    Classes.CLASS_DRUID: 0.9,
    Classes.CLASS_MAGE: 3.2,
    Classes.CLASS_PALADIN: 0.7,
    Classes.CLASS_PRIEST: 3.0,
    Classes.CLASS_SHAMAN: 1.7,
    Classes.CLASS_WARLOCK: 2.0
}

# See https://github.com/The-Alpha-Project/alpha-core/issues/1147 for reasoning and proof.
CLASS_STAMINA_GAIN = {
    Classes.CLASS_WARRIOR: 20.0,
    Classes.CLASS_PALADIN: 18.0,
    Classes.CLASS_HUNTER: 16.0,
    Classes.CLASS_ROGUE: 16.0,
    Classes.CLASS_PRIEST: 14.0,
    Classes.CLASS_SHAMAN: 16.0,
    Classes.CLASS_MAGE: 14.0,
    Classes.CLASS_WARLOCK: 16.0,
    Classes.CLASS_DRUID: 16.0
}

# See https://github.com/The-Alpha-Project/alpha-core/issues/1319 for reasoning and proof.
CLASS_INTELLECT_GAIN = {
    Classes.CLASS_WARRIOR: 0.0,
    Classes.CLASS_PALADIN: 16.0,
    Classes.CLASS_HUNTER: 0.0,
    Classes.CLASS_ROGUE: 0.0,
    Classes.CLASS_PRIEST: 20.0,
    Classes.CLASS_SHAMAN: 18.0,
    Classes.CLASS_MAGE: 20.0,
    Classes.CLASS_WARLOCK: 20.0,
    Classes.CLASS_DRUID: 18.0
}

# VMaNGOS (level 1, level 60).
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

NON_STACKING_STATS = {
    UnitStats.SPELL_CASTING_SPEED
}
