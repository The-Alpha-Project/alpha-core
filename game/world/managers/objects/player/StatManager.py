from enum import IntEnum, auto

from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats, InventoryTypes, ItemSubClasses
from utils.constants.UnitCodes import PowerTypes, Classes


# Stats that are modified aura effects. Used in StatManager and when accessing stats.
# Use auto indexing to make expanding much easier.
class UnitStats(IntEnum):
    ALL_ATTRIBUTES = -1
    STRENGTH = auto()
    AGILITY = auto()
    STAMINA = auto()
    INTELLECT = auto()
    SPIRIT = auto()
    HEALTH = auto()
    MANA = auto()
    ENERGY = auto()

    ALL_RESISTANCES = auto()
    RESISTANCE_PHYSICAL = auto()  # Armor
    RESISTANCE_HOLY = auto()
    RESISTANCE_FIRE = auto()
    RESISTANCE_NATURE = auto()
    RESISTANCE_FROST = auto()
    RESISTANCE_SHADOW = auto()

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
    DAMAGE_TAKEN = auto()
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

    # Skill type in misc value
    SKILL = auto()



    ATTRIBUTE_START = STRENGTH
    ATTRIBUTE_END = HEALTH
    RESISTANCE_START = RESISTANCE_PHYSICAL
    RESISTANCE_END = PARRY


class StatManager(object):

    base_stats: dict[UnitStats, int]
    item_stats: dict[UnitStats, int]

    # Managed by AuraManager. [Aura index, (Stat, bonus, misc value)]
    # Misc value can contain power/weapon/creature type etc. depending on the stat
    aura_stats_flat: dict[int, (UnitStats, int, int)]
    aura_stats_percentual: dict[int, (UnitStats, float, int, int)]

    def __init__(self, player_mgr):
        self.player_mgr = player_mgr

        self.melee_damage = [0] * 2
        self.melee_attack_time = config.Unit.Defaults.base_attack_time
        self.offhand_attack_time = config.Unit.Defaults.offhand_attack_time
        self.weapon_reach = 0

        self.base_stats = {}
        self.item_stats = {}

        self.aura_stats_flat = {}
        self.aura_stats_percentual = {}

    def init_stats(self):
        base_stats = WorldDatabaseManager.player_get_class_level_stats(self.player_mgr.player.class_,
                                                                       self.player_mgr.level)
        base_attrs = WorldDatabaseManager.player_get_level_stats(self.player_mgr.player.class_,
                                                                 self.player_mgr.level,
                                                                 self.player_mgr.player.race)

        if not base_stats or not base_attrs:
            Logger.error(f'Unsupported level ({self.player_mgr.level}) from {self.player_mgr.player.name}.')
            return

        self.base_stats[UnitStats.HEALTH] = base_stats.basehp
        self.base_stats[UnitStats.MANA] = base_stats.basemana
        self.base_stats[UnitStats.STRENGTH] = base_attrs.str
        self.base_stats[UnitStats.AGILITY] = base_attrs.agi
        self.base_stats[UnitStats.STAMINA] = base_attrs.sta
        self.base_stats[UnitStats.INTELLECT] = base_attrs.inte
        self.base_stats[UnitStats.SPIRIT] = base_attrs.spi

        self.player_mgr.base_hp = base_stats.basehp
        self.player_mgr.base_mana = base_stats.basemana

        self.player_mgr.set_base_str(base_attrs.str)
        self.player_mgr.set_base_agi(base_attrs.agi)
        self.player_mgr.set_base_sta(base_attrs.sta)
        self.player_mgr.set_base_int(base_attrs.inte)
        self.player_mgr.set_base_spi(base_attrs.spi)

        self.base_stats[UnitStats.SPEED_RUNNING] = config.Unit.Defaults.run_speed

        self.update_base_health_regen()
        self.update_base_mana_regen()

    def get_total_stat(self, stat_type: UnitStats):
        base_stats = self.base_stats.get(stat_type, 0)
        bonus_stats = self.item_stats.get(stat_type, 0) + self.get_aura_stat_bonus(stat_type)

        return (base_stats + bonus_stats) * self.get_aura_stat_bonus(stat_type, percentual=True)

    def apply_bonuses(self):
        self.calculate_item_stats()

        self.player_mgr.set_str(self.get_total_stat(UnitStats.STRENGTH))
        self.player_mgr.set_agi(self.get_total_stat(UnitStats.AGILITY))
        self.player_mgr.set_sta(self.get_total_stat(UnitStats.STAMINA))
        self.player_mgr.set_int(self.get_total_stat(UnitStats.INTELLECT))
        self.player_mgr.set_spi(self.get_total_stat(UnitStats.SPIRIT))

        self.player_mgr.change_speed(self.get_total_stat(UnitStats.SPEED_RUNNING))

        hp_diff = self.update_max_health()
        mana_diff = self.update_max_mana()
        self.update_resistances()
        self.update_melee_attributes()
        self.update_base_mana_regen()
        self.update_base_health_regen()

        return hp_diff, mana_diff

    def apply_bonuses_for_value(self, value: int, stat_type: UnitStats, misc_value=0):
        flat = self.get_aura_stat_bonus(stat_type, misc_value=misc_value)
        percentual = self.get_aura_stat_bonus(stat_type, percentual=True, misc_value=misc_value)
        return (value + flat) * percentual

    def apply_aura_stat_bonus(self, index: int, stat_type: UnitStats, amount: int, misc_value=0, percentual=False):
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

    def get_aura_stat_bonus(self, stat_type: UnitStats, percentual=False, misc_value=-1):
        if percentual:
            target_bonuses = self.aura_stats_percentual
            bonus = 1
        else:
            target_bonuses = self.aura_stats_flat
            bonus = 0

        for stat_bonus in target_bonuses.values():
            if stat_bonus[0] == UnitStats.ALL_ATTRIBUTES and stat_type not in range(UnitStats.ATTRIBUTE_START, UnitStats.ATTRIBUTE_END):
                continue
            if stat_bonus[0] == UnitStats.ALL_RESISTANCES and stat_type not in range(UnitStats.RESISTANCE_START, UnitStats.RESISTANCE_END):
                continue

            if stat_bonus[0] != stat_type and stat_bonus[0] != UnitStats.ALL_ATTRIBUTES and stat_bonus[0] != UnitStats.ALL_RESISTANCES:
                # Stat bonus doesn't match
                # If the bonus is for all attributes, continue if the requested stat type isn't an attribute
                continue

            if misc_value != -1 and stat_bonus[2] != misc_value:
                continue

            if not percentual:
                bonus += stat_bonus[1]
            else:
                bonus *= stat_bonus[1] / 100 + 1

        return bonus

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

    def calculate_item_stats(self):
        self.melee_damage = [0] * 2
        self.melee_attack_time = config.Unit.Defaults.base_attack_time
        self.offhand_attack_time = config.Unit.Defaults.offhand_attack_time
        self.weapon_reach = 0

        self.item_stats = {}  # Clear item stats

        for slot, item in list(self.player_mgr.inventory.get_backpack().sorted_slots.items()):
            # Check only equipped items
            if item.current_slot <= InventorySlots.SLOT_TABARD:
                for stat in item.stats:
                    if stat.stat_type == 0:
                        continue
                    stat_type = INVENTORY_STAT_TO_UNIT_STAT[stat.stat_type]
                    current = self.item_stats.get(stat_type, 0)
                    self.item_stats[stat_type] = current + stat.value

                self.item_stats[UnitStats.RESISTANCE_PHYSICAL] = item.item_template.armor
                self.item_stats[UnitStats.RESISTANCE_HOLY] = item.item_template.holy_res
                self.item_stats[UnitStats.RESISTANCE_FIRE] = item.item_template.fire_res
                self.item_stats[UnitStats.RESISTANCE_NATURE] = item.item_template.nature_res
                self.item_stats[UnitStats.RESISTANCE_FROST] = item.item_template.frost_res
                self.item_stats[UnitStats.RESISTANCE_SHADOW] = item.item_template.shadow_res
                self.item_stats[UnitStats.BLOCK] = item.item_template.block

                if item.current_slot == InventorySlots.SLOT_MAINHAND:
                    self.melee_damage[0] = int(item.item_template.dmg_min1)
                    self.melee_damage[1] = int(item.item_template.dmg_max1)
                    self.melee_attack_time = item.item_template.delay

                    # This is a TOTAL guess, I have no idea about real weapon reach values.
                    # The weapon reach unit field was removed in patch 0.10.
                    if item.item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON:
                        self.weapon_reach = 1.5
                    elif item.item_template.subclass == ItemSubClasses.ITEM_SUBCLASS_DAGGER:
                        self.weapon_reach = 0.5
                    elif item.item_template.subclass != ItemSubClasses.ITEM_SUBCLASS_FIST_WEAPON:
                        self.weapon_reach = 1.0

                if item.current_slot == InventorySlots.SLOT_OFFHAND:
                    self.offhand_attack_time = item.item_template.delay

    def update_max_health(self):
        total_stamina = self.get_total_stat(UnitStats.STAMINA)
        total_health = self.get_total_stat(UnitStats.HEALTH)

        current_hp = self.player_mgr.max_health
        new_hp = int(self.get_health_bonus_from_stamina(total_stamina) + total_health)
        self.player_mgr.set_max_health(new_hp)

        hp_diff = new_hp - current_hp

        return hp_diff if hp_diff > 0 else 0

    def update_max_mana(self):
        if self.player_mgr.power_type != PowerTypes.TYPE_MANA:
            return 0

        total_intellect = self.get_total_stat(UnitStats.INTELLECT)
        total_mana = self.get_total_stat(UnitStats.MANA)

        current_mana = self.player_mgr.max_power_1
        new_mana = int(self.get_mana_bonus_from_intellect(total_intellect) + total_mana)
        self.player_mgr.set_max_mana(new_mana)

        mana_diff = new_mana - current_mana

        return mana_diff if mana_diff > 0 else 0

    def update_resistances(self):
        self.player_mgr.set_armor(self.get_total_stat(UnitStats.RESISTANCE_PHYSICAL))
        self.player_mgr.set_holy_res(self.get_total_stat(UnitStats.RESISTANCE_HOLY))
        self.player_mgr.set_fire_res(self.get_total_stat(UnitStats.RESISTANCE_FIRE))
        self.player_mgr.set_nature_res(self.get_total_stat(UnitStats.RESISTANCE_NATURE))
        self.player_mgr.set_frost_res(self.get_total_stat(UnitStats.RESISTANCE_FROST))
        self.player_mgr.set_shadow_res(self.get_total_stat(UnitStats.RESISTANCE_SHADOW))

    def update_base_health_regen(self):
        player_class = self.player_mgr.player.class_
        class_spirit_scaling = {
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
        class_base_regen = {
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

        spirit = self.get_total_stat(UnitStats.SPIRIT)
        self.base_stats[UnitStats.HEALTH_REGENERATION_PER_5] = class_base_regen[player_class] + spirit * class_spirit_scaling[player_class]


    def update_base_mana_regen(self):
        player_class = self.player_mgr.player.class_
        class_spirit_scaling = {
            Classes.CLASS_WARRIOR: 0.0,
            Classes.CLASS_PALADIN: 0.20,
            Classes.CLASS_HUNTER: 0.0,
            Classes.CLASS_ROGUE: 0.0,
            Classes.CLASS_PRIEST: 0.25,
            Classes.CLASS_SHAMAN: 0.20,
            Classes.CLASS_MAGE: 0.25,
            Classes.CLASS_WARLOCK: 0.2,
            Classes.CLASS_DRUID: 0.2
        }
        class_base_regen = {
            Classes.CLASS_WARRIOR: -22.6,
            Classes.CLASS_PALADIN: 15.0,
            Classes.CLASS_HUNTER: 12.5,
            Classes.CLASS_ROGUE: -13.0,
            Classes.CLASS_PRIEST: 12.5,
            Classes.CLASS_SHAMAN: 17.0,
            Classes.CLASS_MAGE: 12.5,
            Classes.CLASS_WARLOCK: 15.0,
            Classes.CLASS_DRUID: 15.0
        }

        spirit = self.get_total_stat(UnitStats.SPIRIT)
        regen = class_base_regen[player_class] + spirit * class_spirit_scaling[player_class]
        self.base_stats[UnitStats.POWER_REGENERATION_PER_5] = regen / 2


    def update_defense_bonuses(self):
        pass

    def update_melee_attributes(self):
        self.player_mgr.set_melee_damage(self.melee_damage[0], self.melee_damage[1])
        self.player_mgr.set_melee_attack_time(self.melee_attack_time)
        self.player_mgr.set_offhand_attack_time(self.offhand_attack_time)
        self.player_mgr.set_weapon_reach(self.weapon_reach)


INVENTORY_STAT_TO_UNIT_STAT = {
    InventoryStats.MANA: UnitStats.MANA,
    InventoryStats.HEALTH: UnitStats.HEALTH,
    InventoryStats.AGILITY: UnitStats.AGILITY,
    InventoryStats.STRENGTH: UnitStats.STRENGTH,
    InventoryStats.INTELLECT: UnitStats.INTELLECT,
    InventoryStats.SPIRIT: UnitStats.SPIRIT,
    InventoryStats.STAMINA: UnitStats.STAMINA
}