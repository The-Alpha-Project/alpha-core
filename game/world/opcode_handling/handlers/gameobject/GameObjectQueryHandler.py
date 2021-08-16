from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager


class GameObjectQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty gameobject query packet.
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                gobject_mgr = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
                if not gobject_mgr:
                    gobject_spawn, session = WorldDatabaseManager.gameobject_spawn_get_by_guid(guid)
                    if gobject_spawn and gobject_spawn.gameobject.entry == entry:
                        gobject_mgr = GameObjectManager(
                            gobject_template=gobject_spawn.gameobject
                        )
                    session.close()
                if gobject_mgr:
                    world_session.enqueue_packet(gobject_mgr.query_details())

        return 0
