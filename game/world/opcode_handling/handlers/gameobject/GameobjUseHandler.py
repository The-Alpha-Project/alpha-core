from struct import pack, unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import GameObjectTypes


class GameobjUseHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty gameobj use packet
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                gobject = GridManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
                if gobject:
                    if gobject.gobject_template.type != GameObjectTypes.TYPE_GENERIC:
                        gobject.use(world_session.player_mgr)

        return 0
