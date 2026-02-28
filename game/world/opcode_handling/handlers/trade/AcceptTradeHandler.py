from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.ItemCodes import InventoryError
from utils.constants.MiscCodes import TradeStatus


class AcceptTradeHandler:
    @staticmethod
    def _resolve_enchant_target_item_guids(player_trade, other_player_trade):
        target_item_guids = set()

        for trade_data in (player_trade, other_player_trade):
            proposed = trade_data.proposed_enchantment
            if not proposed.is_valid() or not proposed.enchantment_entry:
                continue

            if proposed.target_item_guid:
                target_item_guids.add(proposed.target_item_guid)
                continue

            if proposed.trade_slot < 0 or proposed.trade_slot >= TradeManager.TRADE_SLOT_COUNT:
                continue

            slot_item = trade_data.items[proposed.trade_slot]
            if slot_item:
                target_item_guids.add(slot_item.guid)
                continue

            linked_trade_data = trade_data.get_linked_trade_data()
            if linked_trade_data and linked_trade_data.items[proposed.trade_slot]:
                target_item_guids.add(linked_trade_data.items[proposed.trade_slot].guid)

        return target_item_guids

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player:
            return res

        player_trade = player.trade_data
        if not player_trade:
            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_CANCELLED)
            return 0

        if not TradeManager.validate_active_trade(player):
            return 0

        other_player = player_trade.other_player
        other_player_trade = other_player.trade_data
        enchant_target_item_guids = AcceptTradeHandler._resolve_enchant_target_item_guids(player_trade,
                                                                                           other_player_trade)
        player_trade.set_accepted(True)

        # Prevent players from trading money they don't actually have.
        if player_trade.money > player.coinage:
            TradeManager.cancel_trade(player)
            return 0
        if other_player_trade.money > other_player.coinage:
            TradeManager.cancel_trade(other_player)
            return 0

        # Prevent trading money if the recipient is going to exceed the hard gold cap to avoid losing the overflowed
        # amount.
        if player.coinage + other_player_trade.money > 2147483647:
            TradeManager.cancel_trade(player)
            return 0
        if other_player.coinage + player_trade.money > 2147483647:
            TradeManager.cancel_trade(other_player)
            return 0

        # Cancel if any item is soulbound and is being traded (not only enchanted).
        for trade_owner, trade_data in ((player, player_trade), (other_player, other_player_trade)):
            for slot in range(TradeManager.TRADE_SLOT_COUNT):
                trade_item = trade_data.items[slot]
                if not trade_item or not trade_item.is_soulbound():
                    continue
                if trade_item.guid in enchant_target_item_guids:
                    continue
                TradeManager.cancel_trade(trade_owner)
                return 0

        # Validate proposed enchants before moving any item/money.
        for trade_owner, trade_data in ((player, player_trade), (other_player, other_player_trade)):
            if not trade_data.can_apply_proposed_enchant():
                TradeManager.cancel_trade(trade_owner)
                return 0

        if other_player_trade.is_accepted:
            # Inventory checks.
            for slot in range(TradeManager.TRADE_SLOT_COUNT):
                player_item = player_trade.items[slot]
                other_player_item = other_player_trade.items[slot]
                if player_item and player_item.guid in enchant_target_item_guids:
                    continue
                if other_player_item and other_player_item.guid in enchant_target_item_guids:
                    continue

                # Check if player can store item.
                if player_item:
                    error = other_player.inventory.can_store_item(player_item.item_template,
                                                                  player_item.item_instance.stackcount)
                    if error != InventoryError.BAG_OK:
                        TradeManager.cancel_trade(other_player)
                        return 0

                # Check if other player can store item.
                if other_player_item:
                    error = player.inventory.can_store_item(other_player_item.item_template,
                                                            other_player_item.item_instance.stackcount)
                    if error != InventoryError.BAG_OK:
                        TradeManager.cancel_trade(player)
                        return 0

            # Transfer items.
            # TODO: Change item instance owner instead of cloning the item.
            for slot in range(TradeManager.TRADE_SLOT_COUNT):
                player_item = player_trade.items[slot]
                other_player_item = other_player_trade.items[slot]

                # Do not transfer enchanted items.
                if player_item and player_item.guid in enchant_target_item_guids:
                    continue
                if other_player_item and other_player_item.guid in enchant_target_item_guids:
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
            for trade_owner, trade_data in ((player, player_trade), (other_player, other_player_trade)):
                if not trade_data.apply_proposed_enchant():
                    TradeManager.cancel_trade(trade_owner)
                    return 0

            player.mod_money(other_player_trade.money)
            player.mod_money(-player_trade.money)
            other_player.mod_money(player_trade.money)
            other_player.mod_money(-other_player_trade.money)

            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_COMPLETE)
            TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_COMPLETE)

            player.trade_data = None
            other_player.trade_data = None
        else:
            TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_ACCEPTED)

        return 0
