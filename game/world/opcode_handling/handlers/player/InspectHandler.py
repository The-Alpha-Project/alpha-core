from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.player.TradeManager import TradeManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import GameObjectTypes, TradeStatus


class InspectHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty inspect packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                inspected_player = GridManager.get_surrounding_player_by_guid(world_session.player_mgr, guid)
                if not inspected_player or not inspected_player.is_alive:
                    return 0

                world_session.player_mgr.set_current_selection(guid)
                world_session.player_mgr.set_current_target(guid)
                world_session.player_mgr.set_dirty()

                data = pack('<Q', world_session.player_mgr.guid)
                inspected_player.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_INSPECT, data))
        return 0
