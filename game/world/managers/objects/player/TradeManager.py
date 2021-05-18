from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import TradeStatus
from utils.constants.OpCodes import OpCode


class TradeManager(object):
    @staticmethod
    def send_trade_status(player, status):
        if not player:
            return

        data = b''
        if status == TradeStatus.TRADE_STATUS_PROPOSED:
            data += pack('<IQ', status, 0)
        elif status == TradeStatus.TRADE_STATUS_FAILED:
            data += pack('<2IBI', status, 0, 0, 0)
        else:
            data += pack('<I', status)

        if player.session:
            player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

    @staticmethod
    def cancel_trade(player):
        if not player:
            return

        if player.trade_data and player.trade_data.other_player:
            TradeManager.send_trade_status(player.trade_data.other_player,
                                           TradeStatus.TRADE_STATUS_CANCELLED)
            player.trade_data.other_player.trade_data = None

            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_CANCELLED)
            player.trade_data = None

    @staticmethod
    def send_update_trade(player, trade_data, is_target):
        if not player:
            return

        data = pack(
            '<B4I',
            1 if is_target else 0,
            TradeManager.TradeData.TRADE_SLOT_COUNT,
            trade_data.money,
            0,  # proposedEnchantmentSlot ?
            0  # proposedEnchantmentSpellI ?
        )

        for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
            data += pack('<B', slot)
            item = trade_data.items[slot]
            data += pack(
                '<4IQ',
                item.item_template.entry if item else 0,
                item.item_template.display_id if item else 0,
                item.item_instance.stackcount if item and item.item_instance else 0,
                0,  # data << uint32(item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
                0  # data << item->GetGuidValue(ITEM_FIELD_CREATOR);
            )

        if player.session:
            player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS_EXTENDED, data))

    @staticmethod
    def send_trade_request(player, other_player):
        if not player:
            return

        data = pack(
            '<IQ',
            TradeStatus.TRADE_STATUS_PROPOSED,
            other_player.guid
        )

        player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

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

            self.items = [None] * TradeManager.TradeData.TRADE_SLOT_COUNT

        def set_item(self, slot, item):
            if self.items[slot] and self.items[slot] == item:
                return

            self.items[slot] = item
            self.player.session.enqueue_packet(item.query_details())
            self.other_player.session.enqueue_packet(item.query_details())

            self.set_accepted(False)
            self.other_player.trade_data.set_accepted(False)

            self.update_trade_status()

        def clear_item(self, slot):
            self.items[slot] = None

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
