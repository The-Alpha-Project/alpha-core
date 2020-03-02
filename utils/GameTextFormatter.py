import re


class GameTextFormatter(object):

    @staticmethod
    def format(player_mgr, text):
        # TODO: Handle $G male:female
        text = GameTextFormatter.replace_all(text, '$B', '\n')
        text = GameTextFormatter.replace_all(text, '$N', player_mgr.player.name)
        text = GameTextFormatter.replace_all(text, '$R', GameTextFormatter.race_to_text(player_mgr.player.race))
        text = GameTextFormatter.replace_all(text, '$C', GameTextFormatter.class_to_text(player_mgr.player.class_))

        return text

    @staticmethod
    def class_to_text(class_):
        if class_ == 1:
            return 'Warrior'
        elif class_ == 2:
            return 'Paladin'
        elif class_ == 3:
            return 'Hunter'
        elif class_ == 4:
            return 'Rogue'
        elif class_ == 5:
            return 'Priest'
        elif class_ == 7:
            return 'Shaman'
        elif class_ == 8:
            return 'Mage'
        elif class_ == 9:
            return 'Warlock'
        elif class_ == 11:
            return 'Druid'
        return ''

    @staticmethod
    def race_to_text(race):
        if race == 1:
            return 'Human'
        elif race == 2:
            return 'Orc'
        elif race == 3:
            return 'Dwarf'
        elif race == 4:
            return 'Night Elf'
        elif race == 5:
            return 'Undead'
        elif race == 6:
            return 'Tauren'
        elif race == 7:
            return 'Gnome'
        elif race == 8:
            return 'Troll'
        return ''

    @staticmethod
    def replace_all(text, old, new):
        pattern = re.compile(re.escape(old), re.IGNORECASE)
        return re.sub(pattern, new, text)
