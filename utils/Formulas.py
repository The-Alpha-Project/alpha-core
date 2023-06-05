import math
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from utils.constants.MiscCodes import ReputationSourceGain


class Distances:
    # Extracted from the 0.5.3 client as is.
    MAX_DUEL_DISTANCE = 10.0
    MAX_TRADE_DISTANCE = 11.111111
    MAX_SHOP_DISTANCE = 5.5555553
    MAX_INSPECT_DISTANCE = 5.5555553
    MAX_LOOT_DISTANCE = 5.0
    MAX_BIND_DISTANCE = 10.0
    MAX_BIND_RADIUS_CHECK = MAX_BIND_DISTANCE * 1.5  # Taken from CGPlayer_C::DeathBindDistanceCompare
    MAX_SITCHAIR_DISTANCE = 0.5
    MAX_SITCHAIRUSE_DISTANCE = 3.0
    MAX_SHARE_DISTANCE = 100.0
    SPELL_FOCUS_DISTANCE = 50.0
    MAX_OBJ_INTEREST_RADIUS = 100.0
    # End of distances extracted from the client.

    # Other distances (not extracted from the client).
    CREATURE_EVADE_DISTANCE = 65.0  # Guessed (Spell Range 'Extra Long Range' + 5).
    GROUP_SHARING_DISTANCE = 74.0  # Used for XP, loot, reputation...


class CreatureFormulas:

    @staticmethod
    def xp_reward(creature_level, player_level, is_elite=False):
        if player_level >= 60:
            return 0

        gray_level = PlayerFormulas.get_gray_level(player_level)
        if creature_level <= gray_level:
            return 0

        base_xp = PlayerFormulas.base_xp_per_mob(player_level)
        multiplier = 2 if is_elite else 1
        if player_level < creature_level:
            if creature_level - player_level > 4:
                player_level = creature_level - 4  # Red mobs cap out at the same experience as orange ones.
            base_xp = int(base_xp * (1 + (0.05 * (creature_level - player_level))))
        elif player_level > creature_level:
            base_xp = int(base_xp * (1 - (player_level - creature_level) /
                                     PlayerFormulas.zero_difference_value(player_level)))

        return base_xp * multiplier


class UnitFormulas(object):

    @staticmethod
    def get_reach_for_weapon(item_template):
        # The weapon reach unit field was removed in patch 0.10.
        # We use swing reach for now.
        item_info = DbcDatabaseManager.item_get_subclass_info_by_class_and_subclass(item_template.class_, item_template.subclass)
        if item_info:
            return item_info.WeaponSwingSize
        return 0

    @staticmethod
    def calculate_max_health_and_max_power(creature_mgr, level):
        c_template = creature_mgr.creature_template
        rel_level = 0
        if c_template.level_max != c_template.level_min:
            rel_level = ((level - c_template.level_min) / (c_template.level_max - c_template.level_min))
        max_health = c_template.health_min + int(rel_level * (c_template.health_max - c_template.health_min))
        max_power1 = c_template.mana_min + int(rel_level * (c_template.mana_max - c_template.mana_min))
        return max_health, max_power1

    # Taken from the 0.5.3 client
    @staticmethod
    def interactable_distance(attacker, target):
        return (attacker.weapon_reach + attacker.combat_reach + target.weapon_reach + target.combat_reach + 1.3333334) * 1.05 * 0.89999998

    @staticmethod
    def combat_distance(attacker, target):
        # TODO: Find better formula?
        return UnitFormulas.interactable_distance(attacker, target) * 0.5

    @staticmethod
    def rage_conversion_value(level):
        return 0.0091107836 * level ** 2 + 3.225598133 * level + 4.2652911

    @staticmethod
    def calculate_rage_regen(damage_info, is_attacking=True):
        # "Rage Conversion Value (note: this number is derived from other values within the game such as a mob's hit
        # points and a warrior's expected damage value against that mob)." We use an approximation.
        # Rage Gained from dealing damage = (Damage Dealt) / (Rage Conversion at Your Level) * 7.5
        # Rage Gained for taking damage = (Damage Taken) / (Rage Conversion at Your Level) * 2.5
        #
        # Source: https://www.bluetracker.gg/wow/topic/eu-en/83678537-the-new-rage-formula-by-kalgan/
        if is_attacking:
            level = damage_info.attacker.level
            factor = 7.5
        else:
            level = damage_info.target.level
            factor = 2.5

        # Get rage regen value based on supplied variables.
        regen = (damage_info.total_damage / UnitFormulas.rage_conversion_value(level)) * factor
        # Rage is measured 0 - 1000, multiply it by 10.
        return int(regen * 10)


class PlayerFormulas:

    @staticmethod
    def calculate_reputation_gain(player, reputation_source, reputation_qty, creature_or_quest_level):
        percent = 100.0
        config_rate_reputation_gain = 1.0  # TODO: configurable.
        diff_level = 0

        if reputation_source == ReputationSourceGain.REPUTATION_SOURCE_KILL:
            rate = 1.0  # TODO: configurable.
        elif reputation_source == ReputationSourceGain.REPUTATION_SOURCE_QUEST:
            rate = 1.0  # TODO: configurable.
            if player.level >= creature_or_quest_level + 5:
                diff_level = player.level - creature_or_quest_level - 5
            else:
                diff_level = 0
        else:
            rate = 1.0

        if diff_level == 0:
            diff_level_rate = 1.0
        elif diff_level == 1:
            diff_level_rate = 0.8
        elif diff_level == 2:
            diff_level_rate = 0.6
        elif diff_level == 3:
            diff_level_rate = 0.4
        else:
            diff_level_rate = 0.2

        if reputation_source == ReputationSourceGain.REPUTATION_SOURCE_QUEST:
            percent += diff_level_rate

        if rate != 1.0 and creature_or_quest_level <= PlayerFormulas.get_gray_level(player.level):
            percent *= rate

        if percent <= 0:
            return 0

        return int(round(config_rate_reputation_gain * reputation_qty * percent / 100.0))

    @staticmethod
    def get_gray_level(player_level):
        gray_level = 0
        if 5 < player_level < 50:
            gray_level = int(player_level - math.floor(player_level / 10.0) - 5)
        elif player_level == 50:
            gray_level = 40
        elif 50 < player_level < 60:
            gray_level = int(player_level - math.floor(player_level / 5.0) - 1)

        return gray_level

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

    @staticmethod
    def skill_points_gain_per_level(level):
        return 2 if level % 10 == 0 else 1

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

    @staticmethod
    def quest_xp_reward(quest_level, player_level, rew_xp):
        if player_level <= quest_level + 5:
            return rew_xp
        elif player_level == quest_level + 6:
            return math.ceil(rew_xp * 0.8)
        elif player_level == quest_level + 7:
            return math.ceil(rew_xp * 0.6)
        elif player_level == quest_level + 8:
            return math.ceil(rew_xp * 0.4)
        elif player_level == quest_level + 9:
            return math.ceil(rew_xp * 0.2)
        else:
            return math.ceil(rew_xp * 0.1)
