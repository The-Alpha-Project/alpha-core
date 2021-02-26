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

    class SpellHolder:
        SPELLS = {}

        @staticmethod
        def load_spell(spell):
            DbcDatabaseManager.SpellHolder.SPELLS[spell.ID] = spell

        @staticmethod
        def spell_get_by_id(spell_id):
            return DbcDatabaseManager.SpellHolder.SPELLS[spell_id] \
                if spell_id in DbcDatabaseManager.SpellHolder.SPELLS else None

        @staticmethod
        def spell_get_rank_by_spell(spell):
            rank_text = spell.NameSubtext_enUS
            if 'Rank' in rank_text:
                return int(rank_text.split('Rank')[-1])
            return 0

        @staticmethod
        def spell_get_rank_by_id(spell_id):
            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not spell:
                return 0

            return DbcDatabaseManager.SpellHolder.spell_get_rank_by_spell(spell)

    @staticmethod
    def spell_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Spell).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def spell_get_by_name(spell_name):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Spell).filter(Spell.Name_enUS.like('%' + spell_name + '%')).all()
        dbc_db_session.close()
        return res

    # Skill

    class SkillHolder:
        SKILLS = {}

        @staticmethod
        def load_skill(skill):
            DbcDatabaseManager.SkillHolder.SKILLS[skill.ID] = skill

        @staticmethod
        def skill_get_by_id(skill_id):
            return DbcDatabaseManager.SkillHolder.SKILLS[skill_id] \
                if skill_id in DbcDatabaseManager.SkillHolder.SKILLS else None

    @staticmethod
    def skill_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).all()
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
