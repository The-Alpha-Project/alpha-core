class TrapInfoHolder(object):
    def __init__(self, world_object, spell_id, x, y, z, radius):
        self.world_object = world_object
        self.spell_id = spell_id
        self.participants = []
        self.x_min = x - (radius / 2)
        self.x_max = x + (radius / 2)
        self.y_min = y - (radius / 2)
        self.y_max = y + (radius / 2)
        self.z_min = z - (radius * 2)
        self.z_max = z + (radius * 2)

    def add_participant(self, unit):
        if unit not in self.participants:
            self.participants.append(unit)

    def remove_participant(self, unit):
        if unit in self.participants:
            self.participants.remove(unit)
