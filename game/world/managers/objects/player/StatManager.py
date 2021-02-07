from database.world.WorldDatabaseManager import WorldDatabaseManager, config
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, InventoryStats


class StatManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr

        self.itm_hp = 0
        self.itm_mana = 0

        self.itm_str = 0
        self.itm_agi = 0
        self.itm_sta = 0
        self.itm_int = 0
        self.itm_spi = 0

        self.itm_armor = 0
        self.itm_holy = 0
        self.itm_fire = 0
        self.itm_nature = 0
        self.itm_frost = 0
        self.itm_shadow = 0

        self.itm_block = 0

        self.melee_damage = [0] * 2
        self.melee_attack_time = config.Unit.Defaults.base_attack_time

    def init_stats(self):
        base_stats = WorldDatabaseManager.player_get_class_level_stats(self.player_mgr.player.class_,
                                                                       self.player_mgr.level)
        base_attrs = WorldDatabaseManager.player_get_level_stats(self.player_mgr.player.class_,
                                                                 self.player_mgr.level,
                                                                 self.player_mgr.player.race)

        if not base_stats or not base_attrs:
            Logger.error("Unsupported level (%d) from %s." % (self.player_mgr.level, self.player_mgr.player.name))
            return

        self.player_mgr.base_hp = base_stats.basehp
        self.player_mgr.base_mana = base_stats.basemana

        self.player_mgr.base_str = base_attrs.str
        self.player_mgr.base_agi = base_attrs.agi
        self.player_mgr.base_sta = base_attrs.sta
        self.player_mgr.base_int = base_attrs.inte
        self.player_mgr.base_spi = base_attrs.spi

    def apply_bonuses(self):
        self.calculate_item_stats()

        self.player_mgr.set_str(self.player_mgr.base_str + self.itm_str)
        self.player_mgr.set_agi(self.player_mgr.base_agi + self.itm_agi)
        self.player_mgr.set_sta(self.player_mgr.base_sta + self.itm_sta)
        self.player_mgr.set_int(self.player_mgr.base_int + self.itm_int)
        self.player_mgr.set_spi(self.player_mgr.base_spi + self.itm_spi)

        hp_diff = self.update_max_health()
        mana_diff = self.update_max_mana()
        self.update_resistances()
        self.update_melee_attributes()

        return hp_diff, mana_diff

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
        self.itm_hp = 0
        self.itm_mana = 0

        self.itm_str = 0
        self.itm_agi = 0
        self.itm_sta = 0
        self.itm_int = 0
        self.itm_spi = 0

        self.itm_armor = 0
        self.itm_holy = 0
        self.itm_fire = 0
        self.itm_nature = 0
        self.itm_frost = 0
        self.itm_shadow = 0

        self.itm_block = 0

        self.melee_damage = [0] * 2
        self.melee_attack_time = config.Unit.Defaults.base_attack_time

        for slot, item in list(self.player_mgr.inventory.get_backpack().sorted_slots.items()):
            # Check only equipped items
            if item.current_slot <= InventorySlots.SLOT_TABARD:
                for stat in item.stats:
                    if stat.stat_type == InventoryStats.MANA:
                        self.itm_mana += stat.value
                    if stat.stat_type == InventoryStats.HEALTH:
                        self.itm_hp += stat.value
                    if stat.stat_type == InventoryStats.AGILITY:
                        self.itm_agi += stat.value
                    if stat.stat_type == InventoryStats.STRENGTH:
                        self.itm_str += stat.value
                    if stat.stat_type == InventoryStats.INTELLECT:
                        self.itm_int += stat.value
                    if stat.stat_type == InventoryStats.SPIRIT:
                        self.itm_spi += stat.value
                    if stat.stat_type == InventoryStats.STAMINA:
                        self.itm_sta += stat.value

                self.itm_armor += item.item_template.armor
                self.itm_holy += item.item_template.holy_res
                self.itm_fire += item.item_template.fire_res
                self.itm_nature += item.item_template.nature_res
                self.itm_frost += item.item_template.frost_res
                self.itm_shadow += item.item_template.shadow_res

                self.itm_block += item.item_template.block

                if item.current_slot == InventorySlots.SLOT_MAINHAND:
                    self.melee_damage[0] = int(item.item_template.dmg_min1)
                    self.melee_damage[1] = int(item.item_template.dmg_max1)
                    self.melee_attack_time = item.item_template.delay

    def update_max_health(self):
        total_sta = self.player_mgr.base_sta + self.itm_sta  # + buffs and stuff
        current_hp = self.player_mgr.max_health
        new_hp = int(self.get_health_bonus_from_stamina(total_sta) + self.itm_hp + self.player_mgr.base_hp)
        self.player_mgr.set_max_health(new_hp)

        return new_hp - current_hp

    def update_max_mana(self):
        total_int = self.player_mgr.base_int + self.itm_int  # + buffs and stuff
        current_mana = self.player_mgr.max_power_1
        new_mana = int(self.get_mana_bonus_from_intellect(total_int) + self.itm_mana + self.player_mgr.base_mana)
        self.player_mgr.set_max_mana(new_mana)

        return new_mana - current_mana

    def update_resistances(self):
        # TODO Take into account buffs and stuff too
        self.player_mgr.set_armor(self.itm_armor)
        self.player_mgr.set_holy_res(self.itm_holy)
        self.player_mgr.set_fire_res(self.itm_fire)
        self.player_mgr.set_nature_res(self.itm_nature)
        self.player_mgr.set_frost_res(self.itm_frost)
        self.player_mgr.set_shadow_res(self.itm_shadow)

    def update_defense_bonuses(self):
        pass

    def update_melee_attributes(self):
        self.player_mgr.set_melee_damage(self.melee_damage[0], self.melee_damage[1])
        self.player_mgr.set_melee_attack_time(self.melee_attack_time)
