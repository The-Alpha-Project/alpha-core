import math
from struct import pack
from typing import NamedTuple

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world import WorldManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import UnitFields


class MovementManager(object):
    def __init__(self, unit):
        self.unit = unit
        self.is_player = self.unit.get_type() == ObjectTypes.TYPE_PLAYER
        self.should_update_waypoints = False
        self.pending_waypoints = []
        self.time_per_point = 0
        self.waypoint_timer = 0

    def update_pending_waypoints(self, elapsed):
        if not self.should_update_waypoints:
            return

        self.waypoint_timer += elapsed

        if self.waypoint_timer > self.time_per_point:
            self.unit.location = self.pending_waypoints[0]
            GridManager.update_object(self.unit)

            self.waypoint_timer = 0
            self.pending_waypoints.pop(0)

        if len(self.pending_waypoints) == 0:
            if self.is_player and self.unit.pending_taxi_destination:
                self.unit.unit_flags &= ~(UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)
                self.unit.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit.unit_flags)
                self.unit.unmount()
                self.unit.teleport(self.unit.map_, self.unit.pending_taxi_destination)
                self.unit.pending_taxi_destination = None
            self.should_update_waypoints = False
            self.time_per_point = 0
            self.waypoint_timer = 0

    def send_move_to(self, waypoints, speed, spline_flag):
        self.should_update_waypoints = False
        self.pending_waypoints.clear()

        data = pack('<Q3fIBI',
                    self.unit.guid,
                    self.unit.location.x,
                    self.unit.location.y,
                    self.unit.location.z,
                    int(WorldManager.get_seconds_since_startup() * 1000),
                    0,
                    spline_flag
                    )

        waypoints_data = b''
        waypoints_length = len(waypoints)
        last_waypoint = self.unit.location
        total_distance = 0
        for waypoint in waypoints:
            waypoints_data += pack('<3f',
                                   waypoint.x,
                                   waypoint.y,
                                   waypoint.z)
            current_distance = last_waypoint.distance(waypoint)
            total_distance += current_distance
            self.pending_waypoints.append(waypoint)

            last_waypoint = waypoint

        total_time = int(total_distance / speed)
        data += pack('<2I%us' % len(waypoints_data),
                     total_time * 1000,
                     waypoints_length,
                     waypoints_data
                     )

        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_MONSTER_MOVE, data), self.unit,
                                     include_self=self.is_player)

        self.time_per_point = total_time / waypoints_length
        self.should_update_waypoints = True
