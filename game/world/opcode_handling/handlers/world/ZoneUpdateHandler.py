from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from utils.constants.UnitCodes import SplineFlags


class ZoneUpdateHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty zone update packet.
            zone = unpack('<I', reader.data[:4])[0]
            player_mgr = world_session.player_mgr
            player_mgr.zone = zone

            # Exploration handling (only if player is not flying).
            if not player_mgr.movement_spline or player_mgr.movement_spline.flags != SplineFlags.SPLINEFLAG_FLYING:
                area_number = MapManager.get_area_number(player_mgr.map_, player_mgr.location.x, player_mgr.location.y)
                area_table = DbcDatabaseManager.area_get_by_area_number(area_number, player_mgr.map_)
                area_explore_bit = MapManager.get_area_explore_flag(player_mgr.map_, player_mgr.location.x, player_mgr.location.y)
                area_level = MapManager.get_area_level(player_mgr.map_, player_mgr.location.x, player_mgr.location.y)
                if not player_mgr.has_area_explored(area_explore_bit):
                    player_mgr.set_area_explored(area_table.ID, area_explore_bit, area_level)

            # Update friends and group.
            player_mgr.friends_manager.send_update_to_friends()
            if player_mgr.group_manager:
                player_mgr.group_manager.send_update()

        return 0
