import math
from random import random
from struct import pack, unpack


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

    def __str__(self):
        return '%f, %f, %f. %f' % (self.x, self.y, self.z, self.o)

    @staticmethod
    def from_bytes(vector_bytes):
        vector = Vector()
        vector.x, vector.y, vector.z = unpack('<3f', vector_bytes[:12])
        if len(vector_bytes) == 16:
            vector.o = unpack('<f', vector_bytes[12:])[0]

        return vector

    def to_bytes(self, include_orientation=True):
        if include_orientation:
            return pack('<4f', self.x, self.y, self.z, self.o)
        return pack('<3f', self.x, self.y, self.z)

    def distance(self, vector=None, x=0, y=0, z=0):
        return math.sqrt(self.distance_sqrd(vector.x, vector.y, vector.z) if vector else self.distance_sqrd(x, y, z))

    def distance_sqrd(self, x, y, z):
        d_x = self.x - x
        d_y = self.y - y
        d_z = self.z - z

        return d_x ** 2 + d_y ** 2 + d_z ** 2

    def angle(self, vector=None, x=0, y=0):
        if not vector:
            vector = Vector(x=x, y=y)
        return math.atan2(vector.x - self.x, vector.y - self.y)

    # https://math.stackexchange.com/a/2045181
    def get_point_in_between(self, offset, vector=None, x=0, y=0, z=0):
        if not vector:
            vector = Vector(x=x, y=y, z=z)

        general_distance = self.distance(vector)
        # Location already in the given offset
        if general_distance <= offset:
            return None

        factor = offset / general_distance
        x3 = self.x + factor * (vector.x - self.x)
        y3 = self.y + factor * (vector.y - self.y)
        z3 = self.z + factor * (vector.z - self.z)

        return Vector(x3, y3, z3)

    # https://stackoverflow.com/a/50746409/4208583
    def get_random_point_in_radius(self, radius):
        r = radius * math.sqrt(random())
        theta = random() * 2 * math.pi

        x2 = self.x + (r * math.cos(theta))
        y2 = self.y + (r * math.sin(theta))
        z2 = self.z  # No mmaps yet :)

        return Vector(x2, y2, z2)
