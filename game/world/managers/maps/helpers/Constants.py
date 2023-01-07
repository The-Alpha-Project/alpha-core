from enum import IntEnum
from utils.ConfigManager import config

RESOLUTION_ZMAP = int(config.Server.Settings.z_resolution)
RESOLUTION_LIQUIDS = 128
RESOLUTION_AREA_INFO = 16
ADT_SIZE = 533.3333


class MapType(IntEnum):
    INSTANCE = 0
    COMMON = 1
