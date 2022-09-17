from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.utils.GoQueryUtils import GoQueryUtils


class GameObjectQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty gameobject query packet.
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                player_mgr = world_session.player_mgr
                gobject_mgr = MapManager.get_surrounding_gameobject_by_guid(player_mgr, guid)
                if gobject_mgr:
                    player_mgr.enqueue_packet(GoQueryUtils.query_details(gameobject_mgr=gobject_mgr))
                else:  # Fallback just in case.
                    go_template = WorldDatabaseManager.GameobjectTemplateHolder.gameobject_get_by_entry(entry)
                    if go_template:
                        player_mgr.enqueue_packet(GoQueryUtils.query_details(gobject_template=go_template))
        return 0
