from typing import Optional

from game.world.managers.abstractions.Vector import Vector


class TaxiResumeInformation:
    def __init__(self, taxi_path_db_state):
        self.taxi_path_db_state = taxi_path_db_state
        self.start_location: Optional[Vector] = None
        self.start_node = 0
        self.dest_node = 0
        self.mount_display_id = 0
        self.remaining_waypoints = 0
        self.load_state(taxi_path_db_state)

    # Load state from DB.
    def load_state(self, taxi_path_db_state):
        if taxi_path_db_state and len(taxi_path_db_state) > 0:
            data = taxi_path_db_state.rsplit(',')
            self.start_location = Vector(float(data[0]), float(data[1]), float(data[2]))
            self.start_node = int(data[3])
            self.dest_node = int(data[4])
            self.mount_display_id = int(data[5])
            self.remaining_waypoints = int(data[6])
            self.taxi_path_db_state = self.to_string()

    # Reset all fields.
    def flush(self):
        self.taxi_path_db_state = ''
        self.start_location = None
        self.start_node = 0
        self.dest_node = 0
        self.mount_display_id = 0
        self.remaining_waypoints = 0

    def to_string(self):
        if not self.is_valid():
            return ''
        else:
            return f'{self.start_location.x},' \
                f'{self.start_location.y},' \
                f'{self.start_location.z},' \
                f'{self.start_node},' \
                f'{self.dest_node},' \
                f'{self.mount_display_id},' \
                f'{self.remaining_waypoints}'

    # Selective fields update.
    def update_fields(self, start_location=None, start_node=None, dest_node=None, mount_id=None, remaining_wp=None):
        should_update = False
        if start_location and start_location != self.start_location:
            self.start_location = start_location
            should_update = True
        if start_node and start_node != self.start_node:
            self.start_node = start_node
            should_update = True
        if dest_node and dest_node != self.dest_node:
            self.dest_node = dest_node
            should_update = True
        if mount_id and mount_id != self.mount_display_id:
            self.mount_display_id = mount_id
            should_update = True
        if remaining_wp and remaining_wp != self.remaining_waypoints:
            self.remaining_waypoints = remaining_wp
            should_update = True

        # Finally, update our db state memento if needed.
        if should_update:
            self.taxi_path_db_state = self.to_string()

    # Check if we hold valid data for resuming a flight.
    def is_valid(self):
        return self.start_location is not None \
            and self.start_node != 0 \
            and self.dest_node != 0 \
            and self.mount_display_id != 0 \
            and self.remaining_waypoints != 0
