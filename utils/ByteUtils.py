class ByteUtils:
    @staticmethod
    def shorts_to_int(short1, short2):
        return (
            # Use bitwise AND with 0xFFFF to ensure each short is within 16 bits.
            ((short1 & 0xFFFF) << 16) |
            (short2 & 0xFFFF)
        )

    @staticmethod
    def bytes_to_int(byte1, byte2, byte3, byte4):
        return (
            # Use bitwise AND with 0xFF to ensure each byte is within 0-255,
            (byte1 & 0xFF) << 24 |
            (byte2 & 0xFF) << 16 |
            (byte3 & 0xFF) << 8 |
            (byte4 & 0xFF)
        )
