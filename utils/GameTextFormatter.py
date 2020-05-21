from utils.constants.UnitCodes import Genders


class GameTextFormatter(object):

    @staticmethod
    def format(player_mgr, text):
        # TODO: Maybe there's a more efficient way of doing this. :P
        if '$G' in text or '$g' in text:
            text = text.replace('$G', '$g')
            tmp_text = text
            for i in range(len(text)):
                if text[i] == '$' and i + 1 < len(text) and text[i + 1] == 'g':
                    next_terminator = text.find(';', i)
                    subs = text[i: next_terminator + 1].strip()
                    tmp_list_data = subs.replace('$g', '').replace(';', '').split(':')
                    tmp_text = tmp_text.replace(subs, tmp_list_data[player_mgr.player.gender].strip())
            text = tmp_text

        return text \
            .replace('$B', '\n') \
            .replace('$b', '\n') \
            .replace('$N', player_mgr.player.name) \
            .replace('$n', player_mgr.player.name) \
            .replace('$R', GameTextFormatter.race_to_text(player_mgr.player.race)) \
            .replace('$r', GameTextFormatter.race_to_text(player_mgr.player.race).lower()) \
            .replace('$C', GameTextFormatter.class_to_text(player_mgr.player.class_)) \
            .replace('$c', GameTextFormatter.class_to_text(player_mgr.player.class_).lower())

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
