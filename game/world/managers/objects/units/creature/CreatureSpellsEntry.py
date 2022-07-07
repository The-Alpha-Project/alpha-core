from random import randint
from database.dbc.DbcDatabaseManager import DbcDatabaseManager


# References a CreatureSpellEntry, but has unit specific cooldowns.
# This might later be somehow handled by SpellManager, and this wrapper could be deprecated then.
class CreatureAISpellsEntry:
    def __init__(self, creature_spell_entry):
        self.creature_spell_entry = creature_spell_entry
        self.cooldown = randint(self.creature_spell_entry.delay_init_min, self.creature_spell_entry.delay_init_max)

    def set_new_random_cooldown(self):
        self.cooldown = randint(self.creature_spell_entry.delay_repeat_min, self.creature_spell_entry.delay_repeat_max)


# Generic CreatureSpellEntry template, shared across multiple creatures.
# noinspection PyUnusedLocal
class CreatureSpellsEntry:
    def __init__(self, creature_spell, index):
        self.index = index
        self.spell = None
        self.finished_loading = False
        self.has_valid_spell = False
        self.spell_id = eval(f'creature_spell.spellId_{index}')
        self.chance = eval(f'creature_spell.probability_{index}')
        self.cast_target = eval(f'creature_spell.castTarget_{index}')
        self.target_param1 = eval(f'creature_spell.targetParam1_{index}')
        self.target_param2 = eval(f'creature_spell.targetParam2_{index}')
        self.cast_flags = eval(f'creature_spell.castFlags_{index}')
        self.delay_init_min = eval(f'creature_spell.delayInitialMin_{index}')
        self.delay_init_max = eval(f'creature_spell.delayInitialMax_{index}')
        self.delay_repeat_min = eval(f'creature_spell.delayRepeatMin_{index}')
        self.delay_repeat_max = eval(f'creature_spell.delayRepeatMax_{index}')
        self.script_id = eval(f'creature_spell.scriptId_{index}')

    # Creature spell templates can be shared across multiple creatures.
    # Make sure we only fully load them once.
    def finish_loading(self):
        if not self.finished_loading:
            if self.spell_id:
                self.spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.spell_id)
                self.has_valid_spell = self.spell is not None
            self.finished_loading = True
