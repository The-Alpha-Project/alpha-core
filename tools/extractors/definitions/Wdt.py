from io import BytesIO

from game.world.managers.maps.helpers.Constants import BLOCK_SIZE
from utils.Logger import Logger
from tools.extractors.definitions.Adt import Adt
from tools.extractors.helpers.Constants import Constants
from tools.extractors.definitions.chunks.TileHeader import TileHeader
from tools.extractors.definitions.reader.StreamReader import StreamReader


class Wdt:
    def __init__(self, dbc_map, mpq_reader):
        self.name = dbc_map.name
        self.mpq_reader = mpq_reader
        self.stream_reader = None
        self.dbc_map = dbc_map
        self.adt_version = 0  # 18
        self.tile_information = [[type[TileHeader] for _ in range(64)] for _ in range(64)]
        self.adt_data = [[type[Adt] for _ in range(64)] for _ in range(64)]

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
        self.adt_data.clear()
        self.tile_information = None
        self.adt_data = None

    def process(self):
        error, token, size = self.stream_reader.read_chunk_information('MVER')
        if error:
            Logger.warning(f'{error}')
            return

        self.adt_version = self.stream_reader.read_int()
        if self.adt_version != 18:
            Logger.warning('Wrong ADT version.')
            return

        error, token, size = self.stream_reader.read_chunk_information('MPHD')
        if error:
            Logger.warning(f'{error}')
            return

        # Move to next token.
        error, token, size = self.stream_reader.read_chunk_information('MAIN', skip=size)
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

        # Move to next token.
        error, token, size = self.stream_reader.read_chunk_information('MONM', skip=size)
        if error:
            Logger.warning(f'{error}')
            return

        # Move to next token.
        error, token, size = self.stream_reader.read_chunk_information('MODF', skip=size)
        # Optional for WMO based.
        if error and token != 'MHDR':
            Logger.warning(f'Map [{self.dbc_map.name}] is WMO based, skipping.')
            return

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
                self.stream_reader.set_position(tile_info.offset)
                # Parse and write .map file for this adt.
                with Adt.from_reader(self.dbc_map.id, x, y, self.stream_reader) as adt:
                    adt.write_to_map_file()
