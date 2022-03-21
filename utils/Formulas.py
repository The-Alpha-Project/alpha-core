import math

from utils.constants.MiscCodes import AttackTypes
from utils.constants.SpellCodes import ShapeshiftForms

# Extracted from the 0.5.3 client as is.
class Distances(object):
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


class CreatureFormulas(object):

    @staticmethod
    def xp_reward(creature_level, player_level, is_elite=False):
        if player_level == 60:
            return 0

        gray_level = PlayerFormulas.get_gray_level(player_level)
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
    def interactable_distance(attacker, target):
        return (attacker.weapon_reach + attacker.combat_reach + target.weapon_reach + target.combat_reach + 1.3333334) * 1.05 * 0.89999998

    @staticmethod
    def combat_distance(attacker, target):
        # TODO: Find better formula?
        return UnitFormulas.interactable_distance(attacker, target) * 0.6


class PlayerFormulas(object):

    @staticmethod
    def rage_conversion_value(level):
        return 0.0091107836 * level ** 2 + 3.225598133 * level + 4.2652911

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
    def calculate_rage_regen_on_received_damage(damage_info):
        # Vanilla rage formula source http://blue.mmo-champion.com/topic/18325-the-new-rage-formula-by-kalgan/
        rage_gained = (damage_info.damage / PlayerFormulas.rage_conversion_value(damage_info.victim.level)) * 2.5

        # Berserker stance - generate 30% more rage
        if (damage_info.victim.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BERSERKERSTANCE)):
            rage_gained *= 1.3

        return int(rage_gained*10)

    @staticmethod
    def calculate_rage_regen(damage_info, is_player=True):
        # R=(15d/4c)+(fs/2) | d=WeaponDamage, c=rage conversion rate, f=hit rating, s=speed
        if is_player:
            main_hand = damage_info.attack_type == AttackTypes.BASE_ATTACK
            damage = damage_info.damage  # This is already calculated based off either Main or Offhand weapon.
            speed = damage_info.attacker.base_attack_time
            hit_rate = 3.5 if main_hand else 1.75

            if main_hand and damage_info.attacker.inventory.has_main_weapon():
                main_weapon = damage_info.attacker.inventory.get_main_hand()
                if main_weapon:
                    speed = main_weapon.item_template.delay
            elif damage_info.attacker.inventory.has_offhand_weapon():
                offhand = damage_info.attacker.inventory.get_offhand()
                if offhand:
                    speed = offhand.item_template.delay

            regen = ((15 * damage) / (4 * PlayerFormulas.rage_conversion_value(damage_info.attacker.level)) + (
                        (hit_rate * speed) / 2))
        else:
            regen = (2.5 * (damage_info.damage / PlayerFormulas.rage_conversion_value(damage_info.victim.level)))

        # Rage is measured 0 - 1000
        return int(regen / 100)

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
