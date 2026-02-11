from random import choice, uniform
from game.world.managers.objects.script.ScriptHelpers import ScriptHelpers
from utils.Logger import Logger
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
        match event.event_type:
            # AI_EVENT_TYPE_TIMER_IN_COMBAT
            # AI_EVENT_TYPE_OUT_OF_COMBAT
            case 0 | 1:
                return event.event_param1 / 1000, event.event_param2 / 1000, event.event_param3 / 1000, event.event_param4 / 1000
            # AI_EVENT_TYPE_HP
            # AI_EVENT_TYPE_MANA
            # AI_EVENT_TYPE_SPELL_HIT
            # AI_EVENT_TYPE_RANGE
            # AI_EVENT_TYPE_OOC_LOS
            # AI_EVENT_TYPE_TARGET_HP
            # AI_EVENT_TYPE_FRIENDLY_HP
            # AI_EVENT_TYPE_FRIENDLY_MISSING_BUFF
            # AI_EVENT_TYPE_FRIENDLY_IS_CC
            # AI_EVENT_TYPE_TARGET_MANA
            # AI_EVENT_TYPE_AURA
            # AI_EVENT_TYPE_TARGET_AURA
            # AI_EVENT_TYPE_MISSING_AURA
            # AI_EVENT_TYPE_TARGET_MISSING_AURA
            # AI_EVENT_TYPE_MOVEMENT_INFORM
            # AI_EVENT_TYPE_HIT_BY_AURA
            # AI_EVENT_TYPE_SPELL_HIT_TARGET
            case 2 | 3 | 8 | 9 | 10 | 12 | 14 | 15 | 16 | 18 | 23 | 24 | 27 | 28 | 29 | 34 | 36:
                return 0, 0, event.event_param3 / 1000, event.event_param4 / 1000
            # AI_EVENT_TYPE_ON_ENTER_COMBAT
            # AI_EVENT_TYPE_ON_DEATH
            # AI_EVENT_TYPE_ON_EVADE
            # AI_EVENT_TYPE_ON_SPAWN
            # AI_EVENT_TYPE_QUEST_ACCEPT
            # AI_EVENT_TYPE_QUEST_COMPLETE
            # AI_EVENT_TYPE_REACHED_HOME
            # AI_EVENT_TYPE_RECEIVE_EMOTE
            # AI_EVENT_TYPE_LEAVE_COMBAT
            # AI_EVENT_TYPE_SCRIPT_EVENT
            # AI_EVENT_TYPE_GROUP_MEMBER_DIED
            case 4 | 6 | 7 | 11 | 19 | 20 | 21 | 22 | 30 | 31 | 32:
                return 0, 0, 0, 0
            # AI_EVENT_TYPE_ON_KILL_UNIT
            # AI_EVENT_TYPE_TARGET_CASTING
            # AI_EVENT_TYPE_TARGET_ROOTED
            # AI_EVENT_TYPE_STEALTH_ALERT
            case 5 | 13 | 33 | 35:
                return 0, 0, event.event_param1 / 1000, event.event_param2 / 1000
            # AI_EVENT_TYPE_SUMMONED_UNIT
            # AI_EVENT_TYPE_SUMMONED_JUST_DIED
            # AI_EVENT_TYPE_SUMMONED_JUST_DESPAWNED
            case 17 | 25 | 26:
                return 0, 0, event.event_param2 / 1000, event.event_param3 / 1000
            case _:
                Logger.warning(f'Failed to fill delay/repeat times for Event type {event.event_type}')
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
