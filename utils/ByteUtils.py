class ByteUtils:
    @staticmethod
    def shorts_to_int(short1, short2):
        return (
            short1 << 16 |
            short2
        )

    @staticmethod
    def bytes_to_int(byte1, byte2, byte3, byte4):
        return (
            byte1 << 24 |
            byte2 << 16 |
            byte3 << 8 |
            byte4
        )
