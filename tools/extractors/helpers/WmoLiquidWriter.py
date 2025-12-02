from struct import pack
from tools.extractors.helpers.Constants import Constants
from tools.extractors.definitions.enums.LiquidFlags import LiquidFlags
from utils.ConfigManager import config
from utils.Float16 import Float16


class WmoLiquidWriter:
    def __init__(self, wmo_liquids_data):
        self.use_float_16 = config.Extractor.Maps.use_float_16
        self.wmo_liquids_data = wmo_liquids_data
        self.signature = '<ff' if not self.use_float_16 else '>hh'

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.wmo_liquids_data.clear()
        self.wmo_liquids_data = None

    def write_to_file(self, file_writer):
        for y in range(Constants.GRID_SIZE):
            for x in range(Constants.GRID_SIZE):
                liq_data = self.wmo_liquids_data[y][x]
                if liq_data:
                    self._write_cell_liquid(file_writer, liq_data[0], liq_data[1], liq_data[2])
                else:  # Empty cell.
                    file_writer.write(pack('<b', -1))

    def _write_cell_liquid(self, file_writer, z_max, z_min, liq_type):
        file_writer.write(pack('<b', liq_type))
        z_max = z_max if not self.use_float_16 else Float16.compress(z_max)
        z_min = z_min if not self.use_float_16 else Float16.compress(z_min)
        file_writer.write(pack(f'{self.signature}', z_max, z_min))
