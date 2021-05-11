import math
from random import random
from struct import pack, unpack

from game.world.managers.maps.MapManager import MapManager
from utils.ConfigManager import config


class Vector(object):
    """Class to represent points in a 3D space and utilities to work with them within the game."""

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
        return f'{self.x}, {self.y}, {self.z}. {self.o}'

    @staticmethod
    def from_bytes(vector_bytes):
        vector = Vector()
        vector.x, vector.y, vector.z = unpack('<3f', vector_bytes[:12])
        if len(vector_bytes) == 16:
            vector.o = unpack('<f', vector_bytes[12:])[0]

        return vector

    @staticmethod
    def _calculate_z(x, y, map_id, default_z=0.0):
        if map_id == -1 or not config.Server.Settings.use_map_tiles:
            return default_z
        else:
            # Calculate destination Z, default Z if not possible.
            return MapManager.calculate_z(map_id, x, y, default_z)

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
    # a map_id of -1 will make Z ignore map information.
    def get_point_in_between(self, offset, vector=None, x=0, y=0, z=0, map_id=-1):
        if not vector:
            vector = Vector(x=x, y=y, z=z)

        general_distance = self.distance(vector)
        # Location already in the given offset
        if general_distance <= offset:
            return None

        factor = offset / general_distance
        x3 = self.x + factor * (vector.x - self.x)
        y3 = self.y + factor * (vector.y - self.y)
        z3 = Vector._calculate_z(x3, y3, map_id, self.z + factor * (vector.z - self.z))

        return Vector(x3, y3, z3)

    def get_point_in_middle(self, vector, map_id=-1):
        x = (self.x + vector.x) / 2
        y = (self.y + vector.y) / 2
        z = Vector._calculate_z(x, y, map_id, (self.z + vector.z) / 2)

        return Vector(x, y, z)

    # https://stackoverflow.com/a/50746409/4208583
    def get_random_point_in_radius(self, radius, map_id=-1):
        r = radius * math.sqrt(random())
        theta = random() * 2 * math.pi

        x = self.x + (r * math.cos(theta))
        y = self.y + (r * math.sin(theta))
        z = Vector._calculate_z(x, y, map_id, self.z)

        return Vector(x, y, z)
