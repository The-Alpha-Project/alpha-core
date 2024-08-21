from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellTargetMask


class SpellFocusManager:
    def __init__(self, gameobject):
        self.gameobject = gameobject
        self.spell_focus_object = DbcDatabaseManager.spell_get_focus_by_id(gameobject.gobject_template.data0)
        self.radius = gameobject.gobject_template.data1 / 2.0
        self.linked_trap_template = WorldDatabaseManager.gameobject_template_get_by_entry(gameobject.gobject_template.data2)
        self.spell_id = self.linked_trap_template.data3 if self.linked_trap_template else 0
        self.cooldown = self.linked_trap_template.data5 if self.linked_trap_template else 0
        # If cooldown was 0, initialize to 1.
        self.cooldown = 1 if not self.cooldown else self.cooldown
        self.start_delay = self.linked_trap_template.data7 if self.linked_trap_template else 0
        self.remaining_cooldown = self.start_delay

    def is_ready(self):
        return self.remaining_cooldown == 0 and self.spell_id

    def update(self, elapsed):
        if not self.is_ready():
            self.remaining_cooldown = max(0, self.remaining_cooldown - elapsed)
            return

        surrounding_creatures, surrounding_players = self.gameobject.get_map().get_surrounding_units_by_location(
            self.gameobject.location, self.gameobject.map_id, self.gameobject.instance_id, self.radius,
            include_players=True)

        surrounding_units = surrounding_creatures | surrounding_players

        for unit in surrounding_units.values():
            if not unit.aura_manager.has_aura_by_spell_id(self.spell_id):
                self.trigger(unit)

    def trigger(self, who):
        spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.spell_id)
        if spell_template:
            spell_target_mask = spell_template.Targets
            target = self.gameobject if not spell_target_mask else who
            self.gameobject.spell_manager.handle_cast_attempt(self.spell_id, target, spell_target_mask, validate=True)
        else:
            Logger.warning(f'Invalid spell id for GameObject focus {self.gameobject.spawn_id}, spell {self.spell_id}')

        self.remaining_cooldown = self.cooldown
        return True

    def reset(self):
        self.remaining_cooldown = self.start_delay
