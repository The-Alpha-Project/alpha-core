from game.world.managers.abstractions.Vector import Vector


class MovementWaypoint:
    def __init__(self, id, x, y, z, orientation, wait_time_seconds, script_id=0):
        self.id = id
        self.script_id = script_id
        self.location = Vector(x,y,z)
        self.orientation = orientation
        self.wait_time_seconds = wait_time_seconds
