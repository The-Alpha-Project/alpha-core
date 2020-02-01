from struct import pack, unpack

from network.packet.PacketWriter import *


class LogoutRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_COMPLETE))
        world_session.player_mgr.logout()

        return 0
