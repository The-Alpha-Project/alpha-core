from game.world.managers.objects.script.ScriptedEventTarget import ScriptedEventTarget
class ScriptedEvent:
    def __init__(self, event_id, source, target, map, expire_time, failure_condition, failure_script, success_condition, success_script):
        self.event_id = event_id
        self.source = source
        self.target = target
        self.map = map
        self.expire_time = time.time() + expire_time
        self.failure_condition = failure_condition
        self.failure_script = failure_script
        self.success_condition = success_condition
        self.success_script = success_script
        self.ended = False

        self.event_data = dict[int, int]
        self.event_targets = {}

        def update():
            if self.ended:
                return

            if self.expire_time <= time.time():
                # TODO: evaluate conditions to determine success/failure
                end_event(0)
            pass

        def end_event(success):
            _success = success == 1

            self.ended = True
            #TODO: implement success/failure

        def send_event_to_main_targets(data_index):
            pass

        def send_event_to_additional_targets(data_index):
            pass

        def send_event_to_all_targets(data_index):
            pass

        def set_source(_source):
            self.source = _source

        def set_target(_target):
            self.target = _target

        def get_target():
            return self.target

        def get_source():
            return self.source

        def add_or_update_extra_target(_target, _failure_condition, _failure_script, _success_condition, _success_script):
            for event_target in self.event_targets:
                if event_target.target == _target:
                    event_target.failure_condition = _failure_condition
                    event_target.failure_script = _failure_script
                    event_target.success_condition = _success_condition
                    event_target.success_script = _success_script
                else:
                    self.event_targets.append(ScriptedEventTarget(_target, _failure_condition, _failure_script, _success_condition, _success_script))

        def remove_event_target(_target, condition_id, options):
            #TODO: check condition and honor options
            self.event_targets.remove(_target)

        def update_event_data(_success_condition, _success_script, _failure_condition, _failure_script):
            self.success_condition = _success_condition
            self.success_script = _success_script
            self.failure_condition = _failure_condition
            self.failure_script = _failure_script

        def get_data(index):
            return self.event_data[index]

        def set_data(index, value):
            self.event_data[index] = value

        def increment_data(index, value):
            self.event_data[index] += value

        def decrement_data(index, value):
            if self.event_data[index] > value:
                self.event_data[index] -= value
            else:
                self.event_data[index] = 0
