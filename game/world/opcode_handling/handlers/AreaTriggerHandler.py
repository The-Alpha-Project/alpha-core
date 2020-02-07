from struct import pack, unpack

from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import *
from database.world.WorldDatabaseManager import WorldDatabaseManager


class AreaTriggerHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        trigger_id = unpack('<I', reader.data)[0]
        location = WorldDatabaseManager.area_trigger_teleport_get_by_id(trigger_id)
        if location and world_session.player_mgr.level >= location.required_level:
            world_session.player_mgr.teleport(location.target_map, Vector(location.target_position_x,
                                                                          location.target_position_y,
                                                                          location.target_position_z,
                                                                          location.target_orientation))

        return 0
