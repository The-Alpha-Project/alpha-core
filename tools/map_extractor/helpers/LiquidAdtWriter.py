from struct import pack
from tools.map_extractor.helpers.Constants import Constants
from tools.map_extractor.definitions.enums.LiquidFlags import LiquidFlags


class LiquidAdtWriter:
    def __init__(self, adt):
        self.adt = adt
        self.lq_show = [[False for _ in range(Constants.GRID_SIZE)] for _ in range(Constants.GRID_SIZE)]
        self.lq_height = [[0.0 for _ in range(Constants.GRID_SIZE + 1)] for _ in range(Constants.GRID_SIZE + 1)]
        self.lq_flags = [[0 for _ in range(Constants.GRID_SIZE + 1)] for _ in range(Constants.GRID_SIZE + 1)]

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.adt = None
        self.lq_show.clear()
        self.lq_show = None
        self.lq_height.clear()
        self.lq_height = None
        self.lq_flags.clear()
        self.lq_flags = None

    def write_to_file(self, file_writer):
        # Calculate which liquids are needed first based on flags.
        for i in range(Constants.TILE_SIZE):
            for j in range(Constants.TILE_SIZE):
                tile = self.adt.tiles[i][j]

                if not tile or not tile.has_liquids:
                    continue

                mclq = tile.mclq[0]
                # Prioritize rivers over oceans.
                not_ocean = [mclq for mclq in tile.mclq if not mclq.flag & LiquidFlags.FLAG_LQ_OCEAN]
                if not_ocean:
                    mclq = not_ocean[0]

                for y in range(Constants.CELL_SIZE):
                    cy = i * Constants.CELL_SIZE + y
                    for x in range(Constants.CELL_SIZE):
                        cx = j * Constants.CELL_SIZE + x

                        if mclq.flags[y][x] != 15:
                            self.lq_show[cy][cx] = True

                            # Overwrite DEEP water flag.
                            if mclq.flags[y][x] & (1 << 7) != 0:
                                mclq.flag = LiquidFlags.FLAG_LQ_DEEP.value

                            self.lq_height[cy][cx] = mclq.heights[y][x]
                            self.lq_flags[cy][cx] = mclq.flag
                        else:
                            self.lq_show[cy][cx] = False

        # Write to file.
        for y in range(Constants.GRID_SIZE):
            for x in range(Constants.GRID_SIZE):
                if self.lq_show[y][x] is True:
                    file_writer.write(pack('<b', self.lq_flags[y][x]))
                    file_writer.write(pack('<f', self.lq_height[y][x]))
                else:
                    file_writer.write(pack('<b', -1))
