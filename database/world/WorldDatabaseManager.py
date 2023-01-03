import os
from typing import Optional
from difflib import SequenceMatcher

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

from database.world.WorldModels import *
from game.world.managers.objects.units.creature.CreatureSpellsEntry import CreatureSpellsEntry
from utils.ConfigManager import *
from utils.constants.MiscCodes import HighGuid

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.Connection.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.Connection.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.Connection.host)
DB_WORLD_NAME = config.Database.DBNames.world_db

world_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_WORLD_NAME}?charset=utf8mb4',
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine, autocommit=True, autoflush=True))


# noinspection PyUnresolvedReferences
class WorldDatabaseManager(object):
    # Player stuff.

    @staticmethod
    def player_create_info_get(race, class_) -> Optional[Playercreateinfo]:
        world_db_session = SessionHolder()
        res = world_db_session.query(Playercreateinfo).filter_by(race=race, _class=class_).first()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_spell_get(race, class_) -> list[PlayercreateinfoSpell]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoSpell).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_action_get(race, class_) -> list[PlayercreateinfoAction]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoAction).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_create_item_get(race, class_) -> list[PlayercreateinfoItem]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoItem).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    def player_get_class_level_stats(class_, level) -> Optional[PlayerClasslevelstats]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayerClasslevelstats).filter_by(level=level, _class=class_).first()
        world_db_session.close()
        return res

    @staticmethod
    def player_get_level_stats(class_, level, race) -> Optional[PlayerLevelstats]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayerLevelstats).filter_by(level=level, _class=class_, race=race).first()
        world_db_session.close()
        return res

    # Pet stuff.

    @staticmethod
    def get_pet_level_stats_by_entry_and_level(entry, level):
        world_db_session = SessionHolder()
        res = world_db_session.query(PetLevelstat).filter_by(creature_entry=entry, level=level).first()
        world_db_session.close()
        return res

    # Area stuff.

    @staticmethod
    def area_trigger_teleport_get_by_id(trigger_id) -> Optional[AreatriggerTeleport]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreatriggerTeleport).filter_by(id=trigger_id).first()
        world_db_session.close()
        return res

    @staticmethod
    def area_get_by_id(area_id) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(entry=area_id).first()
        world_db_session.close()
        return res

    @staticmethod
    def area_get_by_explore_flags(explore_flags, map_id) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(explore_flag=explore_flags, map_id=map_id).first()
        world_db_session.close()
        return res

    @staticmethod
    def area_get_by_name(area_name) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(name=area_name).first()
        world_db_session.close()
        return res

    # Exploration stuff.

    @staticmethod
    def exploration_base_xp_get_by_level(level) -> Optional[ExplorationBaseXP]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ExplorationBaseXP).filter_by(level=level).first()
        world_db_session.close()
        return res.base_xp

    # Worldport stuff.

    @staticmethod
    def worldport_get_by_name(name, return_all=False) -> [list, Optional[Worldports]]:
        world_db_session = SessionHolder()
        best_matching_location = None
        best_matching_ratio = 0
        locations = world_db_session.query(Worldports).filter(Worldports.name.like(f'%{name}%')).all()
        world_db_session.close()

        if return_all:
            return locations

        for location in locations:
            ratio = SequenceMatcher(None, location.name.lower(), name.lower()).ratio()
            if ratio > best_matching_ratio:
                best_matching_ratio = ratio
                best_matching_location = location
        return best_matching_location

    # Item stuff.

    @staticmethod
    def get_item_applied_update(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(AppliedItemUpdates).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def create_item_applied_update(entry, version):
        world_db_session = SessionHolder()
        applied_item_update = AppliedItemUpdates(entry=entry, version=version)
        world_db_session.add(applied_item_update)
        world_db_session.flush()
        world_db_session.refresh(applied_item_update)
        world_db_session.close()

    @staticmethod
    def update_item_applied_update(item_applied_update):
        world_db_session = SessionHolder()
        world_db_session.merge(item_applied_update)
        world_db_session.flush()
        world_db_session.close()

    @staticmethod
    def item_get_loot_template() -> list[ItemLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ItemLootTemplate).all()
        world_db_session.close()
        return res

    class ItemLootTemplateHolder:
        ITEM_LOOT_TEMPLATES: [int, list[ItemLootTemplate]] = {}

        @staticmethod
        def load_item_loot_template(item_loot_template):
            if item_loot_template.entry not in WorldDatabaseManager.ItemLootTemplateHolder.ITEM_LOOT_TEMPLATES:
                WorldDatabaseManager.ItemLootTemplateHolder.ITEM_LOOT_TEMPLATES[item_loot_template.entry] = []

            WorldDatabaseManager.ItemLootTemplateHolder.ITEM_LOOT_TEMPLATES[item_loot_template.entry] \
                .append(item_loot_template)

        @staticmethod
        def item_loot_template_get_by_entry(entry) -> list[ItemLootTemplate]:
            return WorldDatabaseManager.ItemLootTemplateHolder.ITEM_LOOT_TEMPLATES[entry] \
                if entry in WorldDatabaseManager.ItemLootTemplateHolder.ITEM_LOOT_TEMPLATES else []

    class ItemTemplateHolder:
        ITEM_TEMPLATES: [int, ItemTemplate] = {}

        @staticmethod
        def load_item_template(item_template):
            WorldDatabaseManager.ItemTemplateHolder.ITEM_TEMPLATES[item_template.entry] = item_template

        @staticmethod
        def item_template_get_by_entry(entry) -> Optional[ItemTemplate]:
            return WorldDatabaseManager.ItemTemplateHolder.ITEM_TEMPLATES.get(entry)

    @staticmethod
    def item_template_get_all() -> list[ItemTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ItemTemplate).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    @staticmethod
    def item_template_get_by_name(name, return_all=False) -> [list, Optional[ItemTemplate]]:
        world_db_session = SessionHolder()
        best_matching_item = None
        best_matching_ratio = 0
        items = world_db_session.query(ItemTemplate).filter(ItemTemplate.name.like(f'%{name}%'),
                                                            ItemTemplate.ignored == 0).all()
        world_db_session.close()

        if return_all:
            return items

        for item in items:
            ratio = SequenceMatcher(None, item.name.lower(), name.lower()).ratio()
            if ratio > best_matching_ratio:
                best_matching_ratio = ratio
                best_matching_item = item
        return best_matching_item

    # Reference loot.

    @staticmethod
    def reference_loot_template_get_all() -> list[ReferenceLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ReferenceLootTemplate).all()
        world_db_session.close()
        return res

    class ReferenceLootTemplateHolder:
        REFERENCE_LOOT_TEMPLATES: [int, list[ReferenceLootTemplate]] = {}

        @staticmethod
        def load_reference_loot_template(reference_loot_template):
            if reference_loot_template.entry not in \
                    WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES:
                WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES[reference_loot_template.entry] = []

            WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES[reference_loot_template.entry] \
                .append(reference_loot_template)

        @staticmethod
        def reference_loot_template_get_by_entry(entry) -> list[ReferenceLootTemplate]:
            return WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES[entry] \
                if entry in WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES else []

    # Pick Pocketing loot.
    @staticmethod
    def pickpocketing_loot_template_get_all() -> list[PickpocketingLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PickpocketingLootTemplate).all()
        world_db_session.close()
        return res

    class PickPocketingLootTemplateHolder:
        PICKPOCKETING_LOOT_TEMPLATES: [int, list[PickpocketingLootTemplate]] = {}

        @staticmethod
        def load_pickpocketing_loot_template(pickpocketing_loot_template):
            if pickpocketing_loot_template.entry not in \
                    WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES:
                WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[
                    pickpocketing_loot_template.entry] = []

            WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[pickpocketing_loot_template.entry] \
                .append(pickpocketing_loot_template)

        @staticmethod
        def pickpocketing_loot_template_get_by_entry(entry) -> list[PickpocketingLootTemplate]:
            return WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[entry] \
                if entry in WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES else []

    # Page text stuff.

    @staticmethod
    def page_text_get_by_id(page_id) -> Optional[PageText]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PageText).filter_by(entry=page_id).first()
        world_db_session.close()
        return res

    # Gameobject stuff.

    class GameobjectTemplateHolder:
        GAMEOBJECT_TEMPLATES: [int, GameobjectTemplate] = {}

        @staticmethod
        def load_gameobject_template(gameobject_template):
            WorldDatabaseManager.GameobjectTemplateHolder.GAMEOBJECT_TEMPLATES[gameobject_template.entry] = gameobject_template

        @staticmethod
        def gameobject_get_by_entry(entry) -> Optional[GameobjectTemplate]:
            return WorldDatabaseManager.GameobjectTemplateHolder.GAMEOBJECT_TEMPLATES.get(entry)

    @staticmethod
    def gameobject_template_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_get_all_spawns() -> [list[SpawnsGameobjects], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_spawn_get_by_spawn_id(spawn_id) -> [Optional[SpawnsGameobjects], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(spawn_id=spawn_id).first()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_template_get_by_entry(entry) -> Optional[GameobjectTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_get_loot_templates() -> list[GameobjectLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectLootTemplate).all()
        world_db_session.close()
        return res

    class GameObjectLootTemplateHolder:
        GAMEOBJECT_LOOT_TEMPLATES: [int, list[GameobjectLootTemplate]] = {}

        @staticmethod
        def load_gameobject_loot_template(gameobject_loot_template):
            if gameobject_loot_template.entry not in WorldDatabaseManager.GameObjectLootTemplateHolder.\
                    GAMEOBJECT_LOOT_TEMPLATES:
                WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[
                    gameobject_loot_template.entry] = []

            WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[gameobject_loot_template.entry]\
                .append(gameobject_loot_template)

        @staticmethod
        def gameobject_loot_template_get_by_loot_id(loot_id) -> list[GameobjectLootTemplate]:
            return WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[loot_id]\
                if loot_id in WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES else []

    # Fishing.

    @staticmethod
    def fishing_get_loot_templates() -> list[FishingLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(FishingLootTemplate).all()
        world_db_session.close()
        return res

    class FishingLootTemplateHolder:
        FISHING_LOOT_TEMPLATES: [int, list[FishingLootTemplate]] = {}

        @staticmethod
        def load_fishing_loot_template(fishing_loot_template):
            if fishing_loot_template.entry not in WorldDatabaseManager.FishingLootTemplateHolder.FISHING_LOOT_TEMPLATES:
                WorldDatabaseManager.FishingLootTemplateHolder.FISHING_LOOT_TEMPLATES[
                    fishing_loot_template.entry] = []

            WorldDatabaseManager.FishingLootTemplateHolder.FISHING_LOOT_TEMPLATES[fishing_loot_template.entry] \
                .append(fishing_loot_template)

        @staticmethod
        def fishing_loot_template_get_by_loot_id(loot_id) -> list[FishingLootTemplate]:
            return WorldDatabaseManager.FishingLootTemplateHolder.FISHING_LOOT_TEMPLATES[loot_id] \
                if loot_id in WorldDatabaseManager.FishingLootTemplateHolder.FISHING_LOOT_TEMPLATES else []

    # Fishing skill by zone.
    @staticmethod
    def fishing_skill_get_by_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(SkillFishingBaseLevel).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    # Creature stuff.

    class CreatureTemplateHolder:
        CREATURE_TEMPLATES: [int, CreatureTemplate] = {}

        @staticmethod
        def load_creature_template(creature_template):
            WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES[creature_template.entry] = creature_template

        @staticmethod
        def creature_get_by_entry(entry) -> Optional[CreatureTemplate]:
            return WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES.get(entry)

        @staticmethod
        def creature_trainers_by_race_class(race, class_, type):
            trainers = []
            for creature in WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES.values():
                if creature.trainer_race and creature.trainer_race != race:
                    continue
                if creature.trainer_class and creature.trainer_class != class_:
                    continue
                if creature.trainer_type != type:
                    continue
                if not creature.trainer_id:
                    continue
                trainers.append(creature)
            return trainers

    @staticmethod
    def creature_template_get_all() -> list[CreatureModelInfo]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def get_trainer_spell(spell_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(TrainerTemplate).filter_by(spell=spell_id).first()
        world_db_session.close()
        return res

    @staticmethod
    def get_trainer_spell_price_by_level(level):
        world_db_session = SessionHolder()
        res = world_db_session.query(TrainerTemplate).filter_by(reqlevel=level).first()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_all_spawns() -> [list[SpawnsCreatures], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_spawn_get_by_spawn_id(spawn_id) -> [Optional[SpawnsCreatures], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(spawn_id=spawn_id).first()
        world_db_session.close()
        return res

    class CreatureModelInfoHolder:
        CREATURE_MODEL_INFOS: [int, CreatureModelInfo] = {}

        @staticmethod
        def load_creature_model_info(creature_model_info):
            WorldDatabaseManager.CreatureModelInfoHolder.CREATURE_MODEL_INFOS[creature_model_info.modelid] = \
                creature_model_info

        @staticmethod
        def creature_get_model_info(display_id) -> Optional[CreatureModelInfo]:
            return WorldDatabaseManager.CreatureModelInfoHolder.CREATURE_MODEL_INFOS.get(display_id)

    @staticmethod
    def creature_model_info_get_all() -> list[CreatureModelInfo]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureModelInfo).all()
        world_db_session.close()
        return res

    class CreatureLootTemplateHolder:
        CREATURE_LOOT_TEMPLATES: [int, CreatureLootTemplate] = {}

        @staticmethod
        def load_creature_loot_template(creature_loot_template):
            if creature_loot_template.entry not in WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES:
                WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[creature_loot_template.entry] = []

            WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[creature_loot_template.entry]\
                .append(creature_loot_template)

        @staticmethod
        def creature_loot_template_get_by_loot_id(loot_id) -> list[CreatureLootTemplate]:
            return WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[loot_id] \
                if loot_id in WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES else []

    @staticmethod
    def creature_get_loot_templates() -> Optional[list[CreatureLootTemplate]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureLootTemplate).all()
        world_db_session.close()
        return res

    class SkinningLootTemplateHolder:
        SKINNING_LOOT_TEMPLATES: [int, SkinningLootTemplate] = {}

        @staticmethod
        def load_skinning_loot_template(skinning_loot_template):
            if skinning_loot_template.entry not in WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES:
                WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES[skinning_loot_template.entry] = []

            WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES[skinning_loot_template.entry]\
                .append(skinning_loot_template)

        @staticmethod
        def skinning_loot_template_get_by_loot_id(loot_id) -> list[SkinningLootTemplate]:
            return WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES[loot_id] \
                if loot_id in WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES else []

    @staticmethod
    def skinning_get_loot_templates() -> Optional[list[SkinningLootTemplate]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SkinningLootTemplate).all()
        world_db_session.close()
        return res

    # TODO: Move vendor stuff to holders?
    @staticmethod
    def creature_get_vendor_data(entry) -> [Optional[list[NpcVendor]], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcVendor).filter_by(entry=entry).order_by(NpcVendor.slot.asc()).all()
        world_db_session.close()
        return res

    class CreatureEquipmentHolder:
        CREATURE_EQUIPMENT: [int, CreatureEquipTemplate] = {}

        @staticmethod
        def load_creature_equip_template(creature_equip_template):
            WorldDatabaseManager.CreatureEquipmentHolder.CREATURE_EQUIPMENT[creature_equip_template.entry] \
                = creature_equip_template

        @staticmethod
        def creature_get_equipment_by_id(equipment_id) -> Optional[CreatureEquipTemplate]:
            return WorldDatabaseManager.CreatureEquipmentHolder.CREATURE_EQUIPMENT.get(equipment_id)

    @staticmethod
    def creature_equip_template_get_all() -> Optional[list[CreatureEquipTemplate]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureEquipTemplate).all()
        world_db_session.close()
        return res

    class CreatureSpellHolder:
        CREATURE_SPELLS_MAX_SPELLS = 8
        CREATURE_SPELL_TEMPLATE: [int, CreatureSpellsEntry] = {}

        @staticmethod
        def load_creature_spells(creature_spell):
            if creature_spell.entry not in WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE:
                WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE[creature_spell.entry] = []

            for index in range(WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELLS_MAX_SPELLS):
                spell_template = CreatureSpellsEntry(creature_spell, index + 1)
                WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE[creature_spell.entry].append(spell_template)

        @staticmethod
        def get_creature_spell_by_spell_list_id(spell_list_id) -> Optional[list[CreatureSpell]]:
            return WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE.get(spell_list_id)

    @staticmethod
    def creature_get_spell() -> Optional[list[CreatureSpell]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureSpell).all()
        world_db_session.close()
        return res

    class CreatureOnKillReputationHolder:
        CREATURE_ON_KILL_REPUTATION: [int, CreatureOnkillReputation] = {}

        @staticmethod
        def load_creature_on_kill_reputation(creature_on_kill_reputation):
            WorldDatabaseManager.CreatureOnKillReputationHolder.CREATURE_ON_KILL_REPUTATION[
                creature_on_kill_reputation.creature_id] = creature_on_kill_reputation

        @staticmethod
        def creature_on_kill_reputation_get_by_entry(entry):
            return WorldDatabaseManager.CreatureOnKillReputationHolder.CREATURE_ON_KILL_REPUTATION.get(entry)

    @staticmethod
    def creature_on_kill_reputation_get_all() -> Optional[list[CreatureOnkillReputation]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureOnkillReputation).all()
        world_db_session.close()
        return res

    # Quest stuff.

    @staticmethod
    def quest_get_greeting_for_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestGreeting).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def quest_get_by_title(title):
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestTemplate).filter(QuestTemplate.Title.like(f'%{title}%'),
                                                           QuestTemplate.ignored == 0).all()
        world_db_session.close()
        return res
        
    class QuestRelationHolder:
        QUEST_CREATURE_STARTERS: [int, list[t_creature_quest_starter]] = {}
        QUEST_CREATURE_FINISHERS = {}
        QUEST_GAMEOBJECT_STARTERS: [int, list[t_gameobject_quest_starter]] = {}
        QUEST_GAMEOBJECT_FINISHERS = {}
        AREA_TRIGGER_RELATION = {}

        @staticmethod
        def load_area_trigger_quest_relation(area_trigger_relation):
            if area_trigger_relation.quest not in WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION:
                WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[area_trigger_relation.quest] = []

            WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[area_trigger_relation.quest].append(area_trigger_relation.id)

        @staticmethod
        def load_creature_starter_quest(creature_quest_starter):
            if creature_quest_starter.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_STARTERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_STARTERS[creature_quest_starter.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_STARTERS[creature_quest_starter.entry]\
                .append(creature_quest_starter)

        @staticmethod
        def load_creature_finisher_quest(creature_quest_finisher):
            if creature_quest_finisher.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_FINISHERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_FINISHERS[creature_quest_finisher.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_FINISHERS[creature_quest_finisher.entry]\
                .append(creature_quest_finisher)

        @staticmethod
        def load_gameobject_starter_quest(gameobject_quest_starter):
            if gameobject_quest_starter.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS[gameobject_quest_starter.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS[gameobject_quest_starter.entry] \
                .append(gameobject_quest_starter)

        @staticmethod
        def load_gameobject_finisher_quest(gameobject_quest_finisher):
            if gameobject_quest_finisher.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS[gameobject_quest_finisher.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS[gameobject_quest_finisher.entry] \
                .append(gameobject_quest_finisher)

        @staticmethod
        def creature_quest_starter_get_by_entry(entry) -> list[t_creature_quest_starter]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_STARTERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_STARTERS else []

        @staticmethod
        def creature_quest_finisher_get_by_entry(entry) -> list[t_creature_quest_finisher]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_FINISHERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_CREATURE_FINISHERS else []

        @staticmethod
        def gameobject_quest_starter_get_by_entry(entry) -> list[t_gameobject_quest_starter]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS else []

        @staticmethod
        def gameobject_quest_finisher_get_by_entry(entry) -> list[t_gameobject_quest_finisher]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS else []

    @staticmethod
    def creature_quest_starter_get_all() -> list[t_creature_quest_starter]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_quest_starter).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_quest_finisher_get_all() -> list[t_creature_quest_finisher]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_quest_finisher).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_quest_starter_get_all() -> list[t_gameobject_quest_starter]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_gameobject_quest_starter).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_quest_finisher_get_all() -> list[t_gameobject_quest_finisher]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_gameobject_quest_finisher).all()
        world_db_session.close()
        return res

    @staticmethod
    def area_trigger_quest_relations_get_all() -> list[AreatriggerQuestRelation]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreatriggerQuestRelation).all()
        world_db_session.close()
        return res

    @staticmethod
    def quest_template_get_all() -> list[QuestTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestTemplate).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    class QuestExclusiveGroupsHolder:
        EXCLUSIVE_GROUPS: dict[int, list[int]] = {}

        @staticmethod
        def load_exclusive_group(quest_template):
            if not quest_template.ExclusiveGroup:
                return
            if quest_template.ExclusiveGroup not in WorldDatabaseManager.QuestExclusiveGroupsHolder.EXCLUSIVE_GROUPS:
                WorldDatabaseManager.QuestExclusiveGroupsHolder.EXCLUSIVE_GROUPS[quest_template.ExclusiveGroup] = []

            WorldDatabaseManager.QuestExclusiveGroupsHolder.EXCLUSIVE_GROUPS[quest_template.ExclusiveGroup].append(
                quest_template.entry)

        @staticmethod
        def get_quest_for_group_id(group_id):
            if group_id not in WorldDatabaseManager.QuestExclusiveGroupsHolder.EXCLUSIVE_GROUPS:
                return []
            return WorldDatabaseManager.QuestExclusiveGroupsHolder.EXCLUSIVE_GROUPS[group_id]

    class QuestTemplateHolder:
        QUEST_TEMPLATES: dict[int, QuestTemplate] = {}

        @staticmethod
        def load_quest_template(quest_template):
            WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES[quest_template.entry] = quest_template
            WorldDatabaseManager.QuestExclusiveGroupsHolder.load_exclusive_group(quest_template)

        @staticmethod
        def quest_get_by_entry(entry) -> Optional[QuestTemplate]:
            return WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES.get(entry)

    # Trainer stuff.

    @staticmethod
    def get_npc_trainer_greeting(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcTrainerGreeting).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    class DefaultProfessionSpellHolder:
        DEFAULT_PROFESSION_SPELLS: dict[tuple[int, int], DefaultProfessionSpell] = {}
        DEFAULT_PROFESSION_SPELL_BY_TRAINER_SPELL: dict[int, int] = {}
        
        @staticmethod
        def load_default_profession_spell(default_profession_spell: DefaultProfessionSpell):
            WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[(default_profession_spell.trainer_spell, default_profession_spell.default_spell)] = default_profession_spell

        @staticmethod
        def default_profession_spells_get_by_trainer_spell_id(trainer_spell_id: int) -> list[DefaultProfessionSpell]:
            default_profession_spells: list[DefaultProfessionSpell] = []
            for profession_spell in WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS:
                if WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[profession_spell].trainer_spell == trainer_spell_id:
                    default_profession_spells.append(WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[profession_spell])

            return default_profession_spells

    @staticmethod
    def default_profession_spell_get_all() -> list[DefaultProfessionSpell]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(DefaultProfessionSpell).all()
        world_db_session.close()
        return res

    class TrainerSpellHolder:
        TRAINER_SPELLS: dict[tuple[int, int], TrainerTemplate] = {}
        # Custom constant value for talent trainer template id.
        # Use this value to retrieve talents from trainer_template.
        TRAINER_TEMPLATE_TALENT_ID = 1000
        TALENTS: list[TrainerTemplate] = []
        PLAYER_TALENT_SPELL_BY_TRAINER_SPELL: dict[int, int] = {}

        @staticmethod
        def load_trainer_spell(trainer_spell: TrainerTemplate):
            WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[(trainer_spell.template_entry, trainer_spell.spell)] = trainer_spell
            # If this trainer template references a talent spell, load it in the corresponding table too.
            if trainer_spell.template_entry == WorldDatabaseManager.TrainerSpellHolder.TRAINER_TEMPLATE_TALENT_ID:
                WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL[trainer_spell.spell] = trainer_spell.playerspell
                WorldDatabaseManager.TrainerSpellHolder.TALENTS.append(trainer_spell)

        @staticmethod
        def get_player_spell_by_trainer_spell_id(trainer_spell_id):
            return WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL[trainer_spell_id] if \
                trainer_spell_id in WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL else 0

        @staticmethod
        def trainer_spells_get_by_trainer(trainer_entry_id: int) -> list[TrainerTemplate]:
            trainer_spells: list[TrainerTemplate] = []

            creature_template: CreatureTemplate = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
                trainer_entry_id)
            trainer_template_id = creature_template.trainer_id
            return WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer_id(creature_template.trainer_id)

        @staticmethod
        def trainer_spells_get_by_trainer_id(trainer_template_id: int) -> list[TrainerTemplate]:
            trainer_spells: list[TrainerTemplate] = []
            for t_spell in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS:
                if WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].template_entry == trainer_template_id:
                    trainer_spells.append(WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell])

            return trainer_spells

        # Returns the trainer spell database entry for a given trainer id/trainer spell id.
        @staticmethod
        def trainer_spell_entry_get_by_trainer_and_spell(trainer_id: int, spell_id: int) -> Optional[TrainerTemplate]:
            return WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[(trainer_id, spell_id)] \
                if (trainer_id, spell_id) in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS else None

        # Returns the trainer spell that the trainer casts from the trainer spell entry.
        @staticmethod
        def trainer_spell_id_get_from_player_spell_id(trainer_id: int, player_spell_id: int) -> Optional[int]:
            for t_spell in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS:
                if WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].template_entry == trainer_id:
                    if WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].playerspell == player_spell_id:
                        return WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].spell

            return None

    @staticmethod
    def trainer_spell_get_all() -> list[TrainerTemplate]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(TrainerTemplate).all()
        world_db_session.close()
        return res

    # Spell chain / trainer stuff (for chaining together spell ranks)

    class SpellChainHolder:
        SPELL_CHAINS: dict[int, SpellChain] = {}

        @staticmethod
        def load_spell_chain(spell_chain: SpellChain):
            WorldDatabaseManager.SpellChainHolder.SPELL_CHAINS[spell_chain.spell_id] = spell_chain
        
        @staticmethod
        def spell_chain_get_by_spell(spell_id: int) -> Optional[SpellChain]:
            if spell_id in WorldDatabaseManager.SpellChainHolder.SPELL_CHAINS:
                return WorldDatabaseManager.SpellChainHolder.SPELL_CHAINS[spell_id]
            return None

    @staticmethod
    def spell_chain_get_all() -> list[SpellChain]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(SpellChain).all()
        world_db_session.close()
        return res

    @staticmethod
    def spell_target_position_get_by_spell(spell_id) -> Optional[SpellTargetPosition]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(SpellTargetPosition).filter_by(id=spell_id).first()
        world_db_session.close()
        return res

    # Gossip.

    class QuestGossipHolder:
        NPC_GOSSIPS: dict[int, NpcGossip] = {}
        NPC_TEXTS: dict[int, NpcText] = {}
        DEFAULT_GREETING_TEXT_ID = 68  # Greetings $N

        @staticmethod
        def load_npc_gossip(npc_gossip: NpcGossip):
            WorldDatabaseManager.QuestGossipHolder.NPC_GOSSIPS[npc_gossip.npc_guid] = npc_gossip

        @staticmethod
        def load_npc_text(npc_text: NpcText):
            WorldDatabaseManager.QuestGossipHolder.NPC_TEXTS[npc_text.id] = npc_text
        
        @staticmethod
        def npc_gossip_get_by_guid(npc_guid: int) -> Optional[NpcGossip]:
            return WorldDatabaseManager.QuestGossipHolder.NPC_GOSSIPS.get(npc_guid & ~HighGuid.HIGHGUID_UNIT)

        @staticmethod
        def npc_text_get_by_id(text_id: int) -> Optional[NpcText]:
            return WorldDatabaseManager.QuestGossipHolder.NPC_TEXTS.get(text_id)

    @staticmethod
    def npc_gossip_get_all() -> list[NpcGossip]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(NpcGossip).all()
        world_db_session.close()
        return res

    @staticmethod
    def npc_text_get_all() -> list[NpcText]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(NpcText).all()
        world_db_session.close()
        return res
