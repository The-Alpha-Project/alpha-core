# OPCODE: CMSG_CHEAT_SETMONEY
from game.world.managers.objects.player.ChatManager import ChatManager
from struct import unpack

from network.packet.PacketWriter import *

class MoneyCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4: # Avoid handling empty packet!!
            if not world_session.player_mgr.is_gm:
                return 0

            newMoney = unpack('<L', reader.data[:4])[0]
            world_session.player_mgr.mod_money(newMoney)
            ChatManager.send_system_message(world_session, f'You receive {newMoney} copper.')

        return 0