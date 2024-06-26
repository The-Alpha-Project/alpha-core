from random import uniform, randint, shuffle
from struct import pack
from threading import RLock

from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import SkinningLootTemplate
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.OpCodes import OpCode


class LootManager(object):
    def __init__(self, world_object):
        self.world_object = world_object
        self.current_money = 0
        self.current_loot = []
        self.loot_template = self.populate_loot_template()
        self.active_looters = []
        self.loot_lock = RLock()

    # Needs overriding.
    def generate_loot(self, requester):
        pass

    # Needs overriding.
    def generate_money(self, requester):
        pass

    # Generates a complete dictionary { group_id : items }, includes referenced loot items.
    # noinspection PyMethodMayBeStatic
    def generate_loot_groups(self, loot_template):
        loot_groups = {}
        max_groupid = max(loot_item.groupid for loot_item in loot_template)
        for loot_item in loot_template:
            # Group skinning loot templates separately.
            if isinstance(loot_item, SkinningLootTemplate):
                loot_item.groupid = max_groupid + 1
            if loot_item.groupid not in loot_groups:
                loot_groups[loot_item.groupid] = []
            loot_groups[loot_item.groupid].append(loot_item)

        return loot_groups

    # Returns the final list of items available for looting.
    def process_loot_groups(self, loot_groups, requester) -> list:
        loot_item_result = []
        for group_id, loot_group_items in loot_groups.items():
            loot_item_result += self.process_loot_group(group_id, loot_group_items, requester)

        return loot_item_result

    def process_loot_group(self, group_id, group_loot_items: list, requester):
        # A group may consist of explicitly-chanced (having non-zero chance) and equal-chanced (chance = 0) entries.
        # Every equal-chanced entry of a group is considered having such a chance that all equal-chanced entries have
        # the same chance (sum of chances of all entries is 100%).
        #
        # A group may consist of:
        #   · Only explicitly-chanced entries.
        #   · Only equal-chanced entries.
        #   · Entries of both type.
        #
        # Loot generation explanation (might not be 100% accurate to original servers):
        #   · A random number R is rolled in range 0 to 100 (floating point value).
        #   · If R is less than absolute value of chance of the entry then the entry 'wins': the Item is included in
        #     the loot. Group processing stops, the rest of group entries are just skipped. Non-groups can continue
        #     the checks with a new roll.
        #   · Otherwise the entry 'looses': the Item misses its chance to get into the loot. If we are processing a
        #     group, R is decreased by the absolute value of chance and next entry is checked, otherwise a new roll
        #     is made.
        #
        # Notes:
        #   · A group is defined when group_id is greater than 0. A group can only generate a maximum of 1 item.
        #   · Non-groups (group_id = 0) don't have a limit in the number of items they can generate.
        shuffle(group_loot_items)
        loot_item_result = []

        # For groups we need to do loop group items twice, as first we need to determine the number of equal-chances
        # entries it contains.
        # TODO: Find another way?
        split_group_chance = 0
        if group_id > 0:
            equal_chance_entries_length = 0
            for loot_item in group_loot_items:
                if loot_item.ChanceOrQuestChance == 0:
                    equal_chance_entries_length += 1
            if equal_chance_entries_length > 0:
                split_group_chance = 100 / equal_chance_entries_length

        current_roll = uniform(0.0, 100)
        for loot_item in group_loot_items:
            if self.skip_quest_item(loot_item, requester):
                continue

            item_chance = abs(loot_item.ChanceOrQuestChance)
            chance = item_chance if item_chance > 0 else split_group_chance
            if current_roll < item_chance:
                if loot_item.mincountOrRef < 0:
                    reference_loot_template = WorldDatabaseManager.ReferenceLootTemplateHolder\
                        .reference_loot_template_get_by_entry(-loot_item.mincountOrRef)
                    loot_groups = self.generate_loot_groups(reference_loot_template)
                    loot_item_result += self.process_loot_groups(loot_groups, requester)
                else:
                    loot_item_result.append(loot_item)

                # If a group is defined, don't generate more than one item.
                if group_id > 0:
                    return loot_item_result
            elif group_id > 0:
                current_roll -= chance
                continue

            # New roll for every non-group entry.
            current_roll = uniform(0.0, 100)

        return loot_item_result

    # noinspection PyMethodMayBeStatic
    def skip_quest_item(self, loot_item, requester):
        # Check if this is a quest item and if the player or group needs it.
        if requester and loot_item.ChanceOrQuestChance < 0:
            if requester.player_or_group_require_quest_item(loot_item.item):
                return False
        return loot_item.ChanceOrQuestChance < 0

    def add_loot(self, loot_item, requester):
        from game.world.managers.objects.loot.LootHolder import LootHolder
        from game.world.managers.objects.item.ItemManager import ItemManager
        item = ItemManager.generate_item_from_entry(loot_item.item)
        if item:
            self.current_loot.append(LootHolder(item, randint(loot_item.mincountOrRef, loot_item.maxcount), requester))

    # Needs overriding
    def populate_loot_template(self):
        return None

    def loot_item_in_slot(self, slot, requester):
        with self.loot_lock:
            if not self.has_loot():
                return
            if slot >= len(self.current_loot) or not self.current_loot[slot]:
                return
            loot = self.current_loot[slot]
            if not loot or not loot.item or not requester.inventory.add_item(item_template=loot.item.item_template,
                                                                             count=loot.quantity, looted=True):
                return
            # Mark as looted by requester and delete if item is not visible to anyone else.
            if self.current_loot[slot].set_looted_by(requester):
                # Set item to None, do not pop index.
                self.current_loot[slot] = None

            removed_packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_REMOVED, pack('<B', slot))
            # Loot is multi-drop, notify only self about its removal.
            if loot.is_multi_drop():
                requester.enqueue_packet(removed_packet)
            # Notify players with loot window open about its removal.
            else:
                [looter.enqueue_packet(removed_packet) for looter in self.get_active_looters()]

            # Flag as depleted if this is an Item loot container and is empty, destroy will happen on loot release.
            from game.world.managers.objects.item.ItemLootManager import ItemLootManager
            if isinstance(self, ItemLootManager) and not self.has_loot():
                # noinspection PyAttributeOutsideInit
                self.depleted = True

    def clear_money(self):
        self.current_money = 0

    def has_money(self):
        return self.current_money > 0

    def has_items(self):
        return len([loot for loot in self.current_loot if loot is not None]) > 0

    def has_loot(self):
        return self.has_money() or self.has_items()

    def get_loot_type(self, player, world_object):
        from utils.constants.MiscCodes import LootTypes
        return LootTypes.LOOT_TYPE_NOTALLOWED

    def add_active_looter(self, player_mgr):
        if player_mgr not in self.active_looters:
            self.active_looters.append(player_mgr)

    def remove_active_looter(self, player_mgr):
        if player_mgr in self.active_looters:
            self.active_looters.remove(player_mgr)

    def get_active_looters(self):
        return [looter for looter in self.active_looters if looter]

    def clear(self):
        self.clear_money()
        self.current_loot.clear()
        self.active_looters.clear()
