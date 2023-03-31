from game.world.managers.objects.script.ScriptedEvent import ScriptedEvent
from utils.constants.ScriptCodes import SetMapScriptDataOptions


class MapEventManager:
    def __init__(self):
        self.scripted_events = []

    def update(self, now):
        for scripted_event in self.scripted_events:
            scripted_event.update(now)

    def add_event(self, source, target, map_id, event_id, time_limit, success_condition, success_script,
                  failure_condition, failure_script):
        self.scripted_events.append(ScriptedEvent(source, target, map_id, event_id, time_limit, failure_condition,
                                                  failure_script, success_condition, success_script))

    def end_event(self, event_id, success):
        self.scripted_events[event_id].end_event(success)

    def add_event_target(self, target, event_id, success_condition, success_script, failure_condition, failure_script):
        self.scripted_events[event_id].add_or_update_event_target(target, failure_condition, failure_script,
                                                                  success_condition, success_script)

    def remove_event_target(self, target, event_id, condition_id, options):
        self.scripted_events[event_id].remove_event_target(target, condition_id, options)

    def set_event_data(self, event_id, index, data, options):
        if options == SetMapScriptDataOptions.SO_MAPEVENTDATA_RAW:
            self.scripted_events[event_id].set_data(index, data)
        elif options == SetMapScriptDataOptions.SO_MAPEVENTDATA_DECREMENT:
            self.scripted_events[event_id].decrement_data(index, data)
        elif options == SetMapScriptDataOptions.SO_MAPEVENTDATA_INCREMENT:
            self.scripted_events[event_id].increment_data(index, data)

    def edit_map_event_data(self, event_id, success_condition, success_script, failure_condition, failure_script):
        self.scripted_events[event_id].update_event_data(success_condition, success_script, failure_condition,
                                                         failure_script)

    def get_map_event_data(self, event_id):
        if event_id in self.scripted_events:
            return self.scripted_events[event_id]

        return None

    def is_event(self, event_id):
        return event_id in self.scripted_events

    def send_event_data(self, event_id, data_index, options):
        self.scripted_events[event_id].send_event_data(data_index, options)
