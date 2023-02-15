class BaseMovement:
    def __init__(self, is_default, move_type, spline_callback):
        self.is_default = is_default
        self.move_type = move_type
        self.spline_callback = spline_callback
        self.spline = None
        self.unit = None

    def initialize(self, unit):
        self.unit = unit

    def update(self, now, elapsed):
        if self.spline:
            position_changed, new_position, wp_complete = self.spline.update(elapsed)
            # Position changed either guessed or wp complete.
            if position_changed:
                self.on_new_position(new_position, wp_complete)
            # Spline ended.
            if self.spline.is_complete():
                self.on_spline_finished()
                self.spline = None

    def on_new_position(self, new_position, waypoint_completed):
        self.spline.unit.location = new_position

    def on_spline_finished(self):
        pass

    def can_remove(self):
        return not self.is_default

    def on_removed(self):
        pass

    def is_complete(self):
        return self.spline and self.spline.is_complete()

    def reset(self):
        pass

    def interrupt(self):
        if self.spline:
            self.spline.update_to_now()
            self.spline = None
