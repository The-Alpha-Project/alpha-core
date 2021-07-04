from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *


class DeathBindGetZoneHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.deathbind:
            area_number = MapManager.get_area_number_by_zone_id(world_session.player_mgr.deathbind.deathbind_zone)
            data = pack('<2I', world_session.player_mgr.map_, area_number)
            packet = PacketWriter.get_packet(OpCode.SMSG_BINDZONEREPLY, data)
            world_session.enqueue_packet(packet)

        return 0
