from sqlalchemy import create_engine
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

    @staticmethod
    def get_spells_by_rank(rank, only_ids=False):
        rank_text = 'Rank %d' % rank
        dbc_db_session = SessionHolder()
        if only_ids:
            res = [r[0] for r in dbc_db_session.query(Spell.ID).filter_by(NameSubtext_enUS=rank_text).all()]
        else:
            res = dbc_db_session.query(Spell).filter_by(NameSubtext_enUS=rank_text).all()
        dbc_db_session.close()
        return res

    # Skill

    @staticmethod
    def skill_get_by_id(skill_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter_by(ID=skill_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def skill_get_by_type(skill_type):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter_by(SkillType=skill_type).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def skill_line_ability_get_by_skill_line(skill_line):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLineAbility).filter_by(SkillLine=skill_line).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def skill_line_ability_get_by_skill_lines(skill_lines):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLineAbility).filter(SkillLineAbility.SkillLine.in_(skill_lines)).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def skill_line_ability_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLineAbility).all()
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
