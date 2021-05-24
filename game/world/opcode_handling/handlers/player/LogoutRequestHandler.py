from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import LogoutResponseCodes
from utils.constants.UnitCodes import StandState


class LogoutRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.in_combat:
            res: LogoutResponseCodes = LogoutResponseCodes.LOGOUT_CANCEL
        else:
            res = LogoutResponseCodes.LOGOUT_PROCEED
            world_session.player_mgr.set_stand_state(StandState.UNIT_SITTING)
            world_session.player_mgr.set_root(True)
            world_session.player_mgr.set_dirty()
            world_session.player_mgr.logout_timer = 20
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_RESPONSE, pack('<B', res)))

        return 0
