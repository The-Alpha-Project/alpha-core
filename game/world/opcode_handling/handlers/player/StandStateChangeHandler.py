from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import Emotes
from utils.constants.UnitCodes import StandState


class StandStateChangeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty stand state packet.
            state = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.set_stand_state(StandState(state))
            world_session.player_mgr.set_dirty()

        return 0
