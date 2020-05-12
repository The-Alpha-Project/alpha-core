from struct import pack, unpack

from network.packet.PacketWriter import *


class RepopRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.player_mgr.respawn(force_update=False)
        world_session.player_mgr.send_update_self()
        world_session.player_mgr.teleport_deathbind()

        return 0
