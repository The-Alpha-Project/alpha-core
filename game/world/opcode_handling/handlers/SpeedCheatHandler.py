from struct import pack, unpack

from network.packet.PacketWriter import *
from utils.Logger import Logger


class SpeedCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.is_gm:
            Logger.anticheat('Player %s (%s) tried to use speed hacks.' % (world_session.player_mgr.player.name,
                                                                           world_session.player_mgr.guid))
            if reader.opcode == OpCode.MSG_MOVE_SET_RUN_SPEED_CHEAT:
                world_session.player_mgr.change_speed()
            elif reader.opcode == OpCode.MSG_MOVE_SET_SWIM_SPEED_CHEAT:
                world_session.player_mgr.change_swim_speed()
            elif reader.opcode == OpCode.MSG_MOVE_SET_WALK_SPEED_CHEAT:
                world_session.player_mgr.change_walk_speed()
            elif reader.opcode == OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT:
                # world_session.player_mgr.change_turn_speed()
                # Disconnect as I haven't found a way to change turn speed back to normal
                return -1

        return 0

