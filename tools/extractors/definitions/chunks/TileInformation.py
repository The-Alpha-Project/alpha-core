from tools.extractors.definitions.chunks.MCLQ import MCLQ
from tools.extractors.definitions.chunks.MCVT import MCVT
from tools.extractors.definitions.enums.LiquidFlags import LiquidFlags


class TileInformation:
    def __init__(self, flags, has_liquids, area_number, holes_low_mask, d_refs, w_refs, mcvt, mclq):
        self.flags: int = flags
        self.has_liquids: bool = has_liquids
        self.doodad_refs = d_refs
        self.wmo_refs = w_refs
        self.area_number: int = area_number
        self.holes_low_mask: int = holes_low_mask
        self.mcvt: MCVT = mcvt  # Heightfield.
        self.mclq: list = mclq  # Liquids.

    @staticmethod
    def from_reader(stream_reader):
        flags = stream_reader.read_int32()
        has_liquids = flags & LiquidFlags.HAS_LIQUID != 0
        doodad_count = stream_reader.read_int32(skip=16)
        offs_height = stream_reader.read_int32()
        offs_mcrf = stream_reader.read_int32(skip=8)
        area_number = stream_reader.read_int32(skip=16)
        wmo_count = stream_reader.read_int32()
        holes_low_mask = stream_reader.read_uint16()
        offs_liquids = stream_reader.read_int32(skip=34)
        header_offset = stream_reader.get_position(skip=24)

        d_refs = None
        w_refs = None
        if offs_mcrf and (doodad_count or wmo_count):
            stream_reader.set_position(offs_mcrf + header_offset)
            # Move to next token.
            error, token, size = stream_reader.read_chunk_information('MCRF')
            if not error:
                if doodad_count:
                    d_refs = [stream_reader.read_uint32() for _ in range(doodad_count)]
                if wmo_count:
                    w_refs = [stream_reader.read_uint32() for _ in range(wmo_count)]
            else:
                raise ValueError(f'{error}')

        # Read MCVT.
        stream_reader.set_position(offs_height + header_offset)
        mcvt = MCVT.from_reader(stream_reader)

        liquids = []
        if offs_liquids and has_liquids:
            stream_reader.set_position(offs_liquids + header_offset)
            for flag in LiquidFlags.get_liquid_flags(flags):
                liquids.append(MCLQ.from_reader(stream_reader, flag))
            has_liquids = len(liquids) > 0

        return TileInformation(flags, has_liquids, area_number, holes_low_mask, d_refs, w_refs, mcvt, liquids)
