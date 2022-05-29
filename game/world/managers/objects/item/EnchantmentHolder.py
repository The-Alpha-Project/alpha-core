from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SpellItemEnchantment
from utils.constants.ItemCodes import ItemEnchantmentType


class EnchantmentHolder(object):
    def __init__(self, entry=0, duration=0, charges=0):
        self.entry: int = entry
        self.duration: int = duration
        self.charges: int = charges
        self.spell_item_enchantment_entry: [SpellItemEnchantment] = None
        self.effects = []
        self.effect_points = []
        self.effect_spells = []
        self.aura_id = 0

    def update(self, entry, duration, charges):
        self.entry = entry
        self.duration = duration
        self.charges = charges

        # Update enchantments data.
        self.spell_item_enchantment_entry = DbcDatabaseManager.spell_get_item_enchantment(entry)
        if self.spell_item_enchantment_entry:
            self.effects = [self.spell_item_enchantment_entry.Effect_1,
                            self.spell_item_enchantment_entry.Effect_2,
                            self.spell_item_enchantment_entry.Effect_3]
            self.effect_points = [self.spell_item_enchantment_entry.EffectPointsMin_1,
                                  self.spell_item_enchantment_entry.EffectPointsMin_2,
                                  self.spell_item_enchantment_entry.EffectPointsMin_3]
            self.effect_spells = [self.spell_item_enchantment_entry.EffectArg_1,
                                  self.spell_item_enchantment_entry.EffectArg_2,
                                  self.spell_item_enchantment_entry.EffectArg_3]
            self.aura_id = self.spell_item_enchantment_entry.ItemVisual

    def has_enchantment_effect(self, enchantment_type: [ItemEnchantmentType]):
        return enchantment_type in self.effects

    def get_enchantment_effect_points_by_type(self, enchantment_type: [ItemEnchantmentType]):
        for index, effect in enumerate(self.effects):
            if effect == enchantment_type:
                return self.effect_points[index]

    def get_enchantment_spell_effect_by_type(self, enchantment_type: [ItemEnchantmentType]):
        for index, effect in enumerate(self.effects):
            if effect == enchantment_type:
                return self.effect_spells[index]
