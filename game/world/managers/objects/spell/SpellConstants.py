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
