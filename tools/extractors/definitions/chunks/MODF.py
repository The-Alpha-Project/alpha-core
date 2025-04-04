from tools.extractors.definitions.objects.CAaBox import CAaBox
from tools.extractors.definitions.objects.Vector3 import Vector3


class MODF:
    def __init__(self):
        self.name_id = 0
        self.unique_id = 0
        self.position = 0
        self.rotation = 0
        self.extents = 0
        self.flags = 0
        self.doodadSet = 0
        self.name_set = 0

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
