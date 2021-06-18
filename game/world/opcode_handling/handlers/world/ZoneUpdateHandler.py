from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
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
                    explore_area = DbcDatabaseManager.get_explore_area(area.ID)
                    if explore_area and not player_mgr.has_area_explored(explore_area):
                        player_mgr.set_area_explored(explore_area)

            player_mgr.friends_manager.send_update_to_friends()
            if player_mgr.group_manager:
                player_mgr.group_manager.send_update()

        return 0
