from struct import pack, unpack

from network.packet.PacketWriter import *


class LookingForGroupHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        data = pack('<I', world_session.player_mgr.is_lfg)
        socket.sendall(PacketWriter.get_packet(OpCode.MSG_LOOKING_FOR_GROUP, data))

        return 0

    @staticmethod
    def handle_set(world_session, socket, reader):
        if len(reader.data) >= 4:
            world_session.player_mgr.is_lfg = bool(unpack('<I', reader.data)[0])

        return 0
