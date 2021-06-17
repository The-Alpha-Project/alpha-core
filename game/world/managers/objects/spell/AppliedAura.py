import time
from struct import pack

from game.world.managers.objects.spell.AuraEffectHandler import AuraEffectHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import ObjectTypes
from utils.constants.SpellCodes import AuraTypes, ShapeshiftForms, AuraSlots, SpellEffects
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import UnitFields


class AppliedAura:
    def __init__(self, caster, casting_spell, spell_effect, target):
        self.target = target
        self.source_spell = casting_spell

        self.caster = caster
        self.spell_id = casting_spell.spell_entry.ID
        self.spell_effect = spell_effect
        self.duration_entry = casting_spell.duration_entry
        self.duration = self.duration_entry.Duration if self.duration_entry else -1
        self.effective_level = casting_spell.caster_effective_level
        self.interrupt_flags = casting_spell.spell_entry.AuraInterruptFlags

        self.period = spell_effect.aura_period

        self.passive = casting_spell.is_passive()
        for effect in casting_spell.effects:
            if effect.effect_index >= spell_effect.effect_index:
                break
            if effect.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA and \
                    effect.implicit_target_a == self.spell_effect.implicit_target_a:
                # Some buffs/debuffs have multiple effects in one aura, in which case they're merged in the UI
                # If this spell has an effect with a lower index already applies an aura,
                # this aura is set to passive to not display twice in client.
                self.passive = True
                break

        self.aura_period_timestamps = []  # Set on application
        self.index = -1  # Set on application

    def has_duration(self) -> bool:
        return self.duration != -1

    def is_passive(self) -> bool:
        return self.passive

    def is_periodic(self) -> bool:
        return self.period != 0

    def is_harmful(self) -> bool:
        if self.source_spell.initial_target_is_object():
            return self.caster.is_enemy_to(self.target)  # TODO not always applicable, ie. arcane missiles

        # Terrain-targeted aura
        return not self.spell_effect.targets.can_target_friendly()

    def is_past_next_period_timestamp(self) -> bool:
        if len(self.aura_period_timestamps) == 0:
            return False
        return time.time() >= self.aura_period_timestamps[-1]

    def pop_period_timestamp(self):
        if len(self.aura_period_timestamps) == 0:
            return
        self.aura_period_timestamps.pop()

    def initialize_period_timestamps(self):
        if self.period == 0 or self.duration == -1 or len(self.aura_period_timestamps) > 0:  # Don't overwrite old timestamps
            return
        period = self.period
        ticks = int(self.duration / self.period)
        period /= 1000  # Millis -> seconds
        curr_time = time.time()

        for i in range(ticks, 0, -1):  # timestamp stack for channel ticks, first element being last tick
            self.aura_period_timestamps.append(curr_time + period * i)


    def update(self, elapsed):
        if self.has_duration():
            self.duration -= int(elapsed * 1000)

        if not self.target:  # Auras that are only tied to effects - ie. persistent area auras
            return
        if self.is_periodic():
            AuraEffectHandler.handle_aura_effect_change(self)
