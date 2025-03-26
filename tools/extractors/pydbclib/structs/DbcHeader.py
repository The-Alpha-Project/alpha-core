from struct import unpack
from dataclasses import dataclass


@dataclass
class DbcHeader:
    signature: str
    record_count: int
    field_count: int
    record_size: int
    string_block_size: int
    valid: bool

    @staticmethod
    def from_bytes(reader):
        signature = reader.read(4).decode('utf8')
        record_count, field_count, record_size, block_size = unpack('<4I', reader.read(16))
        return DbcHeader(signature, record_count, field_count, record_size, block_size, signature == 'WDBC')
