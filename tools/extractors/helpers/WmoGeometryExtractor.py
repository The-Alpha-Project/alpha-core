import os
import struct

from tools.extractors.definitions.chunks.MOHD import MOHD
from tools.extractors.definitions.objects.Wmo import Wmo, WMO_GEO_FILES_HASH_MAP
from tools.extractors.definitions.objects.WmoGroupFile import WmoGroupFile
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.pympqlib.MpqArchive import MpqArchive
from utils.Logger import Logger

class WmoGeometryExtractor:
    _MAGIC = b'WGEO'
    _VERSION = 3

    @classmethod
    def extract_to_file(cls, wmo_path, output_dir):
        with MpqArchive(wmo_path) as archive:
            data = archive.read_file_bytes()

        group_count = 0
        wmo_hash = Wmo.get_hash_filename(wmo_path)
        file_path = os.path.join(output_dir, f'{wmo_hash}.wgeo')
        try:
            with StreamReader(data) as reader, open(file_path, 'wb+') as f:
                header = cls._read_header(reader)
                if not header:
                    return False

                f.write(cls._MAGIC)
                f.write(struct.pack('<BBH', cls._VERSION, 0, 0))
                f.write(struct.pack('<I', 0))  # group_count placeholder

                total_groups = header.wmo_group_files_count
                current_group = 0
                for _ in range(total_groups):
                    current_group += 1
                    # Progress is helpful here since some WMOs have many groups.
                    Logger.progress(
                        f'Extracting WMO geometry for [{os.path.basename(wmo_path)}]...',
                        current_group,
                        total_groups,
                        divisions=total_groups,
                    )
                    error, token, size = reader.read_chunk_information('MOGP')
                    if error:
                        return False
                    group = WmoGroupFile.from_reader(reader, size=size, parse_geometry=True)
                    if not group.vertices or not group.indices:
                        continue

                    vertex_count = len(group.vertices)
                    tri_count = int(len(group.indices) / 3)
                    if tri_count <= 0:
                        continue

                    collidable_count = 0
                    for tri_index in range(tri_count):
                        tri_flags = group.triangle_flags[tri_index] if tri_index < len(group.triangle_flags) else 0
                        material_id = (group.triangle_materials[tri_index]
                                       if tri_index < len(group.triangle_materials) else 0xFF)
                        if not cls._is_collidable(tri_flags, material_id):
                            continue
                        idx = tri_index * 3
                        if idx + 2 >= len(group.indices):
                            continue
                        i0 = group.indices[idx]
                        i1 = group.indices[idx + 1]
                        i2 = group.indices[idx + 2]
                        if i0 >= vertex_count or i1 >= vertex_count or i2 >= vertex_count:
                            continue
                        collidable_count += 1

                    if collidable_count <= 0:
                        continue

                    index_size = 2 if vertex_count <= 0xFFFF else 4
                    f.write(struct.pack('<BBHII', index_size, 0, 0, vertex_count, collidable_count))

                    for vertex in group.vertices:
                        f.write(struct.pack('<fff', vertex.X, vertex.Y, vertex.Z))

                    for tri_index in range(tri_count):
                        tri_flags = group.triangle_flags[tri_index] if tri_index < len(group.triangle_flags) else 0
                        material_id = (group.triangle_materials[tri_index]
                                       if tri_index < len(group.triangle_materials) else 0xFF)
                        if not cls._is_collidable(tri_flags, material_id):
                            continue
                        idx = tri_index * 3
                        if idx + 2 >= len(group.indices):
                            continue
                        i0 = group.indices[idx]
                        i1 = group.indices[idx + 1]
                        i2 = group.indices[idx + 2]
                        if i0 >= vertex_count or i1 >= vertex_count or i2 >= vertex_count:
                            continue
                        if index_size == 2:
                            f.write(struct.pack('<HHH', i0, i1, i2))
                        else:
                            f.write(struct.pack('<III', i0, i1, i2))
                        f.write(struct.pack('<B', tri_flags))

                    group_count += 1

                f.seek(8)
                f.write(struct.pack('<I', group_count))
        except UnicodeDecodeError:
            return False

        WMO_GEO_FILES_HASH_MAP[wmo_hash] = file_path
        return True

    @staticmethod
    def _read_header(reader):
        error, token, size = reader.read_chunk_information('MVER')
        if error:
            return None
        version = reader.read_int32()
        if version != 14:
            return None

        error, token, size = reader.read_chunk_information('MOMO')
        if error:
            return None

        error, token, size = reader.read_chunk_information('MOHD')
        if error:
            return None
        header = MOHD.from_reader(reader)

        for expected in ('MOTX', 'MOMT', 'MOGN', 'MOGI', 'MOPV', 'MOPT', 'MOPR', 'MOLT', 'MODS', 'MODN', 'MODD', 'MFOG'):
            error, token, size = reader.read_chunk_information(expected)
            if error:
                return None
            reader.move_forward(size)

        error, token, size = reader.read_chunk_information('MCVP')
        if not error and token == 'MCVP':
            reader.move_forward(size)
        elif error and token != 'MOGP':
            return None

        return header

    @staticmethod
    def _is_collidable(flags, material_id):
        # Match client logic: flags bit 0x04 means no collision unless material id is 0xFF.
        return not (flags & 0x04 and material_id != 0xFF)
