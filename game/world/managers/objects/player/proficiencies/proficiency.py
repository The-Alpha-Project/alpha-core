class Proficiency(object):
    def __init__(self, min_level, acquire_method, item_class, item_subclass_mask):
        self.min_level = min_level
        self.acquire_method = acquire_method
        self.item_class = item_class
        self.item_subclass_mask = item_subclass_mask

    @staticmethod
    def build_from_chr_proficiency(chr_proficiency):
        proficiencies = [
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_1,
                chr_proficiency.Proficiency_AcquireMethod_1,
                chr_proficiency.Proficiency_ItemClass_1,
                chr_proficiency.Proficiency_ItemSubClassMask_1
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_2,
                chr_proficiency.Proficiency_AcquireMethod_2,
                chr_proficiency.Proficiency_ItemClass_2,
                chr_proficiency.Proficiency_ItemSubClassMask_2
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_3,
                chr_proficiency.Proficiency_AcquireMethod_3,
                chr_proficiency.Proficiency_ItemClass_3,
                chr_proficiency.Proficiency_ItemSubClassMask_3
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_4,
                chr_proficiency.Proficiency_AcquireMethod_4,
                chr_proficiency.Proficiency_ItemClass_4,
                chr_proficiency.Proficiency_ItemSubClassMask_4
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_5,
                chr_proficiency.Proficiency_AcquireMethod_5,
                chr_proficiency.Proficiency_ItemClass_5,
                chr_proficiency.Proficiency_ItemSubClassMask_5
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_6,
                chr_proficiency.Proficiency_AcquireMethod_6,
                chr_proficiency.Proficiency_ItemClass_6,
                chr_proficiency.Proficiency_ItemSubClassMask_6
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_7,
                chr_proficiency.Proficiency_AcquireMethod_7,
                chr_proficiency.Proficiency_ItemClass_7,
                chr_proficiency.Proficiency_ItemSubClassMask_7
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_8,
                chr_proficiency.Proficiency_AcquireMethod_8,
                chr_proficiency.Proficiency_ItemClass_8,
                chr_proficiency.Proficiency_ItemSubClassMask_8
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_9,
                chr_proficiency.Proficiency_AcquireMethod_9,
                chr_proficiency.Proficiency_ItemClass_9,
                chr_proficiency.Proficiency_ItemSubClassMask_9
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_10,
                chr_proficiency.Proficiency_AcquireMethod_10,
                chr_proficiency.Proficiency_ItemClass_10,
                chr_proficiency.Proficiency_ItemSubClassMask_10
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_11,
                chr_proficiency.Proficiency_AcquireMethod_11,
                chr_proficiency.Proficiency_ItemClass_11,
                chr_proficiency.Proficiency_ItemSubClassMask_11
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_12,
                chr_proficiency.Proficiency_AcquireMethod_12,
                chr_proficiency.Proficiency_ItemClass_12,
                chr_proficiency.Proficiency_ItemSubClassMask_12
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_13,
                chr_proficiency.Proficiency_AcquireMethod_13,
                chr_proficiency.Proficiency_ItemClass_13,
                chr_proficiency.Proficiency_ItemSubClassMask_13
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_14,
                chr_proficiency.Proficiency_AcquireMethod_14,
                chr_proficiency.Proficiency_ItemClass_14,
                chr_proficiency.Proficiency_ItemSubClassMask_14
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_15,
                chr_proficiency.Proficiency_AcquireMethod_15,
                chr_proficiency.Proficiency_ItemClass_15,
                chr_proficiency.Proficiency_ItemSubClassMask_15
                ),
            Proficiency(
                chr_proficiency.Proficiency_MinLevel_16,
                chr_proficiency.Proficiency_AcquireMethod_16,
                chr_proficiency.Proficiency_ItemClass_16,
                chr_proficiency.Proficiency_ItemSubClassMask_16
                )
        ]

        return proficiencies

