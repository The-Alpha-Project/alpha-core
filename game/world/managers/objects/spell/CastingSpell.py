import time

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell, SpellRange, SpellDuration, SpellCastTimes
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.SpellEffect import SpellEffect
from utils.constants.MiscCodes import AttackTypes, ObjectTypes
from utils.constants.SpellCodes import SpellState, SpellCastFlags, SpellTargetMask, SpellAttributes, SpellAttributesEx


class CastingSpell(object):
    spell_entry: Spell
    cast_state: SpellState
    cast_flags: SpellCastFlags  # TODO Write proc flag when needed
    spell_caster = None  # TODO Item caster (use item?)
    initial_target = None
    unit_target_results = {}  # Assigned on cast - contains guids and results on successful hits/misses/blocks etc.
    spell_target_mask: SpellTargetMask
    range_entry: SpellRange
    duration_entry: SpellDuration
    cast_time_entry: SpellCastTimes
    effects: list

    cast_end_timestamp: float
    spell_delay_end_timestamp: float
    caster_effective_level: int

    spell_attack_type: int

    def __init__(self, spell, caster_obj, initial_target, target_mask):
        self.spell_entry = spell
        self.spell_caster = caster_obj
        self.initial_target = initial_target
        self.spell_target_mask = target_mask
        self.duration_entry = DbcDatabaseManager.spell_duration_get_by_id(spell.DurationIndex)
        self.range_entry = DbcDatabaseManager.spell_range_get_by_id(spell.RangeIndex)  # TODO RangeMin is never used
        self.cast_time_entry = DbcDatabaseManager.spell_cast_time_get_by_id(spell.CastingTimeIndex)
        self.cast_end_timestamp = self.get_base_cast_time()/1000 + time.time()
        self.caster_effective_level = self.calculate_effective_level(self.spell_caster.level)

        self.spell_attack_type = AttackTypes.RANGED_ATTACK if self.is_ranged() else AttackTypes.BASE_ATTACK
        self.cast_state = SpellState.SPELL_STATE_PREPARING

        self.load_effects()

        self.cast_flags = SpellCastFlags.CAST_FLAG_NONE  # TODO Ammo/proc flag

    def initial_target_is_object(self):
        return isinstance(self.initial_target, ObjectManager)

    def initial_target_is_unit_or_player(self):
        if not self.initial_target_is_object():
            return False

        target_type = self.initial_target.get_type()
        return target_type == ObjectTypes.TYPE_UNIT or target_type == ObjectTypes.TYPE_PLAYER

    def initial_target_is_player(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type() == ObjectTypes.TYPE_PLAYER

    def initial_target_is_item(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type() == ObjectTypes.TYPE_ITEM

    def initial_target_is_gameobject(self):
        if not self.initial_target_is_object():
            return False

        return self.initial_target.get_type() == ObjectTypes.TYPE_GAMEOBJECT

    def initial_target_is_terrain(self):
        return isinstance(self.initial_target, Vector)

    def get_initial_target_info(self):  # ([values], len)
        is_terrain = self.initial_target_is_terrain()
        return ([self.initial_target.x, self.initial_target.y, self.initial_target.z] if is_terrain
                else [self.initial_target.guid]), ('3f' if is_terrain else 'Q')

    def resolve_target_info_for_effects(self):
        for effect in self.effects:
            self.resolve_target_info_for_effect(effect.effect_index)

    def resolve_target_info_for_effect(self, index):
        if index < 0 or index > len(self.effects)-1:
            return
        effect = self.effects[index]
        if not effect:
            return

        effect.targets.resolve_targets()
        effect_info = effect.targets.get_effect_target_results()
        self.unit_target_results = {**self.unit_target_results, **effect_info}

    def is_instant_cast(self):
        return self.cast_time_entry.Base == 0

    def is_ranged(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_RANGED == SpellAttributes.SPELL_ATTR_RANGED

    def is_passive(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE == SpellAttributes.SPELL_ATTR_PASSIVE

    def is_channeled(self):
        return self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_CHANNELED

    def generates_threat(self):
        return not (self.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_NO_THREAT)

    def trigger_cooldown_on_remove(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_DISABLED_WHILE_ACTIVE == SpellAttributes.SPELL_ATTR_DISABLED_WHILE_ACTIVE

    def casts_on_swing(self):
        return self.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ON_NEXT_SWING_1 == SpellAttributes.SPELL_ATTR_ON_NEXT_SWING_1

    def requires_combo_points(self):
        cp_att = SpellAttributesEx.SPELL_ATTR_EX_REQ_TARGET_COMBO_POINTS | SpellAttributesEx.SPELL_ATTR_EX_REQ_COMBO_POINTS
        return self.spell_caster.get_type() == ObjectTypes.TYPE_PLAYER and \
            self.spell_entry.AttributesEx & cp_att != 0

    def calculate_effective_level(self, level):
        if level > self.spell_entry.MaxLevel > 0:
            level = self.spell_entry.MaxLevel
        elif level < self.spell_entry.BaseLevel:
            level = self.spell_entry.BaseLevel
        return max(level - self.spell_entry.SpellLevel, 0)

    def get_base_cast_time(self):
        skill = self.spell_caster.skill_manager.get_skill_for_spell_id(self.spell_entry.ID)
        if not skill:
            return self.cast_time_entry.Minimum

        return int(max(self.cast_time_entry.Minimum, self.cast_time_entry.Base + self.cast_time_entry.PerLevel * skill.value))

    def get_resource_cost(self):
        if self.spell_caster.get_type() == ObjectTypes.TYPE_PLAYER and self.spell_entry.ManaCostPct != 0:
            return self.spell_caster.base_mana * self.spell_entry.ManaCostPct / 100

        # ManaCostPerLevel is not used by anything relevant (only 271/4513/7290)
        return self.spell_entry.ManaCost

    def load_effects(self):
        self.effects = []
        if self.spell_entry.Effect_1 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))
        if self.spell_entry.Effect_2 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))
        if self.spell_entry.Effect_3 != 0:
            self.effects.append(SpellEffect(self, len(self.effects)))  # Use effects length for index - some spells (by mistake?) have empty effect slots before an actual effect

    def get_reagents(self):
        return (self.spell_entry.Reagent_1, self.spell_entry.ReagentCount_1), (self.spell_entry.Reagent_2, self.spell_entry.ReagentCount_2), \
               (self.spell_entry.Reagent_3, self.spell_entry.ReagentCount_3), (self.spell_entry.Reagent_4, self.spell_entry.ReagentCount_4), \
               (self.spell_entry.Reagent_5, self.spell_entry.ReagentCount_5), (self.spell_entry.Reagent_6, self.spell_entry.ReagentCount_6), \
               (self.spell_entry.Reagent_7, self.spell_entry.ReagentCount_7), (self.spell_entry.Reagent_8, self.spell_entry.ReagentCount_8)

    def get_conjured_items(self):
        conjured_items = []
        for effect in self.effects:
            item_count = abs(effect.get_effect_points(self.caster_effective_level))
            conjured_items.append([effect.item_type, item_count])
        return tuple(conjured_items)
