from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker

from database.realm.RealmModels import *
from utils.ConfigManager import *


realm_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.realm_db))
SessionHolder = sessionmaker(bind=realm_db_engine)
realm_session = SessionHolder()


class RealmDatabaseManager(object):
    @staticmethod
    def load_tables():
        realm_session.add_all(realm_session.query(Account))
        realm_session.add_all(realm_session.query(Character))
        realm_session.add_all(realm_session.query(CharacterInventory))
        realm_session.add_all(realm_session.query(CharacterSocial))
        realm_session.add_all(realm_session.query(Ticket))

    # Account stuff

    @staticmethod
    def account_try_login(username, password):
        account = realm_session.query(Account).filter_by(name=username).first()
        if account:
            if account.password == password:
                return 1, account
            else:
                return 0, None
        return -1, None

    @staticmethod
    def account_get_characters(account_id):
        characters = realm_session.query(Character).filter_by(account=account_id).all()
        return characters if characters else []

    # Character stuff

    @staticmethod
    def character_get_next_available_guid():
        max_id = realm_session.query(func.max(Character.guid)).scalar()
        return max_id + 1 if max_id else 1

    @staticmethod
    def character_get_by_guid(guid):
        return realm_session.query(Character).filter_by(guid=guid).first()

    @staticmethod
    def character_does_name_exist(name_to_check):
        name = realm_session.query(Character.name).filter_by(name=name_to_check).first()
        return name is not None

    @staticmethod
    def character_create(character):
        realm_session.add(character)

    @staticmethod
    def character_delete(guid):
        char_to_delete = RealmDatabaseManager.character_get_by_guid(guid)
        if char_to_delete:
            realm_session.delete(char_to_delete)
            return 0
        Logger.error('Error deleting character with guid %s.' % guid)
        return -1
