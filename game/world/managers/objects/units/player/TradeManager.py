from struct import pack
from typing import Optional

from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.ItemCodes import EnchantmentSlots
from utils.constants.MiscCodes import TradeStatus
from utils.constants.OpCodes import OpCode


class ProposedEnchantment:
    def __init__(self, trade_slot=0, spell_id=0, enchant_slot=0, enchant_entry=0, duration=0, charges=0):
        self.trade_slot: int = trade_slot
        self.spell_id: int = spell_id
        self.enchantment_slot: EnchantmentSlots = EnchantmentSlots(enchant_slot)
        self.enchantment_entry: int = enchant_entry
        self.duration: int = duration
        self.charges: int = charges

    def set_enchantment(self, spell_id, enchant_slot, enchant_entry, duration, charges):
        self.spell_id = spell_id
        self.enchantment_slot = enchant_slot
        self.enchantment_entry = enchant_entry
        self.duration = duration
        self.charges = charges

    def flush(self):
        self.trade_slot = 0
        self.spell_id = 0
        self.enchantment_slot = 0
        self.duration = 0
        self.charges = 0


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

        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

    @staticmethod
    def cancel_trade(player):
        if not player:
            return

        if player.trade_data and player.trade_data.other_player:
            TradeManager.send_trade_status(player.trade_data.other_player, TradeStatus.TRADE_STATUS_CANCELLED)
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
            trade_data.proposed_enchantment.spell_id if trade_data.proposed_enchantment else 0,
            trade_data.proposed_enchantment.trade_slot if trade_data.proposed_enchantment else 0,
        )

        for slot in range(TradeManager.TradeData.TRADE_SLOT_COUNT):
            data += pack('<B', slot)
            item = trade_data.items[slot]
            data += pack(
                '<4IQ',
                item.item_template.entry if item else 0,
                item.item_template.display_id if item else 0,
                item.item_instance.stackcount if item and item.item_instance else 0,
                item.get_creator_guid() if item else 0,  # Wrapped items, creator guid.
                item.get_permanent_enchant_value() if item else 0  # Permanent enchant value.
            )

        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS_EXTENDED, data))

    @staticmethod
    def send_trade_request(player, other_player):
        if not player:
            return

        data = pack(
            '<IQ',
            TradeStatus.TRADE_STATUS_PROPOSED,
            other_player.guid
        )

        player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRADE_STATUS, data))

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
            self.items: list[Optional[ItemManager]] = [None] * TradeManager.TradeData.TRADE_SLOT_COUNT

        def get_item_by_guid(self, guid) -> Optional[ItemManager]:
            for item in self.items:
                if item and item.guid == guid:
                    return item
            return None

        def get_item_by_slot(self, slot) -> Optional[ItemManager]:
            return self.items[slot]

        def set_proposed_enchantment_trade_slot(self, trade_slot):
            # Flush previous provided enchants, if any.
            self.proposed_enchantment.flush()
            # Make sure clients update their trade slots enchant caches.
            self.update_trade_status()
            # Set the new proposed trade slot, actual update will trigger upon set_proposed_enchant.
            self.proposed_enchantment.trade_slot = trade_slot

        def set_proposed_enchant(self, spell_id, enchantment_slot, entry, duration, charges):
            self.proposed_enchantment.set_enchantment(spell_id, enchantment_slot, entry, duration, charges)
            self.update_trade_status()

        def set_item(self, slot, item):
            if self.items[slot] and self.items[slot] == item:
                return

            self.items[slot] = item
            self.player.enqueue_packet(item.query_details_packet())
            self.other_player.enqueue_packet(item.query_details_packet())

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
