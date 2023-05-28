from dataclasses import dataclass
from utils.constants.ScriptCodes import WaypointPathOrigin


@dataclass
class CommandMoveInfo:
    wp_source: WaypointPathOrigin
    start_point: int
    initial_delay: int
    repeat: bool
    overwrite_guid: int
    overwrite_entry: int

