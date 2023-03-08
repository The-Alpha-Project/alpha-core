from random import randint, choice

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.Script import Script
from utils.constants.MiscCodes import CreatureAIEventTypes


class AIEventHandler:
    def __init__(self, creature):
        self.creature = creature
        self._events = None

    def initialize(self):
        self._events = {
            event.event_type: event for event in
            WorldDatabaseManager.CreatureAiEventHolder.creature_ai_events_get_by_creature_entry(self.creature.entry)}
        if len(self._events) > 0:
            print('Here')

    def on_spawn(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return
        db_scripts = AIEventHandler._get_ai_scripts_by_id(event.action1_script)
        if not db_scripts:
            return
        for db_script in db_scripts:
            self.creature.script_handler.enqueue_ai_script(self.creature, Script(db_script=db_script))

    def on_enter_combat(self):
        self.creature.script_handler.reset()  # Reset any scripts that were queued before combat (e.g. on spawn).

        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return

        choices = list(filter((0).__ne__, [event.action1_script, event.action2_script, event.action3_script]))
        random_script = choice(choices)
        db_scripts = AIEventHandler._get_ai_scripts_by_id(random_script)
        if not db_scripts:
            return
        for db_script in db_scripts:
            self.creature.script_handler.enqueue_ai_script(self.creature, Script(db_script=db_script))

    def on_damage_taken(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        if not event:
            return

        db_scripts = None
        # On rare occasions event_param1 is not the health breakpoint but something else?
        if 0 < event.event_param1 <= 100:
            current_health_percent = (self.creature.health / self.creature.max_health) * 100
            if current_health_percent <= event.event_param1 and self.creature.script_handler.last_hp_event_id != event.id:
                db_scripts = AIEventHandler._get_ai_scripts_by_id(event.action1_script)
            # If event1_param is zero the script should be run on aggro.
            elif event.event_param1 == 0 and self.creature.script_handler.last_hp_event_id != event.id:
                db_scripts = AIEventHandler._get_ai_scripts_by_id(event.action1_script)

        if not db_scripts:
            return

        self.creature.script_handler.last_hp_event_id = event.id
        for db_script in db_scripts:
            self.creature.script_handler.enqueue_ai_script(self.creature, Script(db_script=db_script))

    def on_idle(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        if event:
            self.creature.script_handler.set_random_ooc_event(self.creature, event)

    def on_death(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return
        choices = list(filter((0).__ne__, [event.action1_script, event.action2_script, event.action3_script]))
        random_script = choice(choices)
        db_scripts = AIEventHandler._get_ai_scripts_by_id(random_script)

        if not db_scripts:
            return

        for db_script in db_scripts:
            self.creature.script_handler.last_hp_event_id = event.id
            self.creature.script_handler.enqueue_ai_script(self.creature, Script(db_script=db_script))

    @staticmethod
    def _get_ai_scripts_by_id(script_id):
        return WorldDatabaseManager.CreatureAiScriptHolder.creature_ai_scripts_get_by_id(script_id)
