from typing import Optional
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.player.trade.ProposedEnchantment import ProposedEnchantment
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.MiscCodes import TradeStatus


class TradeData(object):
    TRADE_SLOT_COUNT = 6

    def __init__(self,
                 player,
                 other_player,
                 is_accepted=False,
                 money=0):
        self.player = player
        self.other_player = other_player
        self.is_accepted = is_accepted
        self.money = money
        self.proposed_enchantment: ProposedEnchantment = ProposedEnchantment()
        self.items: list[Optional[ItemManager]] = [None] * TradeManager.TRADE_SLOT_COUNT

    def get_item_by_guid(self, guid) -> Optional[ItemManager]:
        for item in self.items:
            if item and item.guid == guid:
                return item
        return None

    def get_item_by_slot(self, slot) -> Optional[ItemManager]:
        return self.items[slot]

    def get_slot_by_item(self, item) -> Optional[int]:
        for slot, trade_item in enumerate(self.items):
            if trade_item == item:
                return slot
        return None

    def set_proposed_enchant(self, trade_slot, spell_id, enchantment_slot, entry, duration, charges):
        # Update the proposed enchant.
        self.proposed_enchantment.set_enchantment(trade_slot, spell_id, enchantment_slot, entry, duration, charges)

    def set_item(self, slot, item):
        if self.items[slot] and self.items[slot] == item:
            return
        self.items[slot] = item
        self.set_accepted(False)
        self.other_player.trade_data.set_accepted(False)
        self.update_trade_status()

    def clear_item(self, slot):
        self.items[slot] = None
        # TODO: Cancel the trade if player moves the item binded to the current proposed enchantment.
        #    The client keeps in cache the slot and any item placed there will be seen as receiving the enchant.
        #    It does not matter if we send a new packet with both fields '-1', the cache will remain.
        #    So, we need more information on what was the trading behavior on enchantments trading.
        if self.proposed_enchantment.trade_slot == slot:
            TradeManager.cancel_trade(self.player)
        self.update_trade_status()

    def set_money(self, money):
        self.money = money
        self.set_accepted(False)
        self.other_player.trade_data.set_accepted(False)
        self.update_trade_status()

    def update_trade_status(self):
        TradeManager.send_update_trade(self.player, self, False)
        TradeManager.send_update_trade(self.other_player, self, True)

    def set_accepted(self, is_accepted):
        self.is_accepted = is_accepted
        if not is_accepted:
            TradeManager.send_trade_status(self.player, TradeStatus.TRADE_STATUS_STATE_CHANGED)
            TradeManager.send_trade_status(self.other_player, TradeStatus.TRADE_STATUS_STATE_CHANGED)
