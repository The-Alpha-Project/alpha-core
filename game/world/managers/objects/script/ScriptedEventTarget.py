class ScriptedEventTarget:
    def __init__(self, target, failure_condition, failure_script, success_condition, success_script):
        self.target = target
        self.failure_condition = failure_condition
        self.failure_script = failure_script
        self.success_condition = success_condition
        self.success_script = success_script
