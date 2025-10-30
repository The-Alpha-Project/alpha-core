import hashlib

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

from database.auth.AuthModels import RealmList, Account
from game.realm.AccountManager import AccountManager
from utils.ConfigManager import *

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.Auth.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.Auth.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.Auth.host)
DB_PORT = os.getenv('MYSQL_TCP_PORT', config.Database.Auth.port)
DB_AUTH_NAME = config.Database.Auth.db_name

auth_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_AUTH_NAME}?charset=utf8mb4',
                               pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=auth_db_engine, autoflush=False))


class AuthDatabaseManager(object):
    # Realm.

    @staticmethod
    def realm_get_list():
        auth_db_session = SessionHolder()
        realm = auth_db_session.query(RealmList).all()
        auth_db_session.close()
        return realm
    
    @staticmethod
    def realm_clear_online_count():
        auth_db_session = SessionHolder()
        auth_db_session.query(RealmList).update({RealmList.online_player_count: 0})
        auth_db_session.flush()
        auth_db_session.commit()
        auth_db_session.close()
    
    @staticmethod
    def realm_set_online_player_count(realm_id, player_count):
        auth_db_session = SessionHolder()
        realmlist_entry = auth_db_session.query(RealmList).filter_by(realm_id=realm_id).first()
        realmlist_entry.online_player_count = player_count
        auth_db_session.flush()
        auth_db_session.commit()
        auth_db_session.close()

    @staticmethod
    def realm_get_online_player_count(realm_id):
        auth_db_session = SessionHolder()
        realmlist_entry = auth_db_session.query(RealmList).filter_by(realm_id=realm_id).first()
        auth_db_session.close()
        return realmlist_entry.online_player_count
    
    # Account.

    @staticmethod
    def account_try_get(username):
        auth_db_session = SessionHolder()
        account_mgr = None
        account = auth_db_session.query(Account).filter_by(name=username).first()
        if account:
            account_mgr = AccountManager(account)
        auth_db_session.close()
        return account_mgr

    @staticmethod
    def account_try_login(username, password, ip, client_digest, server_digest):
        auth_db_session = SessionHolder()
        account = auth_db_session.query(Account).filter_by(name=username).first()
        status = -1
        account_mgr = None
        if account:
            if (password and account.password == password) or (client_digest and client_digest == server_digest):
                status = 1
                account.ip = ip
                account_mgr = AccountManager(account)

                auth_db_session.flush()
                auth_db_session.commit()
                auth_db_session.refresh(account)
            else:
                status = 0
        auth_db_session.close()

        return status, account_mgr

    @staticmethod
    def account_create(username, password, ip, salt, verifier):
        auth_db_session = SessionHolder()
        account = Account(name=username, password=password, ip=ip,
                          gmlevel=int(config.Server.Settings.auto_create_gm_accounts),
                          salt=salt,
                          verifier=verifier,
                          sessionkey=""
                          )
        auth_db_session.add(account)
        auth_db_session.flush()
        auth_db_session.commit()
        auth_db_session.refresh(account)
        auth_db_session.close()
        return AccountManager(account)

    @staticmethod
    def account_try_update_session_key(username, session_key):
        auth_db_session = SessionHolder()
        try:
            account = auth_db_session.query(Account).filter_by(name=username).first()
            if not account:
                return False

            account.sessionkey = session_key

            auth_db_session.merge(account)
            auth_db_session.flush()
            auth_db_session.commit()
        finally:
            auth_db_session.close()

        return True

    @staticmethod
    def account_try_update_password(username, old_password, new_password):
        auth_db_session = SessionHolder()
        try:
            account = auth_db_session.query(Account).filter_by(name=username).first()
            if not account:
                return False

            # Client limitation.
            if len(new_password) > 16:
                return False

            hashed_old_password = hashlib.sha256(old_password.encode('utf-8')).hexdigest()
            if account.password != hashed_old_password:
                return False

            hashed_new_password = hashlib.sha256(new_password.encode('utf-8')).hexdigest()
            account.password = hashed_new_password

            auth_db_session.merge(account)
            auth_db_session.flush()
            auth_db_session.commit()
        finally:
            auth_db_session.close()

        return True
