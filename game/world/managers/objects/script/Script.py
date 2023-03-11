import time
from game.world.managers.objects.script.ScriptCommand import ScriptCommand
from game.world.managers.objects.script.ConditionChecker import ConditionChecker


class Script:
    def __init__(self, script_id, db_commands, source, target, script_handler, delay=0.0):
        self.id: int = script_id
        self.commands: list[ScriptCommand] = [ScriptCommand(script_id, command) for command in db_commands]
        self.source = source
        self.target = target
        self.script_handler = script_handler
        self.delay: float = delay
        self.time_added: float = time.time()

    def update(self, now):
        # Check initial delay for command sequence.
        if now - self.time_added < self.delay:
            return

        for script_command in list(self.commands):
            # Check if it's time to execute the command action.
            if now - self.time_added < script_command.delay:
                return
            self.commands.remove(script_command)

            # Resolve target. TODO: 'ConditionTargetsInternal' VmANGOS.
            script_command.resolve_target(self.source, self.target)

            # Condition is not met, skip.
            if not ConditionChecker.check_condition(script_command.condition_id, source=self.source, target=self.target):
                continue

            # Execute action.
            self.script_handler.handle_script_command_execution(script_command)
            break

    def abort(self):
        self.commands.clear()

    def is_complete(self):
        return not self.commands
