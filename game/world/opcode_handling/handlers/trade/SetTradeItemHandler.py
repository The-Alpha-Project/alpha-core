from struct import unpack

from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.ItemCodes import InventorySlots


class SetTradeItemHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if not TradeManager.validate_active_trade(player_mgr):
            return 0

        # Avoid handling an empty set trade item packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=3):
            return 0

        trade_slot, bag, slot = unpack('<3B', reader.data[:3])
        if trade_slot >= TradeManager.TRADE_SLOT_COUNT:
            TradeManager.cancel_trade(player_mgr)
            return 0

        if bag == 0xFF:
            bag = InventorySlots.SLOT_INBACKPACK.value

        # Keep parity with vmangos: prevent trading items from bank slots.
        if player_mgr.inventory.is_bank_slot(bag, slot):
            TradeManager.cancel_trade(player_mgr)
            return 0

        item = player_mgr.inventory.get_item(bag, slot)
        if not item:
            return 0

        # Guard against placing the same item in multiple trade slots.
        existing_slot = player_mgr.trade_data.get_slot_by_item(item)
        if existing_slot >= 0 and existing_slot != trade_slot:
            TradeManager.cancel_trade(player_mgr)
            return 0

        player_mgr.trade_data.set_item(trade_slot, item)

        return 0
