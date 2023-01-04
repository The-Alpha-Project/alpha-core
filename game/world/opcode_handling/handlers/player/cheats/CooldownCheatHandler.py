from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from utils.Logger import Logger
from struct import pack


class CooldownCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=False)
        if not player_mgr:
            return res

        if not world_session.account_mgr.is_gm():
            Logger.anticheat(f'Player {player_mgr.get_name()} ({player_mgr.guid}) tried to remove his cooldowns.')
            return 0

        # Clear server-side cooldowns.
        player_mgr.spell_manager.flush_cooldowns()

        # Clear client-side cooldowns.
        data = pack('<Q', player_mgr.guid)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_CHEAT, data))

        return 0
