from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class BuyBankSlotHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty buy bank slot packet.
            guid = unpack('<Q', reader.data[:8])[0]
            banker = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
            if banker:
                next_slot = player_mgr.player.bankslots + 1
                slot_cost = DbcDatabaseManager.bank_get_slot_cost(next_slot)
                # Check if player can afford it (even if client already checks it)
                if player_mgr.coinage >= slot_cost:
                    player_mgr.add_bank_slot(slot_cost)
        return 0
