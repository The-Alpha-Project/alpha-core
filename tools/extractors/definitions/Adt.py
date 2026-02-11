import os
from struct import pack

from tools.extractors.definitions.chunks.MDDF import MDDF
from tools.extractors.definitions.chunks.MHDR import MHDR
from tools.extractors.definitions.chunks.MODF import MODF
from tools.extractors.helpers.WmoLiquidParser import WmoLiquidParser
from tools.extractors.helpers.WmoHeightParser import WmoHeightParser
from utils.Logger import Logger
from utils.ConfigManager import config
from utils.Float16 import Float16
from utils.PathManager import PathManager
from network.packet.PacketWriter import PacketWriter
from tools.extractors.helpers.Constants import Constants
from tools.extractors.helpers.DataHolders import DataHolders
from tools.extractors.helpers.HeightField import HeightField
from tools.extractors.helpers.LiquidAdtWriter import LiquidAdtWriter
from tools.extractors.definitions.chunks.TileHeader import TileHeader
from tools.extractors.definitions.chunks.TileInformation import TileInformation


class Adt:
    def __init__(self, map_id, x, y, wmo_filenames, wmo_liquids, wmo_heights=None):
        self.map_id = map_id
        self.adt_x = x
        self.adt_y = y
        self.is_flat = True
        self.header = None
        self.wmo_placements = None
        self.wmo_liquids = wmo_liquids
        self.wmo_heights = wmo_heights
        self.wmo_filenames = wmo_filenames
        self.doodad_placements = None
        self.chunks_information = [[type[TileHeader] for _ in range(16)] for _ in range(16)]
        self.tiles = [[type[TileInformation] for _ in range(16)] for _ in range(16)]

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.wmo_placements = None
        self.header = None
        self.chunks_information.clear()
        self.chunks_information = None
        self.tiles.clear()
        self.tiles = None
        self.wmo_names = None

    @staticmethod
    def get_filepath(map_id, adt_x, adt_y):
        filename = f'{map_id:03}{adt_x:02}{adt_y:02}.map'
        return os.path.join(PathManager.get_maps_path(), filename)

    def write_to_map_file(self):
        with open(Adt.get_filepath(self.map_id, self.adt_x, self.adt_y), 'wb') as file_writer:
            # Write version.
            file_writer.write(PacketWriter.string_to_bytes(Constants.MAPS_VERSION))
            # Write heightmap mode + data.
            uniform_height = self._get_uniform_height()
            if uniform_height is not None:
                file_writer.write(pack('<b', Constants.HEIGHTMAP_MODE_UNIFORM))
                if config.Extractor.Maps.use_float_16:
                    file_writer.write(pack('>h', Float16.compress(uniform_height)))
                else:
                    file_writer.write(pack('<f', uniform_height))
            else:
                file_writer.write(pack('<b', Constants.HEIGHTMAP_MODE_V8V9))
                self._write_heightfield(file_writer)
            # Write area information.
            self._write_area_information(file_writer)
            # Parse Wmo liquids:
            #  Wmo liquids are writen once all Wdt Adt's are parsed since liquids can overlap tiles.
            with WmoLiquidParser(self) as wmo_liquids:
                wmo_liquids.parse(self.wmo_liquids)
            # Parse WMO height geometry for interior floors/ceilings.
            with WmoHeightParser(self) as wmo_heights:
                wmo_heights.parse(self.wmo_heights)
        return self._collect_liquids()

    def _write_heightfield(self, file_writer):
        with HeightField(self) as heightfield:
            heightfield.write_to_file(file_writer)

    def _collect_liquids(self):
        with LiquidAdtWriter(self) as liquids:
            return liquids.collect_cells()

    def _get_uniform_height(self):
        if not self.is_flat:
            return None
        uniform_height = None
        for x in range(Constants.TILE_SIZE):
            for y in range(Constants.TILE_SIZE):
                tile = self.tiles[x][y]
                if not tile or not tile.mcvt or not tile.mcvt.is_flat:
                    return None
                height = tile.mcvt.flat_height
                if uniform_height is None:
                    uniform_height = height
                elif height != uniform_height:
                    return None
        return uniform_height

    @staticmethod
    def write_liquids(map_id, adt_x, adt_y, map_liquids, wmo_liquids, wmo_heights=None):
        map_path = Adt.get_filepath(map_id, adt_x, adt_y)
        if not os.path.exists(map_path):
            return

        with open(Adt.get_filepath(map_id, adt_x, adt_y), 'ab') as file_writer:
            adt_wmo_liquids = wmo_liquids[adt_x][adt_y] if wmo_liquids else None
            adt_map_liquids = map_liquids[adt_x][adt_y] if map_liquids else None
            adt_wmo_heights = wmo_heights[adt_x][adt_y] if wmo_heights else None

            liquid_cells = []
            for y in range(Constants.GRID_SIZE):
                for x in range(Constants.GRID_SIZE):
                    layers = []
                    if adt_wmo_liquids:
                        wmo_cell = adt_wmo_liquids[x][y]
                        if wmo_cell:
                            for z_max, z_min, liq_type in wmo_cell:
                                layers.append((liq_type, True, z_min, z_max))
                    if not layers and adt_map_liquids:
                        # ADT liquid grid uses swapped axes relative to world cell coordinates.
                        map_cell = adt_map_liquids.get((y, x))
                        if map_cell:
                            liq_type, l_max = map_cell
                            layers.append((liq_type, False, None, l_max))

                    if layers:
                        liquid_cells.append((x, y, layers))

            file_writer.write(pack('<H', len(liquid_cells)))
            for cell_x, cell_y, layers in liquid_cells:
                file_writer.write(pack('<BBB', cell_x, cell_y, len(layers)))
                for liq_type, is_wmo, l_min, l_max in layers:
                    file_writer.write(pack('<BB', liq_type, Constants.LIQUID_FLAG_IS_WMO if is_wmo else 0))
                    if config.Extractor.Maps.use_float_16:
                        if is_wmo:
                            file_writer.write(pack('>h', Float16.compress(l_max)))
                            file_writer.write(pack('>h', Float16.compress(l_min)))
                        else:
                            file_writer.write(pack('>h', Float16.compress(l_max)))
                    else:
                        if is_wmo:
                            file_writer.write(pack('<f', l_max))
                            file_writer.write(pack('<f', l_min))
                        else:
                            file_writer.write(pack('<f', l_max))

            # Write WMO height cells as sparse per-cell lists.
            if not adt_wmo_heights:
                file_writer.write(pack('<H', 0))
                return

            file_writer.write(pack('<H', len(adt_wmo_heights)))
            for cell_key, heights in adt_wmo_heights.items():
                cell_x = (cell_key >> 8) & 0xFF
                cell_y = cell_key & 0xFF
                # Deduplicate and sort heights for stable lookup.
                unique = []
                for height in sorted(heights):
                    if not unique or abs(unique[-1] - height) >= 0.1:
                        unique.append(height)
                count = min(len(unique), 255)
                file_writer.write(pack('<BBB', cell_x, cell_y, count))
                for height in unique[:count]:
                    if config.Extractor.Maps.use_float_16:
                        file_writer.write(pack('>h', Float16.compress(height)))
                    else:
                        file_writer.write(pack('<f', height))

    def _write_area_information(self, file_writer):
        for cy in range(Constants.TILE_SIZE):
            for cx in range(Constants.TILE_SIZE):
                area_table = DataHolders.get_area_table_by_area_number(self.map_id, self.tiles[cy][cx].area_number)
                if self.map_id > 1 or not area_table or not area_table.has_exploration:
                    # Empty.
                    file_writer.write(pack('<h', -1))
                else:
                    area_table.write_to_file(file_writer)

    @staticmethod
    def from_reader(map_id, adt_x, adt_y, wmo_filenames, wmo_liquids, wmo_heights, stream_reader):
        # Initialize adt object.
        adt = Adt(map_id, adt_x, adt_y, wmo_filenames, wmo_liquids, wmo_heights)

        error, token, size = stream_reader.read_chunk_information('MHDR')
        if error:
            Logger.warning(f'{error}')
            return

        adt.adt_header = MHDR.from_reader(stream_reader=stream_reader)

        # 256 Entries, so a 16*16 Chunk map.
        error, token, size = stream_reader.read_chunk_information('MCIN')
        if error:
            Logger.warning(f'{error}')
            return

        for x in range(Constants.TILE_SIZE):
            for y in range(Constants.TILE_SIZE):
                adt.chunks_information[x][y] = TileHeader.from_reader(stream_reader)

        # List of textures used for texturing the terrain in this map tile.
        error, token, size = stream_reader.read_chunk_information('MTEX')
        if error:
            Logger.warning(f'{error}')
            return

        # Move to next token. (Optional)
        # Placement information for doodads.
        error, token, size = stream_reader.read_chunk_information('MDDF', skip=size)
        if error:
            Logger.warning(f'{error}')
            return

        if size:
            adt.doodad_placements = MDDF.from_reader(stream_reader, size=size)

        # Move to next token. (Optional)
        # Placement information for WMOs.
        error, token, size = stream_reader.read_chunk_information('MODF')
        if error:
            Logger.warning(f'{error}')
            return

        if size:
            adt.wmo_placements = MODF.from_reader(stream_reader, size=size)

        # ADT data.
        for x in range(Constants.TILE_SIZE):
            for y in range(Constants.TILE_SIZE):
                stream_reader.set_position(adt.chunks_information[x][y].offset)
                error, token, size = stream_reader.read_chunk_information('MCNK')
                if error:
                    Logger.error(f'{error}')
                    exit()
                adt_tile = TileInformation.from_reader(stream_reader)
                if adt.is_flat and not adt_tile.mcvt.is_flat:
                    adt.is_flat = False
                adt.tiles[x][y] = adt_tile

        return adt
