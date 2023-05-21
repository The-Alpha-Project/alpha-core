from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from utils.constants.MiscCodes import GameObjectTypes


class GameobjUseHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty gameobj use packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if guid > 0:
                gobject = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
                if gobject:
                    if gobject.gobject_template.type != GameObjectTypes.TYPE_GENERIC:
                        gobject.use(world_session.player_mgr, target=gobject)

        return 0
