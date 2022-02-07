class EnvironmentalDamageObject(object):
    def __init__(self, damage_source, spell_id, x, y, z, radius):
        self.damage_source = damage_source # EnvironmentalDamageSource IntEnum
        self.spell_id = spell_id
        self.x_min = x - (radius / 2)
        self.x_max = x + (radius / 2)
        self.y_min = y - (radius / 2)
        self.y_max = y + (radius / 2)
        self.z_min = z - (radius * 2)
        self.z_max = z + (radius * 2)