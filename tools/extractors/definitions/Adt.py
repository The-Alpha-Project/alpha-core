import os
from struct import pack

from game.world.managers.maps.helpers.Constants import RESOLUTION_LIQUIDS, ADT_SIZE
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.chunks.MDDF import MDDF
from tools.extractors.definitions.chunks.MHDR import MHDR
from tools.extractors.definitions.chunks.MODF import MODF
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo
from tools.extractors.helpers.WmoLiquidParser import WmoLiquidParser
from tools.extractors.helpers.WmoLiquidWriter import WmoLiquidWriter
from utils.Logger import Logger
from utils.PathManager import PathManager
from network.packet.PacketWriter import PacketWriter
from tools.extractors.helpers.Constants import Constants
from tools.extractors.helpers.DataHolders import DataHolders
from tools.extractors.helpers.HeightField import HeightField
from tools.extractors.helpers.LiquidAdtWriter import LiquidAdtWriter
from tools.extractors.definitions.chunks.TileHeader import TileHeader
from tools.extractors.definitions.chunks.TileInformation import TileInformation


class Adt:
    def __init__(self, map_id, x, y, wmo_names, wmo_liquids):
        self.map_id = map_id
        self.adt_x = x
        self.adt_y = y
        self.is_flat = True
        self.header = None
        self.wmo_placements = None
        self.wmo_liquids = wmo_liquids
        self.wmo_filenames = wmo_names
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
        self.wmo_liquids = None

    @staticmethod
    def get_filepath(map_id, adt_x, adt_y):
        filename = f'{map_id:03}{adt_x:02}{adt_y:02}.map'
        return os.path.join(PathManager.get_maps_path(), filename)

    def write_to_map_file(self):
        with open(Adt.get_filepath(self.map_id, self.adt_x, self.adt_y), 'wb') as file_writer:
            # Write version.
            file_writer.write(PacketWriter.string_to_bytes(Constants.MAPS_VERSION))
            # Write heightfield.
            self._write_heightfield(file_writer)
            # Write area information.
            self._write_area_information(file_writer)
            # Write Adt liquids.
            self._write_liquids(file_writer)
            # Parse qmo liquids and write wmo liquids flag.
            # Wmo liquids are writen once all Wdt Adt's are parsed since liquids can overlap tiles.
            with WmoLiquidParser(self, self.wmo_liquids) as wmo_liquids:
                file_writer.write(pack('<b', 1 if wmo_liquids.has_liquids else 0))

    def _write_heightfield(self, file_writer):
        with HeightField(self) as heightfield:
            heightfield.write_to_file(file_writer)

    def _write_liquids(self, file_writer):
        with LiquidAdtWriter(self) as liquids:
            liquids.write_to_file(file_writer)

    @staticmethod
    def write_wmo_liquids(map_id, adt_x, adt_y, wmo_liquids):
        with open(Adt.get_filepath(map_id, adt_x, adt_y), 'ab') as file_writer:
            with WmoLiquidWriter(wmo_liquids[adt_x][adt_y]) as liquids:
                liquids.write_to_file(file_writer)

    def _write_area_information(self, file_writer):
        for cy in range(Constants.TILE_SIZE):
            for cx in range(Constants.TILE_SIZE):
                area_table = DataHolders.get_area_table_by_area_number(self.map_id, self.tiles[cy][cx].area_number)
                if self.map_id > 1 or not area_table or not area_table.has_exploration:
                    # Empty.
                    file_writer.write(pack('<i', -1))
                else:
                    area_table.write_to_file(file_writer)

    @staticmethod
    def from_reader(map_id, adt_x, adt_y, wmo_filenames, wmo_liquids, stream_reader):
        # Initialize adt object.
        adt = Adt(map_id, adt_x, adt_y, wmo_filenames, wmo_liquids)

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
                    Logger.warning(f'{error}')
                    return
                adt_tile = TileInformation.from_reader(stream_reader)
                if adt.is_flat and not adt_tile.mcvt.is_flat:
                    adt.is_flat = False
                adt.tiles[x][y] = adt_tile

        return adt
