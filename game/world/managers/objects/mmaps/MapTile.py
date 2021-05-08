from os import path
from struct import unpack
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from game.world.managers.objects.mmaps.Constants import RESOLUTION_ZMAP, RESOLUTION_WATER, RESOLUTION_TERRAIN, \
    RESOLUTION_FLAGS


class MapTile(object):

    def __init__(self, map_id, tile_x, tile_y):
        self.cell_x = tile_x
        self.cell_y = tile_y
        self.cell_map = map_id
        self.area_flags = [[0 for r in range(0, RESOLUTION_FLAGS + 1)] for c in range(0, RESOLUTION_FLAGS + 1)]
        self.area_terrain = [[0 for r in range(0, RESOLUTION_TERRAIN + 1)] for c in range(0, RESOLUTION_TERRAIN + 1)]
        self.water_level = [[0 for r in range(0, RESOLUTION_WATER + 1)] for c in range(0, RESOLUTION_WATER + 1)]
        self.z_coords = [[0 for r in range(0, RESOLUTION_ZMAP + 1)] for c in range(0, RESOLUTION_ZMAP + 1)]
        self.load()

    def load(self):
        filename = f'{self.cell_map}00{self.cell_x}{self.cell_y}.map'
        mmaps_path = path.join(path.dirname(__file__), f'../../../../../etc/mmaps/{filename}')
        Logger.info(f'[Maps] Loading map file: {filename}')

        if not path.exists(mmaps_path):
            Logger.warning(f'Unable to locate map file: {filename}')
        else:
            with open(mmaps_path, "rb") as mmap:
                version = PacketReader.read_string(mmap.read(8), 0)

                # AreaFlags
                for x in range(0, RESOLUTION_FLAGS + 1):
                    for y in range(0, RESOLUTION_FLAGS + 1):
                        self.area_flags[x][y] = unpack('<H', mmap.read(2))[0]

                # AreaTerrain
                for x in range(0, RESOLUTION_TERRAIN + 1):
                    for y in range(0, RESOLUTION_TERRAIN + 1):
                        self.area_terrain[x][y] = mmap.read(1)[0]

                # AreaTerrain
                for x in range(0, RESOLUTION_WATER + 1):
                    for y in range(0, RESOLUTION_WATER + 1):
                        self.water_level[x][y] = unpack('<f', mmap.read(4))[0]

                # ZCoords
                for x in range(0, RESOLUTION_ZMAP + 1):
                    for y in range(0, RESOLUTION_ZMAP + 1):
                        self.z_coords[x][y] = unpack('<f', mmap.read(4))[0]
