from sqlalchemy import create_engine, func
from sqlalchemy.exc import StatementError
from sqlalchemy.orm import sessionmaker, scoped_session
from difflib import SequenceMatcher

from database.world.WorldModels import *
from utils.ConfigManager import *
from utils.constants.ObjectCodes import HighGuid

world_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.world_db),
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine, autocommit=True, autoflush=True))


class WorldDatabaseManager(object):
    # Player stuff

    @staticmethod
    def player_create_info_get(race, class_):
        world_db_session = SessionHolder()
        res = world_db_session.query(Playercreateinfo).filter_by(race=race, _class=class_).first()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_spell_get(race, class_):
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoSpell).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_skill_get(race, class_):
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoSkill).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_item_get(race, class_):
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoItem).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_get_class_level_stats(class_, level):
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayerClasslevelstats).filter_by(level=level, _class=class_).first()
        world_db_session.close()
        return res

    # Area trigger stuff

    @staticmethod
    def area_trigger_teleport_get_by_id(trigger_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(AreatriggerTeleport).filter_by(id=trigger_id).first()
        world_db_session.close()
        return res

    # Area Template stuff

    @staticmethod
    def area_get_by_id(area_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(entry=area_id).first()
        world_db_session.close()
        return res

    # Worldport stuff

    @staticmethod
    def worldport_get_by_name(name):
        world_db_session = SessionHolder()
        best_matching_location = None
        best_matching_ratio = 0
        locations = world_db_session.query(Worldports).filter(Worldports.name.like('%' + name + '%')).all()
        world_db_session.close()
        for location in locations:
            ratio = SequenceMatcher(None, location.name, name).ratio()
            if ratio > best_matching_ratio:
                best_matching_location = location
        return best_matching_location

    # Item stuff

    @staticmethod
    def item_template_get_by_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(ItemTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    # Page text stuff

    @staticmethod
    def page_text_get_by_id(page_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(PageText).filter_by(entry=page_id).first()
        world_db_session.close()
        return res

    # Gameobject stuff

    @staticmethod
    def gameobject_get_all_spawns():
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).all()
        return res, world_db_session

    @staticmethod
    def gameobject_spawn_get_by_guid(guid):
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(spawn_id=guid & ~HighGuid.HIGHGUID_GAMEOBJECT).first()
        return res, world_db_session

    # Creature stuff

    @staticmethod
    def creature_get_by_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(Creatures).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_all_spawns():
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).all()
        return res, world_db_session

    @staticmethod
    def creature_spawn_get_by_guid(guid):
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(spawn_id=guid & ~HighGuid.HIGHGUID_UNIT).first()
        return res, world_db_session

    @staticmethod
    def creature_get_model_info(display_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureModelInfo).filter_by(modelid=display_id).first()
        world_db_session.close()
        return res
