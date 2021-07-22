from game.world.managers.objects.timers.MirrorTimer import MirrorTimer
from utils.constants.MiscCodes import MirrorTimerTypes


class MirrorTimersManager(object):
    def __init__(self, owner):
        self.owner = owner
        self.update_liquids_timer = 0
        self.timers = {}
        self.feign_death = False
        self.load()

    def load(self):
        self.timers[MirrorTimerTypes.BREATH] = MirrorTimer(self.owner, MirrorTimerTypes.BREATH, 1, 60, -1, 0)
        self.timers[MirrorTimerTypes.FATIGUE] = MirrorTimer(self.owner, MirrorTimerTypes.FATIGUE, 1, 60, -1, 0)
        self.timers[MirrorTimerTypes.FEIGNDEATH] = MirrorTimer(self.owner, MirrorTimerTypes.FEIGNDEATH, 1, 300, -1, 5384)

    def stop_all(self):
        for timer in self.timers.values():
            timer.stop()

    def update(self, elapsed):
        # Check if we should update liquid information for player.
        self.update_liquids_timer += elapsed
        if self.update_liquids_timer > 3:
            self.owner.update_liquid_information()
            self.update_liquids_timer = 0

        # Handle fatigue timer.
        self._check_fatigue(elapsed)
        # Handle breathing timer.
        self._check_breathing(elapsed)
        # Handle feign death.
        self._check_feign_death(elapsed)

        # Update timers.
        for timer in self.timers.values():
            timer.update(elapsed)

    def _check_fatigue(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.owner.is_swimming() and self.owner.is_in_deep_water()
            timer_scale = -1 if timer_active else 10
            # Set scale depending if timer is regenerating or depleting.
            self.timers[MirrorTimerTypes.FATIGUE].set_scale(timer_scale)
            # If timer should be active and is not, start it.
            if timer_active and not self.timers[MirrorTimerTypes.FATIGUE].active:
                self.timers[MirrorTimerTypes.FATIGUE].start(elapsed)
            elif not timer_active:  # Not swimming and not in deep water, stop the timer.
                self.timers[MirrorTimerTypes.FATIGUE].stop()

    def _check_breathing(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.owner.is_swimming() and self.owner.is_under_water()
            timer_scale = -1 if timer_active else 10
            # Set scale depending if timer is regenerating or depleting.
            self.timers[MirrorTimerTypes.BREATH].set_scale(timer_scale)
            # If timer should be active and is not, start it.
            if timer_active and not self.timers[MirrorTimerTypes.BREATH].active:
                self.timers[MirrorTimerTypes.BREATH].start(elapsed)
            elif not timer_active and not self.owner.is_swimming():  # Not swimming, stop the timer.
                self.timers[MirrorTimerTypes.BREATH].stop()

    def _check_feign_death(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.feign_death
            # If timer should be active and is not, start it.
            if timer_active and not self.timers[MirrorTimerTypes.FEIGNDEATH].active:
                self.timers[MirrorTimerTypes.FEIGNDEATH].start(elapsed)
            elif not timer_active:
                self.timers[MirrorTimerTypes.FEIGNDEATH].stop()
