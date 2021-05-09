from struct import pack
from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import PacketWriter


class BankerActiveHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty guid
            guid = unpack('<Q', reader.data[:8])[0]
            npc = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if guid > 0 and npc:
                data = pack('<Q', guid)
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SHOW_BANK, data))
        return 0
