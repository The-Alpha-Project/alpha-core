from struct import pack, unpack

from network.packet.PacketWriter import *


class LogoutRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        world_session.send_message(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_COMPLETE))
        world_session.player_mgr.logout()

        return 0
