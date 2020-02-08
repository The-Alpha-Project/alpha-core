from struct import pack, unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class NameQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        guid = unpack('<Q', reader.data)
        player = RealmDatabaseManager.character_get_by_guid(guid)
        if player:
            socket.sendall(NameQueryHandler.get_query_details(player))

        return 0

    @staticmethod
    def get_query_details(player):
        name_bytes = PacketWriter.string_to_bytes(player.name)
        player_data = pack(
            '<Q%usIII' % len(name_bytes),
            player.guid,
            name_bytes,
            player.race,
            player.gender,
            player.class_
        )
        return PacketWriter.get_packet(OpCode.SMSG_NAME_QUERY_RESPONSE, player_data)
