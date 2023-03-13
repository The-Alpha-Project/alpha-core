from utils.constants.ScriptCodes import ScriptCommands


class ScriptCommand:
    def __init__(self, script_id, db_command):
        self.script_id = script_id
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

    def resolve_target(self, source, target):
        self.source = source
        from game.world.managers.objects.script.ScriptManager import ScriptManager
        self.target = ScriptManager.get_target_by_type(
            self.source, target, self.target_type, self.target_param1, self.target_param2)

    def get_info(self):
        return f'ScriptID: {self.script_id}, Command {ScriptCommands(self.command).name}'
