from struct import pack
from utils.ConfigManager import config
from game.world.managers.abstractions.Vector import Vector
from tools.map_extractor.helpers.Constants import Constants
from utils.Float16 import Float16

Z_RESOLUTION = 256
Z_PACKED_POSITIVE = 1000


class HeightField:

    def __init__(self, adt):
        self.tiles = adt.tiles
        self.z_packed = config.Extractor.Maps.z_packed
        self.v9 = [[0.0 for _ in range(129)] for _ in range(129)]
        self.v8 = [[0.0 for _ in range(128)] for _ in range(128)]
        self.p = Vector()
        self.v = [Vector() for _ in range(3)]

    def __enter__(self):
        self.build()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.tiles = None
        self.v9.clear()
        self.v9 = None
        self.v8.clear()
        self.v8 = None
        self.p = None
        self.v.clear()
        self.v = None

    def build(self):
        for x in range(128):
            for y in range(128):
                self.v8[x][y] = self.tiles[int(x / 8)][int(y / 8)].mcvt.get_v8(divmod(x, 8)[1], divmod(y, 8)[1])
                self.v9[x][y] = self.tiles[int(x / 8)][int(y / 8)].mcvt.get_v9(divmod(x, 8)[1], divmod(y, 8)[1])
            self.v9[x][128] = self.tiles[int(x / 8)][15].mcvt.get_v9(divmod(x, 8)[1], 8)
            self.v9[128][x] = self.tiles[15][int(x / 8)].mcvt.get_v9(8, divmod(x, 8)[1])
        self.v9[128][128] = self.tiles[15][15].mcvt.get_v9(8, 8)

    def write_to_file(self, file_stream):
        for cy in range(Z_RESOLUTION):
            for cx in range(Z_RESOLUTION):
                # 32 bit Full precision.
                if not self.z_packed:
                    file_stream.write(pack('<f', self.calculate_z(cy, cx)))
                    continue
                # 16 bit Half precision.
                file_stream.write(pack('>h', Float16.compress(self.calculate_z(cy, cx) + Z_PACKED_POSITIVE)))

    def calculate_z(self, cy, cx):
        # Reuse vectors.
        p: Vector = self.p
        v: list[Vector] = self.v

        x = (cy * Constants.TILE_SIZE_YARDS) / (Z_RESOLUTION - 1)
        z = (cx * Constants.TILE_SIZE_YARDS) / (Z_RESOLUTION - 1)

        # Find quadrant.
        xc = int(x / Constants.UNIT_SIZE)
        zc = int(z / Constants.UNIT_SIZE)

        if xc > 127:
            xc = 127

        if zc > 127:
            zc = 127

        lx = x - xc * Constants.UNIT_SIZE
        lz = z - zc * Constants.UNIT_SIZE

        p.x = lx
        p.z = lz

        v[0].x = Constants.UNIT_SIZE / 2
        v[0].y = self.v8[xc][zc]
        v[0].z = Constants.UNIT_SIZE / 2

        if lx > lz:
            v[1].x = Constants.UNIT_SIZE
            v[1].y = self.v9[xc + 1][zc]
            v[1].z = 0.0
        else:
            v[1].x = 0.0
            v[1].y = self.v9[xc][zc + 1]
            v[1].z = Constants.UNIT_SIZE

        if lz > Constants.UNIT_SIZE - lx:
            v[2].x = Constants.UNIT_SIZE
            v[2].y = self.v9[xc + 1][zc + 1]
            v[2].z = Constants.UNIT_SIZE
        else:
            v[2].x = 0.0
            v[2].y = self.v9[xc][zc]
            v[2].z = 0.0

        a = v[0].y * (v[1].z - v[2].z) + v[1].y * (v[2].z - v[0].z) + v[2].y * (v[0].z - v[1].z)
        b = v[0].z * (v[1].x - v[2].x) + v[1].z * (v[2].x - v[0].x) + v[2].z * (v[0].x - v[1].x)
        c = v[0].x * (v[1].y - v[2].y) + v[1].x * (v[2].y - v[0].y) + v[2].x * (v[0].y - v[1].y)
        d = v[0].x * (v[1].y * v[2].z - v[2].y * v[1].z) \
            + v[1].x * (v[2].y * v[0].z - v[0].y * v[2].z) \
            + v[2].x * (v[0].y * v[1].z - v[1].y * v[0].z)

        return -round(float((a * p.x + c * p.z - d) / b), 5)
