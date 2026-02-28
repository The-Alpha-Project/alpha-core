from struct import unpack

from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from utils.constants.UnitCodes import UnitFlags


# Client console command playercombatlogdebug sends CMSG_ENABLEDEBUGCOMBATLOGGING
# with a single uint32 (0/1). When enabled, the client expects UNIT_FLAG_DEBUG_COMBAT_LOGGING to be set
# on the active player to open PlayerCombatLog.txt.
class DebugCombatLogHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res
        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to enable debug combat logging.')
            return 0

        enabled = False
        # Avoid handling an empty or truncated packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=4):
            return 0
        enabled = unpack('<I', reader.data[:4])[0] != 0

        player_mgr.set_unit_flag(UnitFlags.UNIT_FLAG_DEBUG_COMBAT_LOGGING, active=enabled)
        return 0
