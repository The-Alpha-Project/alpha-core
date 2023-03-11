import random
import time
from dataclasses import dataclass
from random import randint, choice
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.constants.MiscCodes import CreatureAIEventTypes, ScriptTypes


@dataclass
class EventLock:
    event_id: int
    time_added: float
    delay: float
    can_repeat: bool


class AIEventHandler:
    def __init__(self, creature):
        self.creature = creature
        self._events = {}
        self.event_locks: dict[int: EventLock] = {}

    def initialize(self):
        self._events = {
            event.event_type: event for event in
            WorldDatabaseManager.CreatureAiEventHolder.creature_ai_events_get_by_creature_entry(self.creature.entry)}

    def on_spawn(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return

        script_id = event.action1_script
        if script_id:
            self.creature.script_handler.enqueue_script(self.creature, None, ScriptTypes.SCRIPT_TYPE_AI, script_id)

    def on_enter_combat(self):
        self.creature.script_handler.reset()  # Reset any scripts that were queued before combat (e.g. on spawn).

        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return

        choices = ScriptHelpers.get_filtered_event_scripts(event)
        random_script = choice(choices)

        if random_script:
            self.creature.script_handler.enqueue_script(self.creature, None, ScriptTypes.SCRIPT_TYPE_AI, random_script)

    def on_damage_taken(self):
        event = self._events.get(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        if not event:
            return

        if randint(0, 100) > event.event_chance:
            return

        now = time.time()
        if self._is_event_locked(event, now):
            return

        current_hp_percent = (self.creature.health / self.creature.max_health) * 100
        # param1 %MaxHP, param2 %MinHp.
        if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
            return

        script_id = event.action1_script
        if script_id:
            self._lock_event(event, now)
            self.creature.script_handler.enqueue_script(self.creature, None, ScriptTypes.SCRIPT_TYPE_AI, script_id)

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
        choices = ScriptHelpers.get_filtered_event_scripts(event)
        random_script = choice(choices)

        if random_script:
            self.creature.script_handler.last_hp_event_id = event.id
            self.creature.script_handler.enqueue_script(self.creature, None, ScriptTypes.SCRIPT_TYPE_AI, random_script)

    def _lock_event(self, event, now):
        delay = random.uniform(event.event_param3, event.event_param4)
        self.event_locks[event.id] = EventLock(event_id=event.id, time_added=now, delay=delay, can_repeat=delay > 0)

    def _is_event_locked(self, event, now):
        event_lock = self.event_locks.get(event.id)
        if not event_lock:
            return False
        return not event_lock.can_repeat or now - event_lock.time_added < event_lock.delay
