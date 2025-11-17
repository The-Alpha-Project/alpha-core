import time

from game.world.managers.objects.script.ScriptedEventTarget import ScriptedEventTarget
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from utils.Logger import Logger
from utils.constants.MiscCodes import ScriptTypes
from utils.constants.ScriptCodes import RemoveMapEventTargetOptions, SendMapEventOptions


class ScriptedEvent:
    def __init__(self, event_id, source, target, map_id, expire_time, failure_condition, failure_script,
                 success_condition, success_script):
        self.event_id = event_id
        self.source = source
        self.target = target
        self.map_id = map_id
        self.expire_time = time.time() + expire_time if expire_time else -1
        self.failure_condition = failure_condition
        self.failure_script = failure_script
        self.success_condition = success_condition
        self.success_script = success_script
        self.ended = False

        self.event_data = {}
        self.event_targets = []

    def update(self, now):
        if self.ended:
            return True

        if self.expire_time == -1:
            Logger.warning(f'Event {self.event_id} has expired with no expiration time set.')
            self.end_event(False)
            return True

        if self.expire_time < now:
            self.end_event(False)
            return True

        # While active, keep checking fail/success conditions.
        if self.failure_condition and ConditionChecker.validate(self.failure_condition, self.source, self.target):
            self.end_event(False)
            return True
        elif self.success_condition and ConditionChecker.validate(self.success_condition, self.source, self.target):
            self.end_event(True)
            return True

        for t in self.event_targets:
            if t.failure_condition and ConditionChecker.validate(t.failure_condition, self.source, t.target):
                self.end_event(False)
                return True
            elif t.success_condition and ConditionChecker.validate(t.success_condition, self.source, t.target):
                self.end_event(True)
                return True

        return False

    def end_event(self, success):
        self.ended = True

        if not self.source:
            Logger.error(f'No source found to trigger end script for event {self.event_id}, aborting.')
            return

        script = self.success_script if success else self.failure_script
        if script:
            self.source.get_map().enqueue_script(self.source, self.target, ScriptTypes.SCRIPT_TYPE_GENERIC, script)

        for t in self.event_targets:
            script = t.success_script if success else t.failure_script
            if script:
                t.target.get_map().enqueue_script(t.target, self.target, ScriptTypes.SCRIPT_TYPE_GENERIC, script)

    def send_event_data(self, data, options):
        if options == SendMapEventOptions.SO_SENDMAPEVENT_ALL_TARGETS:
            self.send_event_to_all_targets(data)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_MAIN_TARGETS_ONLY:
            self.send_event_to_main_targets(data)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_EXTRA_TARGETS_ONLY:
            self.send_event_to_additional_targets(data)

    def send_event_to_main_targets(self, data):
        self.target.object_ai.on_script_event(self.event_id, data, None)

    def send_event_to_additional_targets(self, data):
        for t in self.event_targets:
            t.target.object_ai.on_script_event(self.event_id, data, None)

    def send_event_to_all_targets(self, data):
        self.target.object_ai.on_script_event(self.event_id, data, None)
        for t in self.event_targets:
            t.target.object_ai.on_script_event(self.event_id, data, None)

    def set_source(self, source):
        self.source = source

    def set_target(self, target):
        self.target = target

    def get_target(self, entry=0):
        if not entry:
            return self.target
        event_target = next(t for t in self.event_targets if t.entry == entry)
        return event_target.target if event_target else None

    def get_source(self):
        return self.source

    def add_or_update_extra_target(self, target, failure_condition, failure_script, success_condition,
                                   success_script):
        event_target = [t for t in self.event_targets if t.target.entry == target.entry]
        if not event_target:
            self.event_targets.append(ScriptedEventTarget(target, failure_condition, failure_script,
                                                          success_condition, success_script))
            return

        event_target = target[0]
        event_target.failure_condition = failure_condition
        event_target.failure_script = failure_script
        event_target.success_condition = success_condition
        event_target.success_script = success_script

    def remove_event_target(self, _target, condition_id, options):
        if options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_TARGETS:
            self.event_targets = []
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_SELF:
            self.event_targets.remove(_target)
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ONE_FIT_CONDITION:
            for t in self.event_targets:
                if ConditionChecker.check_condition_object_fit_condition(condition_id, None, t):
                    self.event_targets.remove(t)
                    return
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_FIT_CONDITION:
            matches = 0
            for t in self.event_targets:
                if ConditionChecker.check_condition_object_fit_condition(condition_id, None, t):
                    matches += 1

            if matches == len(self.event_targets):
                self.event_targets = {}

    def update_event_data(self, success_condition, success_script, failure_condition, failure_script):
        self.success_condition = success_condition
        self.success_script = success_script
        self.failure_condition = failure_condition
        self.failure_script = failure_script

    def get_data(self, index):
        return self.event_data[index]

    def set_data(self, index, value):
        self.event_data[index] = value

    def increment_data(self, index, value):
        self.event_data[index] += value

    def decrement_data(self, index, value):
        if self.event_data[index] > value:
            self.event_data[index] -= value
        else:
            self.event_data[index] = 0
