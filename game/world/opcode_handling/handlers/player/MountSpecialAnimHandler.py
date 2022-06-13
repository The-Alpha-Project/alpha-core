from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class MountSpecialAnimHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # TODO Not working, wrong packet data, or animation not implemented client side?
        player_guid = unpack('<Q', reader.data[:8])[0]
        data = pack('<Q', player_guid)
        mount_anim_packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTSPECIAL_ANIM, data)
        MapManager.send_surrounding(mount_anim_packet, world_session.player_mgr)

        return 0
