from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import *
from utils.constants.MiscCodes import LogoutResponseCodes
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState


class LogoutRequestHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if player_mgr.in_combat:
            res = LogoutResponseCodes.LOGOUT_CANCEL
        else:
            res = LogoutResponseCodes.LOGOUT_PROCEED
            if not player_mgr.is_swimming():
                player_mgr.set_stand_state(StandState.UNIT_SITTING)
            player_mgr.set_rooted(True)
            player_mgr.logout_timer = 20
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_RESPONSE, pack('<B', res)))

        return 0
