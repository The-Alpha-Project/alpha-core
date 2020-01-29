from struct import pack, unpack

from network.packet.PacketWriter import *
from game.world.objects.PlayerManager import PlayerManager
from database.realm.RealmDatabaseManager import *
from utils.Logger import Logger


class PlayerLoginHandler(object):

    @staticmethod
    def handle(world_session, socket, packet):
        guid = unpack('>Q', packet)[0]

        world_session.player_mgr = PlayerManager(RealmDatabaseManager.character_get_by_guid(guid))
        if not world_session.player_mgr.player:
            Logger.error('Character with wrong guid (%u) tried to login.' % guid)
            return -1

        PlayerLoginHandler._send_tutorial_packet(socket)
        return 0

    @staticmethod
    def _send_tutorial_packet(socket):
        # Not handling any tutorial (is that even implemented?)
        socket.sendall(PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, b'\xFF' * 32))
