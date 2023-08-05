from enum import IntEnum
from utils.ConfigManager import config

RESOLUTION_ZMAP = 256
Z_PACKED = config.Server.Settings.z_packed
RESOLUTION_LIQUIDS = 128
RESOLUTION_AREA_INFO = 16
ADT_SIZE = 533.3333
BLOCK_SIZE = 64


class MapType(IntEnum):
    INSTANCE = 0
    COMMON = 1
