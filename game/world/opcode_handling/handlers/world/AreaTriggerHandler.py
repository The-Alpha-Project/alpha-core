from struct import unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.ChatManager import ChatManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from utils.constants.UnitCodes import UnitFlags


class AreaTriggerHandler(object):

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

            # TODO: ScriptManager -> OnAreaTrigger.
            # Reward quest exploration objective if any.
            player_mgr.quest_manager.reward_quest_exploration(trigger_id)

            area_trigger_teleport = WorldDatabaseManager.area_trigger_teleport_get_by_id(trigger_id)
            if not area_trigger_teleport:
                return 0

            map_dbc = DbcDatabaseManager.map_get_by_id(area_trigger_teleport.target_map)
            if not map_dbc:
                Logger.debug(f'Player {player_mgr.get_name()} ignore invalid Area Trigger ID {trigger_id}, wrong map.')
                return 0

            if world_session.player_mgr.level <= area_trigger_teleport.required_level and \
                    not world_session.account_mgr.is_gm():
                # Missing SMSG_AREA_TRIGGER_MESSAGE.
                message = f'You must be at least level {area_trigger_teleport.required_level} to enter.'
                ChatManager.send_system_message(world_session, message)
                return 0

            # Trigger teleport.
            player_mgr.teleport(area_trigger_teleport.target_map, Vector(area_trigger_teleport.target_position_x,
                                                                         area_trigger_teleport.target_position_y,
                                                                         area_trigger_teleport.target_position_z,
                                                                         area_trigger_teleport.target_orientation))

        return 0
