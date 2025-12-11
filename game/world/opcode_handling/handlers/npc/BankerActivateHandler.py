from struct import pack
from network.packet.PacketReader import *
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class BankerActivateHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty banker activate packet.
            guid = unpack('<Q', reader.data[:8])[0]
            banker = world_session.player_mgr.get_map().get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if banker:
                data = pack('<Q', guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOW_BANK, data))
        return 0
