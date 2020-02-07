from utils.constants.OpCodes import OpCode
from utils.Logger import Logger

from game.world.opcode_handling.handlers.AuthSessionHandler import AuthSessionHandler
from game.world.opcode_handling.handlers.PingHandler import PingHandler
from game.world.opcode_handling.handlers.CharEnumHandler import CharEnumHandler
from game.world.opcode_handling.handlers.CharCreateHandler import CharCreateHandler
from game.world.opcode_handling.handlers.CharDeleteHandler import CharDeleteHandler
from game.world.opcode_handling.handlers.ChatHandler import ChatHandler
from game.world.opcode_handling.handlers.PlayerLoginHandler import PlayerLoginHandler
from game.world.opcode_handling.handlers.NameQueryHandler import NameQueryHandler
from game.world.opcode_handling.handlers.TimeQueryHandler import TimeQueryHandler
from game.world.opcode_handling.handlers.LogoutRequestHandler import LogoutRequestHandler
from game.world.opcode_handling.handlers.WorldTeleportHandler import WorldTeleportHandler
from game.world.opcode_handling.handlers.AreaTriggerHandler import AreaTriggerHandler
from game.world.opcode_handling.handlers.MovementHandler import MovementHandler


HANDLER_DEFINITIONS = {
    OpCode.CMSG_AUTH_SESSION: AuthSessionHandler.handle,
    OpCode.CMSG_PING: PingHandler.handle,
    OpCode.CMSG_CHAR_ENUM: CharEnumHandler.handle,
    OpCode.CMSG_CHAR_CREATE: CharCreateHandler.handle,
    OpCode.CMSG_CHAR_DELETE: CharDeleteHandler.handle,
    OpCode.CMSG_MESSAGECHAT: ChatHandler.handle,
    OpCode.CMSG_PLAYER_LOGIN: PlayerLoginHandler.handle,
    OpCode.CMSG_NAME_QUERY: NameQueryHandler.handle,
    OpCode.CMSG_QUERY_TIME: TimeQueryHandler.handle,
    OpCode.CMSG_LOGOUT_REQUEST: LogoutRequestHandler.handle,
    OpCode.CMSG_WORLD_TELEPORT: WorldTeleportHandler.handle,
    OpCode.CMSG_AREATRIGGER: AreaTriggerHandler.handle,

    OpCode.MSG_MOVE_HEARTBEAT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_UNROOT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_ROOT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_PITCH: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_FACING: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_SWIM: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_SWIM: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_WALK_MODE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_SET_RUN_MODE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_PITCH: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_PITCH_DOWN: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_PITCH_UP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_TURN: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_TURN_LEFT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_TURN_RIGHT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_JUMP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP_STRAFE: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_STRAFE_RIGHT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_STRAFE_LEFT: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_STOP: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_BACKWARD: MovementHandler.handle_movement_status,
    OpCode.MSG_MOVE_START_FORWARD: MovementHandler.handle_movement_status,
}


class Definitions(object):

    @staticmethod
    def get_handler_from_packet(opcode):
        try:
            opcode_name = OpCode(opcode)
            if opcode_name in HANDLER_DEFINITIONS:
                return HANDLER_DEFINITIONS.get(OpCode(opcode))
            else:
                Logger.warning('Received %s OpCode but is not handled.' % opcode_name)
        except ValueError:
            Logger.error('Received unknown OpCode (%u)' % opcode)
        return None
