import os
from typing import Optional
from difflib import SequenceMatcher

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session

from database.world.WorldModels import *
from utils.ConfigManager import *
from utils.constants.MiscCodes import HighGuid

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.Connection.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.Connection.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.Connection.host)
DB_WORLD_NAME = config.Database.DBNames.world_db

world_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}/{DB_WORLD_NAME}?charset=utf8mb4',
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine, autocommit=True, autoflush=True))


class WorldDatabaseManager(object):
    # Player stuff

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

    # Area stuff

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

    # Exploration stuff

    @staticmethod
    def exploration_base_xp_get_by_level(level) -> Optional[ExplorationBaseXP]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ExplorationBaseXP).filter_by(level=level).first()
        world_db_session.close()
        return res.base_xp

    # Worldport stuff

    @staticmethod
    def worldport_get_by_name(name, return_all=False) -> [list, Optional[Worldports]]:
        world_db_session = SessionHolder()
        best_matching_location = None
        best_matching_ratio = 0
        locations = world_db_session.query(Worldports).filter(Worldports.name.like('%' + name + '%')).all()
        world_db_session.close()

        if return_all:
            return locations

        for location in locations:
            ratio = SequenceMatcher(None, location.name.lower(), name.lower()).ratio()
            if ratio > best_matching_ratio:
                best_matching_ratio = ratio
                best_matching_location = location
        return best_matching_location

    # Item stuff

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
        res = world_db_session.query(ItemTemplate).filter_by().all()
        world_db_session.close()
        return res

    @staticmethod
    def item_template_get_by_name(name, return_all=False) -> [list, Optional[ItemTemplate]]:
        world_db_session = SessionHolder()
        best_matching_item = None
        best_matching_ratio = 0
        items = world_db_session.query(ItemTemplate).filter(ItemTemplate.name.like('%' + name + '%')).all()
        world_db_session.close()

        if return_all:
            return items

        for item in items:
            ratio = SequenceMatcher(None, item.name.lower(), name.lower()).ratio()
            if ratio > best_matching_ratio:
                best_matching_ratio = ratio
                best_matching_item = item
        return best_matching_item

    # Page text stuff

    @staticmethod
    def page_text_get_by_id(page_id) -> Optional[PageText]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PageText).filter_by(entry=page_id).first()
        world_db_session.close()
        return res

    # Gameobject stuff

    @staticmethod
    def gameobject_get_all_spawns() -> [list[SpawnsGameobjects], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(ignored=0).all()
        return res, world_db_session

    @staticmethod
    def gameobject_spawn_get_by_guid(guid) -> [Optional[SpawnsGameobjects], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(spawn_id=guid & ~HighGuid.HIGHGUID_GAMEOBJECT).first()
        return res, world_db_session

    @staticmethod
    def gameobject_template_get_by_entry(entry) -> [Optional[GameobjectTemplate], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectTemplate).filter_by(entry=entry).first()
        return res, world_db_session

    @staticmethod
    def gameobject_get_loot_template() -> list[GameobjectLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectLootTemplate).all()
        world_db_session.close()
        return res

    class GameObjectLootTemplateHolder:
        GAMEOBJECT_LOOT_TEMPLATES: [int, list[GameobjectLootTemplate]] = {}

        @staticmethod
        def load_gameobject_loot_template(gameobject_template):
            if gameobject_template.entry not in WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES:
                WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[gameobject_template.entry] = []

            WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[gameobject_template.entry]\
                .append(gameobject_template)

        @staticmethod
        def gameobject_loot_template_get_by_entry(entry) -> list[GameobjectLootTemplate]:
            return WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES[entry]\
                if entry in WorldDatabaseManager.GameObjectLootTemplateHolder.GAMEOBJECT_LOOT_TEMPLATES else []

    # Creature stuff

    @staticmethod
    def creature_get_by_entry(entry) -> Optional[CreatureTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_all_spawns() -> [list[SpawnsCreatures], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(ignored=0).all()
        return res, world_db_session

    @staticmethod
    def creature_spawn_get_by_guid(guid) -> [Optional[SpawnsCreatures], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(spawn_id=guid & ~HighGuid.HIGHGUID_UNIT).first()
        return res, world_db_session

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
        res = world_db_session.query(CreatureModelInfo).filter_by().all()
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
        def creature_loot_template_get_by_creature(creature_entry) -> list[CreatureLootTemplate]:
            return WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[creature_entry] \
                if creature_entry in WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES else []

    @staticmethod
    def creature_get_loot_template() -> Optional[list[CreatureLootTemplate]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureLootTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_vendor_data(entry) -> [Optional[list[NpcVendor]], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcVendor).filter_by(entry=entry).all()
        return res, world_db_session

    @staticmethod
    def creature_get_vendor_data_by_item(entry, item) -> [Optional[NpcVendor], scoped_session]:
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcVendor).filter_by(entry=entry, item=item).first()
        return res, world_db_session

    @staticmethod
    def creature_get_equipment_by_id(equipment_id) -> Optional[CreatureEquipTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureEquipTemplate).filter_by(entry=equipment_id).first()
        world_db_session.close()
        return res

    class QuestRelationHolder:
        QUEST_STARTERS: [int, list[t_creature_quest_starter]] = {}
        QUEST_FINISHERS = {}

        @staticmethod
        def load_creature_starter_quest(creature_quest_starter):
            if creature_quest_starter.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_STARTERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_STARTERS[creature_quest_starter.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_STARTERS[creature_quest_starter.entry]\
                .append(creature_quest_starter)

        @staticmethod
        def load_creature_finisher_quest(creature_quest_finisher):
            if creature_quest_finisher.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_FINISHERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_FINISHERS[creature_quest_finisher.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_FINISHERS[creature_quest_finisher.entry]\
                .append(creature_quest_finisher)

        @staticmethod
        def creature_quest_starter_get_by_entry(entry) -> list[t_creature_quest_starter]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_STARTERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_STARTERS else []

        @staticmethod
        def creature_quest_finisher_get_by_entry(entry) -> list[t_creature_quest_finisher]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_FINISHERS[entry] \
                if entry in WorldDatabaseManager.QuestRelationHolder.QUEST_FINISHERS else []

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

    # Quest stuff

    class QuestTemplateHolder:
        QUEST_TEMPLATES: dict[int, QuestTemplate] = {}

        @staticmethod
        def load_quest_template(quest_template):
            WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES[quest_template.entry] = quest_template

        @staticmethod
        def quest_get_by_entry(entry) -> Optional[QuestTemplate]:
            return WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES.get(entry)

    @staticmethod
    def quest_template_get_all() -> list[QuestTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestTemplate).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    # Trainer stuff

    class TrainerSpellHolder:
        TRAINER_SPELLS: dict[tuple[int, int], TrainerTemplate] = {}
        # Custom constant value for talent trainer template id. Use this value to retrieve talents from trainer_template.
        TRAINER_TEMPLATE_TALENT_ID = 1000
        TALENTS: list[TrainerTemplate] = []

        @staticmethod
        def load_trainer_spell(trainer_spell: TrainerTemplate):
            WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[(trainer_spell.template_entry, trainer_spell.spell)] = trainer_spell
            # If this trainer template references a talent spell, load it in the corresponding table too.
            if trainer_spell.template_entry == WorldDatabaseManager.TrainerSpellHolder.TRAINER_TEMPLATE_TALENT_ID:
                WorldDatabaseManager.TrainerSpellHolder.TALENTS.append(trainer_spell)

        @staticmethod
        def trainer_spells_get_by_trainer(trainer_entry_id: int) -> list[TrainerTemplate]:
            trainer_spells: list[TrainerTemplate] = []

            creature_template: CreatureTemplate = WorldDatabaseManager.creature_get_by_entry(trainer_entry_id)
            trainer_template_id = creature_template.trainer_id

            for t_spell in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS:
                if WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].template_entry == trainer_template_id:
                    trainer_spells.append(WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell])

            return trainer_spells

        # Returns the trainer spell database entry for a given trainer id/trainer spell id.
        @staticmethod
        def trainer_spell_entry_get_by_trainer_and_spell(trainer_id: int, spell_id: int) -> Optional[TrainerTemplate]:
            return WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[(trainer_id, spell_id)] \
                if (trainer_id, spell_id) in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS else None

        # Returns the actual usable spell that the player casts from the trainer spell entry.
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

    # Gossip

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
