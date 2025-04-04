from tools.extractors.definitions.objects.Vertex import Vertex
from tools.extractors.definitions.reader.BinaryReader import BinaryReader


class Doodad:
    def __init__(self, mpq_entry):
        self.mpq_entry = mpq_entry
        self.vertices = []
        self.indices = []
        self.has_geometry = False
        self._read()

    def _read(self):
        data = self.mpq_entry.read_file_bytes()

        self.reader = BinaryReader(data)
        with self.reader as reader:
            magic = reader.read_int()
            if magic != 1481393229:
                raise ValueError('INVALID_DOODAD_FILE.')
            version_magic = reader.read_int()
            if version_magic != 1397900630:
                raise ValueError('UNEXPECTED_VERTEX_MAGIC_IN_ALPHA_MODEL.')
            version_size = reader.read_int()
            if version_size != 4:
                raise ValueError('UNEXPECTED_VERSION_SIZE_IN_ALPHA_MODEL.')
            version = reader.read_int()
            if version != 1300:
                raise ValueError('UNSUPPORTED_ALPHA_MODEL_VERSION.')

            # Offset to collision.
            reader.seek(0x5C)
            reader.read_int()

            # Find DILC chunk.
            chunk_loc = reader.get_chunk_location('DILC')
            if chunk_loc == -1:
                return

            reader.seek(chunk_loc + 8)

            vertex_magic = reader.read_int()
            if vertex_magic != 1481921110:
                raise ValueError('UNEXPECTED_VERTEX_MAGIC_IN_ALPHA_MODEL.')

            vertex_count = reader.read_int()
            vertices_pos = reader.tell()

            reader.seek(vertices_pos + vertex_count * 12)

            index_magic = reader.read_int()
            if index_magic != 541676116:
                raise ValueError('UNEXPECTED_TRIANGLE_MAGIC_IN_ALPHA_MODEL.')

            index_count = reader.read_int()
            indices_pos = reader.tell()

            if not vertex_count or not index_count:
                return

            reader.seek(vertices_pos)
            self.vertices = [Vertex(reader.read_float(), reader.read_float(), reader.read_float())
                             for _ in range(vertex_count)]

            reader.seek(indices_pos)
            self.indices = [reader.read_short() for _ in range(index_count)]

            self.has_geometry = len(self.vertices) > 0 and len(self.vertices) > 0