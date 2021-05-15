from utils.Logger import Logger


class Faction_(object):
    def __init__(self, faction):
        self.faction_id = faction.ID
        self.faction = faction
        self.templates = {}
        self.enemies = []
        self.friends = []
        self.our_masks = 0
        self.friends_masks = 0
        self.enemies_masks = 0
        self.name = faction.Name_enUS
        self.reputation_index = faction.ReputationIndex
        self.reputation_base_value = faction.ReputationBase_1

    def has_template(self, id):
        return id in self.templates

class FactionManager(object):
    FACTIONS = {}

    @staticmethod
    def load_faction(faction):
        new_faction = Faction_(faction)

        for template in faction.faction_templates:
            new_faction.templates[template.ID] = template

            new_faction.our_masks |= template.FactionGroup
            new_faction.friends_masks |= template.FriendGroup
            new_faction.enemies_masks |= template.EnemyGroup

            new_faction.friends.append(template.Friend_1)
            new_faction.friends.append(template.Friend_2)
            new_faction.friends.append(template.Friend_3)
            new_faction.friends.append(template.Friend_4)

            new_faction.enemies.append(template.Enemies_1)
            new_faction.enemies.append(template.Enemies_2)
            new_faction.enemies.append(template.Enemies_3)
            new_faction.enemies.append(template.Enemies_4)

        new_faction.enemies = list(filter((0).__ne__, new_faction.enemies))
        new_faction.friends = list(filter((0).__ne__, new_faction.friends))

        FactionManager.FACTIONS[faction.ID] = new_faction

    @staticmethod
    def allegiance_status_checker(source_faction_id, target_faction_id, check_friendly=True):
        own_faction = FactionManager.get_by_faction_id(source_faction_id)
        target_faction = FactionManager.get_by_faction_id(target_faction_id)

        # Force lookup if we were unable to locate a direct faction.
        if not own_faction:
            own_faction = FactionManager.get_by_template_id(source_faction_id)
        if not target_faction:
            target_faction = FactionManager.get_by_template_id(target_faction_id)

        # Some units currently have a bugged faction, terminate the method if this is encountered
        if not own_faction or not target_faction:
            Logger.warning(f'Unable to compare factions. {source_faction_id} vs {target_faction_id}')
            return False

        if own_faction.faction_id in target_faction.enemies:
            return not check_friendly
        elif target_faction.faction_id in own_faction.friends:
            return check_friendly

        if check_friendly:
            return ((own_faction.friends_masks & target_faction.our_masks) or (own_faction.our_masks & target_faction.friends_masks)) != 0
        else:
            return ((own_faction.enemies_masks & target_faction.our_masks) or (own_faction.our_masks & target_faction.enemies_masks)) != 0

    @staticmethod
    def get_by_reputation_index(index):
        for faction in FactionManager.FACTIONS.values():
            if faction.reputation_index == index and index > -1:
                return faction
        return None

    @staticmethod
    def get_by_faction_id(id):
        if id in FactionManager.FACTIONS:
            return FactionManager.FACTIONS[id]
        return None

    @staticmethod
    def get_by_template_id(template_id):
        for faction in FactionManager.FACTIONS.values():
            if template_id in faction.templates:
                return faction
        return None
