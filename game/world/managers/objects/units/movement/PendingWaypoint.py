from game.world.managers.abstractions.Vector import Vector


class PendingWaypoint:
    def __init__(self, spline, id_, expected_timestamp, location):
        self.spline = spline
        self.id_: int = id_
        self.expected_timestamp: int = expected_timestamp
        self.location: Vector = location

    def is_complete(self, total_elapsed):
        return total_elapsed >= self.expected_timestamp
