from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *


class MountSpecialAnimHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        # Animation is not implemented client side.
        data = pack('<Q', player_mgr.guid)
        mount_anim_packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTSPECIAL_ANIM, data)
        player_mgr.get_map().send_surrounding(mount_anim_packet, player_mgr)

        return 0
