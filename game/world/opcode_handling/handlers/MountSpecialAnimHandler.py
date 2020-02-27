from struct import pack, unpack

from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class MountSpecialAnimHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # TODO Not working, wrong packet data, or animation not implemented client side?
        player_guid = pack('<Q', world_session.player_mgr.guid)
        mount_anim_packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTSPECIAL_ANIM, player_guid)
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_TEXT_EMOTE, mount_anim_packet),
                                     world_session.player_mgr, include_self=True)

        return 0
