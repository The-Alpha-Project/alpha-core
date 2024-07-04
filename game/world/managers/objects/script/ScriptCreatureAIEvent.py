from random import choice
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.constants.ScriptCodes import EventFlags


class ScriptCreatureAIEvent:
    def __init__(self, event, source):
        self.id = event.id
        self.source = source
        self.comment = event.comment
        self.event_flags = event.event_flags
        self.inverse_phase_mask = event.event_inverse_phase_mask
        self._scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.has_scripts = len(self._scripts) > 0
        self.min_delay = event.event_param1 / 1000  # Seconds.
        self.max_delay = event.event_param2 / 1000  # Seconds.
        self.min_repeat = event.event_param3 / 1000  # Seconds.
        self.max_repeat = event.event_param4 / 1000  # Seconds.

    def pick_scripts(self):
        if self.event_flags & EventFlags.RANDOM_ACTION:
            return [choice(self._scripts)]
        else:
            return list(self._scripts)
