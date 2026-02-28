from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from struct import unpack


class SetWeaponModeHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an invalid set weapon mode packet.
        if not HandlerValidator.validate_packet_length(reader, exact_length=4):
            return 0
        weapon_mode: int = unpack('<I', reader.data[:4])[0]
        player_mgr.set_weapon_mode(weapon_mode)

        return 0
