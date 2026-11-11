from struct import pack, unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class NameQueryHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty name query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]
        # Online players (nearby or not) are answered from memory, only offline characters need the database.
        requested_player = WorldSessionStateHandler.find_player_by_guid(guid)

        if requested_player:
            player = requested_player.player
        else:
            player = RealmDatabaseManager.character_get_by_guid(guid)

        if player:
            player_mgr.enqueue_packet(NameQueryHandler.get_query_details(player))

        return 0

    @staticmethod
    def get_query_details(player) -> bytes:
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
