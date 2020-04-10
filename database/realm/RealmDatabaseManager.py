from sqlalchemy import create_engine, func
from sqlalchemy.exc import StatementError
from sqlalchemy.orm import sessionmaker, scoped_session

from database.realm.RealmModels import *
from utils.ConfigManager import *
from game.realm.AccountManager import AccountManager
from utils.constants.ItemCodes import InventorySlots
from utils.constants.ObjectCodes import HighGuid

realm_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.realm_db),
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=realm_db_engine, autocommit=True, autoflush=True))


class RealmDatabaseManager(object):
    # Account stuff

    @staticmethod
    def account_try_login(username, password):
        realm_db_session = SessionHolder()
        account = realm_db_session.query(Account).filter_by(name=username).first()
        realm_db_session.close()
        if account:
            if account.password == password:
                return 1, AccountManager(account)
            else:
                return 0, None
        return -1, None

    @staticmethod
    def account_create(username, password, ip):
        realm_db_session = SessionHolder()
        account = Account(name=username, password=password, ip=ip, gmlevel=0)
        realm_db_session.add(account)
        realm_db_session.flush()
        realm_db_session.refresh(account)
        realm_db_session.close()
        return AccountManager(account)

    @staticmethod
    def account_get_characters(account_id):
        realm_db_session = SessionHolder()
        characters = realm_db_session.query(Character).filter_by(account_id=account_id).all()
        realm_db_session.close()
        return characters if characters else []

    # Character stuff

    @staticmethod
    def character_get_by_guid(guid):
        realm_db_session = SessionHolder()
        character = realm_db_session.query(Character).filter_by(guid=guid & ~HighGuid.HIGHGUID_PLAYER).first()
        realm_db_session.close()
        return character

    @staticmethod
    def character_get_by_name(name):
        realm_db_session = SessionHolder()
        character = realm_db_session.query(Character).filter_by(name=name).first()
        realm_db_session.close()
        return character

    @staticmethod
    def character_does_name_exist(name_to_check):
        realm_db_session = SessionHolder()
        name = realm_db_session.query(Character.name).filter_by(name=name_to_check).first()
        realm_db_session.close()
        return name is not None

    @staticmethod
    def character_create(character):
        realm_db_session = SessionHolder()
        realm_db_session.add(character)
        realm_db_session.flush()
        realm_db_session.refresh(character)
        realm_db_session.close()
        return character

    @staticmethod
    def character_update(character):
        realm_db_session = SessionHolder()
        realm_db_session.merge(character)
        realm_db_session.flush()
        realm_db_session.close()

    @staticmethod
    def character_inventory_get(character_guid):
        realm_db_session = SessionHolder()
        character_inventory = realm_db_session.query(CharacterInventory).filter_by(
            owner=character_guid & ~HighGuid.HIGHGUID_PLAYER).all()
        realm_db_session.close()
        return character_inventory if character_inventory else []

    @staticmethod
    def character_delete(guid):
        realm_db_session = SessionHolder()
        char_to_delete = RealmDatabaseManager.character_get_by_guid(guid)
        if char_to_delete:
            realm_db_session.delete(char_to_delete)
            realm_db_session.flush()
            realm_db_session.close()
            return 0
        return -1

    @staticmethod
    def character_inventory_add_item(item):
        if item:
            realm_db_session = SessionHolder()
            realm_db_session.add(item)
            realm_db_session.flush()
            realm_db_session.refresh(item)
            realm_db_session.close()

    @staticmethod
    def character_inventory_update_item(item):
        if item:
            realm_db_session = SessionHolder()
            realm_db_session.merge(item)
            realm_db_session.flush()
            realm_db_session.close()

    @staticmethod
    def character_inventory_delete(item):
        if item:
            realm_db_session = SessionHolder()
            realm_db_session.delete(item)
            realm_db_session.flush()
            realm_db_session.close()

    @staticmethod
    def character_get_inventory(guid):
        realm_db_session = SessionHolder()
        inventory = realm_db_session.query(CharacterInventory).filter_by(owner=guid & ~HighGuid.HIGHGUID_PLAYER).all()
        realm_db_session.close()
        return inventory

    @staticmethod
    def character_get_item_by_slot(guid, slot, bag=InventorySlots.SLOT_INBACKPACK.value):
        realm_db_session = SessionHolder()
        item = realm_db_session.query(CharacterInventory).filter_by(owner=guid & ~HighGuid.HIGHGUID_PLAYER, bag=bag,
                                                                    slot=slot).first()
        realm_db_session.close()
        return item

    # Ticket stuff

    @staticmethod
    def ticket_add(ticket):
        realm_db_session = SessionHolder()
        realm_db_session.add(ticket)
        realm_db_session.flush()
        realm_db_session.close()

    @staticmethod
    def ticket_get_by_id(ticket_id):
        realm_db_session = SessionHolder()
        ticket = realm_db_session.query(Ticket).filter_by(id=ticket_id).first()
        realm_db_session.close()
        return ticket

    @staticmethod
    def ticket_delete(ticket_id):
        realm_db_session = SessionHolder()
        ticket_to_delete = RealmDatabaseManager.ticket_get_by_id(ticket_id)
        if ticket_to_delete:
            realm_db_session.delete(ticket_to_delete)
            realm_db_session.flush()
            realm_db_session.close()
            return 0
        return -1

    @staticmethod
    def ticket_get_all():
        realm_db_session = SessionHolder()
        tickets = realm_db_session.query(Ticket).all()
        realm_db_session.close()
        return tickets if tickets else []
