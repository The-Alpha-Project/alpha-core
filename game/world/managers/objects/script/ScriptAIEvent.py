from random import choice, uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.Logger import Logger
from utils.constants.MiscCodes import CreatureAIEventTypes
from utils.constants.ScriptCodes import EventFlags


class ScriptAIEvent:

    def __init__(self, event, source):
        self.id = event.id
        self.source = source
        self.comment = event.comment
        self.event_flags = event.event_flags
        self.inverse_phase_mask = event.event_inverse_phase_mask
        self._scripts = ScriptHelpers.get_filtered_event_scripts(event)
        self.has_scripts = len(self._scripts) > 0
        self.min_delay, self.max_delay, self.min_repeat, self.max_repeat = ScriptAIEvent._fill_delay_repeat_seconds(event)

    @staticmethod
    def _fill_delay_repeat_seconds(event):
        # VMaNGOS reuses event_param1..4 with different meanings per event type
        # (e.g. HP thresholds, ranges, spell ids, and sometimes repeat timers).
        # Our scheduler logic is generic and only understands:
        # min_delay, max_delay, min_repeat, max_repeat
        # We normalize each event's timer into this common shape here.
        # This keeps timing behavior VMaNGOS-compatible while letting the runtime
        # consume one consistent format.
        event_type = event.event_type

        # TIMER/OOC-TIMER store both initial delay and repeat in params 1..4.
        if event_type in ScriptAIEvent._INITIAL_AND_REPEAT_EVENTS:
            return (event.event_param1 / 1000, event.event_param2 / 1000,
                    event.event_param3 / 1000, event.event_param4 / 1000)

        # Most conditional events use params 1..2 for condition data and 3..4 for repeat.
        if event_type in ScriptAIEvent._REPEAT_PARAM3_4_EVENTS:
            return 0, 0, event.event_param3 / 1000, event.event_param4 / 1000

        # One-shot events do not carry repeat timers.
        if event_type in ScriptAIEvent._NO_REPEAT_EVENTS:
            return 0, 0, 0, 0

        # Some events (e.g. kill/target-casting) use params 1..2 as repeat.
        if event_type in ScriptAIEvent._REPEAT_PARAM1_2_EVENTS:
            return 0, 0, event.event_param1 / 1000, event.event_param2 / 1000

        # Summon events use params 2..3 as repeat; param1 is summon/entry selector.
        if event_type in ScriptAIEvent._REPEAT_PARAM2_3_EVENTS:
            return 0, 0, event.event_param2 / 1000, event.event_param3 / 1000

        Logger.warning(f'Failed to fill delay/repeat times for Event type {event_type}')
        return 0, 0, 0, 0

    def pick_scripts(self):
        if (self.event_flags & EventFlags.RANDOM_ACTION) != 0:
            return [choice(self._scripts)]
        else:
            return list(self._scripts)

    def can_repeat(self):
        return (self.event_flags & EventFlags.REPEATABLE) != 0

    def has_repeat_time(self):
        return self.min_repeat or self.max_repeat

    def get_repeat_seconds(self):
        return uniform(self.min_repeat, self.max_repeat)

    def get_delay_seconds(self):
        return uniform(self.min_delay, self.max_delay)

    def get_event_info(self):
        return f'Id: {self.id}, Comment: {self.comment}'

    # Mappers.

    _INITIAL_AND_REPEAT_EVENTS = {
        CreatureAIEventTypes.AI_EVENT_TYPE_TIMER_IN_COMBAT,
        CreatureAIEventTypes.AI_EVENT_TYPE_OUT_OF_COMBAT
    }

    _REPEAT_PARAM3_4_EVENTS = {
        CreatureAIEventTypes.AI_EVENT_TYPE_HP,
        CreatureAIEventTypes.AI_EVENT_TYPE_MANA,
        CreatureAIEventTypes.AI_EVENT_TYPE_SPELL_HIT,
        CreatureAIEventTypes.AI_EVENT_TYPE_RANGE,
        CreatureAIEventTypes.AI_EVENT_TYPE_OOC_LOS,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_HP,
        CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_HP,
        CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_IS_CC,
        CreatureAIEventTypes.AI_EVENT_TYPE_FRIENDLY_MISSING_BUFF,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_MANA,
        CreatureAIEventTypes.AI_EVENT_TYPE_AURA,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_AURA,
        CreatureAIEventTypes.AI_EVENT_TYPE_MISSING_AURA,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_MISSING_AURA,
        CreatureAIEventTypes.AI_EVENT_TYPE_MOVEMENT_INFORM,
        CreatureAIEventTypes.AI_EVENT_TYPE_HIT_BY_AURA,
        CreatureAIEventTypes.AI_EVENT_TYPE_SPELL_HIT_TARGET
    }

    _NO_REPEAT_EVENTS = {
        CreatureAIEventTypes.AI_EVENT_TYPE_ON_ENTER_COMBAT,
        CreatureAIEventTypes.AI_EVENT_TYPE_ON_DEATH,
        CreatureAIEventTypes.AI_EVENT_TYPE_ON_EVADE,
        CreatureAIEventTypes.AI_EVENT_TYPE_ON_SPAWN,
        CreatureAIEventTypes.AI_EVENT_TYPE_QUEST_ACCEPT,
        CreatureAIEventTypes.AI_EVENT_TYPE_QUEST_COMPLETE,
        CreatureAIEventTypes.AI_EVENT_TYPE_REACHED_HOME,
        CreatureAIEventTypes.AI_EVENT_TYPE_RECEIVE_EMOTE,
        CreatureAIEventTypes.AI_EVENT_TYPE_LEAVE_COMBAT,
        CreatureAIEventTypes.AI_EVENT_TYPE_SCRIPT_EVENT,
        CreatureAIEventTypes.AI_EVENT_TYPE_GROUP_MEMBER_DIED
    }

    _REPEAT_PARAM1_2_EVENTS = {
        CreatureAIEventTypes.AI_EVENT_TYPE_ON_KILL_UNIT,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_CASTING,
        CreatureAIEventTypes.AI_EVENT_TYPE_TARGET_ROOTED,
        CreatureAIEventTypes.AI_EVENT_TYPE_STEALTH_ALERT
    }

    _REPEAT_PARAM2_3_EVENTS = {
        CreatureAIEventTypes.AI_EVENT_TYPE_SUMMONED_UNIT,
        CreatureAIEventTypes.AI_EVENT_TYPE_SUMMONED_JUST_DIED,
        CreatureAIEventTypes.AI_EVENT_TYPE_SUMMONED_JUST_DESPAWNED
    }
