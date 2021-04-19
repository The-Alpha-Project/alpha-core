from struct import pack, unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class NameQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty name query packet
            guid = unpack('<Q', reader.data[:8])[0]
            player_mgr = GridManager.get_surrounding_player_by_guid(world_session.player_mgr, guid)

            if player_mgr:
                player = player_mgr.player
            else:
                player = RealmDatabaseManager.character_get_by_guid(guid)

            if player:
                world_session.enqueue_packet(NameQueryHandler.get_query_details(player))

        return 0

    @staticmethod
    def get_query_details(player):
        name_bytes = PacketWriter.string_to_bytes(player.name)
        player_data = pack(
            f'<Q{len(name_bytes)}s3I',
            player.guid,
            name_bytes,
            player.race,
            player.gender,
            player.class_
        )
        return PacketWriter.get_packet(OpCode.SMSG_NAME_QUERY_RESPONSE, player_data)
