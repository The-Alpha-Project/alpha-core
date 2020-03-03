from struct import pack, unpack

from network.packet.PacketWriter import *


class SetWeaponModeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 1:  # Avoid handling empty set weapon mode packet
            weapon_mode = unpack('<B', reader.data[:1])[0]
            world_session.player_mgr.set_weapon_mode(weapon_mode)

        return 0
