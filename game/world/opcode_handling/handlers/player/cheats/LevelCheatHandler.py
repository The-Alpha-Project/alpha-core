# OPCODE: CMSG_LEVEL_CHEAT
from game.world.managers.objects.player.ChatManager import ChatManager

from struct import unpack

from network.packet.PacketWriter import *

class LevelCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4: # Avoid empty packet
            if not world_session.player_mgr.is_gm:
                return 0

            newLevel = unpack('<L', reader.data[:4])[0]
            world_session.player_mgr.mod_level(newLevel)
            ChatManager.send_system_message(world_session, f'You are now level {newLevel}!')

        return 0