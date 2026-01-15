import time


class CooldownEntry:
    spell_id: int
    cooldown_category: int
    cooldown_length: int
    end_timestamp: int
    locked: bool
    cooldown_penalty: int
    forced: bool
    canceled: bool

    # Forced: Overrides spell dbc cooldown. (Used on creatures spell list initialization upon attack start).
    # Cooldown Penalty: Appends time to the normal spell cooldown if provided. (e.g. CounterSpell)
    def __init__(self, spell_entry, timestamp, locked=False, cooldown_penalty=0, forced=False):
        self.forced = forced
        self.spell_id = spell_entry.ID
        self.cooldown_penalty = cooldown_penalty
        # If category cd isn't provided, set to invalid category.
        self.cooldown_category = spell_entry.Category if spell_entry.CategoryRecoveryTime > 0 else -1
        self.cooldown_length = self._get_cooldown_length(spell_entry)
        self.end_timestamp = timestamp + self.cooldown_length / 1000
        self.locked = locked
        self.canceled = False

    def cancel(self):
        self.canceled = True

    def is_valid(self):
        return not self.canceled and (self.locked or self.end_timestamp > time.time())

    def unlock(self, timestamp):
        if not self.locked:
            return
        self.locked = False
        self.end_timestamp = timestamp + self.cooldown_length / 1000

    def matches_spell(self, spell_entry):
        return self.spell_id == spell_entry.ID or self.cooldown_category == spell_entry.Category

    # Either use normal recovery time or provided penalty.
    def _get_cooldown_length(self, spell_entry):
        penalty = self.cooldown_penalty
        recovery = spell_entry.CategoryRecoveryTime if self.cooldown_category != -1 else spell_entry.RecoveryTime
        is_greater_than_dbc_cd = penalty > recovery
        return penalty if penalty and (self.forced or is_greater_than_dbc_cd) else recovery

    # If the returned value is 0, the client will use the default cooldown from the spell DBC.
    # Non-zero values are used to override the default cooldown (e.g., for custom penalties or forced cooldowns).
    def get_cooldown(self, spell_entry):
        penalty = self.cooldown_penalty
        recovery = spell_entry.CategoryRecoveryTime if self.cooldown_category != -1 else spell_entry.RecoveryTime
        is_greater_than_dbc_cd = penalty > recovery

        if penalty and (self.forced or is_greater_than_dbc_cd):
            return penalty

        return 0
