from typing import NamedTuple


class PendingWaypoint(NamedTuple):
    id_: int
    expected_timestamp: int
    location: object  # Vector
