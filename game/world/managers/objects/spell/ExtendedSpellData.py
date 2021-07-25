from typing import Optional

from utils.constants.SpellCodes import ShapeshiftForms
from utils.constants.UnitCodes import Teams


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
        ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
        ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0)
    }

    @staticmethod
    def get_form_model_info(form: ShapeshiftForms, faction: Teams):
        if form not in ShapeshiftInfo.SHAPESHIFT_MODELS:
            return 0, 0
        info = ShapeshiftInfo.SHAPESHIFT_MODELS.get(form)
        # For creatures default to Alliance form for now.
        return (info[1], info[2]) if faction == Teams.TEAM_HORDE else (info[0], info[2])


class AuraSourceRestrictions:
    # Exclusive aura groups don't seem to be labeled in spell.dbc.

    # Only one aura per paladin
    PALADIN_AURAS = {465, 643, 1032, 7362,  # Devotion Aura
                     649, 5606, 5609, 7331,  # Healing Aura
                     3487, 5618,  # Resistance Aura
                     7294}  # Retribution Aura

    PALADIN_SEALS = {94, 5645, 7325,  # Seal of Wisdom
                     636, 645, 6739,  # Seal of Might
                     648, 1034,  # Seal of Wrath
                     1022, 5599,  # Seal of Protection
                     1036,  # Seal of Fury
                     1038,  # Seal of Salvation
                     1052, 5601, 5602,  # Seal of Righteousness
                     6940}  # Seal of Sacrifice

    # "Only one Curse per Warlock can be active on any one target."
    WARLOCK_CURSES = {702, 1108, 6205, 7646,  # Curse of Weakness
                      704, 7658, 7659,  # Curse of Recklessness
                      980, 1014, 6217,  # Curse of Agony
                      1490,  # Curse of the Elements
                      1714}  # Curse of Tongues

    groups = [PALADIN_AURAS, PALADIN_SEALS, WARLOCK_CURSES]

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
