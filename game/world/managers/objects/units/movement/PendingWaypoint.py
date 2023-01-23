from game.world.managers.abstractions.Vector import Vector


class PendingWaypoint:
    def __init__(self, id_, expected_timestamp, location, elapsed=0):
        self.id_: int = id_
        self.expected_timestamp: int = expected_timestamp
        self.location: Vector = location
        self.elapsed: int = elapsed

    def update(self, elapsed):
        self.elapsed += elapsed
