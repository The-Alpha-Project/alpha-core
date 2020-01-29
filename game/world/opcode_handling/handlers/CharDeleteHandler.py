from struct import pack, unpack

from network.packet.PacketWriter import *
from database.realm.RealmDatabaseManager import *
from utils.Logger import Logger
from utils.constants.CharCodes import *


class CharDeleteHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        guid = unpack('!Q', packet)[0]
        res = CharDelete.CHAR_DELETE_SUCCESS.value
        if RealmDatabaseManager.character_delete(guid) != 0:
            res = CharDelete.CHAR_DELETE_FAILED.value
            Logger.error('Error deleting character with guid %s.' % guid)

        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE, pack('!B', res)))

        return 0
