from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState


class LogoutCancelHandler(object):

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        player_mgr.set_stand_state(StandState.UNIT_STANDING)
        player_mgr.set_rooted(False)
        player_mgr.logout_timer = -1
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_CANCEL_ACK))

        return 0
