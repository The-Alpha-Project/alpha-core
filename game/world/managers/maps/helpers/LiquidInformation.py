from dataclasses import dataclass
from typing import Optional

from tools.extractors.definitions.enums.LiquidFlags import WmoGroupLiquidType
from utils.Float16 import Float16
from utils.constants.MiscCodes import LiquidTypes


@dataclass
class LiquidInformation:
    def __init__(self, liquid_type, l_min, l_max, float_16=False, is_wmo=False):
        self._is_wmo = is_wmo
        self._liquid_type = liquid_type
        self._min = l_min if not float_16 else Float16.decompress(l_min)
        self._max = l_max if not float_16 else Float16.decompress(l_max)
        self._liquid_information: Optional[LiquidInformation] = None  # Nested liquid.

    def get_type_str(self):
        if self.is_deep_water():
            return 'DeepWater'
        elif self.is_magma():
            return 'Magma'
        elif self.is_slime():
            return 'Slime'
        return 'Water'

    def set_nested_liquid(self, liq_info):
        self._liquid_information = liq_info

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

    def get_for_z(self, z):
        if self._contains(z):
            return self
        elif self._liquid_information and self._liquid_information._contains(z):
            return self._liquid_information
        return None

    def _contains(self, z):
        return self._min < z < self.get_height()

    def get_bounds(self):
        return self._min, self._max

    def get_height(self):
        return self._max
