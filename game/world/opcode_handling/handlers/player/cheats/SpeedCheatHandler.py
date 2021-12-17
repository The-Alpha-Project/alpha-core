from network.packet.PacketWriter import *
from network.packet.PacketReader import *
from utils.Logger import Logger


class SpeedCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        speed = 0.0
        if world_session.player_mgr.is_gm:
            if len(reader.data) >= 52:  # Avoid handling empty speed cheat packet.
                speed = unpack('<f', reader.data[48:52])[0]
        else:
            # Disconnect if the player is not a GM as I haven't found a way to change turn speed back to normal.
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to use speed hacks.')
            return -1

        # A speed of 0 will ensure that the speed is reset to the default values if the player is not a GM.
        if reader.opcode == OpCode.MSG_MOVE_SET_RUN_SPEED_CHEAT:
            world_session.player_mgr.change_speed(speed)
        elif reader.opcode == OpCode.MSG_MOVE_SET_SWIM_SPEED_CHEAT:
            world_session.player_mgr.change_swim_speed(speed)
        elif reader.opcode == OpCode.MSG_MOVE_SET_WALK_SPEED_CHEAT:
            world_session.player_mgr.change_walk_speed(speed)
        elif reader.opcode == OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT:
            world_session.player_mgr.change_turn_speed(speed)
        else:
            return -1

        return 0
