from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.ItemCodes import InventoryError
from utils.constants.MiscCodes import TradeStatus


class AcceptTradeHandler(object):

    @staticmethod
    def handle(world_session, reader):
        player = world_session.player_mgr
        player_trade = player.trade_data
        if not player_trade:
            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_CANCELLED)
            return 0

        other_player = player_trade.other_player
        other_player_trade = other_player.trade_data
        item_to_receive_enchant = None
        player_trade.set_accepted(True)

        if player_trade.money > player.coinage:
            # You do not have enough gold.
            return 0

        if other_player_trade.money > other_player.coinage:
            # You do not have enough gold.
            return 0

        # Cancel if any item is soulbound.
        for slot in range(TradeManager.TRADE_SLOT_COUNT):
            if player_trade.items[slot] and player_trade.items[slot].is_soulbound():
                TradeManager.cancel_trade(player)
                return 0

            if other_player_trade.items[slot] and other_player_trade.items[slot].is_soulbound():
                TradeManager.cancel_trade(other_player)
                return 0

        if other_player_trade.is_accepted:
            # Inventory checks.
            for slot in range(TradeManager.TRADE_SLOT_COUNT):
                # Search for item to receive enchantment.
                if not item_to_receive_enchant and player_trade.proposed_enchantment.enchantment_entry and \
                        player_trade.proposed_enchantment.trade_slot == slot:
                    if player_trade.items[slot]:
                        item_to_receive_enchant = player_trade.items[slot]
                    elif other_player_trade.items[slot]:
                        item_to_receive_enchant = other_player_trade.items[slot]
                    continue

                # Check if player can store item.
                if player_trade.items[slot]:
                    error = other_player.inventory.can_store_item(player_trade.items[slot].item_template,
                                                                  player_trade.items[slot].item_instance.stackcount)
                    if error != InventoryError.BAG_OK:
                        TradeManager.cancel_trade(other_player)
                        return 0

                # Check if other player can store item.
                if other_player_trade.items[slot]:
                    error = player.inventory.can_store_item(other_player_trade.items[slot].item_template,
                                                            other_player_trade.items[slot].item_instance.stackcount)
                    if error != InventoryError.BAG_OK:
                        TradeManager.cancel_trade(player)
                        return 0

            # Transfer items.
            # TODO: Change item instance owner instead of cloning the item.
            for slot in range(TradeManager.TRADE_SLOT_COUNT):
                player_item = player_trade.items[slot]
                other_player_item = other_player_trade.items[slot]

                # Do not transfer enchanted items.
                if item_to_receive_enchant:
                    if player_item == item_to_receive_enchant or other_player_item == item_to_receive_enchant:
                        continue

                if other_player_item:
                    if player.inventory.add_item(
                            item_template=other_player_item.item_template,
                            count=other_player_item.item_instance.stackcount,
                            created_by=other_player_item.item_instance.creator,
                            perm_enchant=EnchantmentManager.get_permanent_enchant_value(other_player_item),
                            show_item_get=False):
                        other_player.inventory.remove_item(other_player_item.item_instance.bag,
                                                           other_player_item.current_slot, True)

                if player_item:
                    if other_player.inventory.add_item(
                            item_template=player_item.item_template,
                            count=player_item.item_instance.stackcount,
                            created_by=player_item.item_instance.creator,
                            perm_enchant=EnchantmentManager.get_permanent_enchant_value(player_item),
                            show_item_get=False):
                        player.inventory.remove_item(player_item.item_instance.bag,
                                                     player_item.current_slot, True)

            # Apply enchantment to item (if any).
            player_trade.apply_proposed_enchant()

            player.mod_money(other_player_trade.money)
            player.mod_money(-player_trade.money)
            other_player.mod_money(player_trade.money)
            other_player.mod_money(-other_player_trade.money)

            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_COMPLETE)
            TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_COMPLETE)

            player.trade_data = None
            other_player.trade_data = None
        else:
            other_player_trade.set_accepted(True)
            TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_ACCEPTED)

        return 0
