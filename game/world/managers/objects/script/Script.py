import time
from game.world.managers.objects.script.ScriptCommand import ScriptCommand
from game.world.managers.objects.script.ConditionChecker import ConditionChecker
from utils.Logger import Logger


class Script:
    def __init__(self, script_id, db_commands, source, target, script_handler, delay=0.0, ooc_event=None):
        self.id: int = script_id
        self.commands: list[ScriptCommand] = [ScriptCommand(self, command) for command in db_commands]
        self.source = source
        self.target = target
        self.script_handler = script_handler
        self.ooc_event = ooc_event
        self.delay: float = delay
        self.time_added: float = time.time()
        self.started = False

    def __hash__(self):
        return self.id

    def update(self, now):
        # Check initial delay for command sequence.
        if self.delay and now - self.time_added < self.delay:
            return
        self.started = True

        for script_command in list(self.commands):
            # Check if it's time to execute the command action.
            if script_command.delay and now - self.time_added < script_command.delay:
                return
            self.commands.remove(script_command)

            # Try to resolve the final targets for this command.
            succeed, source, target = script_command.resolve_final_targets(self.source, self.target)
            if not succeed:
                continue

            script_command.source = source
            script_command.target = target

            # Condition is not met, skip.
            if not ConditionChecker.validate(script_command.condition_id, source=self.source, target=self.target):
                continue

            # Execute action.
            self.script_handler.handle_script_command_execution(script_command)

    def abort(self):
        Logger.warning(f'Script {self.id} aborted.')
        self.commands.clear()

    def is_complete(self):
        return not self.commands
