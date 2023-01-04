from struct import unpack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.units.player.ChatManager import ChatManager


class AreaTriggerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty area trigger packet.
            trigger_id = unpack('<I', reader.data[:4])[0]
            location = WorldDatabaseManager.area_trigger_teleport_get_by_id(trigger_id)
            if location:
                if world_session.player_mgr.level >= location.required_level or world_session.account_mgr.is_gm():
                    world_session.player_mgr.teleport(location.target_map, Vector(location.target_position_x,
                                                                                  location.target_position_y,
                                                                                  location.target_position_z,
                                                                                  location.target_orientation))
                else:
                    # SMSG_AREA_TRIGGER_MESSAGE in 1.x, but this OpCode seems to be missing in 0.5.3
                    ChatManager.send_system_message(world_session,
                                                    f'You must be at least level {location.required_level} to enter.')
                return 0

            world_session.player_mgr.quest_manager.reward_exploration_completion(trigger_id)

        return 0
