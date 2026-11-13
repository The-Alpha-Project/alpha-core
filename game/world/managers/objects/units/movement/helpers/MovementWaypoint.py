from game.world.managers.abstractions.Vector import Vector


class MovementWaypoint:
    def __init__(self, id_, x, y, z, orientation, wait_time_seconds, script_id=0):
        self.id = id_
        self.script_id = script_id
        self.location = Vector(x, y, z)
        self.orientation = orientation
        self.wait_time_seconds = wait_time_seconds  # On location wait time.
        self.total_wait_time_seconds = 0  # Spline travel time plus waypoint wait time.
        self.initialized = False
        self.completed = False
        # Ground following points of the leg to this waypoint, routes are fixed so they are computed once.
        self.leg_start = None
        self.leg_points = None

    def get_leg_points(self, unit):
        if not self.leg_points or self.leg_start.distance(unit.location) > 1.0:
            self.leg_start = unit.location.copy()
            self.leg_points = unit.get_map().get_ground_points(unit.location, self.location)
        return self.leg_points

    def set_total_wait_time_seconds(self, wait_time_seconds):
        self.total_wait_time_seconds = wait_time_seconds

    def update(self, elapsed):
        if self.completed:
            return
        self.total_wait_time_seconds = max(0, self.total_wait_time_seconds - elapsed)
        if not self.total_wait_time_seconds:
            self.completed = True

    def reset(self):
        self.total_wait_time_seconds = 0
        self.initialized = False
        self.completed = False
