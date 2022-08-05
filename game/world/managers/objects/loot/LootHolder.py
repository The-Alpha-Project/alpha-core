from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from utils.constants.ItemCodes import ItemClasses, ItemFlags


class LootHolder(object):
    def __init__(self, item: ItemManager, quantity: int, requester: PlayerManager):
        self.item = item
        self.quantity = quantity
        if self.is_multi_drop():
            # Used to keep track of who can loot an item with multi drop flag and who has looted it already or not.
            self.shared_with = set()
            self._set_shared_recipients(requester)

    def _set_shared_recipients(self, requester):
        if self.is_multi_drop():
            if requester.group_manager:
                for player in requester.group_manager.get_surrounding_member_players(requester):
                    self.shared_with.add(player.guid)
            else:
                self.shared_with.add(requester.guid)

    def is_quest_item(self):
        return self.item.item_template.class_ == ItemClasses.ITEM_CLASS_QUEST

    def is_multi_drop(self):
        return self.item.item_template.flags & ItemFlags.ITEM_FLAG_MULTI_DROP

    def is_visible_to_player(self, requester):
        if not self.is_multi_drop():
            return True
        return requester.guid in self.shared_with

    # Used to mark this loot slot as already looted. It will return True for items that don't have the multi drop flag,
    # otherwise it will remove the requester from the shared loot list and return if the slot has been looted by all
    # shared recipients or not.
    def set_looted_by(self, requester):
        if not self.is_multi_drop():
            return True

        if requester.guid in self.shared_with:
            self.shared_with.remove(requester.guid)
        return self.can_clear_slot()

    def can_clear_slot(self):
        return not any(self.shared_with)

    def get_item_entry(self):
        return self.item.item_template.entry
