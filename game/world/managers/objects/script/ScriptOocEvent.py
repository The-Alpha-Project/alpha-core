import random
from random import uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers


class ScriptOocEvent:
    def __init__(self, event, target):
        self.event_id = event.id
        self.scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.delay = uniform(event.event_param1 / 1000, event.event_param2 / 1000)
        self.repeat = uniform(event.event_param3 / 1000, event.event_param4 / 1000)
        self.target = target
        self.script_id = 0
        self.should_repeat = self.repeat > 0
        self.started = False
        self.time_added = 0

    def initialize(self, now):
        self.time_added = now
        self.started = True
        self.script_id = self._pick_script_id()

    def is_complete(self, now):
        return now - self.time_added > self.repeat

    def _pick_script_id(self):
        script_id = random.choice(self.scripts)
        self.script_id = script_id if script_id else 0
        return script_id if random else None
