from game.world.managers.objects.spell.AuraEffectHandler import AuraEffectHandler
from utils.constants.SpellCodes import SpellEffects, SpellState


class AppliedAura:
    def __init__(self, caster, casting_spell, spell_effect, target):
        self.target = target
        self.source_spell = casting_spell

        self.caster = caster
        self.spell_id = casting_spell.spell_entry.ID
        self.spell_effect = spell_effect
        self.effective_level = casting_spell.caster_effective_level
        self.interrupt_flags = casting_spell.spell_entry.AuraInterruptFlags

        self.period = spell_effect.aura_period

        self.passive = casting_spell.is_passive()
        self.harmful = self.resolve_harmful()

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

        self.index = -1  # Set on application

    def has_duration(self) -> bool:
        return self.get_duration() != -1

    def is_passive(self) -> bool:
        return self.passive

    def is_periodic(self) -> bool:
        return self.spell_effect.is_periodic()

    def resolve_harmful(self) -> bool:
        if self.source_spell.initial_target_is_object():
            return self.caster.can_attack_target(self.target)  # TODO not always applicable, ie. arcane missiles

        # Terrain-targeted aura
        return not self.spell_effect.targets.can_target_friendly()

    def get_duration(self):
        return self.spell_effect.applied_aura_duration

    def is_past_next_period(self) -> bool:
        return self.spell_effect.is_past_next_period()

    def update(self, elapsed):
        if self.has_duration():
            if self.source_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:  # Active spells manage duration and ticks through SpellManager updates
                self.spell_effect.applied_aura_duration -= elapsed * 1000

        if self.is_periodic():
            AuraEffectHandler.handle_aura_effect_change(self)

        if self.source_spell.cast_state != SpellState.SPELL_STATE_ACTIVE:
            self.spell_effect.remove_old_periodic_effect_ticks()
