from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter, OpCode


class TabardVendorActivateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty tabard vendor activate packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                data = pack('<Q', guid)
                world_session.send_message(PacketWriter.get_packet(OpCode.MSG_TABARDVENDOR_ACTIVATE, data))

        return 0
