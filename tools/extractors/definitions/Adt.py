import os
from struct import pack

from game.world.managers.maps.helpers.Constants import RESOLUTION_LIQUIDS
from game.world.managers.maps.helpers.MapUtils import MapUtils
from tools.extractors.definitions.chunks.MDDF import MDDF
from tools.extractors.definitions.chunks.MHDR import MHDR
from tools.extractors.definitions.chunks.MODF import MODF
from tools.extractors.definitions.objects.Vector3 import Vector3
from tools.extractors.definitions.objects.Wmo import Wmo
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
    def __init__(self, map_id, x, y):
        self.map_id = map_id
        self.adt_x = x
        self.adt_y = y
        self.is_flat = True
        self.header = None
        self.wmo_placements = None
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

    def get_filepath(self):
        filename = f'{self.map_id:03}{self.adt_x:02}{self.adt_y:02}.map'
        return os.path.join(PathManager.get_maps_path(), filename)

    def write_to_map_file(self, doodad_filenames, wmo_filenames, wow_data_path, mdx_data_path):
        with open(self.get_filepath(), 'wb') as file_writer:
            # Write version.
            file_writer.write(PacketWriter.string_to_bytes(Constants.MAPS_VERSION))
            # Write heightfield.
            self._write_heightfield(file_writer)
            # Write area information.
            self._write_area_information(file_writer)
            # Get wmo liquids.
            wmo_lq_heights = self._get_wmo_liquids(wmo_filenames)
            # Write adt/wmo liquids.
            self._write_liquids(file_writer, wmo_lq_heights)

    def _write_heightfield(self, file_writer):
        with HeightField(self) as heightfield:
            heightfield.write_to_file(file_writer)

    def _write_liquids(self, file_writer, wmo_lq_heights):
        with LiquidAdtWriter(self, wmo_lq_heights) as liquids:
            liquids.write_to_file(file_writer)

    def _get_wmo_liquids(self, wmo_filenames):
        if not self.wmo_placements or not wmo_filenames:
            return

        for wmo_placement in self.wmo_placements:
            with Wmo(wmo_filenames[wmo_placement.name_id]) as wmo:
                if not wmo.has_liquids():
                    return None
                lq_heights = [[0.0 for _ in range(Constants.GRID_SIZE + 1)] for _ in range(Constants.GRID_SIZE + 1)]
                t_matrix = wmo_placement.get_transform_matrix()
                verts = []
                tile_size = (533.0 + (1.0 / 3.0)) / 128.0

                for mliq in wmo.mliq:
                    corner = Vector3(mliq.corner[0], mliq.corner[1], mliq.corner[2])

                    for y in range(mliq.y_vertex_count):
                        for x in range(mliq.x_vertex_count):
                            verts.append(Vector3(corner.X + tile_size * (x + 0), corner.Y + tile_size * (y + 0), corner.Z))
                            verts.append(Vector3(corner.X + tile_size * (x + 1), corner.Y + tile_size * (y + 0), corner.Z))
                            verts.append(Vector3(corner.X + tile_size * (x + 0), corner.Y + tile_size * (y + 1), corner.Z))
                            verts.append(Vector3(corner.X + tile_size * (x + 1), corner.Y + tile_size * (y + 1), corner.Z))

                    for v in verts:
                        v = Vector3.transform(v, t_matrix)
                        adt_x, adt_y, cell_x, cell_y = MapUtils.calculate_tile(v.X, v.Y, RESOLUTION_LIQUIDS - 1)
                        if adt_x == self.adt_x and adt_y == self.adt_y:
                            lq_heights[cell_x][cell_y] = v.Z

                    verts.clear()

                return lq_heights

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
    def from_reader(map_id, adt_x, adt_y, wmo_filenames, stream_reader):
        # Initialize adt object.
        adt = Adt(map_id, adt_x, adt_y)

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
