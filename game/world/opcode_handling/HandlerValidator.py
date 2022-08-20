from utils.Logger import Logger
from utils.constants.OpCodes import OpCode


class HandlerValidator:

    @staticmethod
    def validate_session(world_session, opcode, disconnect=True):
        if not world_session:
            Logger.error(f'OpCode {OpCode(opcode).name}, Session was None.')
            return None, -1 if disconnect else 0

        if not world_session.player_mgr:
            Logger.error(f'OpCode {OpCode(opcode).name}, Session: {world_session.client_address} had None PlayerMgr'
                         f' instance. Disconnecting.')
            return None, -1 if disconnect else 0

        return world_session.player_mgr, 0
