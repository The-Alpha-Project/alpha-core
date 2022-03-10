from game.world.managers.maps.MapManager import MapManager
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import SplineFlags


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

        target = None

        # If the trap should be triggered by creatures, search for them along with players.
        if self.spell_id in TrapManager.TRIGGERED_BY_CREATURES:
            surrounding_creatures, surrounding_players = MapManager.get_surrounding_units_by_location(
                self.trap_object.location, self.trap_object.map_, self.radius, include_players=True)
            for creature in surrounding_creatures.values():
                # Keep looking until we find a valid creature (alive, attackable).
                if not creature.is_alive:
                    continue
                elif not self.trap_object.can_attack_target(creature):
                    continue

                target = creature
                break

        else:
            # This trap can only be triggered by players.
            surrounding_players = MapManager.get_surrounding_players_by_location(
                self.trap_object.location, self.trap_object.map_, self.radius)

        # Search for players if no creature has been found yet or if this trap can only be triggered by players.
        if not target:
            for player in surrounding_players.values():
                # Keep looping until we find a valid player (alive, not flying and attackable).
                if not player.is_alive:
                    continue
                elif player.movement_spline and player.movement_spline.flags == SplineFlags.SPLINEFLAG_FLYING:
                    continue
                elif not self.trap_object.can_attack_target(player):
                    continue

                target = player
                break

        if target:
            # Valid target found. In case charges = 1, despawn the trap.
            if self.trigger(target) and self.charges == 1:
                self.trap_object.set_active()
                self.trap_object.despawn()

    def trigger(self, who):
        self.trap_object.spell_manager.handle_cast_attempt(self.spell_id, who, SpellTargetMask.UNIT, validate=False)
        self.remaining_cooldown = self.cooldown

        return True

    def reset(self):
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
