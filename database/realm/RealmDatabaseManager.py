from sqlalchemy import create_engine
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
                return 1
            else:
                return 0
        return -1