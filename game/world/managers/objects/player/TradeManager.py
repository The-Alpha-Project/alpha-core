from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import TradeStatuses
from utils.constants.OpCodes import OpCode


class TradeManager(object):
    @staticmethod
    def send_trade_status(player, status):
        data = b''
        if status == TradeStatuses.TRADE_STATUS_PROPOSED:
            data += pack('<IQ', status, 0)
        elif status == TradeStatuses.TRADE_STATUS_FAILED:
            data += pack('<2IBI', status, 0, 0, 0)
        else:
            data += pack('<I', status)

        player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

    @staticmethod
    def send_update_trade(player, trade_data, is_self):
        if not player:
            return

        data = pack(
            '<B4I',
            1 if is_self else 0,
            TradeManager.TradeData.TRADE_SLOT_COUNT,
            trade_data.money,
            0,  # proposedEnchantmentSlot ?
            0  # proposedEnchantmentSpellI ?
        )

        for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
            data += pack('<B', slot)
            item = trade_data.get_item(slot)
            data += pack(
                '<4IQ',
                item.item_template.entry if item else 0,
                item.item_template.display_id if item else 0,
                item.stackcount if item else 0,
                0,  # data << uint32(item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
                0  # data << item->GetGuidValue(ITEM_FIELD_CREATOR);
            )

        player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS_EXTENDED, data))

    @staticmethod
    def send_trade_request(player, other_player):
        data = pack(
            '<IQ',
            TradeStatuses.TRADE_STATUS_PROPOSED,
            other_player.guid
        )

        player.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

    class TradeData(object):
        TRADE_SLOT_COUNT = 7

        def __init__(self,
                     player,
                     other_player,
                     is_accepted=False,
                     money=0):
            self.player = player
            self.other_player = other_player
            self.is_accepted = is_accepted
            self.money = money

            self.items = [0] * TradeManager.TradeData.TRADE_SLOT_COUNT

        def set_item(self, slot, item):
            if self.items[slot] == item.guid:
                return

            self.player.session.request.sendall(item.query_details())
            self.other_player.session.request.sendall(item.query_details())

            self.set_accepted(False)
            self.other_player.trade_data.set_accepted(False)

            self.update_trade_status()

        def get_item(self, slot):
            return RealmDatabaseManager.character_inventory_get_item(self.items[slot])

        def clear_item(self, slot):
            self.items[slot] = 0

            self.update_trade_status()

        def set_money(self, money):
            self.money = money if money > 0 else 0

            self.set_accepted(False)
            self.other_player.trade_data.set_accepted(False)

        def update_trade_status(self):
            TradeManager.send_update_trade(self.player, self, True)
            TradeManager.send_update_trade(self.other_player, self.other_player.trade_data, False)

        def set_accepted(self, is_accepted):
            self.is_accepted = is_accepted

            if not is_accepted:
                TradeManager.send_trade_status(self.player, TradeStatuses.TRADE_STATUS_STATE_CHANGED)
                TradeManager.send_trade_status(self.other_player, TradeStatuses.TRADE_STATUS_STATE_CHANGED)
