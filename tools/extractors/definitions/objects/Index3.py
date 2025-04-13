from dataclasses import dataclass


@dataclass
class Index3:
    Index0: int
    Index1: int
    Index2: int

    @staticmethod
    def from_reader(stream_reader, from_wmo=False):
         index_0 = stream_reader.read_uint16()
         index_1 = stream_reader.read_uint16()
         index_2 = stream_reader.read_uint16()
         return Index3(Index0=index_2,
                       Index1=index_1 if not from_wmo else index_0,
                       Index2=index_0 if not from_wmo else index_1)
