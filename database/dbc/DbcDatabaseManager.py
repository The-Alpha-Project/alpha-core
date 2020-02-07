from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.dbc.DbcModels import *
from utils.ConfigManager import *

dbc_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                               config.Database.Connection.password,
                                                                               config.Database.Connection.host,
                                                                               config.Database.DBNames.dbc_db))
SessionHolder = scoped_session(sessionmaker(bind=dbc_db_engine))
dbc_db_session = SessionHolder()
# To always keep the db data in memory (this database should be read only anyway).
dbc_db_session.expire_on_commit = False


class DbcDatabaseManager(object):
    @staticmethod
    def load_tables():
        dbc_db_session.add_all(dbc_db_session.query(Spell))
        dbc_db_session.add_all(dbc_db_session.query(SpellRange))
        dbc_db_session.add_all(dbc_db_session.query(SpellRadius))
        dbc_db_session.add_all(dbc_db_session.query(SpellDuration))
        dbc_db_session.add_all(dbc_db_session.query(SpellCastTimes))
        dbc_db_session.add_all(dbc_db_session.query(CharStartOutfit))
        dbc_db_session.add_all(dbc_db_session.query(SkillLine))
        dbc_db_session.add_all(dbc_db_session.query(SkillLineAbility))
        dbc_db_session.add_all(dbc_db_session.query(ChrRaces))
        dbc_db_session.add_all(dbc_db_session.query(CharBaseInfo))
        dbc_db_session.add_all(dbc_db_session.query(ChrProficiency))
        dbc_db_session.add_all(dbc_db_session.query(WorldSafeLocs))
        dbc_db_session.add_all(dbc_db_session.query(FactionTemplate))
        dbc_db_session.add_all(dbc_db_session.query(EmotesText))
        dbc_db_session.add_all(dbc_db_session.query(BankBagSlotPrices))
        dbc_db_session.add_all(dbc_db_session.query(AreaTable))
        dbc_db_session.add_all(dbc_db_session.query(Lock))
        dbc_db_session.add_all(dbc_db_session.query(LockType))

    # ChrRaces

    @staticmethod
    def chr_races_get_by_race(race):
        return dbc_db_session.query(ChrRaces).filter_by(ID=race).first()

    # AreaTrigger
    @staticmethod
    def area_trigger_get_by_id(trigger_id):
        return dbc_db_session.query(AreaTrigger).filter_by(ID=trigger_id).first()
