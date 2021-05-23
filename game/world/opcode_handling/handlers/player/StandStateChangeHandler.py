from network.packet.PacketReader import *
from struct import unpack

from utils.constants.UnitCodes import StandState


class StandStateChangeHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        if len(reader.data) >= 4:  # Avoid handling empty stand state packet.
            state: int = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.set_stand_state(StandState(state))
            world_session.player_mgr.set_dirty()

        return 0
