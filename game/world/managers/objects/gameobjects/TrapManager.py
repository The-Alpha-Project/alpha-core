from utils.constants.SpellCodes import SpellTargetMask


class TrapManager(object):
    def __init__(self, world_object, spell_id, charges, cooldown, start_delay, radius):
        self.world_object = world_object
        self.spell_id = spell_id
        self.charges = charges  # Can only be 0 (infinite triggering) or 1 (should despawn after the trigger).
        self.cooldown = cooldown
        self.start_delay = start_delay
        self.remaining_cooldown = start_delay
        self.radius = radius

    def is_ready(self):
        return self.remaining_cooldown == 0

    def update(self, elapsed):
        self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)

    def trigger(self, who):
        self.world_object.spell_manager.handle_cast_attempt(self.spell_id, who, SpellTargetMask.UNIT, validate=False)
        self.remaining_cooldown = self.cooldown

        return True

    def restart(self):
        self.remaining_cooldown = self.start_delay

    @staticmethod
    def generate(gameobject):
        radius = gameobject.gobject_template.data2 / 2.0
        if radius == 0:
            radius = 2.5
        spell_id = gameobject.gobject_template.data3
        charges = gameobject.gobject_template.data4
        cooldown = gameobject.gobject_template.data5
        start_delay = gameobject.gobject_template.data7

        return TrapManager(gameobject, spell_id, charges, cooldown, start_delay, radius)
