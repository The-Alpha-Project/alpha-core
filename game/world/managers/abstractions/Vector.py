import math
from random import random
from struct import pack, unpack

from game.world.managers.maps.MapManager import MapManager
from utils.ConfigManager import config


class Vector(object):
    """Class to represent points in a 3D space and utilities to work with them within the game."""

    def __init__(self, x=0, y=0, z=0, o=0, z_locked=False):
        self.x = x
        self.y = y
        self.z = z
        self.o = o
        self.z_locked = z_locked

    def __add__(self, other):
        return Vector(self.x + other.x, self.y + other.y, self.z + other.z)

    def __sub__(self, other):
        return Vector(self.x - other.x, self.y - other.y, self.z - other.z)

    def __str__(self):
        return f'{self.x}, {self.y}, {self.z}, {self.o}'

    def __eq__(self, other):
        return other and self.x == other.x and self.y == other.y and self.z == other.z

    @staticmethod
    def from_bytes(vector_bytes):
        vector = Vector()
        vector.x, vector.y, vector.z = unpack('<3f', vector_bytes[:12])
        if len(vector_bytes) == 16:
            vector.o = unpack('<f', vector_bytes[12:])[0]

        return vector

    @staticmethod
    def calculate_z(x, y, map_id, default_z=0.0) -> tuple:  # float, z_locked (Could not use map files Z)
        if map_id == -1 or (not config.Server.Settings.use_map_tiles and not config.Server.Settings.use_nav_tiles):
            return default_z, False
        else:
            # Calculate destination Z, default Z if not possible.
            return MapManager.calculate_z(map_id, x, y, default_z)

    def set_orientation(self, orientation):
        self.o = orientation

    def get_ray_vector(self, world_object=None, is_terrain=False):
        new_vector = self.copy()
        if world_object:
            # TODO: Find model height? CreatureModelData.dbc in later versions, in 0.5.3 it's probably part of the mdx.
            new_vector.z += (1.8 * world_object.native_scale)
        elif is_terrain:
            new_vector.z += 0.1  # TODO: Namigator floating point issue? Investigate, this shouldn't be needed.
        return new_vector

    def to_bytes(self, include_orientation=True):
        if include_orientation:
            return pack('<4f', self.x, self.y, self.z, self.o)
        return pack('<3f', self.x, self.y, self.z)

    def copy(self):
        return Vector(self.x, self.y, self.z, self.o)

    def flush(self):
        self.x = self.y = self.z = self.o = 0

    def distance(self, vector=None, x=0, y=0, z=0, decimals=3):
        return round(math.sqrt(self.distance_sqrd(vector) if vector else
                               self.distance_sqrd(x=x, y=y, z=z)), decimals)

    def distance_sqrd(self, vector=None, x=0, y=0, z=0):
        d_x = self.x - (vector.x if vector else x)
        d_y = self.y - (vector.y if vector else y)
        d_z = self.z - (vector.z if vector else z)

        return d_x ** 2 + d_y ** 2 + d_z ** 2

    def angle(self, vector=None, x=0, y=0):
        if not vector:
            vector = Vector(x=x, y=y)
        return math.atan2(vector.x - self.x, vector.y - self.y)

    def has_in_arc(self, vector, arc):
        vector_angle = self.angle(vector) % (2 * math.pi)

        # Orientation is offset by 90°
        vector_angle += (self.o - math.pi / 2) % (2 * math.pi)

        # Translate arc to 0..pi*2
        arc = arc % (math.pi * 2)

        # Translate total angle to -pi..pi
        vector_angle = vector_angle % (2 * math.pi)
        if vector_angle > math.pi:
            vector_angle -= 2 * math.pi

        return -arc / 2 < vector_angle < arc / 2

    def face_angle(self, angle):
        self.set_orientation(angle)

    def face_point(self, vector):
        self.set_orientation(self.get_angle_towards_vector(vector))

    def get_angle_towards_vector(self, vector):
        # orientation is offset by pi/2 and reversed to atan2.
        vector_angle = -self.angle(vector) + math.pi / 2
        return vector_angle % (2 * math.pi)

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
        z3, z_locked = Vector.calculate_z(x3, y3, map_id, self.z + factor * (vector.z - self.z))

        result = Vector(x3, y3, z3, z_locked=z_locked)
        orientation = self.o if self.o != 0 else self.get_angle_towards_vector(result)
        result.set_orientation(orientation)

        return result

    def get_point_in_middle(self, vector, map_id=-1):
        x = (self.x + vector.x) / 2
        y = (self.y + vector.y) / 2
        z, z_locked = Vector.calculate_z(x, y, map_id, (self.z + vector.z) / 2)

        return Vector(x, y, z, z_locked=z_locked)

    # https://stackoverflow.com/a/50746409/4208583
    def get_random_point_in_radius(self, radius, map_id=-1):
        r = radius * math.sqrt(random())
        theta = random() * 2 * math.pi

        x = self.x + (r * math.cos(theta))
        y = self.y + (r * math.sin(theta))
        z, z_locked = Vector.calculate_z(x, y, map_id, self.z)

        return Vector(x, y, z, z_locked=z_locked)

    def get_point_in_radius_and_angle(self, radius, angle, final_orientation=-1, map_id=-1):
        x = self.x + (radius * math.cos(self.o + angle))
        y = self.y + (radius * math.sin(self.o + angle))
        z, z_locked = Vector.calculate_z(x, y, map_id, self.z)
        o = self.o if final_orientation == -1 else final_orientation

        return Vector(x, y, z, o, z_locked=z_locked)
