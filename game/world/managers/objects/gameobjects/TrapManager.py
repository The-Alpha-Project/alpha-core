from game.world.managers.maps.MapManager import MapManager
from utils.constants.SpellCodes import SpellTargetMask


class TrapManager(object):
    TRIGGERED_BY_CREATURES = {
        3355  # zzOldSnare Trap Effect
    }

    def __init__(self, trap_object, spell_id, charges, cooldown, start_delay, radius):
        self.trap_object = trap_object
        self.spell_id = spell_id
        self.charges = charges  # Can only be 0 (infinite triggering) or 1 (should despawn after the trigger).
        self.cooldown = cooldown
        self.start_delay = start_delay
        self.remaining_cooldown = start_delay
        self.radius = radius

    def is_ready(self):
        return self.remaining_cooldown == 0

    def update(self, elapsed):
        if not self.is_ready():
            self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)
            return

        # If the trap should be triggered by creatures, search for them along with players.
        if self.spell_id in TrapManager.TRIGGERED_BY_CREATURES:
            surrounding_creatures, surrounding_players = MapManager.get_surrounding_units_by_location(
                self.trap_object.location, self.trap_object.map_, self.radius, include_players=True)
            surrounding_units = surrounding_creatures | surrounding_players
        else:
            # This trap can only be triggered by players.
            surrounding_units = MapManager.get_surrounding_players_by_location(
                self.trap_object.location, self.trap_object.map_, self.radius)

        for unit in surrounding_units.values():
            # Keep looping until we find a valid unit.
            if not self.trap_object.can_attack_target(unit):
                continue

            # Valid target found, trigger the trap. In case charges = 1, despawn the trap.
            if self.trigger(unit) and self.charges == 1:
                self.trap_object.set_active()
                self.trap_object.despawn()
            break

    def trigger(self, who):
        self.trap_object.spell_manager.handle_cast_attempt(self.spell_id, who, SpellTargetMask.UNIT, validate=False)
        self.remaining_cooldown = self.cooldown

        return True

    def reset(self):
        self.remaining_cooldown = self.start_delay

    @staticmethod
    def generate(gameobject):
        radius = gameobject.gobject_template.data2 / 2.0
        # If no diameter is defined, use 2.5 yd as radius by default as it seems to be the most common value among traps
        # that have one defined.
        if radius == 0:
            radius = 2.5
        spell_id = gameobject.gobject_template.data3
        charges = gameobject.gobject_template.data4
        cooldown = gameobject.gobject_template.data5
        # If no cooldown is defined, use 1 second as this seems to be the default value as observed in Classic servers.
        if cooldown == 0:
            cooldown = 1
        start_delay = gameobject.gobject_template.data7

        return TrapManager(gameobject, spell_id, charges, cooldown, start_delay, radius)
