from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from utils.constants.ItemCodes import ItemClasses, ItemFlags


class LootHolder(object):
    def __init__(self, item: ItemManager, quantity: int, requester: PlayerManager):
        self.item = item
        self.quantity = quantity
        self.visible_to = {}
        self._initialize(requester)

    def _initialize(self, requester):
        if self.is_multi_drop():
            if requester.group_manager:
                for guid in requester.group_manager.members.keys():
                    self.visible_to[guid] = None
            else:
                self.visible_to[requester.guid] = None

    def is_quest_item(self):
        return self.item.item_template.class_ == ItemClasses.ITEM_CLASS_QUEST

    def is_multi_drop(self):
        return self.item.item_template.flags & ItemFlags.ITEM_FLAG_MULTI_DROP

    def is_visible_to_player(self, requester):
        if not self.is_multi_drop():
            return True
        return requester.guid in self.visible_to

    def set_looted_by(self, requester):
        if requester.guid in self.visible_to:
            self.visible_to.pop(requester.guid, None)

    def can_clear_slot(self):
        return not any(self.visible_to)

    def get_item_entry(self):
        return self.item.item_template.entry
