from struct import pack
from tools.extractors.helpers.Constants import Constants
from tools.extractors.definitions.enums.LiquidFlags import LiquidFlags
from utils.ConfigManager import config
from utils.Float16 import Float16


class WmoLiquidWriter:
    def __init__(self, wmo_lq_height):
        self.use_float_16 = config.Extractor.Maps.use_float_16
        self.wmo_lq_height = wmo_lq_height

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.wmo_lq_height.clear()
        self.wmo_lq_height = None

    def write_to_file(self, file_writer):
        for y in range(Constants.GRID_SIZE):
            for x in range(Constants.GRID_SIZE):
                if self.wmo_lq_height[y][x]:
                    self._write_cell_liquid(file_writer, self.wmo_lq_height[y][x], LiquidFlags.FLAG_LQ_RIVER.value)
                else:  # Empty cell.
                    file_writer.write(pack('<b', -1))

    def _write_cell_liquid(self, file_writer, height, flag):
        file_writer.write(pack('<b', flag))
        # 32 bit Full precision.
        if not self.use_float_16:
            file_writer.write(pack('<ff', height[0], height[1]))
            return
        # 16 bit Half precision.
        file_writer.write(pack('>hh', Float16.compress(height[0]), Float16.compress(height[1])))
