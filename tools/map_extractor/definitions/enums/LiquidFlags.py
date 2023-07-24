from enum import IntEnum


class LiquidFlags(IntEnum):
    NONE = 0x0
    FLAG_SHADOW = 0x1
    FLAG_IMPASS = 0x2
    FLAG_LQ_RIVER = 0x4
    FLAG_LQ_OCEAN = 0x8
    FLAG_LQ_MAGMA = 0x10
    FLAG_LQ_DEEP = 0x14

    HAS_LIQUID = FLAG_LQ_RIVER | FLAG_LQ_OCEAN | FLAG_LQ_MAGMA

    @staticmethod
    def get_liquid_flags(liquids_flags):
        flags = []
        for idx, flag in enumerate(LiquidFlags):
            if idx < 3 or idx > 6:
                continue
            if not flag & liquids_flags:
                continue
            flags.append(flag)
        return flags

