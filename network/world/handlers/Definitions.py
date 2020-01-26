from utils.constants.OpCodes import OpCode
from utils.Logger import Logger

from network.world.handlers.auth.AuthSessionHandler import AuthSessionHandler
from network.world.handlers.auth.PingHandler import PingHandler


HANDLER_DEFINITIONS = {
    OpCode.CMSG_AUTH_SESSION: AuthSessionHandler.handle,
    OpCode.CMSG_PING: PingHandler.handle
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
