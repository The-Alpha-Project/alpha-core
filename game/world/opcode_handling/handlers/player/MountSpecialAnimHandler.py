from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class MountSpecialAnimHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # TODO Not working, wrong packet data, or animation not implemented client side?
        player_guid = pack('<Q', world_session.player_mgr.guid)
        mount_anim_packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTSPECIAL_ANIM, player_guid)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_TEXT_EMOTE, mount_anim_packet),
                                    world_session.player_mgr, include_self=True)

        return 0
