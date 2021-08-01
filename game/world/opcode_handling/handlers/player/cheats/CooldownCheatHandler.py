from network.packet.PacketWriter import PacketWriter
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.OpCodes import OpCode
from struct import pack
from struct import unpack

class CooldownCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.is_gm:
            return 0

        for cooldown_entry in list(world_session.player_mgr.spell_manager.cooldowns): # Clear server-side cooldowns
            world_session.player_mgr.spell_manager.cooldowns.remove(cooldown_entry)

        data = pack('<Q', world_session.player_mgr.guid)
        world_session.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_COOLDOWN_CHEAT, data)) # Clear clientside cooldowns

        return 0