class PlayerFormulas(object):

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

    @staticmethod
    def talent_points_gain_per_level(level):
        return 10 + (int(level / 10) * 5)

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
        return int(round(((8 * level) + diff) * PlayerFormulas.base_xp_per_mob(level) + 1, -2))
