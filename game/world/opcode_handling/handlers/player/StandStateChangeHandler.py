from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from struct import unpack

from utils.constants.UnitCodes import StandState


class StandStateChangeHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an empty stand state packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        state: int = unpack('<I', reader.data[:4])[0]
        player_mgr.set_stand_state(StandState(state))

        return 0
