from dataclasses import dataclass
from utils.Float16 import Float16


@dataclass
class LiquidInformation(object):
    def __init__(self, liquid_type, height, float_16=False):
        self.liquid_type = liquid_type
        self._height = height
        self.float_16 = float_16

    def get_height(self):
        if not self.float_16:
            return self._height
        return Float16.decompress(self._height)
