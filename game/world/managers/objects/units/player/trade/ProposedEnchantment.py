from utils.constants.ItemCodes import EnchantmentSlots


class ProposedEnchantment:
    def __init__(self, trade_slot=-1, spell_id=0, enchant_slot=0, enchant_entry=0,
                 duration=0, charges=0, caster_guid=0, target_owner_guid=0, target_item_guid=0):
        self.trade_slot: int = trade_slot
        self.spell_id: int = spell_id
        self.enchantment_slot: EnchantmentSlots = EnchantmentSlots(enchant_slot)
        self.enchantment_entry: int = enchant_entry
        self.duration: int = duration
        self.charges: int = charges
        self.caster_guid: int = caster_guid
        self.target_owner_guid: int = target_owner_guid
        self.target_item_guid: int = target_item_guid

    def set_enchantment(self, trade_slot, spell_id, enchant_slot, enchant_entry, duration, charges,
                        caster_guid=0, target_owner_guid=0, target_item_guid=0):
        self.trade_slot = trade_slot if isinstance(trade_slot, int) else -1
        self.spell_id = spell_id
        self.enchantment_slot = enchant_slot
        self.enchantment_entry = enchant_entry
        self.duration = duration
        self.charges = charges
        self.caster_guid = caster_guid
        self.target_owner_guid = target_owner_guid
        self.target_item_guid = target_item_guid

    def flush(self):
        self.trade_slot = -1
        self.spell_id = -1
        self.enchantment_slot = 0  # Used to apply enchantment after trade.
        self.enchantment_entry = 0  # ItemEnchantment id.
        self.duration = 0
        self.charges = 0
        self.caster_guid = 0
        self.target_owner_guid = 0
        self.target_item_guid = 0

    def is_valid(self):
        return isinstance(self.trade_slot, int) and self.trade_slot >= 0
