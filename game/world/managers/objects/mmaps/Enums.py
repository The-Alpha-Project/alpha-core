from enum import IntEnum


class DBCValueType(IntEnum):
    DBC_STRING = 0,
    DBC_INTEGER = 1,
    DBC_FLOAT = 2,


class MapType(IntEnum):
    COMMON = 0,
    INSTANCE = 1,
    RAID = 2,
    BATTLEGROUND = 3

