from sqlalchemy import create_engine, func
from sqlalchemy.exc import StatementError
from sqlalchemy.orm import sessionmaker, scoped_session

from database.dbc.DbcModels import *
from utils.ConfigManager import *

dbc_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                               config.Database.Connection.password,
                                                                               config.Database.Connection.host,
                                                                               config.Database.DBNames.dbc_db),
                              pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=dbc_db_engine, autocommit=True, autoflush=True))


class DbcDatabaseManager(object):
    # ChrRaces

    @staticmethod
    def chr_races_get_by_race(race):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(ChrRaces).filter_by(ID=race).first()
        dbc_db_session.close()
        return res

    # AreaTrigger

    @staticmethod
    def area_trigger_get_by_id(trigger_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTrigger).filter_by(ID=trigger_id).first()
        dbc_db_session.close()
        return res

    # EmoteText

    @staticmethod
    def emote_text_get_by_id(emote_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(EmotesText).filter_by(ID=emote_id).first()
        dbc_db_session.close()
        return res

    # Spell

    @staticmethod
    def spell_get_by_id(spell_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Spell).filter_by(ID=spell_id).first()
        dbc_db_session.close()
        return res

    # Skill

    @staticmethod
    def skill_get_by_id(skill_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter_by(ID=skill_id).first()
        dbc_db_session.close()
        return res

    # CharStartOutfit

    @staticmethod
    def char_start_outfit_get(race, class_, gender):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CharStartOutfit).filter_by(RaceID=race, ClassID=class_, GenderID=gender).first()
        dbc_db_session.close()
        return res

    # CreatureDisplayInfo

    @staticmethod
    def creature_display_info_get_by_id(display_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CreatureDisplayInfo).filter_by(ID=display_id).first()
        dbc_db_session.close()
        return res

    # CinematicSequences

    @staticmethod
    def cinematic_sequences_get_by_id(cinematic_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CinematicSequence).filter_by(ID=cinematic_id).first()
        dbc_db_session.close()
        return res

    # Map

    @staticmethod
    def map_get_by_id(map_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Map).filter_by(ID=map_id).first()
        dbc_db_session.close()
        return res
