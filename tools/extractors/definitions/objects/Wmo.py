import os

from tools.extractors.definitions.chunks.MOHD import MOHD
from tools.extractors.definitions.objects.WmoGroupFile import WmoGroupFile
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.pympqlib.MpqArchive import MpqArchive
from tools.extractors.helpers.Constants import Constants
import struct
import hashlib

WMO_LIQ_FILES_HASH_MAP = {}
WMO_FILE_PATHS_HASH_MAP = {}
WMO_GEO_FILES_HASH_MAP = {}

class Wmo:
    def __init__(self, file_path):
        self.file_path = file_path
        self.liquids_data = None
        self.has_liquids = False
        self.hash_name = Wmo.get_hash_filename(self.file_path)
        WMO_FILE_PATHS_HASH_MAP[self.hash_name] = self.file_path
        self._read()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.file_path = None
        self.liq_vertices = None
        self.hash_name = None

    @staticmethod
    def get_hash_filename(file_path):
        filename = os.path.basename(file_path)
        hash_obj = hashlib.md5(filename.encode('utf-8'))
        return hash_obj.hexdigest()

    def save_liquid_data(self, folder_path):
        file_name = os.path.join(folder_path, f'{self.hash_name}.liq')
        WMO_LIQ_FILES_HASH_MAP[self.hash_name] = file_name

        with open(file_name, 'wb') as f:
            f.write(Constants.WLIQ_MAGIC)
            f.write(struct.pack('<HHI', Constants.WLIQ_EXPECTED_VERSION, 0, len(self.liquids_data)))
            for liq_type, liq_min_bound, liq_corner, x_tiles, y_tiles in self.liquids_data:
                f.write(struct.pack('<B', liq_type))
                f.write(struct.pack('<fff', liq_min_bound.X, liq_min_bound.Y, liq_min_bound.Z))
                f.write(struct.pack('<fff', liq_corner.X, liq_corner.Y, liq_corner.Z))
                f.write(struct.pack('<HH', x_tiles, y_tiles))

    def _read(self):
        with MpqArchive(self.file_path) as archive:
            with StreamReader(archive.read_file_bytes()) as reader:

                error, token, size = reader.read_chunk_information('MVER')
                if error:
                    raise ValueError(f'{error}')

                version = reader.read_int32()
                if version != 14:
                    raise ValueError('Wrong wmo version.')

                # Rather than all chunks being top level, they have been wrapped in MOMO.
                error, token, size = reader.read_chunk_information('MOMO')
                if error:
                    raise ValueError(f'{error}')

                # Header for the map object. 64 bytes.
                error, token, size = reader.read_chunk_information('MOHD')
                if error:
                    raise ValueError(f'{error}')
                header = MOHD.from_reader(reader)

                # List of textures (BLP Files) used in this map object.
                error, token, size = reader.read_chunk_information('MOTX')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Materials used in this map object, 64 bytes per texture (BLP file).
                error, token, size = reader.read_chunk_information('MOMT')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # List of group names for the groups in this map object.
                error, token, size = reader.read_chunk_information('MOGN')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Group information for WMO groups, 32 bytes per group, nGroups entries.
                error, token, size = reader.read_chunk_information('MOGI')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Portal vertices, one entry is a float[3], usually 4 * 3 * float per portal.
                error, token, size = reader.read_chunk_information('MOPV')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Portal information. 20 bytes per portal, nPortals entries.
                error, token, size = reader.read_chunk_information('MOPT')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Map Object Portal References from groups. Mostly twice the number of portals.
                error, token, size = reader.read_chunk_information('MOPR')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Lighting information. 48 bytes per light, nLights entries.
                error, token, size = reader.read_chunk_information('MOLT')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # This chunk defines doodad sets. There are 32 bytes per doodad set.
                error, token, size = reader.read_chunk_information('MODS')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # List of filenames for Mdx models that appear in this WMO.
                error, token, size = reader.read_chunk_information('MODN')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Information for doodad instances. 40 bytes per doodad instance, nDoodads entries.
                error, token, size = reader.read_chunk_information('MODD')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Fog information. Made up of blocks of 48 bytes.
                error, token, size = reader.read_chunk_information('MFOG')
                if error:
                    raise ValueError(f'{error}')
                reader.move_forward(size)

                # Optional, client moves pointer before checking for groups.
                error, token, size = reader.read_chunk_information('MCVP')
                if token == 'MCVP':
                    reader.move_forward(size)
                elif error and token != 'MOGP':
                    raise ValueError(f'{error}')

                # WMO groups.
                for group_file in range(0, header.wmo_group_files_count):
                    error, token, size = reader.read_chunk_information('MOGP')
                    if error:
                        raise ValueError(f'{error}')
                    wmo_group_file = WmoGroupFile.from_reader(reader, size=size, parse_geometry=False)
                    if not wmo_group_file.has_liquids():
                        continue
                    self.has_liquids = True
                    # Initialize liquids data holder.
                    if not self.liquids_data:
                        self.liquids_data = []
                    # Store compact liquid tiles info for each chunk.
                    for mliq in wmo_group_file.mliqs:
                        self.liquids_data.append((
                            mliq.liquid_type,
                            mliq.min_bound,
                            mliq.corner,
                            mliq.x_tiles,
                            mliq.y_tiles,
                        ))
