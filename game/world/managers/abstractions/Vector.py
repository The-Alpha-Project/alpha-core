import math


class Vector(object):
    def __init__(self, x=0, y=0, z=0, o=0):
        self.x = x
        self.y = y
        self.z = z
        self.o = o

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y, self.z - other.z)

    def distance(self, vector=None, x=0, y=0, z=0):
        return math.sqrt(self.distance_sqrd(vector.x, vector.y, vector.z) if vector else self.distance_sqrd(x, y, z))

    def distance_sqrd(self, x, y, z):
        d_x = self.x - x
        d_y = self.y - y
        d_z = self.z - z

        return math.pow(d_x, 2) + math.pow(d_y, 2) + math.pow(d_z, 2)

    def angle(self, vector=None, x=0, y=0):
        if not vector:
            vector = Vector(x=x, y=y)
        return math.atan2(vector.x - self.x, vector.y - self.y)
