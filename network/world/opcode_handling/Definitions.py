from utils.constants.OpCodes import OpCode
from utils.Logger import Logger

from network.world.opcode_handling.handlers.AuthSessionHandler import AuthSessionHandler
from network.world.opcode_handling.handlers.PingHandler import PingHandler
from network.world.opcode_handling.handlers.CharEnumHandler import CharEnumHandler


HANDLER_DEFINITIONS = {
    OpCode.CMSG_AUTH_SESSION: AuthSessionHandler.handle,
    OpCode.CMSG_PING: PingHandler.handle,
    OpCode.CMSG_CHAR_ENUM: CharEnumHandler.handle
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
