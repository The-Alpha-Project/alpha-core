from game.world.managers.objects.units.movement.helpers.Spline import Spline
from utils.constants.UnitCodes import SplineType, SplineFlags


class SplineBuilder:

    @staticmethod
    def build_normal_spline(unit, points, speed, spline_flags=SplineFlags.SPLINEFLAG_RUNMODE, extra_time_seconds=0):
        if not unit.location.approximately_equals(points[0], 0.1):
            unit.location.face_point(points[0])

        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_NORMAL,
            spline_flags=spline_flags,
            speed=speed,
            spot=None,
            guid=unit.guid,
            facing=unit.location.o,
            points=points,
            extra_time_seconds=extra_time_seconds
        )

    @staticmethod
    def build_stop_spline(unit, extra_time_seconds=0):
        # Only update Z if not swimming, to avoid setting Z to the water bottom.
        if not unit.is_swimming():
            z, z_locked = unit.get_map().calculate_z_for_object(unit)
            if not z_locked:
                unit.location.z = z

        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_STOP,
            spline_flags=SplineFlags.SPLINEFLAG_NONE,
            spot=unit.location,
            guid=unit.guid,
            facing=unit.location.o,
            points=[unit.location],
            extra_time_seconds=extra_time_seconds
        )

    @staticmethod
    def build_face_spot_spline(unit, spot, extra_time_seconds=0):
        # Server side.
        unit.location.face_point(spot)
        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_SPOT,
            spline_flags=SplineFlags.SPLINEFLAG_SPOT,
            spot=spot,
            guid=unit.guid,
            facing=spot.o,
            points=[spot],
            extra_time_seconds=extra_time_seconds
        )

    @staticmethod
    def build_face_angle_spline(unit, angle, extra_time_seconds=0):
        # Server side.
        unit.location.face_angle(angle)
        # Generate face angle spline
        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_ANGLE,
            spline_flags=SplineFlags.SPLINEFLAG_FACING,
            spot=unit.location,
            guid=unit.guid,
            facing=angle,
            points=[unit.location],
            extra_time_seconds=extra_time_seconds
        )

    @staticmethod
    def build_face_target_spline(unit, target, extra_time_seconds=0):
        # Server side.
        unit.location.face_point(target.location)
        # Generate face target spline
        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_TARGET,
            spline_flags=SplineFlags.SPLINEFLAG_TARGET,
            spot=target.location,
            guid=target.guid,
            facing=target.location.o,
            points=[unit.location],  # On its own axis.
            extra_time_seconds=extra_time_seconds
        )
