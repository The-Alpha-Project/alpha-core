import random
import time
from dataclasses import dataclass
from random import randint, choice
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from game.world.managers.objects.script.ScriptManager import ScriptManager
from utils.constants.MiscCodes import CreatureAIEventTypes, ScriptTypes
from utils.constants.ScriptCodes import EventFlags
from utils.constants.UnitCodes import PowerTypes


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
        self.update_mana_events(now)
        self.update_range_events(now)
        self.update_friendly_hp_events(now)
        self.update_missing_aura_events(now)

    def _enqueue_scripts(self, map_, event, target):
        scripts = event.pick_scripts()
        if not scripts:
            return

        for script in scripts:
            map_.enqueue_script(self.creature, target=target, script_type=ScriptTypes.SCRIPT_TYPE_AI, script_id=script)

    def on_spawn(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event):
                continue
            self._enqueue_scripts(map_, event, None)

    def on_enter_combat(self, source=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=source):
                continue
            self._enqueue_scripts(map_, event, source)

    def on_idle(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event):
                continue
            map_.set_random_ooc_event(self.creature, None, event)

    def on_death(self, killer=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=killer):
                continue
            self._enqueue_scripts(map_, event, killer)

    def on_emote_received(self, player, emote):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RECEIVE_EMOTE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=player):
                continue

            if event.event_param1 != emote:
                continue

            self._enqueue_scripts(map_, event, player)

    def update_missing_aura_events(self, now):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MISSING_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=None, now=now):
                continue

            # Param1: SpellID.
            auras = self.creature.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Expected stacks.
            if auras[0].applied_stacks >= event.event_param2:
                continue

            self._enqueue_scripts(map_, event, self.creature)

    def update_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=target, now=now):
                continue

            current_hp_percent = (self.creature.health / self.creature.max_health) * 100
            # param1 %MaxHP, param2 %MinHp.
            if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, target)

    def update_mana_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MANA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=target, now=now):
                continue

            if self.creature.power_type != PowerTypes.TYPE_MANA:
                continue

            current_mana = self.creature.power_1
            current_max_mana = self.creature.max_power_1

            current_mana_percent = (current_mana / current_max_mana) * 100
            # param1 %MaxMana, param2 %MinMana.
            if current_mana_percent > event.event_param1 or current_mana_percent < event.event_param2:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, target)

    def update_friendly_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=None, now=now):
                continue

            # Param1: HP percent.
            # Param2: Search radius.
            injured_friendly = ScriptManager.handle_friendly_injured(self.creature, target=None,
                                                                     param1=event.event_param2,
                                                                     param2=event.event_param1)

            if not injured_friendly:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, injured_friendly)

    def update_range_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RANGE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_chance_condition_lock(event, target=None, now=now):
                continue

            distance = self.creature.location.distance(target.location)
            # param1 %MinDist, param2 %MaxDist.
            if distance < event.event_param1 or distance > event.event_param2:
                continue

            self._lock_event(event, now)
            self._enqueue_scripts(map_, event, target)

    def _validate_chance_condition_lock(self, event, target=None, now=0):
        if event.event_chance != 100 and randint(0, 100) > event.event_chance:
            return False

        if target and not ConditionChecker.validate(event.condition_id, self.creature, target):
            return False

        if now and self._is_event_locked(event, now):
            return False

        return True

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
        delay = random.uniform(event.event_param3, event.event_param4) / 1000  # Seconds.
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
