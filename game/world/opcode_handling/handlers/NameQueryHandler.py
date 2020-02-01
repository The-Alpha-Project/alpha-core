from struct import pack, unpack

from network.packet.PacketWriter import *
from game.world.managers.PlayerManager import PlayerManager


class NameQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        socket.sendall(world_session.player_mgr.get_query_details())

        return 0
