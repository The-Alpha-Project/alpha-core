from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from utils.Logger import Logger


class SpeedCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to modify speed.')
            return 0

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
