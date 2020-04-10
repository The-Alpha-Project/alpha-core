from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.GameObjectManager import GameObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import *


class GameObjectQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty item query packet
            entry, guid = unpack('<IQ', reader.data[:12])
            if guid > 0:
                gobject_spawn, session = WorldDatabaseManager.gameobject_template_get_by_guid(guid)
                if gobject_spawn and gobject_spawn.gameobject.entry == entry:
                    gobject_mgr = GameObjectManager(
                        gobject_template=gobject_spawn.gameobject
                    )
                    socket.sendall(gobject_mgr.query_details())
                session.close()

        return 0
