import time


class Script:
    def __init__(self, db_script, delay=0):
        self.id: int = db_script.id
        self.command: int = db_script.command
        self.datalong: int = db_script.datalong
        self.datalong2: int = db_script.datalong2
        self.datalong3: int = db_script.datalong3
        self.datalong4: int = db_script.datalong4
        self.x: float = db_script.x
        self.y: float = db_script.y
        self.z: float = db_script.z
        self.o: float = db_script.o
        self.target_param1: int = db_script.target_param1
        self.target_param2: int = db_script.target_param2
        self.target_type: int = db_script.target_type
        self.data_flags: int = db_script.data_flags
        self.dataint: int = db_script.dataint
        self.dataint2: int = db_script.dataint2
        self.dataint3: int = db_script.dataint3
        self.dataint4: int = db_script.dataint4
        self.delay: int = db_script.delay if not delay else delay
        self.condition_id: int = db_script.condition_id
        self.source: object = None
        self.target: object = None
        self.time_added: float = time.time()

    def initialize(self, source, target):
        from game.world.managers.objects.script.ScriptManager import ScriptManager
        self.source = source
        self.target = ScriptManager.get_target_by_type(
            source, target, self.target_type, self.target_param1, self.target_param2)

    def get_filtered_dataint(self):
        return list(filter((0).__ne__, [self.dataint, self.dataint2, self.dataint3, self.dataint4]))

    def get_filtered_datalong(self):
        return list(filter((0).__ne__, [self.datalong, self.datalong2, self.datalong3, self.datalong4]))