from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants.UnitCodes import StandState


class LogoutCancelHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        world_session.player_mgr.set_stand_state(StandState.UNIT_STANDING)
        world_session.player_mgr.set_root(False)
        world_session.player_mgr.set_dirty()
        world_session.player_mgr.logout_timer = -1
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_CANCEL_ACK))

        return 0
