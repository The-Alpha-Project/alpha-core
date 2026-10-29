from random import choice

from database.dbc.DbcDatabaseManager import DbcDatabaseManager


class CreatureUtils:
    @staticmethod
    def generate_creature_display_id(creature_template):
        display_id_list = list(filter((0).__ne__, [creature_template.display_id1,
                                                   creature_template.display_id2,
                                                   creature_template.display_id3,
                                                   creature_template.display_id4]))
        # Some templates mix 0.5.3 display ids with later ones the client doesn't know, prefer the known ones.
        display_info_holder = DbcDatabaseManager.CreatureDisplayInfoHolder
        known_display_ids = [display_id for display_id in display_id_list
                             if display_info_holder.creature_display_info_get_by_id(display_id)]
        if known_display_ids:
            display_id_list = known_display_ids
        return choice(display_id_list) if len(display_id_list) > 0 else 4  # 4 = Shane Cube.
