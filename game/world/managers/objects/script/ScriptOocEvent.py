import random
from random import uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.constants.ScriptCodes import EventFlags


class ScriptOocEvent:
    def __init__(self, event, target, owner, forced=False):
        self.owner = owner
        self.comment = event.comment
        self.event_id = event.id
        self.event_flags = event.event_flags
        self.phase_mask = event.event_inverse_phase_mask
        self.scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.delay = 0 if forced else uniform(event.event_param1 / 1000, event.event_param2 / 1000)
        self.repeat = 0 if forced else uniform(event.event_param3 / 1000, event.event_param4 / 1000)
        self.target = target
        self.script_ids = []
        self.started = False
        self.time_added = 0
        self.forced = forced

    def force(self):
        self.delay = 0
        self.time_added = 0

    def check_phase(self):
        if not self.phase_mask:
            return True
        return self.owner.object_ai.phase & self.phase_mask

    def should_repeat(self):
        return self.repeat > 0 and self.event_flags & EventFlags.REPEATABLE

    def initialize(self, now):
        self.time_added = now if not self.forced else 0
        self.started = True
        if self.event_flags & EventFlags.RANDOM_ACTION:
            self.script_ids.append(self._pick_script_id())
        else:
            self.script_ids = self.scripts

    def is_complete(self, now):
        return now - self.time_added > self.repeat

    def _pick_script_id(self):
        script_id = random.choice(self.scripts)
        return script_id if script_id else None
