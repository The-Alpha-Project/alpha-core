from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class PlayerMacroHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty player macro packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        category = unpack('<I', reader.data[:4])[0]
        if 0x0 <= category <= 0xD:
            voice_packet = PacketWriter.get_packet(OpCode.SMSG_PLAYER_MACRO,
                                                   pack('<QI', player_mgr.guid, category))
            player_mgr.get_map().send_surrounding(voice_packet, player_mgr, include_self=True)

        return 0
