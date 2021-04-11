from struct import pack, unpack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet
            zone = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.zone = zone
            world_session.player_mgr.quest_manager.update_surrounding_quest_status()

        return 0
