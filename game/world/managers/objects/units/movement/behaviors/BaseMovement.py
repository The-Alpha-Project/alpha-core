class BaseMovement:
    def __init__(self, move_type, spline_callback, is_default=False):
        self.is_default = is_default
        self.move_type = move_type
        self.spline_callback = spline_callback
        self.speed_dirty = False
        self.spline = None
        self.unit = None

    def initialize(self, unit):
        self.unit = unit
        return True

    def update(self, now, elapsed):
        if self.spline:
            position_changed, new_position, wp_complete = self.spline.update(elapsed)
            # Position changed either guessed or wp complete.
            if position_changed:
                self.on_new_position(new_position, wp_complete, len(self.spline.pending_waypoints))
            # Spline ended.
            if self.spline.is_complete():
                self.on_spline_finished()
                self.spline = None

    def on_new_position(self, new_position, waypoint_completed, remaining_waypoints):
        self.unit.location = new_position.copy()
        self.unit.set_has_moved(has_moved=True, has_turned=False)

    def set_speed_dirty(self):
        self.speed_dirty = True

    def on_spline_finished(self):
        pass

    def can_remove(self):
        return not self.is_default or not self.unit.is_alive

    def on_removed(self):
        pass

    def is_complete(self):
        return self.spline and self.spline.is_complete()

    def reset(self):
        pass
