from struct import pack, unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class NameQueryHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty name query packet.
            guid = unpack('<Q', reader.data[:8])[0]
            requested_player = player_mgr.get_map().get_surrounding_player_by_guid(world_session.player_mgr, guid)

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
