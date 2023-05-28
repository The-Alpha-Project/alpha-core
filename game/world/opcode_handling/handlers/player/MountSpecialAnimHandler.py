from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class MountSpecialAnimHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        # TODO Not working, wrong packet data, or animation not implemented client side?
        player_guid = unpack('<Q', reader.data[:8])[0]
        data = pack('<Q', player_guid)
        mount_anim_packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTSPECIAL_ANIM, data)
        MapManager.send_surrounding(mount_anim_packet, player_mgr)

        return 0
