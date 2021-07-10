import time


class CooldownEntry(object):
    spell_id: int
    cooldown_category: int
    cooldown_length: int
    end_timestamp: int
    locked: bool

    def __init__(self, spell_entry, timestamp, locked=False):
        self.spell_id = spell_entry.ID
        self.cooldown_category = spell_entry.Category if spell_entry.CategoryRecoveryTime > 0 else -1  # If category cd isn't provided, set to invalid category
        self.cooldown_length = spell_entry.CategoryRecoveryTime if self.cooldown_category != -1 else spell_entry.RecoveryTime
        self.end_timestamp = timestamp + self.cooldown_length/1000
        self.locked = locked

    def is_valid(self):
        return self.locked or self.end_timestamp > time.time()

    def unlock(self, timestamp):
        if not self.locked:
            return
        self.locked = False
        self.end_timestamp = timestamp + self.cooldown_length/1000

    def matches_spell(self, spell_entry):
        return self.spell_id == spell_entry.ID or self.cooldown_category == spell_entry.Category
