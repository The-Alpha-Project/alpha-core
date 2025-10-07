from dataclasses import dataclass
from utils.Float16 import Float16


@dataclass
class LiquidInformation(object):
    def __init__(self, liquid_type, l_min, l_max, float_16=False):
        self.liquid_type = liquid_type
        self.l_min = l_min
        self._lmax = l_max
        self.float_16 = float_16

    def contains(self, z):
        l_max = self.get_height()
        return self.l_min < z < l_max

    def get_height(self):
        if not self.float_16:
            return self._lmax
        return Float16.decompress(self._lmax)
