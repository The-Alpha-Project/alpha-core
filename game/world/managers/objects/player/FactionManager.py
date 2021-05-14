from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from utils.constants.ObjectCodes import FactionGroupType
from utils.constants.UnitCodes import Races

class Faction_(object):
    def __init__(self, faction):
        self.id = faction.ID
        self.faction = faction
        self.templates = []
        self.enemies = []
        self.friends = []
        self.faction_group = None
        self.friend_group = None
        self.enemy_group = None
        self.name = faction.Name_enUS
        self.reputation_index = faction.ReputationIndex
        self.reputation_base_value = faction.ReputationBase_1

    def has_template(self, id):
        return id in self.templates

    def is_friendly_to(self, faction):
        return self.faction_group == faction.faction_group

    def is_enemy_to(self, faction):
        return self.faction_group != faction.faction_group

class FactionManager(object):
    FACTIONS = {}

    @staticmethod
    def load_faction(faction):
        new_faction = Faction_(faction)

        faction_group = 0
        friend_group = 0
        enemy_group = 0

        for template in faction.faction_templates:
            new_faction.templates.append(template.ID)

            faction_group |= FactionManager._get_faction_group(template.FactionGroup)
            friend_group |= FactionManager._get_faction_group(template.FriendGroup)
            enemy_group |= FactionManager._get_faction_group(template.EnemyGroup)

            new_faction.friends.append(template.Friend_1)
            new_faction.friends.append(template.Friend_2)
            new_faction.friends.append(template.Friend_3)
            new_faction.friends.append(template.Friend_4)

            new_faction.enemies.append(template.Enemies_1)
            new_faction.enemies.append(template.Enemies_2)
            new_faction.enemies.append(template.Enemies_3)
            new_faction.enemies.append(template.Enemies_4)

        new_faction.faction_group = FactionManager._get_faction_group(faction_group)
        new_faction.friend_group = FactionManager._get_faction_group(friend_group)
        new_faction.enemy_group = FactionManager._get_faction_group(enemy_group)

        new_faction.enemies = list(filter((0).__ne__, new_faction.enemies))
        new_faction.friends = list(filter((0).__ne__, new_faction.friends))
        new_faction.friends.append(new_faction.id)

        FactionManager.FACTIONS[faction.ID] = new_faction

    @staticmethod
    def get_by_reputation_index(index):
        for faction in FactionManager.FACTIONS.values():
            if faction.reputation_index == index and index > -1:
                return faction
        return None

    @staticmethod
    def get_by_id(id):
        if id in FactionManager.FACTIONS:
            return FactionManager.FACTIONS[id]
        return None

    @staticmethod
    def get_by_template(template_id):
        for faction in FactionManager.FACTIONS.values():
            for template in faction.faction_templates:
                if template.ID == template_id:
                    return faction
        return None

    @staticmethod
    def get_by_race(race):
        if race <= Races.RACE_TAUREN:
            return FactionManager.FACTIONS[int(race)]
        elif race == Races.RACE_GNOME:
            return FactionManager.FACTIONS[115]
        elif race == Races.RACE_TROLL:
            return FactionManager.FACTIONS[116]
        else:
            return None

    @staticmethod
    def are_friendly(race1, race2):
        faction1 = FactionManager.get_by_race(race1)
        faction2 = FactionManager.get_by_race(race2)
        return faction1.is_friendly_to(faction2)

    @staticmethod
    def _get_faction_group(value):
        if value == 0:
            val = FactionGroupType.Default
        elif value > FactionGroupType.Alliance and value < FactionGroupType.Horde:
            val = FactionGroupType.Alliance
        elif value > FactionGroupType.Horde and value < FactionGroupType.Monster:
            val = FactionGroupType.Horde
        elif value > FactionGroupType.Monster:
            val = FactionGroupType.Monster
        else:
            val = FactionGroupType(value)

        return val