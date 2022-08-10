from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.spell.AuraEffectHandler import AuraEffectHandler
from utils.constants.SpellCodes import SpellEffects, SpellState, SpellAttributes


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
        self.harmful = self.resolve_harmful()

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

    def has_duration(self) -> bool:
        return self.get_duration() != -1

    def is_passive(self) -> bool:
        return self.passive

    def is_periodic(self) -> bool:
        return self.spell_effect.is_periodic()

    def resolve_harmful(self) -> bool:
        if self.source_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_AURA_IS_DEBUFF:
            return True

        if self.source_spell.initial_target_is_object():
            return self.caster.can_attack_target(self.target)  # TODO not always applicable, ie. arcane missiles

        # Terrain-targeted aura
        return not self.spell_effect.targets.can_target_friendly()

    def get_duration(self):
        return self.spell_effect.applied_aura_duration

    def get_effect_points(self):
        return self.spell_effect.get_effect_points() * self.applied_stacks

    def is_past_next_period(self) -> bool:
        return self.spell_effect.is_past_next_period()

    def update(self, timestamp):
        if self.has_duration():
            self.spell_effect.update_effect_aura(timestamp)

        if self.is_periodic():
            AuraEffectHandler.handle_aura_effect_change(self, self.target)

        # Don't remove periodic ticks for channeled spells.
        # Channeled spells have special handling for applied auras because of targeting reasons.
        # See SpellManager::handle_spell_effect_update for more information.
        if self.source_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:
            self.spell_effect.remove_old_periodic_effect_ticks()
