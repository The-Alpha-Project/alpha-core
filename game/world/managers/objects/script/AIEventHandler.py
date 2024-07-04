import random
import time
from dataclasses import dataclass
from random import randint, choice
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.script.ScriptCreatureAIEvent import ScriptCreatureAIEvent
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
        self.update_timer_in_combat_events(now)
        self.update_target_hp_events(now)
        self.update_target_casting_events(now)

    def _enqueue_creature_ai_event(self, map_, event, target, now=0):
        scripts = ScriptHelpers.get_filtered_event_scripts(event)
        if not scripts:
            return

        creature_event = ScriptCreatureAIEvent(event, self.creature)
        scripts = creature_event.pick_scripts()

        if now:
            self._lock_event(creature_event, now)

        for script in scripts:
            map_.enqueue_script(self.creature, target=target, script_type=ScriptTypes.SCRIPT_TYPE_AI, script_id=script)

    def on_spawn(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def on_enter_combat(self, source=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT)
        map_ = self.creature.get_map()
        target = source if source else self.creature
        for event in events:
            if not self._validate_event(event, target=target):
                continue
            self._enqueue_creature_ai_event(map_, event, target=target)

    def on_spell_hit(self, casting_spell, source=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_SPELL_HIT)
        map_ = self.creature.get_map()
        target = source if source else self.creature
        for event in events:
            if not self._validate_event(event, target=target):
                continue

            if not event.event_param1 or casting_spell.spell_entry.ID == event.event_param1:
                # TODO: Review this mask comparison.
                if casting_spell.get_damage_school_mask() & event.event_param2:
                    self._enqueue_creature_ai_event(map_, event, target=target)

    def on_group_member_died(self, source, is_leader):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_GROUP_MEMBER_DIED)
        map_ = self.creature.get_map()
        target = source if source else self.creature
        for event in events:
            if not self._validate_event(event, target=target):
                continue

            if event.event_param1 and event.event_param1 != target.entry:
                continue

            requires_leader = event.event_param2 != 0
            if requires_leader == is_leader:
                self._enqueue_creature_ai_event(map_, event, target=target)

    def on_idle(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue
            map_.set_random_ooc_event(source=self.creature, target=self.creature, event=event)

    def on_death(self, killer=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=killer if killer else self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, killer if killer else self.creature)

    def on_emote_received(self, player, emote):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RECEIVE_EMOTE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=player):
                continue

            if event.event_param1 != emote:
                continue

            self._enqueue_creature_ai_event(map_, event, player)

    def on_killed_unit(self, target):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_KILL_UNIT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target):
                continue
            self._enqueue_creature_ai_event(map_, event, target=target)

    def on_evade(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_EVADE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def on_reached_home(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_REACHED_HOME)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, target=self.creature)

    # TODO.
    def on_movement_inform(self, behavior, point_id):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MOVEMENT_INFORM)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue

            if event.event_param1 == behavior and point_id == event.event_param2:
                self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def update_target_missing_aura_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_MISSING_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, now=now):
                continue

            # Param1: SpellID.
            auras = target.creature.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Expected stacks.
            if auras[0].applied_stacks >= event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target, now)

    def update_timer_in_combat_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TIMER_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, now=now):
                continue
            self._enqueue_creature_ai_event(map_, event, target=target, now=now)

    def update_missing_aura_events(self, now):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MISSING_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, now=now):
                continue

            # Param1: SpellID.
            auras = self.creature.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Expected stacks.
            if auras[0].applied_stacks >= event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature, now)

    def update_target_casting_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_CASTING)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, now=now):
                continue

            if not target.is_casting():
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature, now)

    def update_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, now=now):
                continue

            current_hp_percent = (self.creature.health / self.creature.max_health) * 100
            # param1 %MaxHP, param2 %MinHp.
            if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature, now)

    def update_target_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, now=now):
                continue

            current_hp_percent = (target.creature.health / target.creature.max_health) * 100
            # param1 %MaxHP, param2 %MinHp.
            if current_hp_percent > event.event_param1 or current_hp_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target, now)

    def update_mana_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MANA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, now=now):
                continue

            if self.creature.power_type != PowerTypes.TYPE_MANA:
                continue

            current_mana = self.creature.power_1
            current_max_mana = self.creature.max_power_1

            current_mana_percent = (current_mana / current_max_mana) * 100
            # param1 %MaxMana, param2 %MinMana.
            if current_mana_percent > event.event_param1 or current_mana_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature, now)

    def update_friendly_hp_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, now=now):
                continue

            # Param1: HP percent.
            # Param2: Search radius.
            injured_friendly = ScriptManager.resolve_friendly_injured(self.creature, target=None,
                                                                      param1=event.event_param2,
                                                                      param2=event.event_param1)

            if not injured_friendly:
                continue

            self._enqueue_creature_ai_event(map_, event, injured_friendly, now)

    def update_range_events(self, now):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RANGE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, now=now):
                continue

            distance = self.creature.location.distance(target.location)
            # param1 %MinDist, param2 %MaxDist.
            if distance < event.event_param1 or distance > event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target, now)

    def _validate_event(self, event, target=None, now=0):
        if event.event_chance != 100 and randint(0, 100) > event.event_chance:
            return False

        if not ConditionChecker.validate(event.condition_id, self.creature, target if target else self.creature):
            return False

        # Check the inverse phase mask (event doesn't trigger if current phase bit is set in mask)
        if event.event_inverse_phase_mask & (1 << self.creature.object_ai.script_phase):
            return False

        if event.event_flags & EventFlags.NOT_CASTING and self.creature.is_casting():
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
        delay = random.uniform(event.min_delay, event.max_delay)
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
