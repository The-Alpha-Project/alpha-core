from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats, InventoryTypes, ItemSubClasses
from utils.constants.UnitCodes import PowerTypes, UnitStats


class StatManager(object):

    base_stats: dict[UnitStats, int]
    item_stats: dict[UnitStats, int]

    # Managed by AuraManager. [Aura index, (Stat, bonus)]
    aura_stats_flat: dict[int, (UnitStats, int)]
    aura_stats_percentual: dict[int, (UnitStats, float)]

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

        # Regeneration

    def get_total_stat(self, stat_type: UnitStats):
        base_stats = self.base_stats.get(stat_type, 0)
        bonus_stats = self.item_stats.get(stat_type, 0) + self.get_aura_stat_bonus(stat_type, percentual=False)
        return base_stats + bonus_stats * self.get_aura_stat_bonus(stat_type, percentual=True)

    def apply_bonuses(self):
        self.calculate_item_stats()

        self.player_mgr.set_str(self.get_total_stat(UnitStats.STRENGTH))
        self.player_mgr.set_agi(self.get_total_stat(UnitStats.AGILITY))
        self.player_mgr.set_sta(self.get_total_stat(UnitStats.STAMINA))
        self.player_mgr.set_int(self.get_total_stat(UnitStats.INTELLECT))
        self.player_mgr.set_spi(self.get_total_stat(UnitStats.SPIRIT))

        hp_diff = self.update_max_health()
        mana_diff = self.update_max_mana()
        self.update_resistances()
        self.update_melee_attributes()

        return hp_diff, mana_diff

    def apply_aura_stat_bonus(self, index: int, stat_type: UnitStats, amount: int, percentual: bool):
        if percentual:
            self.aura_stats_percentual[index] = (stat_type, amount)
            return
        self.aura_stats_flat[index] = (stat_type, amount)

        self.apply_bonuses()

    def remove_aura_stat_bonus(self, index: int, percentual: bool):
        if percentual:
            self.aura_stats_percentual.pop(index)
            return
        self.aura_stats_flat.pop(index)

        self.apply_bonuses()

    def get_aura_stat_bonus(self, stat_type: UnitStats, percentual: bool):
        if percentual:
            target_bonuses = self.aura_stats_percentual
            bonus = 1
        else:
            target_bonuses = self.aura_stats_flat
            bonus = 0

        for stat_bonus in target_bonuses.values():
            if stat_bonus[0] != stat_type and stat_bonus[0] != UnitStats.ALL_ATTRIBUTES or \
                    (stat_bonus[0] == UnitStats.ALL_ATTRIBUTES and
                     stat_type not in range(UnitStats.ATTRIBUTE_START, UnitStats.ATTRIBUTE_END)):
                # Stat bonus doesn't match
                # If the bonus is for all attributes, continue if the requested stat type isn't an attribute
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
