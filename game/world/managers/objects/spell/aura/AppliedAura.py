from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.spell.aura.AuraEffectHandler import AuraEffectHandler
from utils.constants.SpellCodes import SpellEffects, DispelType, SpellAttributesEx


class AppliedAura:
    def __init__(self, caster, casting_spell, spell_effect, target):
        self.target = target
        self.source_spell = casting_spell

        self.caster = caster
        self.spell_id = casting_spell.spell_entry.ID
        self.spell_effect = spell_effect
        self.interrupt_flags = casting_spell.spell_entry.AuraInterruptFlags

        self.proc_charges = casting_spell.spell_entry.ProcCharges if casting_spell.spell_entry.ProcCharges != 0 else -1
        self.proc_flags = casting_spell.spell_entry.ProcFlags

        self.applied_stacks = 1
        self.can_stack = ExtendedSpellData.AuraDoseInfo.aura_can_stack(self.spell_id)
        self.max_stacks = ExtendedSpellData.AuraDoseInfo.get_aura_max_stacks(self.spell_id)

        self.passive = casting_spell.is_passive()
        self.harmful = self.spell_effect.is_harmful()

        for effect in casting_spell.get_effects():
            if effect.effect_index >= spell_effect.effect_index:
                break
            if effect.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA and \
                    effect.implicit_target_a == self.spell_effect.implicit_target_a:
                # Some buffs/debuffs have multiple effects in one aura, in which case they're merged in the UI
                # If this spell has an effect with a lower index already applies an aura,
                # this aura is set to passive to not display twice in client.
                self.passive = True
                break

        self.index = -1  # Set on application

    def is_passive(self) -> bool:
        return self.passive

    def displays_in_aura_bar(self):
        return not self.source_spell.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_DONT_DISPLAY_IN_AURA_BAR

    def is_periodic(self) -> bool:
        return self.spell_effect.is_periodic()

    def has_duration(self) -> bool:
        return self.get_duration() != -1

    def get_duration(self):
        if self.source_spell.get_duration() == -1:
            # Infinite duration aura.
            # Don't compare to applied_aura_duration as it's still set for periodic effects.
            return -1

        return self.spell_effect.applied_aura_duration

    def get_dispel_mask(self):
        dispel_type = self.source_spell.spell_entry.custom_DispelType
        return 1 << dispel_type if dispel_type != DispelType.ALL else DispelType.MCDP_MASK

    def get_effect_points(self):
        return self.spell_effect.get_effect_points() * self.applied_stacks

    def is_past_next_period(self) -> bool:
        return self.spell_effect.is_past_next_period()

    def update(self, timestamp):
        if self.spell_effect.area_aura_holder:
            return  # Area auras are managed by AreaAuraHolder.

        if self.has_duration():
            self.spell_effect.update_effect_aura(timestamp)

        if self.is_periodic():
            AuraEffectHandler.handle_aura_effect_change(self, self.target)

        self.spell_effect.remove_old_periodic_effect_ticks()
