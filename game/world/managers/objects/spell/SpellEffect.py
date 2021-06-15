import random

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SpellRadius, Spell
from game.world.managers.objects.spell.AuraManager import AppliedAura
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
    trigger_spell_id: int

    caster_effective_level: int
    effect_index: int
    targets: EffectTargets
    radius_entry: SpellRadius
    trigger_spell_entry: Spell

    effect_aura = None


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
        self.trigger_spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.trigger_spell_id) if self.trigger_spell_id else None

        if self.aura_type:  # If this effect has an aura type provided, generate it here. It (might ?) be needed by effect handlers
            self.effect_aura = AppliedAura(casting_spell.spell_caster, casting_spell, self, None)  # Target as none as this effect shouldn't be tied to any unit

    def get_effect_points(self, effective_level) -> int:
        rolled_points = random.randint(1, self.die_sides + self.dice_per_level) if self.die_sides != 0 else 0
        return self.base_points + int(self.real_points_per_level * effective_level) + rolled_points

    def get_radius(self) -> float:
        if not self.radius_entry:
            return 0
        return min(self.radius_entry.RadiusMax, self.radius_entry.Radius + self.radius_entry.RadiusPerLevel * self.caster_effective_level)

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
