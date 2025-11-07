from dataclasses import dataclass
from functools import lru_cache
from random import randint
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from game.world.managers.objects.script.ScriptAIEvent import ScriptAIEvent
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from game.world.managers.objects.script.ScriptManager import ScriptManager
from utils.Logger import Logger
from utils.constants.MiscCodes import CreatureAIEventTypes, ScriptTypes, UnitInLosReaction
from utils.constants.ScriptCodes import EventFlags
from utils.constants.UnitCodes import PowerTypes, UnitStates


@dataclass
class EventLock:
    event_id: int
    elapsed_secs: float
    repeat_secs: float
    can_repeat: bool

    def update(self, elapsed):
        if not self.can_repeat:
            return
        self.elapsed_secs += elapsed

    def is_locked(self):
        locked = not self.can_repeat or self.elapsed_secs < self.repeat_secs
        return locked

class AIEventHandler:
    def __init__(self, creature):
        self.creature = creature
        self.initialized = False
        self._events = {}
        self.event_locks: dict[int, EventLock] = {}
        self.update_interval_secs = 0.5
        self.update_diff_secs = 0

    def reset(self):
        self.update_diff_secs = 0
        self.event_locks.clear()

    def update(self, elapsed_secs: float):
        self.update_diff_secs += elapsed_secs
        if self.update_diff_secs < self.update_interval_secs:
            return

        # Avoid executing new ooc scripts when no players around.
        # Cell can still be active cause of already running script.
        if self.creature.has_player_observers():
            self.update_timer_out_of_combat_events(self.update_diff_secs)
            self.update_missing_aura_events(self.update_diff_secs)

        # Below events require being in combat.
        if self.creature.combat_target:
            target = self.creature.combat_target

            self.update_target_timer_in_combat_events(target, self.update_diff_secs)
            self.update_target_range_events(target, self.update_diff_secs)
            self.update_target_hp_events(target, self.update_diff_secs)
            self.update_target_mana_events(target, self.update_diff_secs)
            self.update_target_casting_events(target, self.update_diff_secs)
            self.update_target_rooted_events(target, self.update_diff_secs)
            self.update_target_aura_events(target, self.update_diff_secs)

            self.update_self_hp_events(self.update_diff_secs)
            self.update_self_mana_events(self.update_diff_secs)
            self.update_self_friendly_hp_events(self.update_diff_secs)
            self.update_self_friendly_missing_buff_events(self.update_diff_secs)

        # Reset timer.
        self.update_diff_secs = 0

    def _enqueue_creature_ai_event(self, map_, event, target):
        scripts = ScriptHelpers.get_filtered_event_scripts(event)
        if not scripts:
            return

        script_event = ScriptAIEvent(event, self.creature)
        scripts = script_event.pick_scripts()
        event_delay_seconds = script_event.get_delay_seconds()

        if not script_event.can_repeat() or script_event.has_repeat_time():
            self._lock_event(script_event.id, script_event.get_repeat_seconds(), script_event.can_repeat())

        for script in scripts:
            map_.enqueue_script(self.creature, target=target, script_type=ScriptTypes.SCRIPT_TYPE_AI, script_id=script,
                                delay=event_delay_seconds, event=script_event)

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

    def on_leave_combat(self):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_LEAVE_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def on_ooc_los(self, source=None):
        target = self.creature.combat_target
        if target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OOC_LOS)
        map_ = self.creature.get_map()
        target = source if source else self.creature
        for event in events:
            if not self._validate_event(event, target=target):
                continue

            reaction = event.event_param1
            radius = event.event_param2

            if self.creature.location.distance(source.location) > radius:
                continue

            if (reaction == UnitInLosReaction.ULR_ANY
                    or (reaction == UnitInLosReaction.ULR_NON_HOSTILE and not self.creature.is_hostile_to(source))
                    or (reaction == UnitInLosReaction.ULR_HOSTILE and self.creature.is_hostile_to(source))):
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

    def on_script_event_happened(self, event_id, event_data, target):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_SCRIPT_EVENT)
        map_ = self.creature.get_map()
        target = target if target else self.creature
        for event in events:
            if event.event_param1 == event_id and event.event_param2 == event_data:
                if not self._validate_event(event, target=target):
                    continue
                self._enqueue_creature_ai_event(map_, event, target=target)
            else:
                Logger.warning(f'Unable to start script on event {event_id} for unit {self.creature.get_name()}')

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

    def on_death(self, killer=None):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=killer if killer else self.creature):
                continue
            self._enqueue_creature_ai_event(map_, event, killer if killer else self.creature)

    def on_summoned(self, world_object):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_SUMMONED_UNIT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=world_object):
                continue

            if event.event_param1 != world_object.entry:
                continue

            self._enqueue_creature_ai_event(map_, event, world_object)

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
            if event.event_param3 and not target.is_player():
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
        Logger.warning('AI_EVENT_TYPE_MOVEMENT_INFORM is not implemented.')
        pass
        #events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MOVEMENT_INFORM)
        #map_ = self.creature.get_map()
        #for event in events:
        #    if not self._validate_event(event, target=self.creature):
        #        continue

        #    if event.event_param1 == behavior and point_id == event.event_param2:
        #        self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def update_target_aura_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            # Param1: SpellID.
            auras = target.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Number of times stacked.
            if auras[0].applied_stacks < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target)

    def update_target_missing_aura_events(self, elapsed_secs):
        target = self.creature.combat_target
        if not target:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_MISSING_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            # Param1: SpellID.
            auras = target.creature.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Expected stacks.
            if auras[0].applied_stacks >= event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target)

    def update_target_timer_in_combat_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TIMER_IN_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue
            self._enqueue_creature_ai_event(map_, event, target=target)

    def update_timer_out_of_combat_events(self, elapsed_secs):
        if self.creature.combat_target:
            return
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue
            self._enqueue_creature_ai_event(map_, event, target=self.creature)

    def update_missing_aura_events(self, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MISSING_AURA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue

            # Param1: SpellID.
            auras = self.creature.aura_manager.get_auras_by_spell_id(event.event_param1)
            if not auras:
                continue

            # Param2: Expected stacks.
            if auras[0].applied_stacks >= event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature)

    def update_target_casting_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_CASTING)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            if not target.is_casting():
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature)

    def update_self_hp_events(self, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue

            # param1 %MaxHP, param2 %MinHp.
            if self.creature.hp_percent > event.event_param1 or self.creature.hp_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature)

    def update_target_mana_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_MANA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            if target.power_type != PowerTypes.TYPE_MANA:
                continue

            # param1 %MaxMana, param2 %MinMana.
            if target.power_percent > event.event_param1 or target.power_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target, elapsed_secs=elapsed_secs)

    def update_target_hp_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            # param1 %MaxHP, param2 %MinHp.
            if target.hp_percent > event.event_param1 or target.hp_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target, elapsed_secs=elapsed_secs)

    def update_target_rooted_events(self, target, elapsed_secs):
        if not target.unit_state & UnitStates.ROOTED:
            return

        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_ROOTED)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            self._enqueue_creature_ai_event(map_, event, target)

    def update_self_mana_events(self, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_MANA)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue

            if self.creature.power_type != PowerTypes.TYPE_MANA:
                continue

            # param1 %MaxMana, param2 %MinMana.
            if self.creature.power_percent > event.event_param1 or self.creature.power_percent < event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, self.creature)

    def update_self_friendly_missing_buff_events(self, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_MISSING_BUFF)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue

            # Param1: Spell.
            # Param2: Search radius.
            missing_buff_friendly = ScriptManager.resolve_friendly_missing_buf(self.creature, target=None,
                                                                               param1=event.event_param2,
                                                                               param2=event.event_param1)

            if not missing_buff_friendly:
                continue

            self._enqueue_creature_ai_event(map_, event, missing_buff_friendly)

    def update_self_friendly_hp_events(self, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_HP)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=self.creature, elapsed_secs=elapsed_secs):
                continue

            # Param1: Missing HP.
            # Param2: Search radius.
            injured_friendly = ScriptManager.resolve_friendly_injured(self.creature, target=None,
                                                                      param1=event.event_param2,
                                                                      param2=event.event_param1,
                                                                      is_percent=False)

            if not injured_friendly:
                continue

            self._enqueue_creature_ai_event(map_, event, injured_friendly)

    def update_target_range_events(self, target, elapsed_secs):
        events = self._event_get_by_type(CreatureAIEventTypes.AI_EVENT_TYPE_RANGE)
        map_ = self.creature.get_map()
        for event in events:
            if not self._validate_event(event, target=target, elapsed_secs=elapsed_secs):
                continue

            distance = self.creature.location.distance(target.location)
            # param1 %MinDist, param2 %MaxDist.
            if distance < event.event_param1 or distance > event.event_param2:
                continue

            self._enqueue_creature_ai_event(map_, event, target)

    def _validate_event(self, event, target=None, elapsed_secs=0):
        if not ConditionChecker.validate(event.condition_id, self.creature, target if target else self.creature):
            return False

        # Check the inverse phase mask (event doesn't trigger if current phase bit is set in mask).
        if event.event_inverse_phase_mask & (1 << self.creature.object_ai.script_phase):
            return False

        if event.event_flags & EventFlags.NOT_CASTING and self.creature.is_casting():
            return False

        if elapsed_secs and self._is_event_locked(event, elapsed_secs):
            return False

        if event.event_chance != 100 and randint(0, 100) > event.event_chance:
            if not event.event_flags & EventFlags.REPEATABLE:
                # Locked until events are flushed.
                self._lock_event(event.id, 0, False)
            return False

        return True

    @lru_cache
    def has_ooc_los_events(self):
        return self._has_event_type(CreatureAIEventTypes.AI_EVENT_TYPE_OOC_LOS)

    def has_lock_for_event(self, event_id):
        event_lock = self.event_locks.get(event_id, None)
        return event_lock is not None and event_lock.is_locked()

    def unlock_event(self, event_id):
        if self.event_locks.pop(event_id, None) is not None:
            self.creature.get_map().unlock_scripted_event(event_id)
            return True
        return False

    def _has_event_type(self, event_type):
        return any(self._event_get_by_type(event_type))

    def _event_get_by_type(self, event_type):
        # Skip for controlled units.
        if self.creature.is_controlled() and not self.creature.is_guardian():
            return []
        if not self.initialized:
            self.initialized = True
            self._events = WorldDatabaseManager.CreatureAiEventHolder.creature_ai_events_get_by_creature_entry(
                self.creature.entry)
        return self._events.get(event_type, [])

    def _lock_event(self, event_id, repeat_seconds, can_repeat):
        self.event_locks[event_id] = EventLock(event_id=event_id, elapsed_secs=0,
                                                      repeat_secs=repeat_seconds,
                                                      can_repeat=can_repeat)

    def _is_event_locked(self, event, elapsed_secs):
        event_lock = self.event_locks.get(event.id, None)
        if not event_lock:
            return False

        event_lock.update(elapsed_secs)
        locked = event_lock.is_locked()

        # Delete lock if necessary.
        if not locked:
            self.event_locks.pop(event.id)

        return locked
