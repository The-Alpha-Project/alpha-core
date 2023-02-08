from database.world.WorldModels import CreatureMovement
from game.world.managers.abstractions.Vector import Vector


class MovementWaypoint:
    def __init__(self, creature_movement):
        self.creature_movement: CreatureMovement = creature_movement
        self._location = self._get_location()

    def _get_location(self):
        movement = self.creature_movement
        return Vector(movement.position_x, movement.position_y, movement.position_z)

    def id(self):
        return self.creature_movement.point

    def orientation(self):
        return self.creature_movement.orientation

    def location(self):
        return self._location

    def wait_time(self):
        return self.creature_movement.waittime

    def script_id(self):
        return self.creature_movement.script_id
