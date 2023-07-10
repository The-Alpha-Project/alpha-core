# TODO: Move this to a more generic event system out of MovementManager.
class SplineEvent:
    def __init__(self, unit, start_seconds):
        self.source = unit
        self.start_seconds: int = start_seconds
        self.elapsed = 0
        self.triggered = False

    def update(self, elapsed):
        self.elapsed += elapsed
        if self.elapsed >= self.start_seconds:
            self.execute()

    def execute(self):
        self.triggered = True


class SplineRestoreOrientationEvent(SplineEvent):
    def __init__(self, source, start_seconds):
        super().__init__(source, start_seconds)

    def execute(self):
        if not self.source.in_combat and self.source.is_alive and not self.source.is_moving():
            self.source.movement_manager.face_angle(self.source.spawn_position.o)
        super().execute()


class SplineTargetedEmoteEvent(SplineEvent):
    def __init__(self, source, target, start_seconds, emote):
        super().__init__(source, start_seconds)
        self.target = target
        self.emote = emote

    def execute(self):
        if not self.source.in_combat and self.source.is_alive and not self.source.is_moving():
            self.source.movement_manager.face_target(self.target)
            self.source.play_emote(self.emote)
        super().execute()
