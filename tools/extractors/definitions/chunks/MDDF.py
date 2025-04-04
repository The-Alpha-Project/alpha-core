from tools.extractors.definitions.objects.Vector3 import Vector3


class MDDF:
    def __init__(self):
        self.name_id = 0
        self.unique_id = 0
        self.position = 0
        self.rotation = 0
        self.scale = 0
        self.flags = 0

    @staticmethod
    def from_reader(stream_reader, size):

        final_pos = stream_reader.get_position() + size
        doodad_placements = []

        while stream_reader.get_position() < final_pos:
            mddf = MDDF()
            mddf.name_id = stream_reader.read_uint32()
            mddf.unique_id = stream_reader.read_uint32()
            mddf.position = Vector3.from_reader(stream_reader)
            mddf.rotation = Vector3.from_reader(stream_reader)
            mddf.scale = stream_reader.read_uint16()
            mddf.flags = stream_reader.read_uint16()
            doodad_placements.append(mddf)

        return doodad_placements
