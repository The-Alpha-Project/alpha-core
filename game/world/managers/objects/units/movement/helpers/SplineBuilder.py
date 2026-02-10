from game.world.managers.objects.units.movement.helpers.Spline import Spline
from utils.constants.UnitCodes import SplineType, SplineFlags
from utils.constants.MiscCodes import ZSource


class SplineBuilder:

    @staticmethod
    def build_normal_spline(unit, points, speed, spline_flags=SplineFlags.SPLINEFLAG_RUNMODE, extra_time_seconds=0,
                            use_packed_deltas=False):
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
            extra_time_seconds=extra_time_seconds,
            use_packed_deltas=use_packed_deltas
        )

    @staticmethod
    def build_stop_spline(unit, extra_time_seconds=0):
        # Only update Z if not swimming, to avoid setting Z to the water bottom.
        if not unit.is_swimming():
            z, z_source = unit.get_map().calculate_z_for_object(unit)
            if z_source != ZSource.CURRENT_Z:
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
    def build_face_angle_spline(unit, angle, extra_time_seconds=0):
        # Server side.
        unit.location.face_angle(angle)

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

        return Spline(
            unit=unit,
            spline_type=SplineType.SPLINE_TYPE_FACING_TARGET,
            spline_flags=SplineFlags.SPLINEFLAG_TARGET,
            spot=unit.location,
            guid=target.guid,
            facing=unit.location.o,
            points=[unit.location],  # On its own axis.
            extra_time_seconds=extra_time_seconds
        )
