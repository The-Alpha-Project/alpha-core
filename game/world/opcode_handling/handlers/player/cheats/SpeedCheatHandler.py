from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from utils.Logger import Logger


class SpeedCheatHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to modify speed.')
            return -1

        if len(reader.data) >= 52:  # Avoid handling empty speed cheat packet.
            speed = unpack('<f', reader.data[48:52])[0]
            if reader.opcode == OpCode.MSG_MOVE_SET_RUN_SPEED_CHEAT:
                player_mgr.change_speed(speed)
            elif reader.opcode == OpCode.MSG_MOVE_SET_SWIM_SPEED_CHEAT:
                player_mgr.change_swim_speed(speed)
            elif reader.opcode == OpCode.MSG_MOVE_SET_WALK_SPEED_CHEAT:
                player_mgr.change_walk_speed(speed)
            elif reader.opcode == OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT:
                player_mgr.change_turn_speed(speed)

        return 0
