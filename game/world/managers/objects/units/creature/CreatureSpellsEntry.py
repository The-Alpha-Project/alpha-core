from database.dbc.DbcDatabaseManager import DbcDatabaseManager


# Generic CreatureSpellEntry template, shared across multiple creatures.
# noinspection PyUnusedLocal
class CreatureSpellsEntry:
    def __init__(self, creature_spell, index):
        self.index = index
        self.spell = None
        self.finished_loading = False
        self.has_valid_spell = False
        self.spell_id = getattr(creature_spell, f'spellId_{index}')
        self.chance = getattr(creature_spell, f'probability_{index}')
        self.cast_target = getattr(creature_spell, f'castTarget_{index}')
        self.target_param1 = getattr(creature_spell, f'targetParam1_{index}')
        self.target_param2 = getattr(creature_spell, f'targetParam2_{index}')
        self.cast_flags = getattr(creature_spell, f'castFlags_{index}')
        self.delay_init_min = getattr(creature_spell, f'delayInitialMin_{index}')
        self.delay_init_max = getattr(creature_spell, f'delayInitialMax_{index}')
        self.delay_repeat_min = getattr(creature_spell, f'delayRepeatMin_{index}')
        self.delay_repeat_max = getattr(creature_spell, f'delayRepeatMax_{index}')
        self.script_id = getattr(creature_spell, f'scriptId_{index}')

    # Creature spell templates can be shared across multiple creatures.
    # Make sure we only fully load them once.
    def finish_loading(self):
        if not self.finished_loading:
            if self.spell_id:
                self.spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.spell_id)
                self.has_valid_spell = self.spell is not None
            self.finished_loading = True
