from game.world.managers.maps.helpers.Constants import ADT_SIZE, RESOLUTION_LIQUIDS
from tools.extractors.definitions.objects.Index3 import Index3
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.helpers.Constants import Constants


class CLID:
    def __init__(self):
        self.vertices_count = 0
        self.vertices = []
        self.indices_count = 0
        self.triangles = []
        self.normals_count = 0
        self.normals = []

    @staticmethod
    def from_reader(reader: StreamReader, from_wmo=False):
        clid = CLID()

        reader.assert_token('VRTX')
        clid.vertices_count = reader.read_uint32()
        for v in range(clid.vertices_count):
            clid.vertices.append(Vector3.from_reader(reader))

        reader.assert_token('TRI')
        clid.indices_count = reader.read_uint32()
        for t in range(int(clid.indices_count / 3)):
            clid.triangles.append(Index3.from_reader(reader, from_wmo=from_wmo))

        reader.assert_token('NRMS')
        clid.normals_count = reader.read_uint32()
        for n in range(clid.normals_count):
            clid.normals.append(Vector3.from_reader(reader))

        return clid
