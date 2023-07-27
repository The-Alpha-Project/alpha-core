import random
import time

from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.spell.aura.AuraEffectHandler import AuraEffectHandler
from utils.constants.SpellCodes import SpellEffects, DispelType, SpellAttributesEx, SpellAttributes


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

        # If this aura is passive, the index of the active component of this aura, if any.
        self.active_aura_index = -1

        # Previous heartbeat resist timestamp.
        self.previous_heartbeat = time.time()

        for effect in casting_spell.get_effects():
            if effect.effect_index >= spell_effect.effect_index:
                break
            if effect.effect_type != SpellEffects.SPELL_EFFECT_APPLY_AURA:
                continue

            # Some buffs/debuffs have multiple effects in one aura, in which case they're merged in the UI
            # If this spell has an effect with a lower index that already applies an aura,
            # this aura is set to passive to not display twice in client.
            if self.target in effect.targets.get_resolved_effect_targets_by_type(type(self.target)):
                self.passive = True
                self.active_aura_index = self.target.aura_manager.get_main_aura_slot_for_spell(self.source_spell)
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

        if self.has_duration() or self.is_periodic():
            # Check periodic in case of periodic auras with infinite duration.
            self.spell_effect.update_effect_aura(timestamp)

        if not self.passive and self.target is self.caster:
            self.spell_effect.handle_periodic_resource_cost(timestamp)

        if self.is_periodic():
            AuraEffectHandler.handle_aura_effect_change(self, self.target)

        self.spell_effect.remove_old_periodic_effect_ticks()

    def get_heartbeat_resist_result(self, timestamp):
        # PvE heartbeat resist, same as VMaNGOS.

        if not self.has_duration() or not self.harmful or self.passive or not \
            self.source_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_HEARTBEAT_RESIST:
            return False

        if timestamp - self.previous_heartbeat <= 5:
            return False

        self.previous_heartbeat = timestamp
        resist_chance = self.target.stat_manager.get_spell_resist_chance_against_self(self.source_spell)

        return random.random() < resist_chance