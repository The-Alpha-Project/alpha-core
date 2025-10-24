import re


ITEM_QUALITY_COLOR = {
    0: 'cff9d9d9d',
    1: 'cffffc600',
    2: 'cff1eff00',
    3: 'cff0070dd',
    4: 'cffa335ee',
    5: 'cffff0000',
    6: 'cfff1e38a'
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
    def format(unit_mgr, text):
        def g_replacer(match):
            parts = match.group(0).replace('$g', '').replace(';', '').split(':')
            return parts[unit_mgr.gender].strip()

        # Replace all $g...; placeholders.
        text = re.sub(r'\$g[^;]*;', g_replacer, text)

        replacements = {
            '$B': '\n', '$b': '\n',
            '$N': unit_mgr.get_name(),
            '$n': unit_mgr.get_name(),
            '$R': GameTextFormatter.race_to_text(unit_mgr.race),
            '$r': GameTextFormatter.race_to_text(unit_mgr.race).lower(),
            '$C': GameTextFormatter.class_to_text(unit_mgr.class_),
            '$c': GameTextFormatter.class_to_text(unit_mgr.class_).lower(),
        }
        return re.sub('|'.join(map(re.escape, replacements.keys())),
                      lambda m: replacements[m.group(0)], text)

    @staticmethod
    def class_to_text(class_):
        return CLASS_TEXT[class_]

    @staticmethod
    def race_to_text(race):
        return RACE_TEXT[race]

    @staticmethod
    def generate_item_link(entry, name, quality):
        color = ITEM_QUALITY_COLOR[quality]
        return f'|{color}|Hitem:{entry}|h[{name}]|h|r'


class TextChecker:

    @staticmethod
    def valid_text(text_, is_name=False, is_guild=False):
        stripped_text = text_.replace(' ', '')
        text_length = len(text_)
        stripped_text_length = len(stripped_text)

        # Null and emptiness checks
        if not text_ or stripped_text_length == 0:
            return False

        # Is text ascii?
        try:
            text_.encode('ascii')
        except (UnicodeEncodeError, UnicodeDecodeError):
            return False

        # Name specific checks
        if is_name:
            # Spaces are not allowed in names
            if text_length != stripped_text_length:
                return False

            # Make sure the name is between the allowed number of characters
            if text_length < 3 or text_length > 12:
                return False

            # Names are allowed to have ONE grave, removing it so it can pass the is_alpha check
            grave_count = text_.count('`')
            if grave_count == 1:
                text_ = text_.replace('`', '')
            elif grave_count > 1:
                return False

        if is_guild:
            # Don't allow spaces at the start or the end of the guild name.
            if text_[0] == ' ' or text_[-1] == ' ':
                return False

            # Make sure the name is between the allowed number of characters
            if text_length < 2 or text_length > 24:
                return False

            # Use the guild name without spaces to pass the isalpha() check.
            text_ = stripped_text

        # If all characters in the string are alphabets (can be both lowercase and uppercase)
        return text_.isalpha()
