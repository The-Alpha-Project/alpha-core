from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from utils.Logger import Logger
from struct import pack


class CooldownCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.is_gm:
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to force remove there cooldowns.')
            return 0

        # Clear server-side cooldowns
        for cooldown_entry in list(world_session.player_mgr.spell_manager.cooldowns):
            world_session.player_mgr.spell_manager.cooldowns.remove(cooldown_entry)

        # Clear clientside cooldowns
        data = pack('<Q', world_session.player_mgr.guid)
        world_session.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_CHEAT, data))

        return 0
