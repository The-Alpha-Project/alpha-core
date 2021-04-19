from struct import pack, unpack

from game.world.managers.objects.player.TradeManager import TradeManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import TradeStatus


class AcceptTradeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player = world_session.player_mgr
        player_trade = player.trade_data
        other_player = player_trade.other_player
        other_player_trade = other_player.trade_data

        player_trade.set_accepted(True)

        if player_trade.money > player.coinage:
            # You do not have enough gold
            return 0

        if other_player_trade.money > other_player.coinage:
            # You do not have enough gold
            return 0

        # Cancel if any item is soulbound
        for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
            if player_trade.items[slot] and player_trade.items[slot].is_soulbound():
                TradeManager.cancel_trade(player_trade)
                return 0

            if other_player_trade.items[slot] and other_player_trade.items[slot].is_soulbound():
                TradeManager.cancel_trade(other_player)
                return 0

        if other_player_trade.is_accepted:
            # I don't think spell casts are implemented

            # Inventory checks
            for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
                if player_trade.items[slot]:
                    if not other_player.inventory.can_store_item(player_trade.items[slot].item_template,
                                                                 player_trade.items[slot].item_instance.stackcount):
                        TradeManager.cancel_trade(other_player)
                        return 0

                if other_player_trade.items[slot]:
                    if not player.inventory.can_store_item(other_player_trade.items[slot].item_template,
                                                           other_player_trade.items[slot].item_instance.stackcount):
                        TradeManager.cancel_trade(player)
                        return 0

            # Transfer items
            # TODO: Change item instance owner instead of cloning the item
            for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
                player_item = player_trade.items[slot]
                other_player_item = other_player_trade.items[slot]

                if other_player_item:
                    player.inventory.add_item(item_template=other_player_item.item_template,
                                              count=other_player_item.item_instance.stackcount,
                                              show_item_get=False)

                    other_player.inventory.mark_as_removed(other_player_item)
                    other_player.session.enqueue_packet(other_player_item.get_destroy_packet())
                    other_player.inventory.get_container(other_player_item.item_instance.bag).remove_item(
                        other_player_item)

                if player_item:
                    other_player.inventory.add_item(item_template=player_item.item_template,
                                                    count=player_item.item_instance.stackcount,
                                                    show_item_get=False)

                    player.inventory.mark_as_removed(player_item)
                    player.session.enqueue_packet(player_item.get_destroy_packet())
                    player.inventory.get_container(player_item.item_instance.bag).remove_item(player_item)

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
