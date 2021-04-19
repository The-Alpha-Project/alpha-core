from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.GameObjectManager import GameObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import *


class GameObjectQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty gameobject query packet
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                gobject_mgr = GridManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
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
