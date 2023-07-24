from dataclasses import dataclass


@dataclass
class TileHeader:
    offset: int
    size: int
    flags: int

    @staticmethod
    def from_reader(stream_reader):
        offset = stream_reader.read_int()
        size = stream_reader.read_int()
        flags = stream_reader.read_int()
        stream_reader.move_forward(4)  # Padding.
        return TileHeader(offset, size, flags)
