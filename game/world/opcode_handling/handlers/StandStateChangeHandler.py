from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import Emotes
from utils.constants.UnitCodes import StandState


class StandStateChangeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty stand state packet
            state = unpack('<I', reader.data)[0]
            world_session.player_mgr.stand_state = StandState(state)
            world_session.player_mgr.flagged_for_update = True

        return 0
