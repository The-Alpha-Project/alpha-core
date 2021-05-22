# OPCODE: CMSG_LEVELUP_CHEAT -- NOT THE SAME AS CMSG_LEVEL_CHEAT!
from struct import unpack

from network.packet.PacketWriter import *

class LevelUpCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if not world_session.player_mgr.is_gm:
            return 0

        world_session.player_mgr.mod_level(world_session.player_mgr.level + 1)

        return 0