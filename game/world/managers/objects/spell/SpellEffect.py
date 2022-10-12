import random
import time
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SpellRadius
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.aura.AuraEffectHandler import PERIODIC_AURA_EFFECTS
from game.world.managers.objects.spell.EffectTargets import EffectTargets
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags
from utils.constants.SpellCodes import SpellEffects, SpellAttributes, SpellAttributesEx, SpellImmunity


class SpellEffect:
    effect_type: SpellEffects
    die_sides: int
    base_dice: int
    dice_per_level: int
    real_points_per_level: int
    base_points: int
    implicit_target_a: int
    implicit_target_b: int
    radius_index: int
    aura_type: int
    aura_period: int
    amplitude: int
    chain_targets: int
    item_type: int
    misc_value: int
    trigger_spell_id: int

    caster_effective_level: int
    effect_index: int
    targets: EffectTargets
    radius_entry: SpellRadius

    _harmful: Optional[bool] = None

    # Duration and periodic timing info for auras applied by this effect
    applied_aura_duration = -1
    periodic_effect_ticks = []
    last_update_timestamp = -1

    def __init__(self, casting_spell, index):
        if index == 0:
            self.load_first(casting_spell.spell_entry)
        elif index == 1:
            self.load_second(casting_spell.spell_entry)
        elif index == 2:
            self.load_third(casting_spell.spell_entry)

        self.caster_effective_level = casting_spell.caster_effective_level
        self.targets = EffectTargets(casting_spell, self)
        self.radius_entry = DbcDatabaseManager.spell_radius_get_by_id(self.radius_index) if self.radius_index else None
        self.casting_spell = casting_spell

        is_periodic = self.aura_type in PERIODIC_AURA_EFFECTS
        # Descriptions of periodic effects with a period of 0 either imply regeneration every 5s or say "per tick".
        self.aura_period = (self.aura_period if self.aura_period else 5000) if is_periodic else 0

    def update_effect_aura(self, timestamp):
        if self.applied_aura_duration == -1:
            return

        self.applied_aura_duration -= (timestamp - self.last_update_timestamp) * 1000
        self.last_update_timestamp = timestamp

    def remove_old_periodic_effect_ticks(self):
        while self.is_past_next_period():
            self.periodic_effect_ticks.pop()

    def is_past_next_period(self):
        # Also accept equal duration to properly handle last tick.
        return len(self.periodic_effect_ticks) > 0 and self.periodic_effect_ticks[-1] >= self.applied_aura_duration

    def generate_periodic_effect_ticks(self) -> list[int]:
        duration = self.casting_spell.get_duration()
        if self.aura_period == 0:
            return []
        period = self.aura_period
        tick_count = int(duration / self.aura_period)

        ticks = []
        for i in range(tick_count):
            ticks.append(period * i)
        return ticks

    def start_aura_duration(self, overwrite=False):
        if not self.casting_spell.duration_entry or (len(self.periodic_effect_ticks) > 0 and not overwrite):
            return
        self.applied_aura_duration = self.casting_spell.get_duration()
        self.last_update_timestamp = time.time()
        if self.is_periodic():
            self.periodic_effect_ticks = self.generate_periodic_effect_ticks()

    def is_periodic(self):
        return self.aura_period != 0

    def get_effect_points(self) -> int:
        rolled_points = random.randint(1, self.die_sides + self.dice_per_level) if self.die_sides != 0 else 0
        return self.base_points + int(self.real_points_per_level * self.caster_effective_level) + rolled_points

    def get_effect_simple_points(self) -> int:
        return self.base_points + self.base_dice

    def get_radius(self) -> float:
        if not self.radius_entry:
            return 0
        return min(self.radius_entry.RadiusMax, self.radius_entry.Radius + self.radius_entry.RadiusPerLevel * self.caster_effective_level)

    def is_harmful(self):
        if self._harmful is None:
            self._harmful = self._resolve_harmful()

        return self._harmful

    def _resolve_harmful(self):
        if self.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA:
            if self.casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_AURA_IS_DEBUFF:
                return True

            if self.casting_spell.initial_target_is_object():
                return self.casting_spell.spell_caster.can_attack_target(self.casting_spell.initial_target)

        return not self.targets.can_target_friendly()  # TODO this may not cover all cases.

    def is_target_immune(self, target):
        # Validate target and check harmfulness.
        if not target or not isinstance(target, ObjectManager) or \
            not target.object_type_mask & ObjectTypeFlags.TYPE_UNIT or \
                (not self.is_harmful() and not
                 self.casting_spell.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_IMMUNITY_HOSTILE_FRIENDLY_EFFECTS):
            return False

        # Spell school/effect aura.
        if self.casting_spell.is_target_immune() or \
                (self.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA and
                 self.casting_spell.is_target_immune_to_aura()):
            return True

        # Effect type.
        if target.has_immunity(SpellImmunity.IMMUNITY_EFFECT, self.effect_type):
            return True

        return False

    def load_first(self, spell):
        self.effect_type = spell.Effect_1
        self.die_sides = spell.EffectDieSides_1
        self.base_dice = spell.EffectBaseDice_1
        self.dice_per_level = spell.EffectDicePerLevel_1
        self.real_points_per_level = spell.EffectRealPointsPerLevel_1
        self.base_points = spell.EffectBasePoints_1
        self.implicit_target_a = spell.ImplicitTargetA_1
        self.implicit_target_b = spell.ImplicitTargetB_1
        self.radius_index = spell.EffectRadiusIndex_1
        self.aura_type = spell.EffectAura_1
        self.aura_period = spell.EffectAuraPeriod_1
        self.amplitude = spell.EffectAmplitude_1
        self.chain_targets = spell.EffectChainTargets_1
        self.item_type = spell.EffectItemType_1
        self.misc_value = spell.EffectMiscValue_1
        self.trigger_spell_id = spell.EffectTriggerSpell_1

        self.effect_index = 0

    def load_second(self, spell):
        self.effect_type = spell.Effect_2
        self.die_sides = spell.EffectDieSides_2
        self.base_dice = spell.EffectBaseDice_2
        self.dice_per_level = spell.EffectDicePerLevel_2
        self.real_points_per_level = spell.EffectRealPointsPerLevel_2
        self.base_points = spell.EffectBasePoints_2
        self.implicit_target_a = spell.ImplicitTargetA_2
        self.implicit_target_b = spell.ImplicitTargetB_2
        self.radius_index = spell.EffectRadiusIndex_2
        self.aura_type = spell.EffectAura_2
        self.aura_period = spell.EffectAuraPeriod_2
        self.amplitude = spell.EffectAmplitude_2
        self.chain_targets = spell.EffectChainTargets_2
        self.item_type = spell.EffectItemType_2
        self.misc_value = spell.EffectMiscValue_2
        self.trigger_spell_id = spell.EffectTriggerSpell_2

        self.effect_index = 1

    def load_third(self, spell):
        self.effect_type = spell.Effect_3
        self.die_sides = spell.EffectDieSides_3
        self.base_dice = spell.EffectBaseDice_3
        self.dice_per_level = spell.EffectDicePerLevel_3
        self.real_points_per_level = spell.EffectRealPointsPerLevel_3
        self.base_points = spell.EffectBasePoints_3
        self.implicit_target_a = spell.ImplicitTargetA_3
        self.implicit_target_b = spell.ImplicitTargetB_3
        self.radius_index = spell.EffectRadiusIndex_3
        self.aura_type = spell.EffectAura_3
        self.aura_period = spell.EffectAuraPeriod_3
        self.amplitude = spell.EffectAmplitude_3
        self.chain_targets = spell.EffectChainTargets_3
        self.item_type = spell.EffectItemType_3
        self.misc_value = spell.EffectMiscValue_3
        self.trigger_spell_id = spell.EffectTriggerSpell_3

        self.effect_index = 2
