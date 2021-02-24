import math


class CreatureFormulas(object):

    @staticmethod
    def xp_reward(creature_level, player_level, is_elite=False):
        if player_level == 60:
            return 0

        gray_level = 0
        if 5 < player_level < 50:
            gray_level = int(player_level - math.floor(player_level / 10.0) - 5)
        elif player_level == 50:
            gray_level = 40
        elif 50 < player_level < 60:
            gray_level = int(player_level - math.floor(player_level / 5.0) - 1)

        if creature_level <= gray_level:
            return 0

        base_xp = PlayerFormulas.base_xp_per_mob(player_level)
        multiplier = 2 if (is_elite and creature_level < player_level <= 4) else 1
        if player_level < creature_level:
            if creature_level - player_level > 4:
                player_level = creature_level - 4  # Red mobs cap out at the same experience as orange ones
            base_xp = int(base_xp * (1 + (0.05 * (creature_level - player_level))))
        elif player_level > creature_level:
            base_xp = int(base_xp * (1 - (player_level - creature_level) /
                                     PlayerFormulas.zero_difference_value(player_level)))

        return base_xp * multiplier


class UnitFormulas(object):

    # Taken from the 0.5.3 client
    @staticmethod
    def interactable_distance(weapon_reach, combat_reach, target_weapon_reach, target_combat_reach):
        return (weapon_reach + combat_reach + target_weapon_reach + target_combat_reach + 1.3333334) * 1.05 * 0.89999998


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
