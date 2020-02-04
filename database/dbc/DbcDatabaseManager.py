from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker

from database.dbc.DbcModels import *
from utils.ConfigManager import *

dbc_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                               config.Database.Connection.password,
                                                                               config.Database.Connection.host,
                                                                               config.Database.DBNames.dbc_db))
SessionHolder = sessionmaker(bind=dbc_db_engine)
dbc_session = SessionHolder()
# To always keep the db data in memory (this database should be read only anyway).
dbc_session.expire_on_commit = False


class DbcDatabaseManager(object):
    @staticmethod
    def load_tables():
        dbc_session.add_all(dbc_session.query(Spell))
        dbc_session.add_all(dbc_session.query(SpellRange))
        dbc_session.add_all(dbc_session.query(SpellRadius))
        dbc_session.add_all(dbc_session.query(SpellDuration))
        dbc_session.add_all(dbc_session.query(SpellCastTimes))
        dbc_session.add_all(dbc_session.query(CharStartOutfit))
        dbc_session.add_all(dbc_session.query(SkillLine))
        dbc_session.add_all(dbc_session.query(SkillLineAbility))
        dbc_session.add_all(dbc_session.query(ChrRaces))
        dbc_session.add_all(dbc_session.query(CharBaseInfo))
        dbc_session.add_all(dbc_session.query(ChrProficiency))
        dbc_session.add_all(dbc_session.query(WorldSafeLocs))
        dbc_session.add_all(dbc_session.query(FactionTemplate))
        dbc_session.add_all(dbc_session.query(EmotesText))
        dbc_session.add_all(dbc_session.query(BankBagSlotPrices))
        dbc_session.add_all(dbc_session.query(AreaTable))
        dbc_session.add_all(dbc_session.query(Lock))
        dbc_session.add_all(dbc_session.query(LockType))

    # ChrRaces

    @staticmethod
    def chr_races_get_by_race(race):
        return dbc_session.query(ChrRaces).filter_by(ID=race).first()
