from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.GridManager import GridManager
from game.world.managers.objects.creature.CreatureManager import CreatureManager


class CreatureQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty creature query packet
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                creature_mgr = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
                if not creature_mgr:
                    creature_spawn, session = WorldDatabaseManager.creature_spawn_get_by_guid(guid)
                    if creature_spawn and creature_spawn.creature_template.entry == entry:
                        creature_mgr = CreatureManager(
                            creature_template=creature_spawn.creature_template
                        )
                    session.close()
                if creature_mgr:
                    world_session.enqueue_packet(creature_mgr.query_details())

        return 0
