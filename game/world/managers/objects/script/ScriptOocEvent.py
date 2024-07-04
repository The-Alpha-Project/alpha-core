import random
from random import uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.Logger import Logger
from utils.constants.ScriptCodes import EventFlags


class ScriptOocEvent:
    def __init__(self, event, source, target, forced=False):
        self.source = source
        self.target = target
        self.comment = event.comment
        self.event_id = event.id
        self.event_flags = event.event_flags
        self.phase_mask = event.event_inverse_phase_mask
        self._scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.has_scripts = len(self._scripts) > 0
        self.min_delay = event.event_param1 / 1000  # Seconds.
        self.max_delay = event.event_param2 / 1000  # Seconds.
        self.min_repeat = event.event_param3 / 1000  # Seconds.
        self.max_repeat = event.event_param4 / 1000  # Seconds.
        self.delay = 0 if forced else uniform(self.min_delay, self.max_delay)
        self.repeat = 0 if forced else uniform(self.min_repeat, self.max_repeat)
        self.started = False
        self.time_added = 0
        self.forced = forced

    def force(self):
        self.delay = 0
        self.time_added = 0

    def check_phase(self):
        if not self.phase_mask:
            return True

        # Check the inverse phase mask (event doesn't trigger if current phase bit is set in mask).
        return self.phase_mask & (1 << self.source.object_ai.script_phase)

    def should_repeat(self):
        return self.repeat > 0 and self.event_flags & EventFlags.REPEATABLE

    def initialize(self, now):
        self.time_added = now if not self.forced else 0
        self.started = True
        # If repeatable, refresh delay and repeat for next execution.
        if self.event_flags & EventFlags.REPEATABLE:
            self.delay = 0 if self.forced else uniform(self.min_delay, self.max_delay)
            self.repeat = 0 if self.forced else uniform(self.min_repeat, self.max_repeat)
        Logger.info(f'OOC Event started [{self.comment}], source: {self.source.get_name()}, '
                    f'will repeat in {self.repeat} seconds.')

    def pick_scripts(self):
        if self.event_flags & EventFlags.RANDOM_ACTION:
            return [random.choice(self._scripts)]
        else:
            return list(self._scripts)

    def is_complete(self, now):
        return now - self.time_added > self.repeat
