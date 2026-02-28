from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.ObjectQueryUtils import ObjectQueryUtils


class GameObjectQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty gameobject query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0
        entry, guid = unpack('<IQ', reader.data[:12])
        if guid <= 0:
            return 0

        player_mgr = world_session.player_mgr
        gobject_mgr = player_mgr.get_map().get_surrounding_gameobject_by_guid(player_mgr, guid)
        if gobject_mgr:
            player_mgr.enqueue_packet(gobject_mgr.get_query_details_packet())
        else:  # Fallback just in case.
            go_template = WorldDatabaseManager.GameobjectTemplateHolder.gameobject_get_by_entry(entry)
            if go_template:
                player_mgr.enqueue_packet(ObjectQueryUtils.get_query_details_data(template=go_template))
        return 0
