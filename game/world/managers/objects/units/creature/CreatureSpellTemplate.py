from database.dbc.DbcDatabaseManager import DbcDatabaseManager


# noinspection PyUnusedLocal
class CreatureSpellTemplate:
    def __init__(self, creature_spell, index):
        self.index = index
        self.spell_id = eval(f'creature_spell.spellId_{index}')
        self.probability = eval(f'creature_spell.probability_{index}')
        self.cast_target = eval(f'creature_spell.castTarget_{index}')
        self.target_param1 = eval(f'creature_spell.targetParam1_{index}')
        self.target_param2 = eval(f'creature_spell.targetParam2_{index}')
        self.cast_flags = eval(f'creature_spell.castFlags_{index}')
        self.delay_init_min = eval(f'creature_spell.delayInitialMin_{index}')
        self.delay_init_max = eval(f'creature_spell.delayInitialMax_{index}')
        self.delay_repeat_min = eval(f'creature_spell.delayRepeatMin_{index}')
        self.delay_repeat_max = eval(f'creature_spell.delayRepeatMax_{index}')
        self.script_id = eval(f'creature_spell.scriptId_{index}')
        # If 0, set target_param1 to spell range.
        if not self.target_param1:
            self.target_param1 = DbcDatabaseManager.spell_range_get_by_id(self.spell_id)
