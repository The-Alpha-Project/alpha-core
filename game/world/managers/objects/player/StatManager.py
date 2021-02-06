from database.world.WorldDatabaseManager import WorldDatabaseManager
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

    def init_stats(self):
        base_stats = WorldDatabaseManager.player_get_class_level_stats(self.player_mgr.player.class_,
                                                                       self.player_mgr.level)
        base_attrs = WorldDatabaseManager.player_get_level_stats(self.player_mgr.player.class_,
                                                                 self.player_mgr.level,
                                                                 self.player_mgr.player.race)

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

        return hp_diff, mana_diff

    @staticmethod
    def get_health_bonus_from_stamina(stamina):
        base_sta = stamina if stamina < 20 else 20
        more_sta = stamina - base_sta
        return base_sta + (more_sta * 10.0)

    @staticmethod
    def get_mana_bonus_from_intellect(intellect):
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
