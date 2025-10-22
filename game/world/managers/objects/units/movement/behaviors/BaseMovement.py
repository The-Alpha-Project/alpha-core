import time


class BaseMovement:
    def __init__(self, move_type, spline_callback, is_default=False):
        self.is_default = is_default
        self.move_type = move_type
        self.spline_callback = spline_callback
        self.speed_dirty = False
        self.spline = None
        self.unit = None
        self.last_change = time.time()

    def initialize(self, unit):
        self.unit = unit
        return True

    def update(self, now, elapsed):
        if not self.spline:
            self._check_relocation(now)
            return

        position_changed, new_position, wp_complete = self.spline.update(elapsed)

        # Position changed either guessed or wp complete.
        if position_changed:
            self.on_new_position(new_position, wp_complete, len(self.spline.pending_waypoints))
            self.last_change = now
        # Units can be waiting on a waypoint, handle this case here.
        else:
            self._check_relocation(now)

        # Spline ended.
        if self.spline.is_complete():
            self.on_spline_finished()
            self.spline = None

    def _check_relocation(self, now):
        if now - self.last_change > 1:
            self.unit.pending_relocation = True
            self.last_change = now

    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        self.unit.location = new_position.copy()
        self.unit.set_has_moved(has_moved=True, has_turned=False)

    def set_speed_dirty(self):
        self.speed_dirty = True

    def on_spline_finished(self):
        pass

    def can_remove(self):
        pass

    def on_removed(self):
        pass

    def is_complete(self):
        return self.spline and self.spline.is_complete()

    def get_total_time_secs(self):
        return 0 if not self.spline else self.spline.get_total_time_secs()

    def get_total_time_ms(self):
        return 0 if not self.spline else self.spline.get_total_time_ms()

    def reset(self):
        pass
