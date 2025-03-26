from enum import IntEnum


class MpqFlags(IntEnum):
    CompressedPK = 0x100
    CompressedMulti = 0x200
    Compressed = 0xff00
    Encrypted = 0x10000
    BlockOffsetAdjustedKey = 0x020000
    SingleUnit = 0x1000000
