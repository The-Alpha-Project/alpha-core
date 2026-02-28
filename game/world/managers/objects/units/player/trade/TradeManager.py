from struct import pack

from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.constants.MiscCodes import TradeStatus
from utils.constants.OpCodes import OpCode


class TradeManager:
    TRADE_SLOT_COUNT = 6

    @staticmethod
    def has_active_trade(player):
        if not player or not player.trade_data:
            return False

        other_player = player.trade_data.other_player
        if not other_player or not other_player.trade_data or other_player.trade_data.other_player != player:
            # Drop stale non-reciprocal trade data to prevent "always busy" lockups.
            player.trade_data = None
            return False

        return True

    @staticmethod
    def fail_trade_too_far(player):
        if not player or not player.trade_data:
            return

        other_player = player.trade_data.other_player
        player.trade_data = None
        TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_TOO_FAR_AWAY)

        if other_player and other_player.trade_data and other_player.trade_data.other_player == player:
            other_player.trade_data = None
            TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_TOO_FAR_AWAY)

    @staticmethod
    def validate_active_trade(player):
        if not TradeManager.has_active_trade(player):
            return False

        if not Distances.is_within_trade_distance(player, player.trade_data.other_player):
            TradeManager.fail_trade_too_far(player)
            return False

        return True

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

        if player.trade_data:
            other_player = player.trade_data.other_player
            if other_player and other_player.trade_data and other_player.trade_data.other_player == player:
                TradeManager.send_trade_status(other_player, TradeStatus.TRADE_STATUS_CANCELLED)
                other_player.trade_data = None

            TradeManager.send_trade_status(player, TradeStatus.TRADE_STATUS_CANCELLED)
            player.trade_data = None

    @staticmethod
    def send_update_trade(player, trade_data, is_target):
        if not player:
            return

        # Header.
        data = pack(
            '<B2I',
            1 if is_target else 0,
            TradeManager.TRADE_SLOT_COUNT,
            trade_data.money
        )

        # Proposed enchantments.
        data += pack(
            '<2i',
            trade_data.proposed_enchantment.spell_id,
            trade_data.proposed_enchantment.trade_slot
        )

        # Trade items updates.
        for slot in range(TradeManager.TRADE_SLOT_COUNT):
            data += pack('<B', slot)
            item = trade_data.items[slot]
            data += pack(
                '<4IQ',
                item.item_template.entry if item else 0,
                item.item_template.display_id if item else 0,
                item.item_instance.stackcount if item and item.item_instance else 0,
                EnchantmentManager.get_permanent_enchant_value(item) if item else 0,  # Permanent enchant value.
                item.get_creator_guid() if item else 0  # Wrapped/Crafted items, creator guid.
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
