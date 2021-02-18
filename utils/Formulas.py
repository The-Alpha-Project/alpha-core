class PlayerFormulas(object):
    _BASE_MANA_REGEN_TABLE = [
        0.020979, 0.020515, 0.020079, 0.019516, 0.018997, 0.018646, 0.018314, 0.017997, 0.017584, 0.017197, 0.016551,
        0.015729, 0.015229, 0.014580, 0.014008, 0.013650, 0.011840, 0.013175, 0.012832, 0.012475, 0.012073, 0.011494,
        0.011292, 0.010990, 0.010761, 0.010546, 0.010321, 0.010151, 0.009949, 0.009740, 0.009597, 0.009425, 0.009278,
        0.009123, 0.008974, 0.008847, 0.008698, 0.008581, 0.008457, 0.008338, 0.008235, 0.008113, 0.008018, 0.007906,
        0.007798, 0.007713, 0.007612, 0.007524, 0.007430, 0.007340, 0.007268, 0.007184, 0.007116, 0.007029, 0.006945,
        0.006884, 0.006805, 0.006747, 0.006667, 0.006600
    ]

    @staticmethod
    def base_mana_regen(level):
        if level > 60:
            level = 60
        return PlayerFormulas._BASE_MANA_REGEN_TABLE[level - 1]

    @staticmethod
    def rage_conversion_value(level):
        return 0.0091107836 * level ** 2 + 3.225598133 * level + 4.2652911

    @staticmethod
    def zero_difference_value(level):
        if level < 8:
            return 5
        if level < 10:
            return 6
        if level < 12:
            return 7
        if level < 16:
            return 8
        if level < 20:
            return 9
        if level < 30:
            return 11
        if level < 40:
            return 12
        if level < 45:
            return 13
        if level < 50:
            return 15
        if level < 55:
            return 16
        return 17

    # Basic amount of XP earned for killing a mob of level equal to the character
    @staticmethod
    def base_xp_per_mob(level):
        return 45 + (5 * level)

    # XP = ((8 × Level) + Diff(Level)) × MXP(Level)
    @staticmethod
    def xp_to_level(level):
        if level > 31:
            diff = 5 * (level - 30)
        elif level == 31:
            diff = 6
        elif level == 30:
            diff = 3
        elif level == 29:
            diff = 1
        else:
            diff = 0

        # Always round to the nearest hundred
        return int(round(((8 * level) + diff) * PlayerFormulas.base_xp_per_mob(level), -2))
