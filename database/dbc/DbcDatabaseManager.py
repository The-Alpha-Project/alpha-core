from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.dbc.DbcModels import *
from utils.ConfigManager import *

dbc_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                               config.Database.Connection.password,
                                                                               config.Database.Connection.host,
                                                                               config.Database.DBNames.dbc_db))
SessionHolder = scoped_session(sessionmaker(bind=dbc_db_engine))


class DbcDatabaseManager(object):
    @staticmethod
    def acquire_session():
        dbc_db_session = SessionHolder()
        # To always keep the db data in memory (this database should be read only anyway).
        dbc_db_session.expire_on_commit = False
        return dbc_db_session

    @staticmethod
    def save(dbc_db_session):
        try:
            dbc_db_session.commit()
        except:
            dbc_db_session.rollback()
            raise

    @staticmethod
    def close(dbc_db_session):
        dbc_db_session.remove()

    # ChrRaces

    @staticmethod
    def chr_races_get_by_race(dbc_db_session, race):
        return dbc_db_session.query(ChrRaces).filter_by(ID=race).first()

    # AreaTrigger
    @staticmethod
    def area_trigger_get_by_id(dbc_db_session, trigger_id):
        return dbc_db_session.query(AreaTrigger).filter_by(ID=trigger_id).first()
