from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.UnitCodes import SplineFlags


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            player_mgr = world_session.player_mgr
            player_mgr.zone = zone

            if not player_mgr.movement_spline or player_mgr.movement_spline.flags != SplineFlags.SPLINEFLAG_FLYING:
                # Exploration check.
                area = DbcDatabaseManager.area_get_by_id_and_map_id(world_session.player_mgr.zone, world_session.player_mgr.map_)
                if area:
                    area_template = WorldDatabaseManager.get_explore_area(area.AreaName_enUS)
                    if area_template and not player_mgr.has_area_explored(area_template):
                        player_mgr.set_area_explored(area_template)

            player_mgr.friends_manager.send_update_to_friends()
            if player_mgr.group_manager:
                player_mgr.group_manager.send_update()

        return 0
