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
        self.initialized = False
        self._events = {}
        self.event_locks: dict[int: EventLock] = {}

    def on_spawn(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        for event in events:
            if randint(0, 100) > event.event_chance:
                continue

            script_id = event.action1_script
            if script_id:
                self.creature.script_handler.enqueue_script(self.creature, None, ScriptTypes.SCRIPT_TYPE_AI, script_id)

    def on_enter_combat(self, source=None):
        self.creature.script_handler.reset()  # Reset any scripts that were queued before combat (e.g. on spawn).

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        for event in events:
            if randint(0, 100) > event.event_chance:
                continue

            choices = ScriptHelpers.get_filtered_event_scripts(event)
            random_script = choice(choices)

            if random_script:
                self.creature.script_handler.enqueue_script(self.creature, source, ScriptTypes.SCRIPT_TYPE_AI,
                                                            random_script)

    def on_damage_taken(self, attacker=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        for event in events:
            if randint(0, 100) > event.event_chance:
                continue

            now = time.time()
            if self._is_event_locked(event, now):
                continue

            current_hp_percent = (self.creature.health / self.creature.max_health) * 100
            # param1 %MaxHP, param2 %MinHp.
            if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
                continue

            script_id = event.action1_script
            if script_id:
                self._lock_event(event, now)
                self.creature.script_handler.enqueue_script(self.creature, attacker, ScriptTypes.SCRIPT_TYPE_AI, script_id)

    def on_idle(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        for event in events:
            if randint(0, 100) > event.event_chance:
                continue
            self.creature.script_handler.set_random_ooc_event(self.creature, event)

    def on_death(self, killer=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        for event in events:
            if randint(0, 100) > event.event_chance:
                continue
            choices = ScriptHelpers.get_filtered_event_scripts(event)
            random_script = choice(choices)

            if random_script:
                self.creature.script_handler.last_hp_event_id = event.id
                self.creature.script_handler.enqueue_script(self.creature, killer, ScriptTypes.SCRIPT_TYPE_AI,
                                                            random_script)

    def on_emote_received(self, player, emote):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RECEIVE_EMOTE)
        for event in events:
            if event.event_param1 != emote:
                continue

            # TODO: Check conditions (EmoteId, Condition, CondValue1, CondValue2).

            script_id = event.action1_script
            if script_id:
                self.creature.script_handler.enqueue_script(self.creature, player, ScriptTypes.SCRIPT_TYPE_AI,
                                                            script_id)

    def _event_get_by_type(self, event_type):
        # Skip for controlled units.
        if self.creature.get_charmer_or_summoner():
            return []
        if not self.initialized:
            self.initialized = True
            self._events = WorldDatabaseManager.CreatureAiEventHolder.creature_ai_events_get_by_creature_entry(
                self.creature.entry)
        return self._events.get(event_type, [])

    def _lock_event(self, event, now):
        delay = random.uniform(event.event_param3, event.event_param4)
        self.event_locks[event.id] = EventLock(event_id=event.id, time_added=now, delay=delay, can_repeat=delay > 0)

    def _is_event_locked(self, event, now):
        event_lock = self.event_locks.get(event.id)
        if not event_lock:
            return False
        return not event_lock.can_repeat or now - event_lock.time_added < event_lock.delay
