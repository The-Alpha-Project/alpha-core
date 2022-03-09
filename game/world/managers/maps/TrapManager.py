from game.world.managers.maps.MapManager import MapManager
from utils.constants.SpellCodes import SpellTargetMask


class TrapManager(object):
    def __init__(self, world_object, spell_id, charges, cooldown, start_delay, x, y, z, diameter):
        self.world_object = world_object
        self.spell_id = spell_id
        self.charges = charges  # Can only be 0 (infinite triggering) or 1 (should despawn after the trigger).
        self.cooldown = cooldown
        self.start_delay = start_delay
        self.remaining_cooldown = start_delay
        self.participants = []
        self.radius = diameter / 2

    def is_ready(self):
        return self.remaining_cooldown == 0

    def update(self, elapsed):
        self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)

    def trigger(self, who):
        self.world_object.spell_manager.handle_cast_attempt(self.spell_id, who, SpellTargetMask.UNIT, validate=False)
        self.remaining_cooldown = self.cooldown

        return True

    @staticmethod
    def generate(gameobject):
        x = MapManager.validate_map_coord(gameobject.location.x)
        y = MapManager.validate_map_coord(gameobject.location.y)
        z = gameobject.location.z
        radius = gameobject.gobject_template.data2
        spell_id = gameobject.gobject_template.data3
        charges = gameobject.gobject_template.data4
        cooldown = gameobject.gobject_template.data5
        start_delay = gameobject.gobject_template.data7

        return TrapManager(gameobject, spell_id, charges, cooldown, start_delay, x, y, z, radius)
