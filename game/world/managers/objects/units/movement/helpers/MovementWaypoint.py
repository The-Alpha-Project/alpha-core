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
