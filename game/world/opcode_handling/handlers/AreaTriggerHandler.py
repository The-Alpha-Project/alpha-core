from struct import pack, unpack

from game.world.managers.ChatManager import ChatManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import *
from database.world.WorldDatabaseManager import WorldDatabaseManager


class AreaTriggerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid handling empty area trigger packet
            trigger_id = unpack('<I', reader.data[:4])[0]
            location = WorldDatabaseManager.area_trigger_teleport_get_by_id(world_session.world_db_session, trigger_id)
            if location:
                if world_session.player_mgr.level >= location.required_level:
                    world_session.player_mgr.teleport(location.target_map, Vector(location.target_position_x,
                                                                                  location.target_position_y,
                                                                                  location.target_position_z,
                                                                                  location.target_orientation))
                else:
                    # SMSG_AREA_TRIGGER_MESSAGE in 1.x, but this OpCode seems to be missing in 0.5.3
                    ChatManager.send_system_message(world_session, 'You must be at least level %u to enter.' %
                                                    location.required_level)

        return 0
