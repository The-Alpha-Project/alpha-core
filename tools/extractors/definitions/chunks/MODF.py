import math

from tools.extractors.definitions.objects.CAaBox import CAaBox
from tools.extractors.definitions.objects.Vector3 import Vector3
from utils.Matrix import Matrix


class MODF:
    def __init__(self):
        self.name_id = 0
        self.unique_id = 0
        self.position = None
        self.rotation = None
        self.extents = None
        self.flags = 0
        self.doodadSet = 0
        self.name_set = 0

    def get_transform_matrix(self):
        mid = 32.0 * 533.3333

        rot_x = self.rotation.Z * (math.pi / 180.0)
        rot_y = self.rotation.X * (math.pi / 180.0)
        rot_z = (self.rotation.Y + 180.0) * (math.pi / 180.0)

        base_position = Vector3(mid - self.position.Z, mid - self.position.X, self.position.Y)
        translation_matrix = Matrix.create_translation_matrix(base_position)

        matrix = (translation_matrix * Matrix.create_rotation_z(rot_z)
                  * Matrix.create_rotation_y(rot_y)
                  * Matrix.create_rotation_x(rot_x))

        return matrix

    @staticmethod
    def from_reader(stream_reader, size):

        final_pos = stream_reader.get_position() + size
        wmo_placements = []

        while stream_reader.get_position() < final_pos:
            modf = MODF()
            modf.name_id = stream_reader.read_uint32()
            modf.unique_id = stream_reader.read_uint32()
            modf.position = Vector3.from_reader(stream_reader)
            modf.rotation = Vector3.from_reader(stream_reader)
            modf.extents = CAaBox.from_reader(stream_reader)
            modf.flags = stream_reader.read_uint16()
            modf.doodadSet = stream_reader.read_uint16()
            stream_reader.read_uint32()  # Padding.
            wmo_placements.append(modf)

        return wmo_placements
