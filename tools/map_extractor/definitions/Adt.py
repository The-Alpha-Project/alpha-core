import os
from struct import pack
from utils.Logger import Logger
from utils.PathManager import PathManager
from network.packet.PacketWriter import PacketWriter
from tools.map_extractor.helpers.Constants import Constants
from tools.map_extractor.helpers.DataHolders import DataHolders
from tools.map_extractor.helpers.HeightField import HeightField
from tools.map_extractor.helpers.LiquidAdtWriter import LiquidAdtWriter
from tools.map_extractor.definitions.chunks.TileHeader import TileHeader
from tools.map_extractor.definitions.chunks.TileInformation import TileInformation


class Adt:
    def __init__(self, map_id, x, y):
        self.map_id = map_id
        self.adt_x = x
        self.adt_y = y
        self.is_flat = True
        self.chunks_information = [[type[TileHeader] for _ in range(16)] for _ in range(16)]
        self.tiles = [[type[TileInformation] for _ in range(16)] for _ in range(16)]

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.chunks_information.clear()
        self.chunks_information = None
        self.tiles.clear()
        self.tiles = None

    def get_filepath(self):
        filename = f'{self.map_id:03}{self.adt_x:02}{self.adt_y:02}.map'
        return os.path.join(PathManager.get_maps_path(), filename)

    def write_to_map_file(self):
        with open(self.get_filepath(), 'wb') as file_writer:
            # Write version.
            file_writer.write(PacketWriter.string_to_bytes(Constants.MAPS_VERSION))
            # Write heightfield.
            with HeightField(self) as heightfield:
                heightfield.write_to_file(file_writer)
            # Write area information.
            self._write_area_information(file_writer)
            with LiquidAdtWriter(self) as liquids:
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
    def from_reader(map_id, adt_x, adt_y, stream_reader):
        # Initialize adt object.
        adt = Adt(map_id, adt_x, adt_y)

        error, token, size = stream_reader.read_chunk_information('MHDR')
        if error:
            Logger.warning(f'{error}')
            return

        # 16x16 chunk map.
        error, token, size = stream_reader.read_chunk_information('MCIN', skip=size)
        if error:
            Logger.warning(f'{error}')
            return

        for x in range(Constants.TILE_SIZE):
            for y in range(Constants.TILE_SIZE):
                adt.chunks_information[x][y] = TileHeader.from_reader(stream_reader)

        error, token, size = stream_reader.read_chunk_information('MTEX')
        if error:
            Logger.warning(f'{error}')
            return

        # Move to next token. (Optional)
        error, token, size = stream_reader.read_chunk_information('MDDF', skip=size)
        if error:
            Logger.warning(f'{error}')
            return

        # Move to next token. (Optional)
        error, token, size = stream_reader.read_chunk_information('MODF', skip=size)
        if error:
            Logger.warning(f'{error}')
            return

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
