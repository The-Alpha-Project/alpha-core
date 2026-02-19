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
        self.expire_time = time.time() + max(0, expire_time or 0)
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

        if self.expire_time <= now:
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
            if not t.target:
                continue
            if t.failure_condition and ConditionChecker.validate(t.failure_condition, self.source, t.target):
                self.end_event(False)
                return True
            elif t.success_condition and ConditionChecker.validate(t.success_condition, self.source, t.target):
                self.end_event(True)
                return True

        return False

    def end_event(self, success):
        self.ended = True

        script = self.success_script if success else self.failure_script
        enqueue_source = self.source or self.target
        if script and enqueue_source and (ConditionChecker.is_unit(enqueue_source) or
                                          ConditionChecker.is_gameobject(enqueue_source)):
            map_ = enqueue_source.get_map()
            if map_:
                map_.enqueue_script(enqueue_source, self.target, ScriptTypes.SCRIPT_TYPE_GENERIC, script)
        elif script:
            Logger.error(f'No valid source found to trigger end script for event {self.event_id}, skipping.')

        for t in self.event_targets:
            script = t.success_script if success else t.failure_script
            if not script or not t.target:
                continue
            if not (ConditionChecker.is_unit(t.target) or ConditionChecker.is_gameobject(t.target)):
                continue
            map_ = t.target.get_map()
            if map_:
                map_.enqueue_script(t.target, self.target, ScriptTypes.SCRIPT_TYPE_GENERIC, script)

    def send_event_data(self, data, options):
        if options == SendMapEventOptions.SO_SENDMAPEVENT_ALL_TARGETS:
            self.send_event_to_all_targets(data)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_MAIN_TARGETS_ONLY:
            self.send_event_to_main_targets(data)
        elif options == SendMapEventOptions.SO_SENDMAPEVENT_EXTRA_TARGETS_ONLY:
            self.send_event_to_additional_targets(data)

    # Map events can target non-creatures, only units with object_ai can consume script events.
    def _notify_script_event_if_possible(self, world_object, data):
        if not ConditionChecker.is_unit(world_object):
            return
        if not world_object.object_ai:
            return
        world_object.object_ai.on_script_event(self.event_id, data, None)

    def send_event_to_main_targets(self, data):
        self._notify_script_event_if_possible(self.target, data)

    def send_event_to_additional_targets(self, data):
        for t in self.event_targets:
            self._notify_script_event_if_possible(t.target, data)

    def send_event_to_all_targets(self, data):
        self._notify_script_event_if_possible(self.target, data)
        for t in self.event_targets:
            self._notify_script_event_if_possible(t.target, data)

    def set_source(self, source):
        self.source = source

    def set_target(self, target):
        self.target = target

    def get_target(self, entry=0):
        if not entry:
            return self.target
        # Extra targets are stored as wrappers, compare by wrapped object's entry.
        event_target = next((t for t in self.event_targets if t.target and t.target.entry == entry), None)
        return event_target.target if event_target else None

    def get_source(self):
        return self.source

    def add_or_update_extra_target(self, target, failure_condition, failure_script, success_condition,
                                   success_script):
        if not target:
            return

        # Match by object identity (guid), not by entry, to avoid overwriting multiple same-entry targets.
        event_target = [t for t in self.event_targets if t.target and t.target.guid == target.guid]
        if not event_target:
            self.event_targets.append(ScriptedEventTarget(target, failure_condition, failure_script,
                                                          success_condition, success_script))
            return

        event_target = event_target[0]
        event_target.failure_condition = failure_condition
        event_target.failure_script = failure_script
        event_target.success_condition = success_condition
        event_target.success_script = success_script

    def remove_event_target(self, _target, condition_id, options):
        if options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_TARGETS:
            self.event_targets.clear()
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_SELF:
            if not _target:
                return
            self.event_targets = [t for t in self.event_targets if t.target != _target]
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ONE_FIT_CONDITION:
            if not condition_id:
                return
            for t in self.event_targets:
                if ConditionChecker.validate(condition_id, self.source, t.target):
                    self.event_targets.remove(t)
                    return
        elif options == RemoveMapEventTargetOptions.SO_REMOVETARGET_ALL_FIT_CONDITION:
            if not condition_id:
                return
            self.event_targets = [t for t in self.event_targets
                                  if not ConditionChecker.validate(condition_id, self.source, t.target)]

    def update_event_data(self, success_condition, success_script, failure_condition, failure_script):
        self.success_condition = success_condition
        self.success_script = success_script
        self.failure_condition = failure_condition
        self.failure_script = failure_script

    def get_data(self, index):
        # Missing indices are valid and should default to 0.
        return self.event_data.get(index, 0)

    def set_data(self, index, value):
        self.event_data[index] = value

    def increment_data(self, index, value):
        self.event_data[index] = self.event_data.get(index, 0) + value

    def decrement_data(self, index, value):
        current = self.event_data.get(index, 0)
        if current > value:
            self.event_data[index] = current - value
        else:
            self.event_data[index] = 0
