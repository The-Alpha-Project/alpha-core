from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SpellItemEnchantment
from utils.constants.ItemCodes import ItemEnchantmentType


class EnchantmentHolder(object):
    def __init__(self, entry=0, duration=0, charges=0):
        self.entry: int = entry
        self.duration: int = duration
        self.charges: int = charges
        self.spell_item_enchantment_entry: [SpellItemEnchantment] = None
        self.effect = ItemEnchantmentType.NONE
        self.effect_points = 0
        self.effect_spell = 0
        self.aura_id = 0

    def update(self, entry, duration, charges):
        self.entry = entry
        self.duration = duration
        self.charges = charges

        # Update enchantments data.
        self.spell_item_enchantment_entry = None if not entry else DbcDatabaseManager.spell_get_item_enchantment(entry)
        if self.spell_item_enchantment_entry:
            self.effect = self.spell_item_enchantment_entry.Effect_1
            self.effect_points = self.spell_item_enchantment_entry.EffectPointsMin_1
            self.effect_spell = self.spell_item_enchantment_entry.EffectArg_1
            self.aura_id = self.spell_item_enchantment_entry.ItemVisual

    def flush(self):
        self.effect = 0
        self.effect_points = 0
        self.effect_spell = 0
        self.aura_id = 0
        self.entry = 0
        self.duration = 0
        self.charges = 0

    def has_enchantment_effect(self, enchantment_type: [ItemEnchantmentType]):
        return enchantment_type == self.effect

    def is_expired(self) -> bool:
        return self.duration == 0 and self.charges == 0

    def get_enchantment_effect_points_by_type(self, enchantment_type: [ItemEnchantmentType]):
        return self.effect_points if self.effect == enchantment_type else 0

    def get_enchantment_effect_spell_by_type(self, enchantment_type: [ItemEnchantmentType]):
        return self.effect_spell if self.effect == enchantment_type else 0
