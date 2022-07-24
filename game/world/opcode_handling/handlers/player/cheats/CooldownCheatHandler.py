from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from utils.Logger import Logger
from struct import pack


class CooldownCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to remove his cooldowns.')
            return 0

        # Clear server-side cooldowns.
        for cooldown_entry in list(player_mgr.spell_manager.cooldowns):
            player_mgr.spell_manager.cooldowns.remove(cooldown_entry)

        # Clear client-side cooldowns.
        data = pack('<Q', player_mgr.guid)
        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_CHEAT, data))

        return 0
