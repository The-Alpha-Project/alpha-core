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
            return

        # While active, keep checking fail/success conditions.
        # No expire time - Event should have both failure and success conditions set.
        if self.expire_time == -1 or self.expire_time >= now:
            if self.failure_condition and ConditionChecker.validate(self.failure_condition, self.source, self.target):
                self.end_event(False)
            elif self.success_condition and ConditionChecker.validate(self.success_condition, self.source, self.target):
                self.end_event(True)
        else:
            self.end_event(False)

    def end_event(self, success):
        self.ended = True

        if not self.source:
            Logger.error(f'No source found to trigger end script for event {self.event_id}, aborting.')
            return

        self.source.get_map().enqueue_script(self.source, self.target, ScriptTypes.SCRIPT_TYPE_GENERIC,
                                             self.success_script if success else self.failure_script)

    def send_event_data(self, data_index, options):
        if options == SendMapEventOptions.SO_SENDMAPEVENT_ALL_TARGETS:
            self.send_event_to_all_targets(data_index)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_MAIN_TARGETS_ONLY:
            self.send_event_to_main_targets(data_index)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_EXTRA_TARGETS_ONLY:
            self.send_event_to_additional_targets(data_index)

    def send_event_to_main_targets(self, data_index):
        self.target.object_ai.on_scripted_event(self.event_id, self.event_data[data_index])

    def send_event_to_additional_targets(self, data_index):
        for t in self.event_targets:
            t.object_ai.on_scripted_event(self.event_id, self.event_data[data_index])

    def send_event_to_all_targets(self, data_index):
        self.target.object_ai.on_scripted_event(self.event_id, self.event_data[data_index])
        for t in self.event_targets:
            t.object_ai.on_scripted_event(self.event_id, self.event_data[data_index])

    def set_source(self, _source):
        self.source = _source

    def set_target(self, _target):
        self.target = _target

    def get_target(self):
        return self.target

    def get_source(self):
        return self.source

    def add_or_update_extra_target(self, _target, _failure_condition, _failure_script, _success_condition,
                                   _success_script):
        for event_target in self.event_targets:
            if event_target.target == _target:
                event_target.failure_condition = _failure_condition
                event_target.failure_script = _failure_script
                event_target.success_condition = _success_condition
                event_target.success_script = _success_script
            else:
                self.event_targets.append(ScriptedEventTarget(_target, _failure_condition, _failure_script,
                                                              _success_condition, _success_script))

    def remove_event_target(self, _target, condition_id, options):
        if options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_TARGETS:
            self.event_targets = []
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_SELF:
            self.event_targets.remove(_target)
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ONE_FIT_CONDITION:
            for t in self.event_targets:
                # TODO: this doesn't actually do anything until the condition handler is implemented
                if ConditionChecker.check_condition_object_fit_condition(condition_id, None, t):
                    self.event_targets.remove(t)
                    return
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_FIT_CONDITION:
            matches = 0
            for t in self.event_targets:
                # TODO: this doesn't actually do anything until the condition handler is implemented
                if ConditionChecker.check_condition_object_fit_condition(condition_id, None, t):
                    matches += 1

            if matches == len(self.event_targets):
                self.event_targets = {}

    def update_event_data(self, _success_condition, _success_script, _failure_condition, _failure_script):
        self.success_condition = _success_condition
        self.success_script = _success_script
        self.failure_condition = _failure_condition
        self.failure_script = _failure_script

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
