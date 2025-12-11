class Stat:
    def __init__(self, stat_type, value):
        self.stat_type = stat_type
        self.value = value

    @staticmethod
    def generate_stat_list(item_template):
        return [
            Stat(item_template.stat_type1, item_template.stat_value1),
            Stat(item_template.stat_type2, item_template.stat_value2),
            Stat(item_template.stat_type3, item_template.stat_value3),
            Stat(item_template.stat_type4, item_template.stat_value4),
            Stat(item_template.stat_type5, item_template.stat_value5),
            Stat(item_template.stat_type6, item_template.stat_value6),
            Stat(item_template.stat_type7, item_template.stat_value7),
            Stat(item_template.stat_type8, item_template.stat_value8),
            Stat(item_template.stat_type9, item_template.stat_value9),
            Stat(item_template.stat_type10, item_template.stat_value10)
        ]


class DamageStat:
    def __init__(self, minimum, maximum, stat_type):
        self.minimum = minimum
        self.maximum = maximum
        self.stat_type = stat_type

    @staticmethod
    def generate_damage_stat_list(item_template):
        return [
            DamageStat(item_template.dmg_min1, item_template.dmg_max1, item_template.dmg_type1),
            DamageStat(item_template.dmg_min2, item_template.dmg_max2, item_template.dmg_type2),
            DamageStat(item_template.dmg_min3, item_template.dmg_max3, item_template.dmg_type3),
            DamageStat(item_template.dmg_min4, item_template.dmg_max4, item_template.dmg_type4),
            DamageStat(item_template.dmg_min5, item_template.dmg_max5, item_template.dmg_type5)
        ]


class SpellStat:
    def __init__(self, spell_id, trigger, charges, cooldown, category, category_cooldown):
        self.spell_id = spell_id
        self.trigger = trigger
        self.charges = charges
        self.cooldown = cooldown
        self.category = category
        self.category_cooldown = category_cooldown

    @staticmethod
    def generate_spell_stat_list(item_template):
        return [
            SpellStat(item_template.spellid_1, item_template.spelltrigger_1, item_template.spellcharges_1,
                      item_template.spellcooldown_1, item_template.spellcategory_1,
                      item_template.spellcategorycooldown_1),
            SpellStat(item_template.spellid_2, item_template.spelltrigger_2, item_template.spellcharges_2,
                      item_template.spellcooldown_2, item_template.spellcategory_2,
                      item_template.spellcategorycooldown_2),
            SpellStat(item_template.spellid_3, item_template.spelltrigger_3, item_template.spellcharges_3,
                      item_template.spellcooldown_3, item_template.spellcategory_3,
                      item_template.spellcategorycooldown_3),
            SpellStat(item_template.spellid_4, item_template.spelltrigger_4, item_template.spellcharges_4,
                      item_template.spellcooldown_4, item_template.spellcategory_4,
                      item_template.spellcategorycooldown_4),
            SpellStat(item_template.spellid_5, item_template.spelltrigger_5, item_template.spellcharges_5,
                      item_template.spellcooldown_5, item_template.spellcategory_5,
                      item_template.spellcategorycooldown_5)
        ]
