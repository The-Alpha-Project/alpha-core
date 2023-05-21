from struct import unpack, pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class TabardVendorActivateHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty tabard vendor activate packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                data = pack('<Q', guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_TABARDVENDOR_ACTIVATE, data))

        return 0
