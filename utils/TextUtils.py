ITEM_QUALITY_COLOR = {
    0: 'cff9d9d9d',
    1: 'cffffd200',
    2: 'cff1eff00',
    3: 'cff0070dd',
    4: 'cffa335ee',
    5: 'cffff8000',
    6: 'cffe6cc80'
}

CLASS_TEXT = {
    1: 'Warrior',
    2: 'Paladin',
    3: 'Hunter',
    4: 'Rogue',
    5: 'Priest',
    7: 'Shaman',
    8: 'Mage',
    9: 'Warlock',
    11: 'Druid'
}

RACE_TEXT = {
    1: 'Human',
    2: 'Orc',
    3: 'Dwarf',
    4: 'Night Elf',
    5: 'Undead',
    6: 'Tauren',
    7: 'Gnome',
    8: 'Troll'
}


class GameTextFormatter:

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
        return CLASS_TEXT[class_]

    @staticmethod
    def race_to_text(race):
        return RACE_TEXT[race]

    @staticmethod
    def generate_item_link(entry, name, quality):
        color = ITEM_QUALITY_COLOR[quality]
        return '|%s|Hitem:%u|h[%s]|h|r' % (color, entry, name)


class TextChecker:

    @staticmethod
    def valid_text(text_, is_name=False):
        # Null and emptiness checks
        if not text_ or text_.strip() == '':
            return False

        # Is text ascii?
        try:
            text_.encode('ascii')
        except UnicodeDecodeError:
            return False

        text_length = len(text_)

        # Name specific checks
        if is_name:
            if text_length < 3 or text_length > 12:
                return False

            # Names are allowed to have ONE grave, removing it so it can pass the is_alpha check
            grave_count = text_.count('`')
            if grave_count == 1:
                text_ = text_.replace('`', '')
            elif grave_count > 1:
                return False

        # If all characters in the string are alphabets (can be both lowercase and uppercase)
        return text_.isalpha()
