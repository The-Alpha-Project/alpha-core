import time


class CooldownEntry:
    spell_id: int
    cooldown_category: int
    cooldown_length: int
    end_timestamp: int
    locked: bool
    cooldown_penalty: int

    def __init__(self, spell_entry, timestamp, locked=False, cooldown_penalty=0):
        self.spell_id = spell_entry.ID
        self.cooldown_penalty = cooldown_penalty
        # If category cd isn't provided, set to invalid category.
        self.cooldown_category = spell_entry.Category if spell_entry.CategoryRecoveryTime > 0 else -1
        self.cooldown_length = spell_entry.CategoryRecoveryTime if self.cooldown_category != -1 else spell_entry.RecoveryTime
        # Either use normal recovery time or provided penalty.
        self.cooldown_length = cooldown_penalty if cooldown_penalty else self.cooldown_length
        self.end_timestamp = timestamp + self.cooldown_length / 1000
        self.locked = locked

    def is_valid(self):
        return self.locked or self.end_timestamp > time.time()

    def unlock(self, timestamp):
        if not self.locked:
            return
        self.locked = False
        self.end_timestamp = timestamp + self.cooldown_length / 1000

    def matches_spell(self, spell_entry):
        return self.spell_id == spell_entry.ID or self.cooldown_category == spell_entry.Category
