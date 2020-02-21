from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session
from difflib import SequenceMatcher

from database.world.WorldModels import *
from utils.ConfigManager import *

world_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.world_db))
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine))


class WorldDatabaseManager(object):
    @staticmethod
    def acquire_session():
        world_db_session = SessionHolder()
        return world_db_session

    @staticmethod
    def save(world_db_session):
        error = False
        try:
            world_db_session.commit()
        except:
            error = True
            raise
        finally:
            if error:
                world_db_session.rollback()
            return not error

    @staticmethod
    def close(world_db_session):
        world_db_session.close()

    # Player stuff

    @staticmethod
    def player_create_info_get(world_db_session, race, class_):
        return world_db_session.query(Playercreateinfo).filter_by(race=race, _class=class_).first()

    # Area trigger stuff

    @staticmethod
    def area_trigger_teleport_get_by_id(world_db_session, trigger_id):
        return world_db_session.query(AreatriggerTeleport).filter_by(id=trigger_id).first()

    # Area Template stuff

    @staticmethod
    def area_get_by_id(world_db_session, area_id):
        return world_db_session.query(AreaTemplate).filter_by(entry=area_id).first()

    # Worldport stuff

    @staticmethod
    def get_location_by_name(world_db_session, name):
        best_matching_location = None
        best_matching_ratio = 0
        locations = world_db_session.query(Worldports).filter(Worldports.name.like('%' + name + '%')).all()
        for location in locations:
            ratio = SequenceMatcher(None, location.name, name).ratio()
            if ratio > best_matching_ratio:
                best_matching_location = location
        return best_matching_location
