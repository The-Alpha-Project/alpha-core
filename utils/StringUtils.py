from difflib import get_close_matches


TRUE_STRINGS = {'1', 'true', 'on', 'yes', 'enable', 'enabled'}
FALSE_STRINGS = {'0', 'false', 'off', 'no', 'disable', 'disabled'}


def normalize_name(value):
    return str(value).strip().upper().replace('-', '_').replace(' ', '_')


def parse_bool(value):
    normalized = str(value).strip().lower()
    if normalized in TRUE_STRINGS:
        return True
    if normalized in FALSE_STRINGS:
        return False
    return None


def find_closest_match(value, names, prefixes=None):
    normalized = normalize_name(value)
    if not normalized:
        return None

    names = list(names)
    if normalized in names:
        return normalized

    if prefixes:
        for prefix in prefixes:
            candidate = f'{prefix}{normalized}'
            if candidate in names:
                return candidate

    alias_map = {name: name for name in names}
    if prefixes:
        for name in names:
            for prefix in prefixes:
                if name.startswith(prefix):
                    alias_map[name.replace(prefix, '', 1)] = name

    if normalized in alias_map:
        return alias_map[normalized]

    matches = get_close_matches(normalized, alias_map.keys(), n=1, cutoff=0.0)
    if not matches:
        return None
    return alias_map[matches[0]]
