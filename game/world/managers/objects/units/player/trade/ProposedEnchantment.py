from utils.constants.ItemCodes import EnchantmentSlots


class ProposedEnchantment:
    def __init__(self, trade_slot=0, spell_id=0, enchant_slot=0, enchant_entry=0, duration=0, charges=0):
        self.trade_slot: int = trade_slot
        self.spell_id: int = spell_id
        self.enchantment_slot: EnchantmentSlots = EnchantmentSlots(enchant_slot)
        self.enchantment_entry: int = enchant_entry
        self.duration: int = duration
        self.charges: int = charges

    def set_enchantment(self, trade_slot, spell_id, enchant_slot, enchant_entry, duration, charges):
        self.trade_slot = trade_slot
        self.spell_id = spell_id
        self.enchantment_slot = enchant_slot
        self.enchantment_entry = enchant_entry
        self.duration = duration
        self.charges = charges

    def flush(self):
        self.trade_slot = 0
        self.spell_id = 0
        self.enchantment_slot = 0
        self.enchantment_entry = 0
        self.duration = 0
        self.charges = 0
