from struct import pack, unpack

from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *
from utils.Logger import Logger
from utils.constants.CharCodes import *


class CharDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        guid = 0
        if len(reader.data) >= 8:  # Avoid handling empty area char delete packet
            guid = unpack('<Q', reader.data[:8])[0]

        res = CharDelete.CHAR_DELETE_SUCCESS
        if guid == 0 or RealmDatabaseManager.character_delete(guid) != 0:
            res = CharDelete.CHAR_DELETE_FAILED
            Logger.error(f'Error deleting character with guid {guid}.')

        world_session.send_message(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE, pack('<B', res)))

        return 0
