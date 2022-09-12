from random import choice


class CreatureUtils:
    @staticmethod
    def generate_creature_display_id(creature_template):
        display_id_list = list(filter((0).__ne__, [creature_template.display_id1,
                                                   creature_template.display_id2,
                                                   creature_template.display_id3,
                                                   creature_template.display_id4]))
        return choice(display_id_list) if len(display_id_list) > 0 else 4  # 4 = Shane Cube.
