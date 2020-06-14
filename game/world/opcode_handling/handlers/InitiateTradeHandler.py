from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.player.TradeManager import TradeManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import GameObjectTypes, TradeStatuses


class InitiateTradeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty initiate trade packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                trade_player = GridManager.get_surrounding_player_by_guid(world_session.player_mgr, guid)
                if not trade_player or not trade_player.is_alive:
                    TradeManager.send_trade_status(world_session.player_mgr, TradeStatuses.TRADE_STATUS_PLAYER_NOT_FOUND)
                    return 0

                # TODO: Finish implementing everything
        return 0
