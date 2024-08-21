from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from utils.Logger import Logger


class TrapManager:
    TRIGGERED_BY_CREATURES = {
        3355  # zzOldSnare Trap Effect
    }

    def __init__(self, trap_object):
        self.trap_object = trap_object
        self.spell_id = trap_object.gobject_template.data3
        # Can only be 0 (infinite triggering) or 1 (should despawn after the trigger).
        self.charges = trap_object.gobject_template.data4
        self.infinite_trigger = not self.charges
        self.cooldown = trap_object.gobject_template.data5
        self.start_delay = trap_object.gobject_template.data7
        self.remaining_cooldown = self.start_delay
        self.radius = trap_object.gobject_template.data2 / 2.0

    def is_ready(self):
        return self.remaining_cooldown == 0

    def update(self, elapsed):
        # Triggered by use action.
        if not self.radius or not self.cooldown:
            return

        if not self.is_ready():
            self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)
            return

        # If the trap should be triggered by creatures, search for them along with players.
        if self.spell_id in TrapManager.TRIGGERED_BY_CREATURES:
            surrounding_creatures, surrounding_players = self.trap_object.get_map().get_surrounding_units_by_location(
                self.trap_object.location, self.trap_object.map_id, self.trap_object.instance_id,
                self.radius, include_players=True)
            surrounding_units = surrounding_creatures | surrounding_players
        else:
            # This trap can only be triggered by players.
            surrounding_units = self.trap_object.get_map().get_surrounding_players_by_location(
                self.trap_object.location, self.trap_object.map_id, self.trap_object.instance_id, self.radius)

        for unit in surrounding_units.values():
            # Keep looping until we find a valid unit.
            if not self.trap_object.can_attack_target(unit):
                continue

            self.trigger(unit)
            break

    def trigger(self, who):
        self.trap_object.set_active()
        self.charges = max(0, self.charges - 1)

        spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.spell_id)
        if spell_template:
            spell_target_mask = spell_template.Targets
            target = self.trap_object if not spell_target_mask else who
            self.trap_object.spell_manager.handle_cast_attempt(self.spell_id, target, spell_target_mask, validate=True)
        else:
            Logger.warning(f'Invalid spell id for GameObject trap {self.trap_object.spawn_id}, spell {self.spell_id}')

        self.remaining_cooldown = self.cooldown
        if self.charges <= 0 and not self.infinite_trigger:
            self.trap_object.despawn()

    def reset(self):
        self.remaining_cooldown = self.start_delay
