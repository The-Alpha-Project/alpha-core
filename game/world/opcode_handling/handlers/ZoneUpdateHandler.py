from struct import pack, unpack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        zone = unpack('<I', reader.data)[0]

        world_session.player_mgr.zone = zone

        return 0
