class Proficiency(object):
    def __init__(self, min_level, acquire_method, item_class, item_subclass_mask):
        self.min_level = min_level
        self.acquire_method = acquire_method
        self.item_class = item_class
        self.item_subclass_mask = item_subclass_mask

    @staticmethod
    def build_from_chr_proficiency(chr_proficiency):
        proficiencies = []

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_1,
                        chr_proficiency.Proficiency_AcquireMethod_1,
                        chr_proficiency.Proficiency_ItemClass_1,
                        chr_proficiency.Proficiency_ItemSubClassMask_1,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_2,
                        chr_proficiency.Proficiency_AcquireMethod_2,
                        chr_proficiency.Proficiency_ItemClass_2,
                        chr_proficiency.Proficiency_ItemSubClassMask_2,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_3,
                        chr_proficiency.Proficiency_AcquireMethod_3,
                        chr_proficiency.Proficiency_ItemClass_3,
                        chr_proficiency.Proficiency_ItemSubClassMask_3,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_4,
                        chr_proficiency.Proficiency_AcquireMethod_4,
                        chr_proficiency.Proficiency_ItemClass_4,
                        chr_proficiency.Proficiency_ItemSubClassMask_4,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_5,
                        chr_proficiency.Proficiency_AcquireMethod_5,
                        chr_proficiency.Proficiency_ItemClass_5,
                        chr_proficiency.Proficiency_ItemSubClassMask_5,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_6,
                        chr_proficiency.Proficiency_AcquireMethod_6,
                        chr_proficiency.Proficiency_ItemClass_6,
                        chr_proficiency.Proficiency_ItemSubClassMask_6,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_7,
                        chr_proficiency.Proficiency_AcquireMethod_7,
                        chr_proficiency.Proficiency_ItemClass_7,
                        chr_proficiency.Proficiency_ItemSubClassMask_7,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_8,
                        chr_proficiency.Proficiency_AcquireMethod_8,
                        chr_proficiency.Proficiency_ItemClass_8,
                        chr_proficiency.Proficiency_ItemSubClassMask_8,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_9,
                        chr_proficiency.Proficiency_AcquireMethod_9,
                        chr_proficiency.Proficiency_ItemClass_9,
                        chr_proficiency.Proficiency_ItemSubClassMask_9,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_10,
                        chr_proficiency.Proficiency_AcquireMethod_10,
                        chr_proficiency.Proficiency_ItemClass_10,
                        chr_proficiency.Proficiency_ItemSubClassMask_10,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_11,
                        chr_proficiency.Proficiency_AcquireMethod_11,
                        chr_proficiency.Proficiency_ItemClass_11,
                        chr_proficiency.Proficiency_ItemSubClassMask_11,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_12,
                        chr_proficiency.Proficiency_AcquireMethod_12,
                        chr_proficiency.Proficiency_ItemClass_12,
                        chr_proficiency.Proficiency_ItemSubClassMask_12,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_13,
                        chr_proficiency.Proficiency_AcquireMethod_13,
                        chr_proficiency.Proficiency_ItemClass_13,
                        chr_proficiency.Proficiency_ItemSubClassMask_13,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_14,
                        chr_proficiency.Proficiency_AcquireMethod_14,
                        chr_proficiency.Proficiency_ItemClass_14,
                        chr_proficiency.Proficiency_ItemSubClassMask_14,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_15,
                        chr_proficiency.Proficiency_AcquireMethod_15,
                        chr_proficiency.Proficiency_ItemClass_15,
                        chr_proficiency.Proficiency_ItemSubClassMask_15,
                        )
        )

        proficiencies.append(
            Proficiency(chr_proficiency.Proficiency_MinLevel_16,
                        chr_proficiency.Proficiency_AcquireMethod_16,
                        chr_proficiency.Proficiency_ItemClass_16,
                        chr_proficiency.Proficiency_ItemSubClassMask_16,
                        )
        )

        return proficiencies

