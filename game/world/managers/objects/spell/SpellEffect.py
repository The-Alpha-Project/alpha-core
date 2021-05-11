import random

from game.world.managers.objects.spell.EffectTargets import EffectTargets
from utils.constants.SpellCodes import SpellEffects


class SpellEffect(object):
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
    trigger_spell: int

    effect_index: int
    targets: EffectTargets

    def __init__(self, casting_spell, index):
        if index == 1:
            self.load_first(casting_spell.spell_entry)
        elif index == 2:
            self.load_second(casting_spell.spell_entry)
        elif index == 3:
            self.load_third(casting_spell.spell_entry)

        self.targets = EffectTargets(casting_spell, self)

    def get_effect_points(self, effective_level):
        rolled_points = random.randint(1, self.die_sides + self.dice_per_level) if self.die_sides != 0 else 0
        return self.base_points + int(self.real_points_per_level * effective_level) + rolled_points

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
        self.trigger_spell = spell.EffectTriggerSpell_1

        self.effect_index = 1

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
        self.trigger_spell = spell.EffectTriggerSpell_2

        self.effect_index = 2

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
        self.trigger_spell = spell.EffectTriggerSpell_3

        self.effect_index = 3