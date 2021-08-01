from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from struct import pack


class CooldownCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.is_gm:
            return 0

        # Clear server-side cooldowns
        for cooldown_entry in list(world_session.player_mgr.spell_manager.cooldowns):
            world_session.player_mgr.spell_manager.cooldowns.remove(cooldown_entry)

        # Clear clientside cooldowns
        data = pack('<Q', world_session.player_mgr.guid)
        world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_CHEAT, data))

        return 0
