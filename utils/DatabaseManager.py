import time

import os
from typing import Optional
from difflib import SequenceMatcher

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

from database.world.WorldModels import *
from database.world.WorldModels import Condition
from game.world.managers.objects.units.creature.CreatureSpellsEntry import CreatureSpellsEntry
from utils.ConfigManager import *
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid, Languages
from utils.constants.ScriptCodes import WaypointPathOrigin

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.Connection.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.Connection.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.Connection.host)
DB_WORLD_NAME = config.Database.DBNames.world_db


START_TIME = time.time()
MAX_WAIT_TIME = 120

def test():
    while time.time() - START_TIME < MAX_WAIT_TIME:
        try:
            world_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_WORLD_NAME}?charset=utf8mb4',
                                pool_pre_ping=True)
            SessionHolder = scoped_session(sessionmaker(bind=world_db_engine, autoflush=True))
            world_db_session = SessionHolder() 
            res = world_db_session.query(AppliedUpdates).count()
            world_db_session.close()
            
            Logger.info("Database server is ready for connections")
            return
        except:
            Logger.info("Waiting for database server will be ready...")
            time.sleep(2)
            pass
    
    Logger.info("MySQL didn't become ready within 2 minutes")
    exit(1)

test()
