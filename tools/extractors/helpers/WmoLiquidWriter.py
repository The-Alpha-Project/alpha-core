from struct import pack
from tools.extractors.helpers.Constants import Constants
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
                    self._write_cell_liquid(file_writer, liq_data)
                else:  # Empty cell.
                    file_writer.write(pack('<b', -1))

    def _write_cell_liquid(self, file_writer, liq_data):
        liq_count_for_cell = len(liq_data)
        file_writer.write(pack('<b', liq_count_for_cell))
        for l in range(liq_count_for_cell):
            z_max = liq_data[l][0]
            z_min = liq_data[l][1]
            liq_type = liq_data[l][2]
            file_writer.write(pack('<b', liq_type))
            z_max = z_max if not self.use_float_16 else Float16.compress(z_max)
            z_min = z_min if not self.use_float_16 else Float16.compress(z_min)
            file_writer.write(pack(f'{self.signature}', z_max, z_min))
