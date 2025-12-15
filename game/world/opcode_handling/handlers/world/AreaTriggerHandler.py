from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from utils.constants.MiscCodes import ScriptTypes
from utils.constants.UnitCodes import UnitFlags


class AreaTriggerHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 4:  # Avoid handling empty area trigger packet.
            trigger_id = unpack('<I', reader.data[:4])[0]

            # Validate world session.
            player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
            if not player_mgr:
                return res

            if player_mgr.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
                Logger.debug(f'Player {player_mgr.get_name()} ignore Area Trigger ID {trigger_id} due flying.')
                return 0

            area_trigger = DbcDatabaseManager.area_trigger_get_by_id(trigger_id)
            if not area_trigger:
                Logger.debug(f'Player {player_mgr.get_name()} ignore invalid DBC Area Trigger ID {trigger_id}.')
                return 0

            area_trigger_point = Vector(area_trigger.X, area_trigger.Y, area_trigger.Z)
            if area_trigger_point.distance(player_mgr.location) > area_trigger.Radius * 2:
                Logger.debug(f'Player {player_mgr.get_name()} ignore Area Trigger ID {trigger_id} due distance.')
                return 0

            # Reward quest exploration objective if any.
            player_mgr.quest_manager.reward_quest_exploration(trigger_id)

            # Check scripts (If any).
            player_mgr.get_map().enqueue_script(player_mgr, player_mgr, ScriptTypes.SCRIPT_TYPE_AREA_TRIGGER, trigger_id)

            area_trigger_teleport = WorldDatabaseManager.area_trigger_teleport_get_by_id(trigger_id)
            if not area_trigger_teleport:
                return 0

            map_dbc = DbcDatabaseManager.map_get_by_id(area_trigger_teleport.target_map)
            if not map_dbc:
                Logger.debug(f'Player {player_mgr.get_name()} ignore invalid Area Trigger ID {trigger_id}, wrong map.')
                return 0

            # No level requirement in 0.5.3. From 1.4.1 Patch Notes:
            #     World of Warcraft Client Patch 1.4.1 (2005-05-03)
            #     Added minimum level requirements to all instances to prevent
            #     exploitive behavior. The minimum levels are very generous and should
            #     not affect the normal course of gameplay.

            # Trigger teleport.
            player_mgr.teleport(area_trigger_teleport.target_map, Vector(area_trigger_teleport.target_position_x,
                                                                         area_trigger_teleport.target_position_y,
                                                                         area_trigger_teleport.target_position_z,
                                                                         area_trigger_teleport.target_orientation))

        return 0
