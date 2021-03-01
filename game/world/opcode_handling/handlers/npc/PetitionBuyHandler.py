from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants import ObjectCodes
from utils.constants.ItemCodes import InventoryError
from utils.constants.ObjectCodes import BuyResults

CHARTER_ENTRY = 5863
CHARTER_COST = 1000


class PetitionBuyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 23:  # Avoid handling empty petition buy packet
            npc_guid = unpack('<Q', reader.data[:8])[0]
            guild_name = PacketReader.read_string(reader.data, 20)

            if world_session.player_mgr.guild_manager.guid == 0:
                if npc_guid > 0:
                    if len(guild_name) > 2 and guild_name.replace(' ', '').isalpha():
                        if world_session.player_mgr.coinage >= CHARTER_COST:
                            charter_template = world_session.player_mgr.inventory.add_item(CHARTER_ENTRY,
                                                                                           handle_error=False)
                            if charter_template:
                                world_session.player_mgr.coinage -= CHARTER_COST
                        else:
                            world_session.player_mgr.inventory.send_buy_error(BuyResults.BUY_ERR_NOT_ENOUGH_MONEY,
                                                                              CHARTER_ENTRY, npc_guid)

        return 0
