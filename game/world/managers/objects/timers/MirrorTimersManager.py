from game.world.managers.objects.timers.MirrorTimer import MirrorTimer
from utils.constants.MiscCodes import MirrorTimerTypes
from utils.constants.SpellCodes import AuraTypes


class MirrorTimersManager(object):
    UPDATE_RATE = 1  # In seconds, how often we check timers status.

    def __init__(self, owner):
        self.owner = owner
        self.timers = {}
        self.feign_death = False
        self.update_timer = 0
        self.load()

    def load(self):
        self.timers[MirrorTimerTypes.BREATH] = MirrorTimer(self.owner, MirrorTimerTypes.BREATH, 1, 60)
        self.timers[MirrorTimerTypes.FATIGUE] = MirrorTimer(self.owner, MirrorTimerTypes.FATIGUE, 1, 60)
        self.timers[MirrorTimerTypes.FEIGNDEATH] = MirrorTimer(self.owner, MirrorTimerTypes.FEIGNDEATH, 1, 300)

    def set_water_breathing(self, state):
        self.timers[MirrorTimerTypes.BREATH].set_water_breathing(state)

    def stop_all(self):
        for timer in self.timers.values():
            timer.stop()

    def update(self, elapsed):
        # Check if we should update liquid information for player.
        self.update_timer += elapsed
        if self.update_timer >= MirrorTimersManager.UPDATE_RATE:
            self.owner.update_liquid_information()

            # Handle fatigue timer.
            self._check_fatigue(self.update_timer)
            # Handle breathing timer.
            self._check_breathing(self.update_timer)
            # Handle feign death.
            self._check_feign_death(self.update_timer)

            # Update timers.
            for timer in self.timers.values():
                timer.update(self.update_timer)

            # Reset timer
            self.update_timer = 0

    def _check_fatigue(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.owner.is_swimming() and self.owner.is_in_deep_water()
            self._update_breath_fatigue_timer(elapsed, timer_active, MirrorTimerTypes.FATIGUE)

    def _check_breathing(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.owner.is_swimming() and self.owner.is_under_water()
            self._update_breath_fatigue_timer(elapsed, timer_active, MirrorTimerTypes.BREATH)

    def _update_breath_fatigue_timer(self, elapsed, timer_active, timer_type):
        timer_scale = -1 if timer_active else 10
        # Set scale depending if timer is regenerating or depleting.
        self.timers[timer_type].set_scale(timer_scale)
        # If timer should be active and is not, start it.
        if timer_active and not self.timers[timer_type].active:
            self.timers[timer_type].start(elapsed)
        elif not timer_active and not self.owner.is_swimming():  # Not swimming, stop the timer else regenerate.
            self.timers[timer_type].stop()

    def _check_feign_death(self, elapsed):
        if self.owner.is_alive:
            timer_active = self.feign_death
            # If timer should be active and is not, start it.
            if timer_active and not self.timers[MirrorTimerTypes.FEIGNDEATH].active:
                feign_death_auras = self.owner.aura_manager.get_auras_by_type(AuraTypes.SPELL_AURA_FEIGN_DEATH)
                if len(feign_death_auras) > 0:
                    self.timers[MirrorTimerTypes.FEIGNDEATH].start(elapsed, feign_death_auras[0].spell_id)
                else:  # Possible edge case where the player doesn't have any Feign Death aura anymore.
                    self.feign_death = False
                    self.timers[MirrorTimerTypes.FEIGNDEATH].stop()
            elif not timer_active:
                self.timers[MirrorTimerTypes.FEIGNDEATH].stop()
