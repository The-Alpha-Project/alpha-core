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

        if len(reader.data) >= 1:  # Avoid handling empty set weapon mode packet.
            weapon_mode: int = unpack('<B', reader.data[:1])[0]
            player_mgr.set_weapon_mode(weapon_mode)

        return 0
