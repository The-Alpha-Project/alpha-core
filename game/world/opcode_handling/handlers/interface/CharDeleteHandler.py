from struct import unpack

from database.realm.RealmDatabaseManager import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.CharCodes import *


class CharDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        guid = 0
        if len(reader.data) >= 8:  # Avoid handling empty area char delete packet.
            guid = unpack('<Q', reader.data[:8])[0]

        res = CharDelete.CHAR_DELETE_SUCCESS
        # Prevent Guild Masters from deleting their character.
        if RealmDatabaseManager.character_is_gm(guid):
            res = CharDelete.CHAR_DELETE_FAILED

        # Try to delete the character.
        if res != CharDelete.CHAR_DELETE_FAILED and (guid == 0 or RealmDatabaseManager.character_delete(guid) != 0):
            res = CharDelete.CHAR_DELETE_FAILED
            Logger.error(f'Error deleting character with guid {guid}.')

        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE, pack('<B', res)))

        return 0
