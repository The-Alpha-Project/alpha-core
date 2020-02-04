from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker

from database.dbc.DbcModels import *
from utils.ConfigManager import *

world_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.world_db))
SessionHolder = sessionmaker(bind=world_db_engine)
world_session = SessionHolder()
# To always keep the db data in memory (this database should be read only anyway).
world_session.expire_on_commit = False


class WorldDatabaseManager(object):
    @staticmethod
    def load_tables():
        pass
