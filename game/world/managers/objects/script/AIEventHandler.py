import random
import time
from dataclasses import dataclass
from random import randint, choice
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.constants.MiscCodes import CreatureAIEventTypes, ScriptTypes
from utils.constants.ScriptCodes import EventFlags


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
        self.update_interval_secs = 0.5
        self.update_diff_secs = 0

    def reset(self):
        self.update_diff_secs = 0
        self.event_locks.clear()

    def ai_update(self, elapsed_secs: float):
        self.update_diff_secs += elapsed_secs
        if self.update_diff_secs < self.update_interval_secs:
            return
        self.update_diff_secs = 0

        # TODO: Update all type of events that are bound to AI update calls time diff (No on-action triggering).
        now = time.time()
        self.update_hp_events(now)
        self.update_range_events(now)

    def _enqueue_scripts(self, map_, event, target):
        scripts = ScriptHelpers.get_filtered_event_scripts(event)
        if not scripts:
            return

        for script in scripts:
            map_.enqueue_script(self.creature, target=target, script_type=ScriptTypes.SCRIPT_TYPE_AI,
                                script_id=script)

    def on_spawn(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue
            self._enqueue_scripts(map_, event, None)

    def on_enter_combat(self, source=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue
            self._enqueue_scripts(map_, event, source)

    def on_idle(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue
            map_.set_random_ooc_event(self.creature, None, event)

    def on_death(self, killer=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue
            self._enqueue_scripts(map_, event, killer)

    def on_emote_received(self, player, emote):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RECEIVE_EMOTE)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_param1 != emote:
                continue

            # TODO: Check conditions (EmoteId, Condition, CondValue1, CondValue2).
            self._enqueue_scripts(map_, event, player)

    def update_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue

            if self._is_event_locked(event, now):
                continue

            current_hp_percent = (self.creature.health / self.creature.max_health) * 100
            # param1 %MaxHP, param2 %MinHp.
            if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, target)

    def update_range_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RANGE)
        map_ = self.creature.get_map()
        for event in events:
            if event.event_chance != 100 and randint(0, 100) > event.event_chance:
                continue

            if self._is_event_locked(event, now):
                continue

            distance = self.creature.location.distance(target.location)
            # param1 %MinDist, param2 %MaxDist.
            if distance < event.event_param1 or distance > event.event_param2:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, target)

    def _event_get_by_type(self, event_type):
        # Skip for charmed units.
        if self.creature.charmer:
            return []
        if not self.initialized:
            self.initialized = True
            self._events = WorldDatabaseManager.CreatureAiEventHolder.creature_ai_events_get_by_creature_entry(
                self.creature.entry)
        return self._events.get(event_type, [])

    def _lock_event(self, event, now):
        delay = random.uniform(event.event_param3, event.event_param4)
        self.event_locks[event.id] = EventLock(event_id=event.id, time_added=now, delay=delay,
                                               can_repeat=delay > 0 and event.event_flags & EventFlags.REPEATABLE)

    def _is_event_locked(self, event, now):
        event_lock = self.event_locks.get(event.id)
        if not event_lock:
            return False
        locked = not event_lock.can_repeat or now - event_lock.time_added < event_lock.delay
        # Delete lock if necessary.
        if not locked:
            self.event_locks.pop(event.id)
        return locked
