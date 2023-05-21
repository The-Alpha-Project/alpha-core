from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.maps.MapManager import MapManager


class BuyBankSlotHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty buy bank slot packet.
            guid = unpack('<Q', reader.data[:8])[0]
            banker = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if banker:
                next_slot = world_session.player_mgr.player.bankslots + 1
                slot_cost = DbcDatabaseManager.bank_get_slot_cost(next_slot)
                # Check if player can afford it (even if client already checks it)
                if world_session.player_mgr.coinage >= slot_cost:
                    world_session.player_mgr.add_bank_slot(slot_cost)
        return 0
