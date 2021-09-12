from struct import pack, unpack
from game.world.managers.abstractions.Vector import Vector
from utils.constants.UnitCodes import SplineFlags


class MovementSpline(object):
    def __init__(self, spline_type=0, flags=0, spot=None, guid=0, facing=0, elapsed=0, total_time=0, points=None):
        self.spline_type = spline_type
        self.flags = flags
        self.spot = spot
        self.guid = guid
        self.facing = facing
        self.elapsed = elapsed
        self.total_time = total_time
        self.points = points
        if not points:
            self.points = []

    @staticmethod
    def from_bytes(spline_bytes):
        if len(spline_bytes < 42):
            return None

        bytes_read = 0

        spline = MovementSpline()
        spline.flags = unpack('<I', spline_bytes[:4])[0]
        bytes_read += 4

        if spline.flags & SplineFlags.SPLINEFLAG_SPOT:
            spline.spot = Vector.from_bytes(spline_bytes[bytes_read:12])
            bytes_read += 12
        if spline.flags & SplineFlags.SPLINEFLAG_TARGET:
            spline.guid = unpack('<Q', spline_bytes[bytes_read:8])[0]
            bytes_read += 8
        if spline.flags & SplineFlags.SPLINEFLAG_FACING:
            spline.facing = unpack('<f', spline_bytes[bytes_read:4])[0]
            bytes_read += 4

        spline.elapsed, spline.total_time = unpack('<2I', spline_bytes[bytes_read:8])
        bytes_read += 8

        points_length = unpack('<I', spline_bytes[bytes_read:4])[0]
        bytes_read += 4
        for i in range(points_length):
            spline.points.append(Vector.from_bytes(spline_bytes[bytes_read:12]))
            bytes_read += 12

        return spline

    def to_bytes(self):
        data = pack('<I', self.flags)

        if self.flags & SplineFlags.SPLINEFLAG_SPOT:
            data += self.spot.to_bytes(include_orientation=False)
        if self.flags & SplineFlags.SPLINEFLAG_TARGET:
            data += pack('<Q', self.guid)
        if self.flags & SplineFlags.SPLINEFLAG_FACING:
            data += pack('<f', self.facing)

        data += pack(
            '<2Ii',
            int(self.elapsed),
            self.total_time,
            len(self.points)
        )

        for point in self.points:
            data += point.to_bytes(include_orientation=False)

        return data
