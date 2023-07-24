from io import BytesIO
from struct import unpack


class MCVT:
    def __init__(self):
        self.v9 = [[0.0 for _ in range(9)] for _ in range(9)]
        self.v8 = [[0.0 for _ in range(8)] for _ in range(8)]
        self.heights = [0.0] * (8 * 8 + 9 * 9)
        self.is_flat = True
        self.height = 0.0

    def get_v8(self, x, y):
        if self.is_flat:
            return self.height
        return self.v8[x][y]

    def get_v9(self, x, y):
        if self.is_flat:
            return self.height
        return self.v9[x][y]

    def flush(self):
        self.heights.clear()
        self.heights = None
        self.v9.clear()
        self.v9 = None
        self.v8.clear()
        self.v8 = None

    @staticmethod
    def from_reader(stream_reader):
        mcvt = MCVT()
        v9 = stream_reader.read_bytes(324)
        v8 = stream_reader.read_bytes(256)

        # Interleaved heights.
        with BytesIO(v9) as _v9:
            with BytesIO(v8) as _v8:
                h_index = 0
                while _v9.tell() != 324:
                    for i in range(9):
                        mcvt.heights[h_index] = unpack('<f', _v9.read(4))[0]
                        h_index += 1

                    if _v8.tell() != 256:
                        for j in range(8):
                            mcvt.heights[h_index] = unpack('<f', _v8.read(4))[0]
                            h_index += 1

        for idx, h in enumerate(mcvt.heights):
            if mcvt.height == 0.0:
                mcvt.height = mcvt.heights[idx]
            if h != mcvt.height:
                mcvt.is_flat = False
                break

        # Is flat, flush and return.
        if mcvt.is_flat:
            mcvt.flush()
            return mcvt

        # Segmented.
        with BytesIO(v9) as _v9:
            for x in range(9):
                for y in range(9):
                    mcvt.v9[x][y] = unpack('<f', _v9.read(4))[0]

        with BytesIO(v9) as _v8:
            for x in range(8):
                for y in range(8):
                    mcvt.v8[x][y] = unpack('<f', _v8.read(4))[0]

        return mcvt
