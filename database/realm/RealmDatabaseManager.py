from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.realm.RealmModels import *
from utils.ConfigManager import *
from game.realm.AccountManager import AccountManager


realm_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.realm_db))
SessionHolder = scoped_session(sessionmaker(bind=realm_db_engine))
realm_db_session = SessionHolder()
# To always keep the db data in memory
realm_db_session.expire_on_commit = False


class RealmDatabaseManager(object):
    @staticmethod
    def load_tables():
        realm_db_session.add_all(realm_db_session.query(Account))
        realm_db_session.add_all(realm_db_session.query(Character))
        realm_db_session.add_all(realm_db_session.query(CharacterInventory))
        realm_db_session.add_all(realm_db_session.query(CharacterSocial))
        realm_db_session.add_all(realm_db_session.query(Ticket))

    @staticmethod
    def save():
        try:
            realm_db_session.commit()
        except:
            realm_db_session.rollback()
            raise

    # Account stuff

    @staticmethod
    def account_try_login(username, password):
        account = realm_db_session.query(Account).filter_by(name=username).first()
        if account:
            if account.password == password:
                return 1, AccountManager(account)
            else:
                return 0, None
        return -1, None

    @staticmethod
    def account_create(username, password, ip):
        account = Account(name=username, password=password, ip=ip, gmlevel=0)
        realm_db_session.add(account)
        return AccountManager(account)

    @staticmethod
    def account_get_characters(account_id):
        characters = realm_db_session.query(Character).filter_by(account_id=account_id).all()
        return characters if characters else []

    # Character stuff

    @staticmethod
    def character_get_by_guid(guid):
        return realm_db_session.query(Character).filter_by(guid=guid).first()

    @staticmethod
    def character_does_name_exist(name_to_check):
        name = realm_db_session.query(Character.name).filter_by(name=name_to_check).first()
        return name is not None

    @staticmethod
    def character_create(character):
        realm_db_session.add(character)

    @staticmethod
    def character_delete(guid):
        char_to_delete = RealmDatabaseManager.character_get_by_guid(guid)
        if char_to_delete:
            realm_db_session.delete(char_to_delete)
            return 0
        return -1
