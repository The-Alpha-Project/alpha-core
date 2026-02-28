from struct import unpack, pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import PacketWriter
from utils.Formulas import Distances
from utils.constants.MiscCodes import NpcFlags, BankSlotErrors
from utils.constants.OpCodes import OpCode


class BuyBankSlotHandler:
    @staticmethod
    def _send_bank_slot_result(player_mgr, result):
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_BUY_BANK_SLOT_RESULT, pack('<I', result)))

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if not player_mgr.is_alive:
            return 0

        # Avoid handling an empty buy bank slot packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]
        banker = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not banker:
            BuyBankSlotHandler._send_bank_slot_result(player_mgr, BankSlotErrors.BANKSLOT_ERROR_NOTBANKER)
            return 0
        if not Distances.is_within_shop_distance(player_mgr, banker):
            BuyBankSlotHandler._send_bank_slot_result(player_mgr, BankSlotErrors.BANKSLOT_ERROR_NOTBANKER)
            return 0
        if (banker.get_npc_flags() & NpcFlags.NPC_FLAG_BANKER) == 0:
            BuyBankSlotHandler._send_bank_slot_result(player_mgr, BankSlotErrors.BANKSLOT_ERROR_NOTBANKER)
            return 0

        next_slot = player_mgr.player.bankslots + 1
        try:
            slot_cost = DbcDatabaseManager.bank_get_slot_cost(next_slot)
        except Exception:
            BuyBankSlotHandler._send_bank_slot_result(player_mgr, BankSlotErrors.BANKSLOT_ERROR_FAILED_TOO_MANY)
            return 0

        if player_mgr.coinage < slot_cost:
            BuyBankSlotHandler._send_bank_slot_result(player_mgr, BankSlotErrors.BANKSLOT_ERROR_INSUFFICIENT_FUNDS)
            return 0

        player_mgr.add_bank_slot(slot_cost)
        return 0
