from collections import defaultdict
from functools import lru_cache
from typing import Optional, Dict

from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.dbc.DbcModels import *
from game.world.managers.maps.helpers.AreaInformation import AreaInformation
from game.world.managers.objects.locks.LockHolder import LockHolder
from utils.ConfigManager import *
from utils.constants.SpellCodes import SpellImplicitTargets


DB_USER = os.getenv('MYSQL_USERNAME', config.Database.DBC.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.DBC.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.DBC.host)
DB_PORT = os.getenv('MYSQL_TCP_PORT', config.Database.DBC.port)
DB_DBC_NAME = config.Database.DBC.db_name

dbc_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_DBC_NAME}?charset=utf8mb4',
                              pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=dbc_db_engine, autoflush=True))


# noinspection PyUnresolvedReferences
class DbcDatabaseManager:
    # ChrRaces

    @staticmethod
    @lru_cache
    def chr_races_get_by_race(race):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(ChrRaces).filter_by(ID=race).first()
        dbc_db_session.close()
        return res

    # CharBaseInfo

    class CharBaseInfoHolder:
        BASE_INFOS = {}

        @staticmethod
        def load_base_info(base_info):
            if base_info.RaceID not in DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS:
                DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS[base_info.RaceID] = {}
            DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS[base_info.RaceID][base_info.ClassID] = base_info

        @staticmethod
        def char_base_info_get(race, class_):
            if race not in DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS:
                return None
            if class_ not in DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS[race]:
                return None
            return DbcDatabaseManager.CharBaseInfoHolder.BASE_INFOS[race][class_]

    @staticmethod
    def char_base_info_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CharBaseInfo).all()
        dbc_db_session.close()
        return res

    # AreaTrigger

    @staticmethod
    @lru_cache
    def area_trigger_get_by_id(trigger_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTrigger).filter_by(ID=trigger_id).first()
        dbc_db_session.close()
        return res

    # AreaTable

    @staticmethod
    @lru_cache
    def area_get_by_id_and_map_id(area_id, map_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTable).filter_by(ID=area_id, ContinentID=map_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_area_number(area_number, map_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTable).filter_by(AreaNumber=area_number, ContinentID=map_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_id(area_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTable).filter_by(ID=area_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_name(area_name):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTable).filter_by(AreaName_enUS=area_name).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def area_get_all_ids():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(AreaTable.ID).all()
        dbc_db_session.close()
        return [area_id[0] for area_id in res]

    class AreaInformationHolder:
        # AreaInformation is used by the exploration feature, it gets filled by MapTiles.
        BY_ZONE_AND_AREA = {}

        @staticmethod
        def get_by_map_and_zone(map_id, zone_id):
            if map_id not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA:
                return None
            if zone_id not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id]:
                return None
            # Find matching AreaNumber for given zone.
            area_by_zone = DbcDatabaseManager.area_get_by_id_and_map_id(zone_id, map_id)
            if not area_by_zone:
                return None
            # Check if the entry for this area number exists.
            if area_by_zone.AreaNumber not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id]:
                return None
            return DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id].get(area_by_zone.AreaNumber, None)

        @staticmethod
        def get_or_create(map_id, zone_id, area_number, area_flags, area_level, explore_bit):
            if map_id not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA:
                DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id] = {}
            if zone_id not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id]:
                DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id] = {}
            if area_number not in DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id]:
                DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id][area_number] =\
                    AreaInformation(zone_id, area_number, area_flags, area_level, explore_bit)
            return DbcDatabaseManager.AreaInformationHolder.BY_ZONE_AND_AREA[map_id][zone_id].get(area_number, None)

    # EmoteText

    @staticmethod
    @lru_cache
    def emote_text_get_by_id(emote_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(EmotesText).filter_by(ID=emote_id).first()
        dbc_db_session.close()
        return res

    # Spell

    class SpellHolder:
        SPELLS: dict[int, Spell] = {}

        @staticmethod
        def load_spell(spell: Spell):
            DbcDatabaseManager.SpellHolder.SPELLS[spell.ID] = spell

        @staticmethod
        def spell_get_by_id(spell_id):
            return DbcDatabaseManager.SpellHolder.SPELLS[spell_id] \
                if spell_id in DbcDatabaseManager.SpellHolder.SPELLS else None

        @staticmethod
        def spell_get_trainer_spell_by_id(spell_id):
            for id_, spell in DbcDatabaseManager.SpellHolder.SPELLS.items():
                triggers = [spell.EffectTriggerSpell_1, spell.EffectTriggerSpell_2, spell.EffectTriggerSpell_3]
                if spell_id in triggers and spell.ImplicitTargetA_1 == SpellImplicitTargets.TARGET_INITIAL:
                    return spell
            return None

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
    @lru_cache
    def spell_get_by_name(spell_name):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Spell).filter(Spell.Name_enUS.like(f'%{spell_name}%')).all()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_cast_time_get_by_id(casting_time_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellCastTimes).filter_by(ID=casting_time_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_visual_get_by_id(spell_visual_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellVisual).filter_by(ID=spell_visual_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_range_get_by_id(range_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellRange).filter_by(ID=range_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_duration_get_by_id(duration_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellDuration).filter_by(ID=duration_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_radius_get_by_id(radius_index):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellRadius).filter_by(ID=radius_index).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_get_item_enchantment(enchantment_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellItemEnchantment).filter_by(ID=enchantment_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def spell_get_focus_by_id(spell_focus_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SpellFocusObject).filter_by(ID=spell_focus_id).first()
        dbc_db_session.close()
        return res

    # Skill

    class SkillHolder:
        SKILLS = {}

        @staticmethod
        def load_skill(skill):
            DbcDatabaseManager.SkillHolder.SKILLS[skill.ID] = skill

        @staticmethod
        def skill_get_by_id(skill_id) -> Optional[SkillLine]:
            return DbcDatabaseManager.SkillHolder.SKILLS[skill_id] \
                if skill_id in DbcDatabaseManager.SkillHolder.SKILLS else None

    @staticmethod
    def skill_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).all()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def skill_get_by_type(skill_type):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter_by(SkillType=skill_type).all()
        dbc_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def skill_get_by_name(skill_type):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(SkillLine).filter(SkillLine.DisplayName_enUS.like(f'%{skill_type}%')).all()
        dbc_db_session.close()
        return res

    class SkillLineAbilityHolder:
        SKILL_LINE_ABILITIES = defaultdict(list)
        SKILL_LINE_PRECEDED = dict()
        SPELLS_BY_SKILL_LINE = defaultdict(list)
        SKILL_LINES_BY_SKILL = defaultdict(list)

        @staticmethod
        def load_skill_line_ability(skill_line_ability):
            DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_ABILITIES[skill_line_ability.Spell].append(
                skill_line_ability)

            if skill_line_ability.SupercededBySpell:
                DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_PRECEDED[skill_line_ability.SupercededBySpell] = skill_line_ability

            if skill_line_ability.Spell:
                DbcDatabaseManager.SkillLineAbilityHolder.SPELLS_BY_SKILL_LINE[skill_line_ability.SkillLine].append(
                    skill_line_ability.Spell)

            if skill_line_ability.SkillLine:
                DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINES_BY_SKILL[skill_line_ability.SkillLine].append(
                    skill_line_ability)

        @staticmethod
        def skill_line_abilities_get_preceded_by_spell(spell_id) -> Optional[SkillLineAbility]:
            if spell_id in DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_PRECEDED:
                return DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_PRECEDED[spell_id]
            return None

        @staticmethod
        def skill_line_abilities_get_by_skill_id(skill_id) -> Optional[list[SkillLineAbility]]:
            if skill_id in DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINES_BY_SKILL:
                return DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINES_BY_SKILL[skill_id]
            return []

        @staticmethod
        def spells_get_by_skill_id(skill_id) -> Optional[list[int]]:
            if skill_id in DbcDatabaseManager.SkillLineAbilityHolder.SPELLS_BY_SKILL_LINE:
                return DbcDatabaseManager.SkillLineAbilityHolder.SPELLS_BY_SKILL_LINE[skill_id]
            return []

        @staticmethod
        def skill_line_abilities_get_by_spell(spell_id) -> list:
            return DbcDatabaseManager.SkillLineAbilityHolder.SKILL_LINE_ABILITIES.get(spell_id, list())

        @staticmethod
        @lru_cache
        def skill_line_ability_get_by_spell_race_and_class(spell_id, race, class_):
            race_mask = 1 << (race - 1)
            class_mask = 1 << (class_ - 1)
            skill_line_abilities = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_by_spell(spell_id)

            for skill_line_ability in skill_line_abilities:
                req_race_mask = skill_line_ability.RaceMask
                req_class_mask = skill_line_ability.ClassMask

                if skill_line_ability.ExcludeRace:  # Always 0
                    req_race_mask = ~req_race_mask
                if skill_line_ability.ExcludeClass:
                    req_class_mask = ~req_class_mask

                if (req_race_mask and req_race_mask & race_mask == 0) or \
                        (req_class_mask and req_class_mask & class_mask == 0):
                    continue

                # Validate Skill Line.
                skill_line = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_line_ability.SkillLine)
                req_race_mask = skill_line.RaceMask
                req_class_mask = skill_line.ClassMask

                if skill_line.ExcludeRace:  # Always 0
                    req_race_mask = ~req_race_mask
                if skill_line.ExcludeClass:
                    req_class_mask = ~req_class_mask

                if (req_race_mask and req_race_mask & race_mask == 0) or \
                        (req_class_mask and req_class_mask & class_mask == 0):
                    continue

                return skill_line_ability
            return None

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

    # ItemSubClass

    @staticmethod
    @lru_cache
    def item_get_subclass_info_by_class_and_subclass(class_, subclass):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(ItemSubClass).filter_by(ClassID=class_, SubClassID=subclass).first()
        dbc_db_session.close()
        return res

    # CharStartOutfit

    @staticmethod
    @lru_cache
    def char_start_outfit_get(race, class_, gender):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CharStartOutfit).filter_by(RaceID=race, ClassID=class_, GenderID=gender).first()
        dbc_db_session.close()
        return res

    # MdxModelsData

    class MdxModelsDataHolder:
        MDX_MODELS_INFOS: Dict[int, t_mdx_models_data] = {}

        @staticmethod
        def load_mdx_model_info(mdx_model_info):
            DbcDatabaseManager.MdxModelsDataHolder.MDX_MODELS_INFOS[mdx_model_info.ID] = mdx_model_info

        @staticmethod
        def get_mdx_model_info_by_id(mdx_model_id):
            return DbcDatabaseManager.MdxModelsDataHolder.MDX_MODELS_INFOS.get(mdx_model_id)

    # CreatureDisplayInfo

    class CreatureDisplayInfoHolder:
        CREATURE_DISPLAY_INFOS: dict[int, CreatureDisplayInfo] = {}

        @staticmethod
        def load_creature_display_info(creature_display_info):
            DbcDatabaseManager.CreatureDisplayInfoHolder.CREATURE_DISPLAY_INFOS[creature_display_info.ID] \
                = creature_display_info

        @staticmethod
        def creature_display_info_get_by_id(display_id) -> Optional[CreatureDisplayInfo]:
            return DbcDatabaseManager.CreatureDisplayInfoHolder.CREATURE_DISPLAY_INFOS.get(display_id)

    @staticmethod
    def creature_display_info_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CreatureDisplayInfo).all()
        dbc_db_session.close()
        return res

    @staticmethod
    def mdx_models_info_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(t_mdx_models_data).all()
        dbc_db_session.close()
        return res

    # GameObjectDisplayInfo

    @staticmethod
    @lru_cache
    def gameobject_display_info_get_by_id(display_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(GameObjectDisplayInfo).filter_by(ID=display_id).first()
        dbc_db_session.close()
        return res

    # CreatureFamily

    class CreatureFamilyHolder:
        CREATURE_FAMILIES: Dict[int, CreatureFamily] = {}

        @staticmethod
        def load_creature_family(creature_family):
            DbcDatabaseManager.CreatureFamilyHolder.CREATURE_FAMILIES[creature_family.ID] = creature_family

        @staticmethod
        def creature_family_get_by_id(family_id) -> Optional[CreatureFamily]:
            return DbcDatabaseManager.CreatureFamilyHolder.CREATURE_FAMILIES.get(family_id)

    @staticmethod
    def creature_family_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(CreatureFamily).all()
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
    @lru_cache
    def map_get_by_id(map_id):
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Map).filter_by(ID=map_id).first()
        dbc_db_session.close()
        return res

    @staticmethod
    def get_max_map_id():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(func.max(Map.ID)).scalar()
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
    @lru_cache
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
        @lru_cache
        def taxi_nodes_get_by_map_id(map_id):
            if map_id == 0:
                return DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES.items()
            elif map_id == 1:
                return DbcDatabaseManager.TaxiNodesHolder.KALIMDOR_TAXI_NODES.items()
            return {}

        @staticmethod
        @lru_cache
        def taxi_nodes_get_by_map_id_and_node_id(map_id, node_id):
            if map_id == 0:
                return DbcDatabaseManager.TaxiNodesHolder.EASTERN_KINGDOMS_TAXI_NODES[node_id]
            elif map_id == 1:
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
    @lru_cache
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

    # Locks
    class LocksHolder:
        LOCKS = {}

        @staticmethod
        def load_lock(lock: Lock):
            DbcDatabaseManager.LocksHolder.LOCKS[lock.ID] = LockHolder(lock)

        @staticmethod
        def get_lock_by_id(lock_id):
            if lock_id in DbcDatabaseManager.LocksHolder.LOCKS:
                return DbcDatabaseManager.LocksHolder.LOCKS[lock_id]
            return 0

    @staticmethod
    def locks_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Lock).all()
        dbc_db_session.close()
        return res

    # Transports

    class TransportAnimationHolder:
        TRANSPORT_ANIMATIONS = {}

        @staticmethod
        def load_transport_animation(t_animation):
            if t_animation.TransportID not in DbcDatabaseManager.TransportAnimationHolder.TRANSPORT_ANIMATIONS:
                DbcDatabaseManager.TransportAnimationHolder.TRANSPORT_ANIMATIONS[t_animation.TransportID] = []
            DbcDatabaseManager.TransportAnimationHolder.TRANSPORT_ANIMATIONS[t_animation.TransportID].append(t_animation)

        @staticmethod
        def animations_by_entry(entry):
            return DbcDatabaseManager.TransportAnimationHolder.TRANSPORT_ANIMATIONS.get(entry, [])

    @staticmethod
    def transport_animation_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(TransportAnimation).all()
        dbc_db_session.close()
        return res

    # Faction

    class FactionHolder:
        FACTIONS = {}

        @staticmethod
        def load_faction(faction):
            DbcDatabaseManager.FactionHolder.FACTIONS[faction.ID] = faction

        @staticmethod
        @lru_cache
        def faction_get_by_index(index):
            for faction in DbcDatabaseManager.FactionHolder.FACTIONS.values():
                if faction.ReputationIndex == index:
                    return faction
            return None

        @staticmethod
        def faction_get_by_id(faction_id):
            if faction_id in DbcDatabaseManager.FactionHolder.FACTIONS:
                return DbcDatabaseManager.FactionHolder.FACTIONS[faction_id]
            return None

    @staticmethod
    def faction_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(Faction).all()
        dbc_db_session.close()
        return res

    # FactionTemplate

    class FactionTemplateHolder:
        FACTION_TEMPLATES = {}
        # TODO: This shouldn't be needed once all NPCs involved in escort quests have the proper EscortAI ai_name.
        ESCORTEE_FACTIONS = {10, 33, 113, 231, 232, 250}

        @staticmethod
        def load_faction_template(faction_template):
            DbcDatabaseManager.FactionTemplateHolder.FACTION_TEMPLATES[faction_template.ID] = faction_template

        @staticmethod
        def is_escortee_faction(faction_id):
            return faction_id in DbcDatabaseManager.FactionTemplateHolder.ESCORTEE_FACTIONS

        @staticmethod
        def faction_template_get_by_id(faction_template_id):
            if faction_template_id in DbcDatabaseManager.FactionTemplateHolder.FACTION_TEMPLATES:
                return DbcDatabaseManager.FactionTemplateHolder.FACTION_TEMPLATES[faction_template_id]
            return None

    @staticmethod
    def faction_template_get_all():
        dbc_db_session = SessionHolder()
        res = dbc_db_session.query(FactionTemplate).all()
        dbc_db_session.close()
        return res
