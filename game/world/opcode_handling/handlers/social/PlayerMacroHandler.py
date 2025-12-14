from struct import unpack
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode


class PlayerMacroHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty player macro packet.
            category = unpack('<I', reader.data[:4])[0]
            if 0x0 <= category <= 0xD:
                voice_packet = PacketWriter.get_packet(OpCode.SMSG_PLAYER_MACRO,
                                                       pack('<QI', world_session.player_mgr.guid,
                                                            category))
                world_session.player_mgr.get_map().send_surrounding(voice_packet, world_session.player_mgr,
                                                                    include_self=True)

        return 0
