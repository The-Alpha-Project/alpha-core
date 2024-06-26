from utils.Logger import Logger
from utils.constants.MiscFlags import ScriptFlags
from utils.constants.ScriptCodes import ScriptCommands


class ScriptCommand:
    def __init__(self, script, db_command):
        self.script = script
        self.script_id = script.id
        self.comments = db_command.comments
        self.command: int = db_command.command
        self.datalong: int = db_command.datalong
        self.datalong2: int = db_command.datalong2
        self.datalong3: int = db_command.datalong3
        self.datalong4: int = db_command.datalong4
        self.x: float = db_command.x
        self.y: float = db_command.y
        self.z: float = db_command.z
        self.o: float = db_command.o
        self.target_param1: int = db_command.target_param1
        self.target_param2: int = db_command.target_param2
        self.target_type: int = db_command.target_type
        self.data_flags: int = db_command.data_flags
        self.dataint: int = db_command.dataint
        self.dataint2: int = db_command.dataint2
        self.dataint3: int = db_command.dataint3
        self.dataint4: int = db_command.dataint4
        self.delay: int = db_command.delay
        self.condition_id: int = db_command.condition_id
        self.source = None
        self.target = None

    # Script commands should return False by default.
    # If they return True the rest of the script is aborted.
    def should_abort(self):
        return self.data_flags & ScriptFlags.SF_GENERAL_ABORT_ON_FAILURE

    def resolve_initial_targets(self, source, target):
        if self.data_flags & ScriptFlags.SF_GENERAL_SKIP_MISSING_TARGETS:
            if not source or not target or not source.is_in_world() or not target.is_in_world():
                return False, None, None

        return True, source, target

    def resolve_final_targets(self, source, target):
        # Swap target and source if needed.
        if self.data_flags & ScriptFlags.SF_GENERAL_SWAP_INITIAL_TARGETS:
            tmp = source
            source = target
            target = tmp

        if self.target_type:
            from game.world.managers.objects.script.ScriptManager import ScriptManager
            target = ScriptManager.get_target_by_type(source, target, self.target_type,
                                                      self.target_param1, self.target_param2)
            if not target:
                if not self.data_flags & ScriptFlags.SF_GENERAL_SKIP_MISSING_TARGETS:
                    Logger.error(f'Unable to find target for script {self.script_id}')
                return False, None, None

        if self.data_flags & ScriptFlags.SF_GENERAL_SWAP_FINAL_TARGETS:
            tmp = source
            source = target
            target = tmp

        if self.data_flags & ScriptFlags.SF_GENERAL_TARGET_SELF:
            target = source

        self.source = source
        self.target = target

        return True, self.source, self.target

    def get_info(self):
        return (f'ScriptID: {self.script_id}, Command {ScriptCommands(self.command).name}, '
                f'Abort {'True' if self.should_abort() else 'False'}')
