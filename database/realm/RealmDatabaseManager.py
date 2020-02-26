from sqlalchemy import create_engine, func
from sqlalchemy.exc import StatementError
from sqlalchemy.orm import sessionmaker, scoped_session

from database.realm.RealmModels import *
from utils.ConfigManager import *
from game.realm.AccountManager import AccountManager


realm_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.realm_db),
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=realm_db_engine))


class RealmDatabaseManager(object):
    @staticmethod
    def acquire_session():
        realm_db_session = SessionHolder()
        return realm_db_session

    @staticmethod
    def save(realm_db_session):
        error = False
        try:
            realm_db_session.commit()
        except StatementError:
            error = True
        finally:
            if error:
                realm_db_session.rollback()
            return not error

    @staticmethod
    def close(realm_db_session):
        realm_db_session.close()

    # Account stuff

    @staticmethod
    def account_try_login(realm_db_session, username, password):
        account = realm_db_session.query(Account).filter_by(name=username).first()
        if account:
            if account.password == password:
                return 1, AccountManager(account)
            else:
                return 0, None
        return -1, None

    @staticmethod
    def account_create(realm_db_session, username, password, ip):
        account = Account(name=username, password=password, ip=ip, gmlevel=0)
        realm_db_session.add(account)
        return AccountManager(account)

    @staticmethod
    def account_get_characters(realm_db_session, account_id):
        characters = realm_db_session.query(Character).filter_by(account_id=account_id).all()
        return characters if characters else []

    # Character stuff

    @staticmethod
    def character_get_by_guid(realm_db_session, guid):
        return realm_db_session.query(Character).filter_by(guid=guid).first()

    @staticmethod
    def character_get_by_name(realm_db_session, name):
        return realm_db_session.query(Character).filter_by(name=name).first()

    @staticmethod
    def character_does_name_exist(realm_db_session, name_to_check):
        name = realm_db_session.query(Character.name).filter_by(name=name_to_check).first()
        return name is not None

    @staticmethod
    def character_create(realm_db_session, character):
        realm_db_session.add(character)
        RealmDatabaseManager.save(realm_db_session)

    @staticmethod
    def character_inventory_get(realm_db_session, character_guid):
        character_inventory = realm_db_session.query(CharacterInventory).filter_by(owner=character_guid).all()
        return character_inventory if character_inventory else []

    @staticmethod
    def character_delete(realm_db_session, guid):
        char_to_delete = RealmDatabaseManager.character_get_by_guid(realm_db_session, guid)
        if char_to_delete:
            realm_db_session.delete(char_to_delete)
            RealmDatabaseManager.save(realm_db_session)
            return 0
        return -1

    @staticmethod
    def character_inventory_add_item(realm_db_session, item):
        if item:
            realm_db_session.add(item)
            RealmDatabaseManager.save(realm_db_session)

    @staticmethod
    def character_get_inventory(realm_db_session, guid):
        return realm_db_session.query(CharacterInventory).filter_by(owner=guid).all()

    @staticmethod
    def character_get_item_by_slot(realm_db_session, guid, slot):
        return realm_db_session.query(CharacterInventory).filter_by(owner=guid, slot=slot).first()

    # Ticket stuff

    @staticmethod
    def ticket_add(realm_db_session, ticket):
        realm_db_session.add(ticket)
        RealmDatabaseManager.save(realm_db_session)

    @staticmethod
    def ticket_get_by_id(realm_db_session, ticket_id):
        ticket = realm_db_session.query(Ticket).filter_by(id=ticket_id).first()
        return ticket

    @staticmethod
    def ticket_delete(realm_db_session, ticket_id):
        ticket_to_delete = RealmDatabaseManager.ticket_get_by_id(realm_db_session, ticket_id)
        if ticket_to_delete:
            realm_db_session.delete(ticket_to_delete)
            RealmDatabaseManager.save(realm_db_session)
            return 0
        return -1

    @staticmethod
    def ticket_get_all(realm_db_session):
        tickets = realm_db_session.query(Ticket).all()
        return tickets if tickets else []
