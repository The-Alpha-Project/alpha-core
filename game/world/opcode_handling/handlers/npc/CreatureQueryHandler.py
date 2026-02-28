from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.ObjectQueryUtils import ObjectQueryUtils


class CreatureQueryHandler:

    @staticmethod
    def handle(world_session, reader):
        # Avoid handling an empty creature query packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0
        entry, guid = unpack('<IQ', reader.data[:12])
        if not guid:
            return 0
        player_mgr = world_session.player_mgr
        creature_mgr = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if creature_mgr:
            player_mgr.enqueue_packet(creature_mgr.get_query_details_packet())
        else:  # Fallback just in case.
            creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(entry)
            if creature_template:
                player_mgr.enqueue_packet(ObjectQueryUtils.get_query_details_data(template=creature_template))
        return 0
