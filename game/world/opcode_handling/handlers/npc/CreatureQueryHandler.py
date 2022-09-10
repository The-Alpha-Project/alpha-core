from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.creature.utils.UnitQueryUtils import UnitQueryUtils


class CreatureQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty creature query packet.
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                player_mgr = world_session.player_mgr
                creature_mgr = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)
                if creature_mgr:
                    player_mgr.enqueue_packet(UnitQueryUtils.query_details(creature_mgr=creature_mgr))
                else:  # Fallback just in case.
                    creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(entry)
                    if creature_template:
                        player_mgr.enqueue_packet(UnitQueryUtils.query_details(creature_template=creature_template))
        return 0
