from dataclasses import dataclass

from tools.extractors.definitions.enums.LiquidFlags import WmoGroupLiquidType
from utils.Float16 import Float16
from utils.constants.MiscCodes import LiquidTypes


@dataclass
class LiquidInformation(object):
    def __init__(self, liquid_type, l_min, l_max, float_16=False, is_wmo=False):
        self._is_wmo = is_wmo
        self._liquid_type = liquid_type
        self._l_min = l_min if not float_16 else Float16.decompress(l_min)
        self._lmax = l_max if not float_16 else Float16.decompress(l_max)

    def get_type_str(self):
        if self.is_deep_water():
            return 'DeepWater'
        elif self.is_magma():
            return 'Magma'
        elif self.is_slime():
            return 'Slime'
        return 'Water'

    def is_deep_water(self):
        if self._is_wmo:
            return False
        return self._liquid_type == LiquidTypes.DEEP

    def is_magma(self):
        if not self._is_wmo:
            return self._liquid_type == LiquidTypes.MAGMA
        return self._liquid_type == WmoGroupLiquidType.MAGMA

    def is_slime(self):
        if not self._is_wmo:
            return self._liquid_type == LiquidTypes.MAGMA
        return self._liquid_type == WmoGroupLiquidType.SLIME

    def contains(self, z):
        l_max = self.get_height()
        return self._l_min < z < l_max

    def get_bounds(self):
        return self._l_min, self._lmax

    def get_height(self):
        return self._lmax
