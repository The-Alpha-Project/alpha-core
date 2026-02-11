from tools.extractors.definitions.chunks.MLIQ import MLIQ
from tools.extractors.definitions.enums.LiquidFlags import MOGP_Flags
from tools.extractors.definitions.objects.CAaBox import CAaBox
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.reader.StreamReader import StreamReader


class WmoGroupFile:
    def __init__(self):
        self.flags = 0
        self.bounding = None
        self.group_liquid = 0
        self.mliqs = []
        self.vertices = []
        self.indices = []
        self.triangle_flags = []
        self.triangle_materials = []

    def has_liquids(self):
        return bool(self.mliqs)

    @staticmethod
    def from_reader(reader: StreamReader, size=None, parse_geometry=False):
        wmo_group_file = WmoGroupFile()
        group_start = reader.get_position()

        reader.read_int32()  # group_name_start
        reader.read_int32()  # descriptive_group_name
        flags = reader.read_uint32()
        wmo_group_file.flags = flags
        wmo_group_file.bounding = CAaBox.from_reader(reader)
        reader.read_uint32()  # portal_start
        reader.read_uint32()  # portal_count
        reader.read_bytes(4)  # fogs_id
        wmo_group_file.group_liquid = reader.read_int32()

        # IntBatch.
        for i in range(0, 4):
            reader.read_uint16()  # Vert start.
            reader.read_uint16()  # Vert count.
            reader.read_uint16()  # Batch start.
            reader.read_uint16()  # Batch count.

        # ExtBatch.
        for i in range(0, 4):
            reader.read_uint16()  # Vert start.
            reader.read_uint16()  # Vert count.
            reader.read_uint16()  # Batch start.
            reader.read_uint16()  # Batch count.

        wmo_group_id = reader.read_uint32()
        reader.move_forward(8)  # Padding.

        end_position = group_start + (size if size is not None else 0)
        while reader.get_position() < end_position:
            error, token, chunk_size = reader.read_chunk_information()
            if error:
                raise ValueError(f'{error}')

            if token == 'MOPY':
                if parse_geometry:
                    # Alpha client MOPY is 4 bytes per tri: flags, padding, material, padding.
                    count = int(chunk_size / 4)
                    for _ in range(count):
                        wmo_group_file.triangle_flags.append(reader.read_uint8())
                        reader.read_uint8()  # padding
                        wmo_group_file.triangle_materials.append(reader.read_uint8())
                        reader.read_uint8()  # padding
                else:
                    reader.move_forward(chunk_size)
                continue

            if token == 'MOVT':
                if parse_geometry:
                    count = int(chunk_size / 12)
                    for _ in range(count):
                        x = reader.read_float()
                        y = reader.read_float()
                        z = reader.read_float()
                        wmo_group_file.vertices.append(Vector3(x, y, z))
                else:
                    reader.move_forward(chunk_size)
                continue

            if token == 'MOIN':
                reader.move_forward(chunk_size)
                continue

            if token == 'MOVI':
                reader.move_forward(chunk_size)
                continue

            if token == 'MLIQ':
                if MOGP_Flags.HasLiquids & flags:
                    final_position = reader.get_position() + chunk_size
                    while reader.get_position() < final_position:
                        wmo_group_file.mliqs.append(MLIQ.from_reader(reader, wmo_group_file.bounding.min, flags))
                else:
                    reader.move_forward(chunk_size)
                continue

            # Skip remaining chunks we don't need for extraction.
            reader.move_forward(chunk_size)

        if parse_geometry and not wmo_group_file.indices and wmo_group_file.triangle_flags:
            tri_count = len(wmo_group_file.triangle_flags)
            max_indices = min(len(wmo_group_file.vertices), tri_count * 3)
            max_indices -= max_indices % 3
            if max_indices > 0:
                wmo_group_file.indices = list(range(max_indices))

        return wmo_group_file
