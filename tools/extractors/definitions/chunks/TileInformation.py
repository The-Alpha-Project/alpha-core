from tools.extractors.definitions.chunks.MCLQ import MCLQ
from tools.extractors.definitions.chunks.MCVT import MCVT
from tools.extractors.definitions.enums.LiquidFlags import LiquidFlags


class TileInformation:
    def __init__(self, flags, has_liquids, area_number, holes_low_mask, mcvt, mclq):
        self.flags: int = flags
        self.has_liquids: bool = has_liquids
        self.area_number: int = area_number
        self.holes_low_mask: int = holes_low_mask
        self.mcvt: MCVT = mcvt  # Heightfield.
        self.mclq: list = mclq  # Liquids.

    @staticmethod
    def from_reader(stream_reader):
        flags = stream_reader.read_int()
        has_liquids = flags & LiquidFlags.HAS_LIQUID != 0
        offs_height = stream_reader.read_int(skip=20)
        area_number = stream_reader.read_int(skip=28)
        holes_low_mask = stream_reader.read_uint16(skip=4)
        offs_liquids = stream_reader.read_int(skip=34)
        header_offset = stream_reader.get_position(skip=24)

        # Read MCVT.
        stream_reader.set_position(offs_height + header_offset)
        mcvt = MCVT.from_reader(stream_reader)

        liquids = []
        if offs_liquids and has_liquids:
            stream_reader.set_position(offs_liquids + header_offset)
            for flag in LiquidFlags.get_liquid_flags(flags):
                liquids.append(MCLQ.from_reader(stream_reader, flag))
            has_liquids = len(liquids) > 0

        return TileInformation(flags, has_liquids, area_number, holes_low_mask, mcvt, liquids)
