from io import BytesIO
import os
import struct

from game.world.managers.maps.helpers.Constants import BLOCK_SIZE
from tools.extractors.definitions.chunks.MDNM import MDMN
from tools.extractors.definitions.chunks.MONM import MONM
from tools.extractors.definitions.chunks.MPHD import MPHD
from utils.Logger import Logger
from tools.extractors.definitions.Adt import Adt
from tools.extractors.helpers.Constants import Constants
from tools.extractors.definitions.chunks.TileHeader import TileHeader
from tools.extractors.definitions.reader.StreamReader import StreamReader
from tools.extractors.definitions.objects.Wmo import Wmo, WMO_LIQ_FILES_HASH_MAP, WMO_GEO_FILES_HASH_MAP, WMO_FILE_PATHS_HASH_MAP
from tools.extractors.helpers.WmoGeometryExtractor import WmoGeometryExtractor
from utils.PathManager import PathManager


class Wdt:
    def __init__(self, dbc_map, mpq_reader, wow_data_path, mdx_data_path, adt_x, adt_y):
        self.name = dbc_map.name
        self.mpq_reader = mpq_reader
        self.stream_reader = None
        self.dbc_map = dbc_map
        self.adt_version = 0  # 18
        self.map_header = None
        self.wmo_filenames = []
        self.doodad_filenames = []
        self.wow_data_path = wow_data_path
        self.mdx_data_path = mdx_data_path
        self.tile_information = [[type[TileHeader] for _ in range(64)] for _ in range(64)]
        self.wmo_liquids = [[None for _ in range(64)] for _ in range(64)]
        self.wmo_heights = [[None for _ in range(64)] for _ in range(64)]
        self.map_liquids = [[None for _ in range(64)] for _ in range(64)]
        self.adt_x = adt_x
        self.adt_y = adt_y

    def __enter__(self):
        mpq_entry = self.mpq_reader.mpq_entries[0]
        self.stream_reader = StreamReader(BytesIO(self.mpq_reader.read_file_bytes(mpq_entry)))
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.stream_reader:
            self.stream_reader.close()
        self.stream_reader = None
        self.mpq_reader = None
        self.tile_information.clear()
        self.tile_information = None
        self.wmo_liquids = None
        self.wmo_heights = None

    def process(self):
        error, token, size = self.stream_reader.read_chunk_information('MVER')
        if error:
            Logger.warning(f'{error}')
            return

        self.adt_version = self.stream_reader.read_int32()
        if self.adt_version != 18:
            Logger.warning('Wrong ADT version.')
            return

        error, token, size = self.stream_reader.read_chunk_information('MPHD')
        if error:
            Logger.warning(f'{error}')
            return

        self.map_header = MPHD.from_reader(stream_reader=self.stream_reader)

        # Move to next token.
        error, token, size = self.stream_reader.read_chunk_information('MAIN')
        if error:
            Logger.warning(f'{error}')
            return

        # Tiles information.
        for x in range(BLOCK_SIZE):
            for y in range(BLOCK_SIZE):
                self.tile_information[x][y] = TileHeader.from_reader(self.stream_reader)


        error, token, size = self.stream_reader.read_chunk_information('MDNM')
        if error:
            Logger.warning(f'{error}')
            return

        with MDMN(stream_reader=self.stream_reader, size=size, data_path=self.mdx_data_path) as chunk:
            for filename in chunk.doodad_filenames:
                self.doodad_filenames.append(filename)

        # Move to next token.
        error, token, size = self.stream_reader.read_chunk_information('MONM')
        if error:
            Logger.warning(f'{error}')
            return

        with MONM(stream_reader=self.stream_reader, size=size, data_path=self.wow_data_path) as chunk:
            for filename in chunk.wmo_filenames:
                self.wmo_filenames.append(filename)

        self._ensure_wmo_cache()

        # Move to next token. (Optional)
        error, token, size = self.stream_reader.read_chunk_information('MODF')
        if error and token != 'MHDR':
            Logger.warning(f'{error}')
            return
        # Optional for WMO based.
        elif token == 'MODF':
            Logger.warning(f'Map [{self.dbc_map.name}] is WMO based, skipping.')
            pass  # TODO, wmo based.

        # ADT data.
        total = Constants.TILE_BLOCK_SIZE * Constants.TILE_BLOCK_SIZE
        current = 0
        for x in range(Constants.TILE_BLOCK_SIZE):
            for y in range(Constants.TILE_BLOCK_SIZE):
                current += 1
                tile_info: TileHeader = self.tile_information[x][y]
                Logger.progress(f'Processing ADT tiles for [{self.dbc_map.name}]...', current, total, divisions=total)
                if not tile_info or not tile_info.size:
                    continue

                if self.adt_x != -1 and x != self.adt_x or self.adt_y != -1 and y != self.adt_y:
                    continue

                self.stream_reader.set_position(tile_info.offset)
                # Parse and write .map file for this adt.
                with Adt.from_reader(
                        self.dbc_map.id,
                        x,
                        y,
                        self.wmo_filenames,
                        self.wmo_liquids,
                        self.wmo_heights,
                        self.stream_reader,
                ) as adt:
                    self.map_liquids[x][y] = adt.write_to_map_file()

        # Reset progress counter for the WMO liquid pass to avoid exceeding the total.
        current = 0
        for x in range(Constants.TILE_BLOCK_SIZE):
            for y in range(Constants.TILE_BLOCK_SIZE):
                current += 1
                Logger.progress(f'Processing WMO liquids for [{self.dbc_map.name}]...', current, total, divisions=total)

                if self.adt_x != -1 and x != self.adt_x or self.adt_y != -1 and y != self.adt_y:
                    continue

                Adt.write_liquids(self.dbc_map.id, x, y, self.map_liquids, self.wmo_liquids, self.wmo_heights)

    def _ensure_wmo_cache(self):
        if not self.wmo_filenames:
            return

        wmo_liquids_path = PathManager.get_wmo_liquids_path()
        wmo_geometry_path = PathManager.get_wmo_geometry_path()
        os.makedirs(wmo_liquids_path, exist_ok=True)
        os.makedirs(wmo_geometry_path, exist_ok=True)

        for filename in sorted({f for f in self.wmo_filenames if f}):
            if not os.path.exists(filename):
                continue
            wmo_hash = Wmo.get_hash_filename(filename)
            # Register every WMO path so height parsing can always resolve it.
            WMO_FILE_PATHS_HASH_MAP[wmo_hash] = filename

            liq_file = os.path.join(wmo_liquids_path, f'{wmo_hash}.liq')
            if self._has_wliq_v2(liq_file):
                WMO_LIQ_FILES_HASH_MAP[wmo_hash] = liq_file
            else:
                try:
                    with Wmo(filename) as wmo:
                        if wmo.has_liquids:
                            wmo.save_liquid_data(wmo_liquids_path)
                except Exception as e:
                    Logger.error(f'Error extracting WMO liquids for {filename}: {e}')

            wgeo_file = os.path.join(wmo_geometry_path, f'{wmo_hash}.wgeo')
            if self._has_wgeo_v3(wgeo_file):
                WMO_GEO_FILES_HASH_MAP[wmo_hash] = wgeo_file
            else:
                try:
                    WmoGeometryExtractor.extract_to_file(filename, wmo_geometry_path)
                except Exception as e:
                    Logger.error(f'Error extracting WMO geometry for {filename}: {e}')

    @staticmethod
    def _has_wliq_v2(file_path):
        try:
            with open(file_path, 'rb') as f:
                if f.read(4) != b'WLIQ':
                    return False
                version = struct.unpack('<H', f.read(2))[0]
                return version == 2
        except OSError:
            return False

    @staticmethod
    def _has_wgeo_v3(file_path):
        try:
            with open(file_path, 'rb') as f:
                if f.read(4) != b'WGEO':
                    return False
                header = f.read(4)
                if len(header) < 4:
                    return False
                version = struct.unpack('<B', header[:1])[0]
                return version == 3
        except OSError:
            return False
