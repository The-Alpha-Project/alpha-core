from game.world.managers.abstractions.Vector import Vector


class ResumeInformation(object):
    def __init__(self, data):
        self.start_location = Vector(float(data[0]), float(data[1]), float(data[2]))
        self.start_node = int(data[3])
        self.dest_node = int(data[4])
        self.mount_display_id = int(data[5])
        self.remaining_waypoints = int(data[6])
