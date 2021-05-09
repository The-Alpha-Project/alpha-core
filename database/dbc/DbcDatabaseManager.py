import os

from sqlalchemy import create_engine
from sqlalchemy.exc import StatementError
from sqlalchemy.orm import sessionmaker, scoped_session

from database.dbc.DbcModels import *
from utils.ConfigManager import *

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.Connection.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.Connection.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.Connection.host)
DB_DBC_NAME = config.Database.DBNames.dbc_db

dbc_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_DBC_NAME}?charset=utf8mb4',
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

    # TODO Caching for all spell database methods?

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

    @staticmethod
    def spell_cast_time_get_by_id(range_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellCastTimes).filter_by(ID=range_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def spell_range_get_by_id(range_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellRange).filter_by(ID=range_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def spell_duration_get_by_id(duration_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellDuration).filter_by(ID=duration_index).first()
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
    def skill_get_by_name(skill_type):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter(SkillLine.DisplayName_enUS.like('%' + skill_type + '%')).all()
        dbc_db_session.close()
        return res

    class SkillLineAbilityHolder:
        SKILL_LINE_ABILITIES = {}

        @staticmethod
        def load_skill_line_ability(skill_line_ability):
            DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_ABILITIES[
                skill_line_ability.Spell] = skill_line_ability

        @staticmethod
        def skill_line_ability_get_by_spell(spell_id):
            return DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_ABILITIES[spell_id] \
                if spell_id in DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_ABILITIES else None

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

    # GameObjectDisplayInfo

    @staticmethod
    def gameobject_display_info_get_by_id(display_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(GameObjectDisplayInfo).filter_by(ID=display_id).first()
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

    @staticmethod
    def map_get_all_ids():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Map.ID).all()
        dbc_db_session.close()
        return [map_id[0] for map_id in res]

    # Bank

    @staticmethod
    def bank_get_slot_cost(slot):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(BankBagSlotPrices).filter_by(ID=slot).first()
        dbc_db_session.close()
        return res.Cost

    # Taxi

    class TaxiNodesHolder:
        EASTERN_KINGDOMS_TAXI_NODES = {}
        KALIMDOR_TAXI_NODES = {}

        @staticmethod
        def load_taxi_node(taxi_node):
            if taxi_node.ContinentID == 0:
                DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES[taxi_node.ID] = taxi_node
            elif taxi_node.ContinentID == 1:
                DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES[taxi_node.ID] = taxi_node

        @staticmethod
        def taxi_nodes_get_by_map(map_):
            if map_ == 0:
                return DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES.items()
            elif map_ == 1:
                return DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES.items()
            return {}

        @staticmethod
        def taxi_nodes_get_by_map_and_id(map_, node_id):
            if map_ == 0:
                return DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES[node_id]
            elif map_ == 1:
                return DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES[node_id]
            return {}

    class TaxiPathNodesHolder:
        TAXI_PATH_NODES = {}

        @staticmethod
        def load_taxi_path_node(taxi_path_node):
            if taxi_path_node.PathID not in DbcDatabaseManager.TaxiPathNodesHolder.TAXI_PATH_NODES:
                DbcDatabaseManager.TaxiPathNodesHolder.TAXI_PATH_NODES[taxi_path_node.PathID] = []
            DbcDatabaseManager.TaxiPathNodesHolder.TAXI_PATH_NODES[taxi_path_node.PathID].append(taxi_path_node)

        @staticmethod
        def taxi_nodes_get_by_path_id(taxi_path_id):
            if taxi_path_id in DbcDatabaseManager.TaxiPathNodesHolder.TAXI_PATH_NODES:
                return DbcDatabaseManager.TaxiPathNodesHolder.TAXI_PATH_NODES[taxi_path_id]
            return []

    @staticmethod
    def taxi_nodes_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(TaxiNode).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def taxi_path_get(from_node, to_node):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(TaxiPath).filter_by(FromTaxiNode=from_node, ToTaxiNode=to_node).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def taxi_path_nodes_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(TaxiPathNode).order_by(TaxiPathNode.NodeIndex.asc()).all()
        dbc_db_session.close()
        return res

    # Faction

    @staticmethod
    def faction_template_get_by_id(faction_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(FactionTemplate).filter_by(ID=faction_id).first()
        dbc_db_session.close()
        return res
