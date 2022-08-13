import math
from typing import Optional

from utils.constants.SpellCodes import ShapeshiftForms, TotemSlots, SpellMechanic, AuraTypes
from utils.constants.UnitCodes import Teams, PowerTypes


class AuraDoseInfo:
    DOSE_INFO = {
        2537: 5,  # Crusader strike (Rank 1)
        7386: 5,  # Sundering Strike (Rank 1)
        7405: 5  # Sundering Strike (Rank 2)
    }

    @staticmethod
    def aura_can_stack(spell_id: int):
        return spell_id in AuraDoseInfo.DOSE_INFO

    @staticmethod
    def get_aura_max_stacks(spell_id: int):
        return AuraDoseInfo.DOSE_INFO.get(spell_id, 1)


class ShapeshiftInfo:
    # Alliance / Default display_id, Horde display_id, Scale
    SHAPESHIFT_MODELS = {
        ShapeshiftForms.SHAPESHIFT_FORM_CAT: (892, 892, 0.8),
        ShapeshiftForms.SHAPESHIFT_FORM_TREE: (864, 864, 1.0),
        ShapeshiftForms.SHAPESHIFT_FORM_FLYING: (632, 632, 0.8),  # Guessed, using Travel Form display id instead.
        ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
        ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0),
        ShapeshiftForms.SHAPESHIFT_FORM_AMBIENT: (328, 328, 1.0),  # Guessed, only used by zzOLDScout Form.
        ShapeshiftForms.SHAPESHIFT_FORM_GHOSTWOLF: (1164, 1164, 0.8)  # Guessed, the normal Ghost Wolf didn't exist yet.
    }

    SHAPESHIFT_POWER_TYPES = {
        ShapeshiftForms.SHAPESHIFT_FORM_CAT: PowerTypes.TYPE_ENERGY,
        ShapeshiftForms.SHAPESHIFT_FORM_BEAR: PowerTypes.TYPE_RAGE,
        ShapeshiftForms.SHAPESHIFT_FORM_BATTLESTANCE: PowerTypes.TYPE_RAGE,
        ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE: PowerTypes.TYPE_RAGE,
        ShapeshiftForms.SHAPESHIFT_FORM_BERSERKERSTANCE: PowerTypes.TYPE_RAGE
    }

    @staticmethod
    def get_power_for_form(shapeshift_form):
        if shapeshift_form in ShapeshiftInfo.SHAPESHIFT_POWER_TYPES:
            return ShapeshiftInfo.SHAPESHIFT_POWER_TYPES[shapeshift_form]
        return PowerTypes.TYPE_MANA

    @staticmethod
    def get_form_model_info(form: ShapeshiftForms, faction: Teams):
        if form not in ShapeshiftInfo.SHAPESHIFT_MODELS:
            return 0, 0
        info = ShapeshiftInfo.SHAPESHIFT_MODELS.get(form)
        # For creatures default to Alliance form for now.
        return (info[1], info[2]) if faction == Teams.TEAM_HORDE else (info[0], info[2])


class AuraSourceRestrictions:
    # Exclusive aura groups don't seem to be labeled in spell.dbc.

    # Only one aura per paladin.
    PALADIN_AURAS = {
        465, 643, 1032, 7362,  # Devotion Aura
        649, 5606, 5609, 7331,  # Healing Aura
        3487, 5618,  # Resistance Aura
        7294  # Retribution Aura
    }

    PALADIN_SEALS = {
        94, 5645, 7325,  # Seal of Wisdom
        636, 645, 6739,  # Seal of Might
        48, 1034,  # Seal of Wrath
        1022, 5599,  # Seal of Protection
        1036,  # Seal of Fury
        1038,  # Seal of Salvation
        1052, 5601, 5602,  # Seal of Righteousness
        6940  # Seal of Sacrifice
    }

    # "Only one Curse per Warlock can be active on any one target."
    WARLOCK_CURSES = {
        702, 1108, 6205, 7646,  # Curse of Weakness
        704, 7658, 7659,  # Curse of Recklessness
        980, 1014, 6217,  # Curse of Agony
        1490,  # Curse of the Elements
        1714  # Curse of Tongues
    }

    # Mage and Warlock armor buffs can't overlap.
    MAGE_ARMORS = {
        7302, 7320,  # Ice Armor
        168, 7300, 7301  # Frost Armor
    }

    WARLOCK_ARMORS = {
        687, 696,  # Demon Skin
        706, 1086  # Demon Armor
    }

    groups = [PALADIN_AURAS, PALADIN_SEALS, WARLOCK_CURSES, MAGE_ARMORS, WARLOCK_ARMORS]

    @staticmethod
    def are_colliding_auras(spell_id_1: int, spell_id_2: int) -> bool:
        for group in AuraSourceRestrictions.groups:
            if spell_id_1 in group and spell_id_2 in group:
                return True
        return False


class CastPositionRestrictions:
    CASTABLE_FROM_BEHIND = {
        53, 2589, 2590, 2591, 7159, 7463,  # Backstab
        694, 7400, 7402,  # Punishing Blow
        6785, 6787, 6788, 6789,  # Rip and Tear
        2070, 6770,  # Sap
        5221, 6800,  # Suprise Attack
        6595  # Exploit Weakness
    }

    CASTABLE_FROM_FRONT = {
        1776, 1777,  # Gouge
        1966, 6768  # Feint
    }

    @staticmethod
    def is_position_correct(spell_id: int, facing_target: bool) -> bool:
        if spell_id in CastPositionRestrictions.CASTABLE_FROM_BEHIND:
            return not facing_target
        if spell_id in CastPositionRestrictions.CASTABLE_FROM_FRONT:
            return facing_target
        return True

    @staticmethod
    def is_from_behind(spell_id: int):
        return spell_id in CastPositionRestrictions.CASTABLE_FROM_BEHIND


class SummonedObjectPositions:
    # Vanilla has separate spell effects for different totem positions.
    # Shamans were still a work-in-progress in 0.5.3.
    TOTEM_INDICES_BY_TOOL = {
        5176: TotemSlots.TOTEM_SLOT_FIRE,
        5175: TotemSlots.TOTEM_SLOT_EARTH,
        5177: TotemSlots.TOTEM_SLOT_WATER,
        5178: TotemSlots.TOTEM_SLOT_AIR
    }

    FRONT_SUMMONED_OBJECTS = (
        36727,  # Ritual of Summoning
        29784,  # Basic Campfire
        31511  # Bright Campfire
    )

    @staticmethod
    def get_position_for_object(object_id, caster_location):
        if object_id in SummonedObjectPositions.FRONT_SUMMONED_OBJECTS:
            return SummonedObjectPositions.get_position_in_front(caster_location)
        return caster_location

    @staticmethod
    def get_position_for_totem(totem_tool_id, caster_location):
        totem_slot = SummonedObjectPositions.TOTEM_INDICES_BY_TOOL.get(totem_tool_id, -1)
        if totem_slot == -1:
            return caster_location

        totem_angle = math.pi / float(TotemSlots.MAX_TOTEM_SLOT) - (
                totem_slot * 2 * math.pi / float(TotemSlots.MAX_TOTEM_SLOT))

        return caster_location.get_point_in_radius_and_angle(2, totem_angle)

    @staticmethod
    def get_position_for_duel_flag(caster_location, target_location):
        return caster_location.get_point_in_middle(target_location)

    @staticmethod
    def get_position_in_front(caster_location):
        return caster_location.get_point_in_radius_and_angle(2, 0)


class ProfessionInfo:
    PROFESSION_MAX_SKILL_VALUES = {
        164: (2018, 3100, 3538),  # Blacksmithing
        165: (2108, 3104, 3811),  # Leatherworking
        171: (2259, 3101, 3464),  # Alchemy
        182: (2366, 2368, 3570),  # Herbalism
        185: (2550, 3102, 3413),  # Cooking
        186: (2575, 2576, 3564),  # Mining
        197: (3908, 3909, 3910),  # Tailoring
        202: (4036, 4037, 4038),  # Engineering
        333: (7411, 7412, 7413),  # Enchanting
        356: (7620, 7731, 7732)   # Fishing
    }

    @staticmethod
    def get_max_skill_value(profession_spell_id, player):
        prof_spells = ProfessionInfo.PROFESSION_MAX_SKILL_VALUES[profession_spell_id]
        known = player.spell_manager.spells.keys() & prof_spells
        if not known:
            return 0
        return (prof_spells.index(max(known)) + 1) * 75

    @staticmethod
    def get_profession_skill_id_for_spell(spell_id):
        for profession_spell_id, prof_spells in ProfessionInfo.PROFESSION_MAX_SKILL_VALUES.items():
            if spell_id in prof_spells:
                return profession_spell_id
        return 0


class SpellEffectMechanics:
    _MECHANIC_AURAS = {
        AuraTypes.SPELL_AURA_MOD_CHARM: SpellMechanic.MECHANIC_CHARM,
        AuraTypes.SPELL_AURA_MOD_DISARM: SpellMechanic.MECHANIC_DISARM,
        AuraTypes.SPELL_AURA_MOD_FEAR: SpellMechanic.MECHANIC_FEAR
    }

    # Sleep uses stun but is a distinct mechanic; use IDs instead.
    _SLEEP_MECHANIC_SPELLS = (700, 1090, 2937)

    @staticmethod
    def get_mechanic_for_aura_effect(aura_type, spell_id) -> Optional[SpellMechanic]:
        if not aura_type:
            return None

        if aura_type in SpellEffectMechanics._MECHANIC_AURAS:
            return SpellEffectMechanics._MECHANIC_AURAS[aura_type]

        return SpellMechanic.MECHANIC_SLEEP if \
            spell_id in SpellEffectMechanics._SLEEP_MECHANIC_SPELLS else None
