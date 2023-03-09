import random
from random import uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers


class ScriptOccEvent:
    def __init__(self, event, target):
        self.id = event.id
        self.scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.delay = uniform(event.event_param1 / 1000, event.event_param2 / 1000)
        self.repeat = uniform(event.event_param3 / 1000, event.event_param4 / 1000)
        self.target = target
        self.current_script_id = 0
        self.should_repeat = not self.repeat
        self.running = False

    def pick_script_id(self):
        script_id = random.choice(self.scripts)
        self.current_script_id = script_id if script_id else 0
        return script_id if random else None
