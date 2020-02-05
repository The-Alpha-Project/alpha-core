import math


class Vector(object):
    def __init__(self, x=0, y=0, z=0):
        self.x = x
        self.y = y
        self.z = z

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y, self.z - other.z)

    def distance(self, vector):
        return math.sqrt(self.distance_sqrd(vector))

    def distance_sqrd(self, vector):
        d_x = self.x - vector.x
        d_y = self.y - vector.y
        d_z = self.z - vector.z

        return math.pow(d_x, 2) + math.pow(d_y, 2) + math.pow(d_z, 2)

    def angle(self, vector=None, x=0, y=0):
        if not vector:
            vector = Vector(x=x, y=y)
        return math.atan2(vector.x - self.x, vector.y - self.y)
