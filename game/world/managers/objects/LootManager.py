from typing import NamedTuple
from utils.constants.ObjectCodes import LootTypes
from game.world.managers.objects.item.ItemManager import ItemManager


class LootHolder(NamedTuple):
    item: ItemManager
    quantity: int


class LootManager(object):
    def __init__(self, world_obj):
        self.world_obj = world_obj
        self.current_money = 0
        self.current_loot = []
        self.loot_template = self.populate_loot_template()

    # Needs overriding
    def generate_loot(self):
        pass

    # Needs overriding
    def populate_loot_template(self):
        return None

    def get_loot_in_slot(self, slot):
        if slot < len(self.current_loot) and self.current_loot[slot]:
            return self.current_loot[slot]
        return None

    def do_loot(self, slot):
        if slot < len(self.current_loot):
            self.current_loot[slot] = None

    def clear_money(self):
        self.current_money = 0

    def has_money(self):
        return self.current_money > 0

    def has_items(self):
        return len([loot for loot in self.current_loot if loot]) > 0

    def has_loot(self):
        return self.has_money() or self.has_items()

    def get_loot_type(self, player, victim):
        loot_type = LootTypes.LOOT_TYPE_NOTALLOWED

        # killed_by is None or looter is the actual killer, allow.
        if not victim.killed_by or victim.killed_by == player:
            loot_type = LootTypes.LOOT_TYPE_CORPSE
        # Looter is part of the killer_by player party, allow.
        elif victim.killed_by.group_manager and victim.killed_by.group_manager.is_party_member(player):
            loot_type = LootTypes.LOOT_TYPE_CORPSE
        # Deny
        return loot_type

    def clear(self):
        self.clear_money()
        self.current_loot.clear()
