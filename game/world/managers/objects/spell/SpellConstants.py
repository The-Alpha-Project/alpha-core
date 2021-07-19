from typing import Optional

from utils.constants.SpellCodes import ShapeshiftForms
from utils.constants.UnitCodes import Teams


class AuraDoseInfo:
    dose_info = {
        2537: 5,  # Crusader strike (Rank 1)
        7386: 5,  # Sundering Strike (Rank 1)
        7405: 5  # Sundering Strike (Rank 2)
    }
    @staticmethod
    def aura_can_stack(spell_id: int):
        return spell_id in AuraDoseInfo.dose_info

    @staticmethod
    def get_aura_max_stacks(spell_id: int):
        return AuraDoseInfo.dose_info.get(spell_id, 1)


class ShapeshiftInfo:
    # Alliance / Default display_id, Horde display_id, Scale
    shapeshift_model_ids = {
        ShapeshiftForms.SHAPESHIFT_FORM_CAT: (892, 892, 0.8),
        ShapeshiftForms.SHAPESHIFT_FORM_TREE: (864, 864, 1.0),
        ShapeshiftForms.SHAPESHIFT_FORM_AQUATIC: (2428, 2428, 0.8),
        ShapeshiftForms.SHAPESHIFT_FORM_BEAR: (2281, 2289, 1.0)
    }

    @staticmethod
    def get_form_model_info(form: ShapeshiftForms, faction: Teams):
        if form not in ShapeshiftInfo.shapeshift_model_ids:
            return 0, 0
        info = ShapeshiftInfo.shapeshift_model_ids.get(form)
        # For creatures default to Alliance form for now.
        return (info[1], info[2]) if faction == Teams.TEAM_HORDE else (info[0], info[2])


class AuraSourceRestrictions:
    # Exclusive aura groups don't seem to be labeled in spell.dbc.

    # Only one aura per paladin
    paladin_auras = {465, 643, 1032, 7362,  # Devotion Aura
                     649, 5606, 5609, 7331,  # Healing Aura
                     3487, 5618,  # Resistance Aura
                     7294}  # Retribution Aura

    paladin_seals = {94, 5645, 7325,  # Seal of Wisdom
                     636, 645, 6739,  # Seal of Might
                     648, 1034,  # Seal of Wrath
                     1022, 5599,  # Seal of Protection
                     1036,  # Seal of Fury
                     1038,  # Seal of Salvation
                     1052, 5601, 5602,  # Seal of Righteousness
                     6940}  # Seal of Sacrifice

    # "Only one Curse per Warlock can be active on any one target."
    warlock_curses = {702, 1108, 6205, 7646,  # Curse of Weakness
                      704, 7658, 7659,  # Curse of Recklessness
                      980, 1014, 6217,  # Curse of Agony
                      1490,  # Curse of the Elements
                      1714}  # Curse of Tongues

    groups = [paladin_auras, paladin_seals, warlock_curses]

    @staticmethod
    def are_colliding_auras(spell_id_1: int, spell_id_2: int) -> bool:
        for group in AuraSourceRestrictions.groups:
            if spell_id_1 in group and spell_id_2 in group:
                return True
        return False
