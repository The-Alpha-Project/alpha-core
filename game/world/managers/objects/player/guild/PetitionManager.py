from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import Petition


class PetitionManager(object):
    PETITIONS = {}

    @staticmethod
    def create_petition(owner_guid, guild_name, petition_guid):
        petition = Petition()
        petition.petition_guid = petition_guid
        petition.owner_guid = owner_guid
        petition.name = guild_name

        RealmDatabaseManager.guild_petition_create(petition)

    @staticmethod
    def owns_petition(player_guid):
        return player_guid in PetitionManager.PETITIONS
