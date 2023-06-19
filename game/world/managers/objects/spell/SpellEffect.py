import random
import time
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import SpellRadius
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.aura.AuraEffectDummyHandler import AuraEffectDummyHandler
from game.world.managers.objects.spell.aura.AuraEffectHandler import PERIODIC_AURA_EFFECTS
from game.world.managers.objects.spell.EffectTargets import EffectTargets
from game.world.managers.objects.spell.aura.AreaAuraHolder import AreaAuraHolder
from utils.constants.MiscCodes import ObjectTypeFlags
from utils.constants.SpellCodes import SpellEffects, SpellAttributes, SpellAttributesEx, SpellImmunity, SpellMissReason
from utils.constants.UnitCodes import PowerTypes


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

    # Duration and periodic timing info for auras applied by this effect.
    applied_aura_duration = -1  # Period timer in the case of an infinite periodic effect.
    periodic_effect_ticks: Optional[list[int]] = None  # None for distinct uninitialized state.
    last_update_timestamp = -1
    last_cost_timestamp = -1

    area_aura_holder: Optional[AreaAuraHolder] = None

    def __init__(self, casting_spell, index):
        self.load_effect(casting_spell.spell_entry, index)

        self.caster_effective_level = casting_spell.caster_effective_level
        self.targets = EffectTargets(casting_spell, self)
        self.radius_entry = DbcDatabaseManager.spell_radius_get_by_id(self.radius_index) if self.radius_index else None
        self.casting_spell = casting_spell

        is_periodic = self.aura_type in PERIODIC_AURA_EFFECTS or AuraEffectDummyHandler.is_periodic(casting_spell.spell_entry.ID)
        # Descriptions of periodic effects with a period of 0 either imply regeneration every 5s or say "per tick".
        self.aura_period = (self.aura_period if self.aura_period else 5000) if is_periodic else 0
        if is_periodic and casting_spell.is_channeled():
            # Account for channel time modifiers.
            tick_count = int(self.casting_spell.get_duration(apply_mods=False) / self.aura_period)
            self.aura_period = int(self.casting_spell.get_duration() / tick_count)

    def update_effect_aura(self, timestamp):
        if self.applied_aura_duration == -1:
            return

        self.applied_aura_duration -= (timestamp - self.last_update_timestamp) * 1000
        self.last_update_timestamp = timestamp

    def remove_old_periodic_effect_ticks(self):
        # Periodic effects with an infinite duration only have one tick internally.
        if self.casting_spell.get_duration() == -1:
            # Reset aura duration when the tick is reached.
            if self.is_past_next_period():
                self.applied_aura_duration = self.aura_period
            return

        while self.is_past_next_period():
            self.periodic_effect_ticks.pop()

    def is_past_next_period(self):
        # Also accept equal duration to properly handle last tick.
        return self.periodic_effect_ticks is not None and \
               len(self.periodic_effect_ticks) > 0 and self.periodic_effect_ticks[-1] >= self.applied_aura_duration

    def has_periodic_ticks_remaining(self):
        if not self.is_periodic() or not self.casting_spell.duration_entry:
            return False

        return self.periodic_effect_ticks is None or len(self.periodic_effect_ticks) > 0

    def generate_periodic_effect_ticks(self) -> Optional[list[int]]:
        duration = self.casting_spell.get_duration()
        if not self.is_periodic():
            return []

        if duration == -1:
            tick_count = 1  # Generate first tick for infinite duration spells.
        else:
            tick_count = int(duration / self.aura_period)

        ticks = []
        for i in range(tick_count):
            ticks.append(self.aura_period * i)
        return ticks

    def start_aura_duration(self, overwrite=False):
        if not self.casting_spell.duration_entry or (self.periodic_effect_ticks is not None and not overwrite):
            return

        self.applied_aura_duration = self.casting_spell.get_duration()
        if self.applied_aura_duration == -1:
            # For periodic effects with infinite duration,
            # we'll use the aura duration to track the remaining period instead.
            self.applied_aura_duration = self.aura_period

        # Match timestamps for channeled spells.
        # This is necessary since slight processing delays can cause the last tick to be skipped otherwise
        # due to the channel ending before the aura wearing off.
        self.last_update_timestamp = time.time() if not self.casting_spell.is_channeled() else \
            self.casting_spell.cast_start_timestamp
        self.last_cost_timestamp = self.last_update_timestamp

        if self.is_periodic():
            self.periodic_effect_ticks = self.generate_periodic_effect_ticks()

    def handle_periodic_resource_cost(self, timestamp):
        cost = self.casting_spell.spell_entry.ManaPerSecond
        if not cost:
            return

        if self.last_cost_timestamp != -1 and \
                timestamp - self.last_cost_timestamp <= 1:
            return
        self.last_cost_timestamp = timestamp

        power_type = self.casting_spell.spell_entry.PowerType
        caster = self.casting_spell.spell_caster

        current_power = caster.health if power_type == PowerTypes.TYPE_HEALTH \
            else caster.get_power_value(power_type)
        new_power = current_power - cost

        # Interrupt cast if the caster has insufficient resources.
        if new_power < 0 or (new_power == 0 and power_type == PowerTypes.TYPE_HEALTH):
            caster.spell_manager.remove_cast(self.casting_spell, interrupted=True)
            return

        if power_type == PowerTypes.TYPE_HEALTH:
            caster.set_health(new_power)
        else:
            caster.set_power_value(new_power, power_type)

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
        # Effect harmfulness is resolved before actual target resolution.
        # Instead of analyzing resolved targets,
        # take into account initial target friendliness and the nature of the effect's implicit targets.
        target = self.casting_spell.initial_target if self.casting_spell.initial_target_is_unit_or_player() else None

        if self.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA:
            if self.casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_AURA_IS_DEBUFF:
                return True

        can_target_friendly, can_target_hostile = self.targets.get_target_hostility_info(unit_target=target)

        if can_target_friendly != can_target_hostile:
            return can_target_hostile  # No ambiguity.

        if self.casting_spell.initial_target is self.casting_spell.spell_caster:
            return False  # Assume that self-cast is friendly with mixed targets.

        if self.casting_spell.initial_target_is_object():
            # Select friendliness based on hostility.
            return self.casting_spell.spell_caster.can_attack_target(self.casting_spell.initial_target)

        return False

    def is_target_immune(self, target):
        # Validate target and check harmfulness.
        if not target or not isinstance(target, ObjectManager) or \
            not target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return False

        # Spell school/effect aura.
        if self.casting_spell.is_target_immune() or \
                (self.effect_type == SpellEffects.SPELL_EFFECT_APPLY_AURA and
                 self.casting_spell.is_target_immune_to_aura(target)):
            return True

        # Effect type.
        if target.has_immunity(SpellImmunity.IMMUNITY_EFFECT, self.effect_type, is_friendly=not self.is_harmful()):
            return True

        return False

    def can_miss(self):
        return self.effect_type not in {SpellEffects.SPELL_EFFECT_LEAP, SpellEffects.SPELL_EFFECT_SCRIPT_EFFECT}

    def is_full_miss(self):
        if not self.casting_spell.object_target_results:
            return False

        if not self.casting_spell.initial_target_is_unit_or_player():
            # Don't consider non-unit-targeted spells for "full misses", as the initial target is unmissable.
            return False

        targets = self.targets.get_resolved_effect_targets_by_type(ObjectManager)
        if not targets:
            # Initial unit target, but primary target type isn't an object.
            return False

        return all([self.casting_spell.object_target_results[target.guid].result != SpellMissReason.MISS_REASON_NONE
                    for target in targets])

    # noinspection PyUnusedLocal
    def load_effect(self, spell, index):
        self.effect_type = eval(f'spell.Effect_{index+1}')
        self.die_sides = eval(f'spell.EffectDieSides_{index+1}')
        self.base_dice = eval(f'spell.EffectBaseDice_{index+1}')
        self.dice_per_level = eval(f'spell.EffectDicePerLevel_{index+1}')
        self.real_points_per_level = eval(f'spell.EffectRealPointsPerLevel_{index+1}')
        self.base_points = eval(f'spell.EffectBasePoints_{index+1}')
        self.implicit_target_a = eval(f'spell.ImplicitTargetA_{index+1}')
        self.implicit_target_b = eval(f'spell.ImplicitTargetB_{index+1}')
        self.radius_index = eval(f'spell.EffectRadiusIndex_{index+1}')
        self.aura_type = eval(f'spell.EffectAura_{index+1}')
        self.aura_period = eval(f'spell.EffectAuraPeriod_{index+1}')
        self.amplitude = eval(f'spell.EffectAmplitude_{index+1}')
        self.chain_targets = eval(f'spell.EffectChainTargets_{index+1}')
        self.item_type = eval(f'spell.EffectItemType_{index+1}')
        self.misc_value = eval(f'spell.EffectMiscValue_{index+1}')
        self.trigger_spell_id = eval(f'spell.EffectTriggerSpell_{index+1}')

        # Handle dummy aura effects custom periods.
        if not self.aura_period and AuraEffectDummyHandler.is_periodic(spell.ID):
            self.aura_period = AuraEffectDummyHandler.get_period(spell.ID)

        self.effect_index = index
