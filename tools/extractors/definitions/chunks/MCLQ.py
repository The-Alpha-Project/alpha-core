

class MCLQ:
    def __init__(self, flag):
        self.flag = flag
        self.flags = [[0 for _ in range(8)] for _ in range(8)]
        self.heights = [[0.0 for _ in range(9)] for _ in range(9)]

    @staticmethod
    def from_reader(stream_reader, flag):
        mclq = MCLQ(flag)

        # Skip low and high range. 2 floats.
        stream_reader.move_forward(8)

        for i in range(9):
            for j in range(9):
                mclq.heights[i][j] = round(stream_reader.read_float(skip=4), 5)

        for i in range(8):
            for j in range(8):
                mclq.flags[i][j] = int.from_bytes(stream_reader.read_bytes(1), byteorder='little')

        return mclq
