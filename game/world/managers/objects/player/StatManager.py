from enum import IntEnum, auto, IntFlag
from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats, InventoryTypes, ItemSubClasses
from utils.constants.MiscCodes import AttackTypes, ObjectTypes
from utils.constants.SpellCodes import SpellSchools
from utils.constants.UnitCodes import PowerTypes, Classes, CreatureTypes


# Stats that are modified aura effects. Used in StatManager and when accessing stats.
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

    PARRY = auto()
    DODGE = auto()
    BLOCK = auto()

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
    THREAT = auto()
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

    # Player base stats and misc. stats scaling off items (weapon damage etc.)
    base_stats: dict[UnitStats, int]

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
        if self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER:
            base_stats = WorldDatabaseManager.player_get_class_level_stats(self.unit_mgr.player.class_,
                                                                           self.unit_mgr.level)
            base_attrs = WorldDatabaseManager.player_get_level_stats(self.unit_mgr.player.class_,
                                                                     self.unit_mgr.level,
                                                                     self.unit_mgr.player.race)
            if not base_stats or not base_attrs:
                Logger.error(f'Unsupported level ({self.unit_mgr.level}) from {self.unit_mgr.player.name}.')
                return
            self.base_stats[UnitStats.HEALTH] = base_stats.basehp
            self.base_stats[UnitStats.MANA] = base_stats.basemana
            self.base_stats[UnitStats.STRENGTH] = base_attrs.str
            self.base_stats[UnitStats.AGILITY] = base_attrs.agi
            self.base_stats[UnitStats.STAMINA] = base_attrs.sta
            self.base_stats[UnitStats.INTELLECT] = base_attrs.inte
            self.base_stats[UnitStats.SPIRIT] = base_attrs.spi
            self.base_stats[UnitStats.SPEED_RUNNING] = config.Unit.Defaults.run_speed

            self.unit_mgr.base_hp = base_stats.basehp
            self.unit_mgr.base_mana = base_stats.basemana
        else:
            # Creature
            self.base_stats[UnitStats.HEALTH] = self.unit_mgr.max_health
            self.base_stats[UnitStats.MANA] = self.unit_mgr.max_power_1
            self.base_stats[UnitStats.SPEED_RUNNING] = self.unit_mgr.running_speed

        self.send_attributes()

        self.update_base_health_regen()
        self.update_base_mana_regen()

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

    def get_total_stat(self, stat_type: UnitStats, misc_value=-1, accept_negative=False, misc_value_is_mask=False) -> int:
        base_stats = self.get_base_stat(stat_type)
        bonus_stats = self.item_stats.get(stat_type, 0) + \
            self.get_aura_stat_bonus(stat_type, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)

        total = int((base_stats + bonus_stats) *
                    self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask))

        if accept_negative:
            return total

        return max(0, total)  # Stats are always positive

    def apply_bonuses(self):
        self.calculate_item_stats()

        # Always update base attack since unarmed damage should update.
        self.update_base_weapon_attributes(attack_type=AttackTypes.BASE_ATTACK)

        if self.unit_mgr.has_offhand_weapon():
            self.update_base_weapon_attributes(attack_type=AttackTypes.OFFHAND_ATTACK)
        if self.unit_mgr.has_ranged_weapon():  # TODO Are ranged formulas different?
            self.update_base_weapon_attributes(attack_type=AttackTypes.RANGED_ATTACK)

        self.unit_mgr.change_speed(self.get_total_stat(UnitStats.SPEED_RUNNING))

        hp_diff = self.update_max_health()
        mana_diff = self.update_max_mana()

        self.update_base_mana_regen()
        self.update_base_health_regen()

        self.send_attributes()
        self.send_melee_attributes()
        self.send_damage_bonuses()
        self.send_resistances()

        if self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER:
            self.unit_mgr.skill_manager.build_update()
        self.unit_mgr.set_dirty()

        return hp_diff, mana_diff

    def apply_bonuses_for_value(self, value: int, stat_type: UnitStats, misc_value=-1, misc_value_is_mask=False):
        flat = self.get_aura_stat_bonus(stat_type, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)
        percentual = self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value, misc_value_is_mask=misc_value_is_mask)
        return int((value + flat) * percentual)

    def apply_aura_stat_bonus(self, index: int, stat_type: UnitStats, amount: int, misc_value=-1, percentual=False):
        if percentual:
            self.aura_stats_percentual[index] = (stat_type, amount, misc_value)
        else:
            self.aura_stats_flat[index] = (stat_type, amount, misc_value)

        self.apply_bonuses()

    def remove_aura_stat_bonus(self, index: int, percentual=False):
        if percentual:
            self.aura_stats_percentual.pop(index)
        else:
            self.aura_stats_flat.pop(index)

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
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            self.weapon_reach = self.unit_mgr.weapon_reach
            min_damage, max_damage = unpack('<2H', pack('<I', self.unit_mgr.damage))
            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = min_damage
            self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = max_damage
            self.item_stats[UnitStats.MAIN_HAND_DELAY] = self.unit_mgr.base_attack_time
            return

        self.item_stats = {UnitStats.MAIN_HAND_DELAY: config.Unit.Defaults.base_attack_time,
                           UnitStats.OFF_HAND_DELAY: config.Unit.Defaults.offhand_attack_time}  # Clear item stats
        self.weapon_reach = 0

        for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
            # Check only equipped items
            if item.current_slot <= InventorySlots.SLOT_TABARD:
                for stat in item.stats:
                    if stat.value == 0:
                        continue
                    stat_type = INVENTORY_STAT_TO_UNIT_STAT[stat.stat_type]
                    current = self.item_stats.get(stat_type, 0)
                    self.item_stats[stat_type] = current + stat.value

                # Add resistances/block
                separate_stats = {UnitStats.RESISTANCE_PHYSICAL: item.item_template.armor,
                                  UnitStats.RESISTANCE_HOLY: item.item_template.holy_res,
                                  UnitStats.RESISTANCE_FIRE: item.item_template.fire_res,
                                  UnitStats.RESISTANCE_NATURE: item.item_template.nature_res,
                                  UnitStats.RESISTANCE_FROST: item.item_template.frost_res,
                                  UnitStats.RESISTANCE_SHADOW: item.item_template.shadow_res,
                                  UnitStats.BLOCK: item.item_template.block}
                for stat, value in separate_stats.items():
                    self.item_stats[stat] = self.item_stats.get(stat, 0) + value

                weapon_min_damage = int(item.item_template.dmg_min1)
                weapon_max_damage = int(item.item_template.dmg_max1)
                weapon_delay = item.item_template.delay

                if item.current_slot == InventorySlots.SLOT_MAINHAND:
                    self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MIN] = weapon_min_damage
                    self.item_stats[UnitStats.MAIN_HAND_DAMAGE_MAX] = weapon_max_damage
                    self.item_stats[UnitStats.MAIN_HAND_DELAY] = weapon_delay
                elif item.current_slot == InventorySlots.SLOT_OFFHAND:
                    dual_wield_penalty = 0.5
                    self.item_stats[UnitStats.OFF_HAND_DAMAGE_MIN] = int(weapon_min_damage * dual_wield_penalty)
                    self.item_stats[UnitStats.OFF_HAND_DAMAGE_MAX] = int(weapon_max_damage * dual_wield_penalty)
                    self.item_stats[UnitStats.OFF_HAND_DELAY] = weapon_delay
                elif item.current_slot == InventorySlots.SLOT_RANGED:
                    self.item_stats[UnitStats.RANGED_DAMAGE_MIN] = weapon_min_damage
                    self.item_stats[UnitStats.RANGED_DAMAGE_MAX] = weapon_max_damage
                    self.item_stats[UnitStats.RANGED_DELAY] = weapon_delay

                current_reach = self.weapon_reach
                weapon_reach = StatManager.get_reach_for_weapon(item.item_template)
                if current_reach == -1 or current_reach > weapon_reach:
                    self.weapon_reach = weapon_reach

    # TODO move to formulas?
    @staticmethod
    def get_reach_for_weapon(item_template):
        # This is a TOTAL guess, I have no idea about real weapon reach values.
        # The weapon reach unit field was removed in patch 0.10.
        if item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON:
            return 1.5
        elif item_template.subclass == ItemSubClasses.ITEM_SUBCLASS_DAGGER:
            return 0.5
        elif item_template.subclass != ItemSubClasses.ITEM_SUBCLASS_FIST_WEAPON:
            return 1.0
        return 0

    def update_max_health(self):
        total_stamina = self.get_total_stat(UnitStats.STAMINA)
        total_health = self.get_total_stat(UnitStats.HEALTH)

        current_hp = self.unit_mgr.max_health
        new_hp = int(self.get_health_bonus_from_stamina(total_stamina) + total_health)
        self.unit_mgr.set_max_health(new_hp)

        hp_diff = new_hp - current_hp

        return hp_diff if hp_diff > 0 else 0

    def update_max_mana(self):
        if self.unit_mgr.power_type != PowerTypes.TYPE_MANA:
            return 0

        total_intellect = self.get_total_stat(UnitStats.INTELLECT)
        total_mana = self.get_total_stat(UnitStats.MANA)

        current_mana = self.unit_mgr.max_power_1
        new_mana = int(self.get_mana_bonus_from_intellect(total_intellect) + total_mana)
        self.unit_mgr.set_max_mana(new_mana)

        mana_diff = new_mana - current_mana

        return mana_diff if mana_diff > 0 else 0

    def update_base_health_regen(self):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        player_class = self.unit_mgr.player.class_
        spirit = self.get_total_stat(UnitStats.SPIRIT)
        self.base_stats[UnitStats.HEALTH_REGENERATION_PER_5] = int(CLASS_BASE_REGEN_HEALTH[player_class] + spirit * CLASS_SPIRIT_SCALING_HP5[player_class])


    def update_base_mana_regen(self):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        player_class = self.unit_mgr.player.class_
        if player_class not in CLASS_SPIRIT_SCALING_MANA:
            return

        spirit = self.get_total_stat(UnitStats.SPIRIT)
        regen = CLASS_BASE_REGEN_MANA[player_class] + spirit * CLASS_SPIRIT_SCALING_MANA[player_class]
        self.base_stats[UnitStats.POWER_REGENERATION_PER_5] = int(regen / 2)

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

        return weapon_min_damage, weapon_max_damage

    def apply_bonuses_for_damage(self, damage, attack_school: SpellSchools, victim, weapon_type: ItemSubClasses = -1):
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
        # Damage taken reduction can bring damage to negative, limit to 0.
        return max(0, damage_dealt)

    def update_base_weapon_attributes(self, attack_type=0):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        # TODO: Using Vanilla formula, AP was not present in Alpha

        dual_wield_penalty = 1 if attack_type != AttackTypes.OFFHAND_ATTACK else 0.5

        attack_power = 0
        strength = self.get_total_stat(UnitStats.STRENGTH)
        agility = self.get_total_stat(UnitStats.AGILITY)
        level = self.unit_mgr.level
        class_ = self.unit_mgr.player.class_

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
        pass

    def send_melee_attributes(self):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        # For stat sheet
        self.unit_mgr.set_melee_damage(self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MIN),
                                       self.get_total_stat(UnitStats.MAIN_HAND_DAMAGE_MAX))

        self.unit_mgr.set_melee_attack_time(self.get_total_stat(UnitStats.MAIN_HAND_DELAY))
        self.unit_mgr.set_offhand_attack_time(self.get_total_stat(UnitStats.OFF_HAND_DELAY))
        self.unit_mgr.set_weapon_reach(self.weapon_reach)

    def send_resistances(self):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        self.unit_mgr.set_armor(self.get_total_stat(UnitStats.RESISTANCE_PHYSICAL, accept_negative=True))
        self.unit_mgr.set_holy_res(self.get_total_stat(UnitStats.RESISTANCE_HOLY, accept_negative=True))
        self.unit_mgr.set_fire_res(self.get_total_stat(UnitStats.RESISTANCE_FIRE, accept_negative=True))
        self.unit_mgr.set_nature_res(self.get_total_stat(UnitStats.RESISTANCE_NATURE, accept_negative=True))
        self.unit_mgr.set_frost_res(self.get_total_stat(UnitStats.RESISTANCE_FROST, accept_negative=True))
        self.unit_mgr.set_shadow_res(self.get_total_stat(UnitStats.RESISTANCE_SHADOW, accept_negative=True))

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

        item_bonus = self.get_item_stat(stat_type)
        if item_bonus > 0:
            positive += item_bonus
        else:
            negative += item_bonus

        for percentual_bonus in percentual:
            positive *= percentual_bonus
        return negative, positive

    def send_attributes(self):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
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
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return
        main_hand = self.unit_mgr.inventory.get_main_hand()
        subclass_mask = 0
        if main_hand:
            subclass_mask = 1 << main_hand.item_template.subclass

        for school in SpellSchools:
            flat_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, misc_value=school) + \
                self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, misc_value=subclass_mask, misc_value_is_mask=True)

            percentual_bonuses = self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, misc_value=school, percentual=True) * \
                self.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, misc_value=subclass_mask, percentual=True, misc_value_is_mask=True)

            self.unit_mgr.set_bonus_damage_done_for_school(int(flat_bonuses * percentual_bonuses), school)

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

INVENTORY_STAT_TO_UNIT_STAT = {
    InventoryStats.MANA: UnitStats.MANA,
    InventoryStats.HEALTH: UnitStats.HEALTH,
    InventoryStats.AGILITY: UnitStats.AGILITY,
    InventoryStats.STRENGTH: UnitStats.STRENGTH,
    InventoryStats.INTELLECT: UnitStats.INTELLECT,
    InventoryStats.SPIRIT: UnitStats.SPIRIT,
    InventoryStats.STAMINA: UnitStats.STAMINA
}