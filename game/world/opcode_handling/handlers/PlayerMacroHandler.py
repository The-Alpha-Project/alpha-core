from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import *


class PlayerMacroHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty player macro packet
            category = unpack('<I', reader.data[:4])[0]
            if 0x0 < category <= 0xD:
                voice_packet = PacketWriter.get_packet(OpCode.SMSG_PLAYER_MACRO,
                                                       pack('<QI', world_session.player_mgr.guid,
                                                            category))
                GridManager.send_surrounding(voice_packet, world_session.player_mgr, include_self=True)

        return 0
