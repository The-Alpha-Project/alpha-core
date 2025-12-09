from functools import lru_cache
from typing import Optional, Dict, List, Union
from difflib import SequenceMatcher

from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.world.WorldModels import *
from database.world.WorldModels import Condition
from game.world.managers.objects.units.creature.CreatureSpellsEntry import CreatureSpellsEntry
from utils.ConfigManager import *
from utils.Logger import Logger
from utils.constants.MiscCodes import Languages
from utils.constants.ScriptCodes import WaypointPathOrigin

DB_USER = os.getenv('MYSQL_USERNAME', config.Database.World.username)
DB_PASSWORD = os.getenv('MYSQL_PASSWORD', config.Database.World.password)
DB_HOST = os.getenv('MYSQL_HOST', config.Database.World.host)
DB_PORT = os.getenv('MYSQL_TCP_PORT', config.Database.World.port)
DB_WORLD_NAME = config.Database.World.db_name

world_db_engine = create_engine(f'mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_WORLD_NAME}?charset=utf8mb4',
                                pool_pre_ping=True)
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine, autoflush=True))


# noinspection PyUnresolvedReferences
class WorldDatabaseManager(object):
    # Player.

    @staticmethod
    @lru_cache
    def player_create_info_get(race, class_) -> Optional[Playercreateinfo]:
        world_db_session = SessionHolder()
        res = world_db_session.query(Playercreateinfo).filter_by(race=race, _class=class_).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def player_create_spell_get(race, class_) -> list[PlayercreateinfoSpell]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoSpell).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def player_create_action_get(race, class_) -> list[PlayercreateinfoAction]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayercreateinfoAction).filter_by(race=race, _class=class_).all()
        world_db_session.close()
        return res

    class UnitClassLevelStatsHolder:
        CLASS_LEVEL_STATS: Dict[int, Dict[int, PlayerClasslevelstats]] = {}

        @staticmethod
        def load_player_class_level_stats(stats):
            if stats.class_ not in WorldDatabaseManager.UnitClassLevelStatsHolder.CLASS_LEVEL_STATS:
                WorldDatabaseManager.UnitClassLevelStatsHolder.CLASS_LEVEL_STATS[stats.class_] = {}
            WorldDatabaseManager.UnitClassLevelStatsHolder.CLASS_LEVEL_STATS[stats.class_][stats.level] = stats

        @staticmethod
        @lru_cache
        def get_for_class_level(class_, level) -> Optional[PlayerClasslevelstats]:
            if class_ not in WorldDatabaseManager.UnitClassLevelStatsHolder.CLASS_LEVEL_STATS:
                return None
            return WorldDatabaseManager.UnitClassLevelStatsHolder.CLASS_LEVEL_STATS[class_].get(level, None)

    @staticmethod
    def player_class_level_stats_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayerClasslevelstats).all()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def player_get_level_stats(class_, level, race) -> Optional[PlayerLevelstats]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PlayerLevelstats).filter_by(level=level, _class=class_, race=race).first()
        world_db_session.close()
        return res

    # Pet.

    @staticmethod
    @lru_cache
    def get_pet_level_stats_by_entry_and_level(entry, level):
        world_db_session = SessionHolder()
        res = world_db_session.query(PetLevelstat).filter_by(creature_entry=entry, level=level).first()
        world_db_session.close()
        return res

    # Area.

    @staticmethod
    @lru_cache
    def area_trigger_teleport_get_by_id(trigger_id) -> Optional[AreatriggerTeleport]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreatriggerTeleport).filter_by(id=trigger_id).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_id(area_id) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(entry=area_id).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_explore_flags(explore_flags, map_id) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(explore_flag=explore_flags, map_id=map_id).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def area_get_by_name(area_name) -> Optional[AreaTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(AreaTemplate).filter_by(name=area_name).first()
        world_db_session.close()
        return res

    # Exploration.

    @staticmethod
    @lru_cache
    def exploration_base_xp_get_by_level(level) -> int:
        world_db_session = SessionHolder()
        res = world_db_session.query(ExplorationBaseXP).filter_by(level=level).first()
        world_db_session.close()
        return res.base_xp if res else 0

    # Worldport.

    @staticmethod
    def worldport_get_by_name(name, return_all=False) -> Union[Worldports, Optional[list[Worldports]]]:
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

    # Item.

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
        world_db_session.commit()
        world_db_session.refresh(applied_item_update)
        world_db_session.close()

    @staticmethod
    def update_item_applied_update(item_applied_update):
        world_db_session = SessionHolder()
        world_db_session.merge(item_applied_update)
        world_db_session.commit()
        world_db_session.close()

    @staticmethod
    def item_get_loot_template() -> list[ItemLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ItemLootTemplate).all()
        world_db_session.close()
        return res

    class ItemLootTemplateHolder:
        ITEM_LOOT_TEMPLATES: Dict[int, List[ItemLootTemplate]] = {}

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
        ITEM_TEMPLATES: Dict[int, ItemTemplate] = {}

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
    def item_template_get_by_entry(entry) -> Optional[ItemTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(ItemTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def item_template_get_by_name(name, return_all=False) -> list[Optional[ItemTemplate]]:
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
        REFERENCE_LOOT_TEMPLATES: Dict[int, List[ReferenceLootTemplate]] = {}

        @staticmethod
        def load_reference_loot_template(reference_loot_template):
            entry = reference_loot_template.entry
            if entry not in WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES:
                WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES[entry] = []

            WorldDatabaseManager.ReferenceLootTemplateHolder.REFERENCE_LOOT_TEMPLATES[entry]\
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
        PICKPOCKETING_LOOT_TEMPLATES: Dict[int, List[PickpocketingLootTemplate]] = {}

        @staticmethod
        def load_pickpocketing_loot_template(pickpocketing_loot_template):
            entry = pickpocketing_loot_template.entry
            if entry not in WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES:
                WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[entry] = []

            WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[entry]\
                .append(pickpocketing_loot_template)

        @staticmethod
        def pickpocketing_loot_template_get_by_entry(entry) -> list[PickpocketingLootTemplate]:
            return WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES[entry] \
                if entry in WorldDatabaseManager.PickPocketingLootTemplateHolder.PICKPOCKETING_LOOT_TEMPLATES else []

    # Page text.

    @staticmethod
    @lru_cache
    def page_text_get_by_id(page_id) -> Optional[PageText]:
        world_db_session = SessionHolder()
        res = world_db_session.query(PageText).filter_by(entry=page_id).first()
        world_db_session.close()
        return res

    # Gameobject.

    class GameobjectTemplateHolder:
        GAMEOBJECT_TEMPLATES: Dict[int, GameobjectTemplate] = {}

        @staticmethod
        def load_gameobject_template(gameobject_template):
            entry = gameobject_template.entry
            WorldDatabaseManager.GameobjectTemplateHolder.GAMEOBJECT_TEMPLATES[entry] = gameobject_template

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
    def gameobject_get_all_spawns() -> List[SpawnsGameobjects]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_get_max_spawn_id() -> int:
        world_db_session = SessionHolder()
        res = world_db_session.query(func.max(SpawnsGameobjects.spawn_id)).filter_by(ignored=0).scalar()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_get_all_spawns_by_map_id(map_id) -> List[SpawnsGameobjects]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(ignored=0, spawn_map=map_id).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_spawn_get_by_spawn_id(spawn_id) -> Optional[SpawnsGameobjects]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsGameobjects).filter_by(spawn_id=spawn_id).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def gameobject_template_get_by_entry(entry) -> Optional[GameobjectTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_get_loot_templates() -> List[GameobjectLootTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(GameobjectLootTemplate).all()
        world_db_session.close()
        return res

    class GameObjectLootTemplateHolder:
        GAMEOBJECT_LOOT_TEMPLATES: Dict[int, List[GameobjectLootTemplate]] = {}

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
        FISHING_LOOT_TEMPLATES: Dict[int, List[FishingLootTemplate]] = {}

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
    @lru_cache
    def fishing_skill_get_by_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(SkillFishingBaseLevel).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    # Pools.
    class PoolsHolder:
        POOL_POOL: Dict[int, PoolPool] = {}
        POOL_TEMPLATES: Dict[int, PoolTemplate] = {}
        POOL_CREATURES: Dict[int, PoolCreature] = {}
        POOL_CREATURES_TEMPLATES: Dict[int, List[PoolCreatureTemplate]] = {}
        POOL_GAMEOBJECTS: Dict[int, List[PoolGameobject]] = {}
        POOL_GAMEOBJECTS_TEMPLATES: Dict[int, List[PoolGameobjectTemplate]] = {}

        @staticmethod
        def get_pool_pool_by_entry(entry):
            if entry in WorldDatabaseManager.PoolsHolder.POOL_POOL:
                return WorldDatabaseManager.PoolsHolder.POOL_POOL[entry]
            return None

        @staticmethod
        def get_pool_template_by_entry(entry):
            if entry in WorldDatabaseManager.PoolsHolder.POOL_TEMPLATES:
                return WorldDatabaseManager.PoolsHolder.POOL_TEMPLATES[entry]
            return None

        @staticmethod
        def get_gameobject_pool_by_spawn_id(spawn_id):
            if spawn_id in WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS:
                return WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS.get(spawn_id)
            return None

        @staticmethod
        def get_creature_pool_by_spawn_id(spawn_id):
            if spawn_id in WorldDatabaseManager.PoolsHolder.POOL_CREATURES:
                return WorldDatabaseManager.PoolsHolder.POOL_CREATURES.get(spawn_id)
            return None

        @staticmethod
        def get_gameobject_spawn_pool_template_by_template_entry(entry):
            if entry in WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS_TEMPLATES:
                return WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS_TEMPLATES.get(entry)
            return None

        @staticmethod
        def get_creature_spawn_pool_template_by_template_entry(entry):
            if entry in WorldDatabaseManager.PoolsHolder.POOL_CREATURES_TEMPLATES:
                return WorldDatabaseManager.PoolsHolder.POOL_CREATURES_TEMPLATES.get(entry)
            return None

        @staticmethod
        def load_pool_pool(pool_pool):
            if pool_pool.pool_id not in WorldDatabaseManager.PoolsHolder.POOL_POOL:
                WorldDatabaseManager.PoolsHolder.POOL_POOL[pool_pool.pool_id] = pool_pool

        @staticmethod
        def load_pool_template(pool_template):
            if pool_template.pool_entry not in WorldDatabaseManager.PoolsHolder.POOL_TEMPLATES:
                WorldDatabaseManager.PoolsHolder.POOL_TEMPLATES[pool_template.pool_entry] = pool_template

        @staticmethod
        def load_pool_creature(pool_creature):
            if pool_creature.guid not in WorldDatabaseManager.PoolsHolder.POOL_CREATURES:
                WorldDatabaseManager.PoolsHolder.POOL_CREATURES[pool_creature.guid] = pool_creature

        @staticmethod
        def load_pool_creature_template(pool_creature_template):
            if pool_creature_template.id not in WorldDatabaseManager.PoolsHolder.POOL_CREATURES_TEMPLATES:
                WorldDatabaseManager.PoolsHolder.POOL_CREATURES_TEMPLATES[pool_creature_template.id] \
                    = pool_creature_template

        @staticmethod
        def load_pool_gameobject(pool_gameobject):
            if pool_gameobject.guid not in WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS:
                WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS[pool_gameobject.guid] = pool_gameobject

        @staticmethod
        def load_pool_gameobject_template(pool_gameobject_template):
            if pool_gameobject_template.id not in WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS_TEMPLATES:
                WorldDatabaseManager.PoolsHolder.POOL_GAMEOBJECTS_TEMPLATES[pool_gameobject_template.id] \
                    = pool_gameobject_template

    @staticmethod
    def pool_creature_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolCreature).all()
        world_db_session.close()
        return res

    @staticmethod
    def pool_creature_template_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolCreatureTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def pool_gameobject_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolGameobject).all()
        world_db_session.close()
        return res

    @staticmethod
    def pool_gameobject_template_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolGameobjectTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def pool_pool_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolPool).all()
        world_db_session.close()
        return res

    @staticmethod
    def pool_template_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(PoolTemplate).all()
        world_db_session.close()
        return res

    # Creature.

    @staticmethod
    def creature_movement_get_all() -> list[CreatureMovement]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureMovement).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_movement_template_get_all() -> list[CreatureMovementTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureMovementTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_movement_special_get_all() -> list[CreatureMovementSpecial]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureMovementSpecial).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_groups_get_all() -> list[CreatureGroup]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureGroup).all()
        world_db_session.close()
        return res

    class CreatureGroupsHolder:
        CREATURE_GROUP_BY_MEMBER: dict = {}

        @staticmethod
        def load_creature_groups(creature_group):
            leader_guid = creature_group.leader_guid
            member_guid = creature_group.member_guid
            if creature_group.leader_guid not in WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER:
                WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER[leader_guid] = creature_group

            if creature_group.member_guid not in WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER:
                WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER[member_guid] = creature_group

        @staticmethod
        def get_group_by_member_spawn_id(spawn_id):
            if spawn_id in WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER:
                return WorldDatabaseManager.CreatureGroupsHolder.CREATURE_GROUP_BY_MEMBER[spawn_id]
            return []

    class CreatureMovementHolder:
        CREATURE_WAYPOINTS: Dict[int, List[CreatureMovement]] = {}
        CREATURE_MOVEMENT_TEMPLATES: Dict[int, List[CreatureMovementTemplate]] = {}
        CREATURE_MOVEMENT_SPECIAL: Dict[int, List[CreatureMovementSpecial]] = {}

        @staticmethod
        def load_creature_movement_template(movement_template):
            entry = movement_template.entry
            if entry not in WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES:
                WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES[entry] = []
            WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES[entry].append(movement_template)

        @staticmethod
        def load_creature_movement(creature_movement):
            id_ = creature_movement.id
            if id_ not in WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS:
                WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS[id_] = []
            WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS[id_].append(creature_movement)

        @staticmethod
        def load_creature_movement_special(creature_movement_special):
            id_ = creature_movement_special.id
            if id_ not in WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL:
                WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL[id_] = []
            WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL[id_].append(
                creature_movement_special)

        @staticmethod
        def get_waypoints_for_creature(entry, guid, path_origin: WaypointPathOrigin = WaypointPathOrigin.PATH_NO_PATH):
            if path_origin == WaypointPathOrigin.PATH_FROM_GUID:
                return WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS.get(guid, [])
            elif path_origin == WaypointPathOrigin.PATH_FROM_SPECIAL:
                return WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL.get(entry, [])
            elif path_origin == WaypointPathOrigin.PATH_FROM_ENTRY:
                return WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES.get(entry, [])
            else:
                if guid in WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS:
                    return WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS[guid]
                if entry in WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES:
                    return WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES[entry]
                if entry in WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL:
                    return WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_SPECIAL[entry]
            return []

        @staticmethod
        def get_waypoints_by_entry(entry):
            if entry in WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES:
                return WorldDatabaseManager.CreatureMovementHolder.CREATURE_MOVEMENT_TEMPLATES[entry]
            return []

        @staticmethod
        def get_waypoints_by_spawn_id(spawn_id) -> list[CreatureMovement]:
            if spawn_id in WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS:
                return WorldDatabaseManager.CreatureMovementHolder.CREATURE_WAYPOINTS[spawn_id]
            return []

    class CreatureTemplateHolder:
        CREATURE_TEMPLATES: Dict[int, CreatureTemplate] = {}

        @staticmethod
        def load_creature_template(creature_template):
            WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES[creature_template.entry] = creature_template

        @staticmethod
        def creature_get_by_entry(entry) -> Optional[CreatureTemplate]:
            return WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES.get(entry)

        @staticmethod
        def creature_get_by_name(name, return_all=False, remove_space=False) -> Union[CreatureTemplate, List[Optional[CreatureTemplate]]]:
            creatures = []
            for creature in WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES.values():
                formatted_creature_name = creature.name.lower()
                formatted_name = name.lower()
                if remove_space: 
                    # More permissive searches like "thomasmiller".
                    formatted_creature_name = formatted_creature_name.replace(" ", "")
                    formatted_name = formatted_name.replace(" ", "")

                if formatted_name in formatted_creature_name:
                    creatures.append(creature)

            if return_all:
                return creatures

            best_matching_creature = None
            best_matching_ratio = 0
            for creature in creatures:
                ratio = SequenceMatcher(None, creature.name.lower(), name.lower()).ratio()
                if ratio > best_matching_ratio:
                    best_matching_ratio = ratio
                    best_matching_creature = creature
            return best_matching_creature

        @staticmethod
        @lru_cache
        def creature_trainers_by_race_class(race, class_, type_):
            trainers = []
            for creature in WorldDatabaseManager.CreatureTemplateHolder.CREATURE_TEMPLATES.values():
                if creature.trainer_race and creature.trainer_race != race:
                    continue
                if creature.trainer_class and creature.trainer_class != class_:
                    continue
                if creature.trainer_type != type_:
                    continue
                if not creature.trainer_id:
                    continue
                trainers.append(creature)
            return trainers

    @staticmethod
    def creature_template_get_all() -> list[CreatureTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureTemplate).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_template_by_entry(entry) -> list[CreatureTemplate]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    def get_trainer_spell(spell_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(TrainerTemplate).filter_by(spell=spell_id).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def get_trainer_spell_price_by_level(level):
        world_db_session = SessionHolder()
        res = world_db_session.query(TrainerTemplate).filter_by(reqlevel=level).first()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_all_spawns() -> list[SpawnsCreatures]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(ignored=0).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_get_max_spawn_id() -> int:
        world_db_session = SessionHolder()
        res = world_db_session.query(func.max(SpawnsCreatures.spawn_id)).filter_by(ignored=0).scalar()
        world_db_session.close()
        return res

    @staticmethod
    def creature_spawn_get_by_entry(entry) -> list[SpawnsCreatures]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(spawn_entry1=entry).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_spawn_get_by_map_id(map_id) -> list[SpawnsCreatures]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(ignored=0, map=map_id).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_spawn_get_by_spawn_id(spawn_id) -> Optional[SpawnsCreatures]:
        world_db_session = SessionHolder()
        res = world_db_session.query(SpawnsCreatures).filter_by(spawn_id=spawn_id).first()
        world_db_session.close()
        return res

    class CreatureModelInfoHolder:
        CREATURE_MODEL_INFOS: Dict[int, CreatureModelInfo] = {}

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
        CREATURE_LOOT_TEMPLATES: Dict[int, List[CreatureLootTemplate]] = {}

        @staticmethod
        def load_creature_loot_template(creature_loot_template):
            entry = creature_loot_template.entry
            if entry not in WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES:
                WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[entry] = []

            WorldDatabaseManager.CreatureLootTemplateHolder.CREATURE_LOOT_TEMPLATES[entry]\
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

    class CreatureClassLevelStatsHolder:
        CREATURE_CLASS_LEVEL_STATS: Dict[int, Dict[int, CreatureClassLevelStats]] = {}

        @staticmethod
        def load_creature_class_level_stats(creature_class_level_stats):
            class_id = creature_class_level_stats.class_
            level = creature_class_level_stats.level
            if class_id not in WorldDatabaseManager.CreatureClassLevelStatsHolder.CREATURE_CLASS_LEVEL_STATS:
                WorldDatabaseManager.CreatureClassLevelStatsHolder.CREATURE_CLASS_LEVEL_STATS[class_id] = {}

            WorldDatabaseManager.CreatureClassLevelStatsHolder.CREATURE_CLASS_LEVEL_STATS[class_id][level] = \
                creature_class_level_stats

        @staticmethod
        def creature_class_level_stats_get_by_class_and_level(class_id, level) -> Optional[CreatureClassLevelStats]:
            return WorldDatabaseManager.CreatureClassLevelStatsHolder.CREATURE_CLASS_LEVEL_STATS[class_id][level]

    @staticmethod
    def creature_class_level_stats_get_all() -> Optional[list[CreatureClassLevelStats]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureClassLevelStats).all()
        world_db_session.close()
        return res

    class SkinningLootTemplateHolder:
        SKINNING_LOOT_TEMPLATES: Dict[int, List[SkinningLootTemplate]] = {}

        @staticmethod
        def load_skinning_loot_template(skinning_loot_template):
            entry = skinning_loot_template.entry
            if entry not in WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES:
                WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES[entry] = []

            WorldDatabaseManager.SkinningLootTemplateHolder.SKINNING_LOOT_TEMPLATES[entry]\
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

    @staticmethod
    @lru_cache
    def creature_get_vendor_data(entry) -> Optional[list[NpcVendor]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcVendor).filter_by(entry=entry).order_by(NpcVendor.slot.asc()).all()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def creature_get_vendor_template_data(vendor_id) -> Optional[list[NpcVendorTemplate]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(NpcVendorTemplate).filter_by(entry=vendor_id).order_by(
            NpcVendorTemplate.slot.asc()).all()
        world_db_session.close()
        return res

    class CreatureEquipmentHolder:
        CREATURE_EQUIPMENT: Dict[int, CreatureEquipTemplate] = {}

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
        CREATURE_SPELL_TEMPLATE: Dict[int, List[CreatureSpellsEntry]] = {}

        @staticmethod
        def load_creature_spells(creature_spell):
            if creature_spell.entry not in WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE:
                WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE[creature_spell.entry] = []

            for index in range(WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELLS_MAX_SPELLS):
                template = CreatureSpellsEntry(creature_spell, index + 1)
                WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE[creature_spell.entry].append(template)

        @staticmethod
        def get_creature_spell_by_spell_list_id(spell_list_id) -> Optional[list[CreatureSpellsEntry]]:
            return WorldDatabaseManager.CreatureSpellHolder.CREATURE_SPELL_TEMPLATE.get(spell_list_id)

    @staticmethod
    def creature_get_spell() -> Optional[list[CreatureSpell]]:
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureSpell).all()
        world_db_session.close()
        return res

    class CreatureOnKillReputationHolder:
        CREATURE_ON_KILL_REPUTATION: Dict[int, CreatureOnkillReputation] = {}

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

    # Quest.

    @staticmethod
    @lru_cache
    def quest_get_greeting_for_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestGreeting).filter_by(entry=entry).first()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def quest_get_by_title(title):
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestTemplate).filter(QuestTemplate.Title.like(f'%{title}%'),
                                                           QuestTemplate.ignored == 0).all()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def quest_get_by_entry(entry):
        world_db_session = SessionHolder()
        res = world_db_session.query(QuestTemplate).filter_by(entry=entry).first()
        world_db_session.close()
        return res
        
    class QuestRelationHolder:
        QUEST_UNIT_STARTERS: Dict[int, List[t_creature_quest_starter]] = {}
        QUEST_UNIT_FINISHERS: Dict[int, List[t_creature_quest_finisher]] = {}
        UNIT_STARTER_BY_QUEST: Dict[int, List[t_creature_quest_starter]] = {}
        UNIT_FINISHER_BY_QUEST: Dict[int, List[t_creature_quest_starter]] = {}
        QUEST_GAMEOBJECT_STARTERS: Dict[int, List[t_gameobject_quest_starter]] = {}
        QUEST_GAMEOBJECT_FINISHERS: Dict[int, List[t_gameobject_quest_finisher]] = {}
        AREA_TRIGGER_RELATION = {}

        @staticmethod
        def load_area_trigger_quest_relation(relation):
            if relation.quest not in WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION:
                WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[relation.quest] = []

            WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[relation.quest].append(relation.id)

        @staticmethod
        def load_creature_starter_quest(unit_quest_starter):
            if unit_quest_starter.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_STARTERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_STARTERS[unit_quest_starter.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_STARTERS[unit_quest_starter.entry] \
                .append(unit_quest_starter)

            if unit_quest_starter.quest not in WorldDatabaseManager.QuestRelationHolder.UNIT_STARTER_BY_QUEST:
                WorldDatabaseManager.QuestRelationHolder.UNIT_STARTER_BY_QUEST[unit_quest_starter.quest] = []

            WorldDatabaseManager.QuestRelationHolder.UNIT_STARTER_BY_QUEST[unit_quest_starter.quest]\
                .append(unit_quest_starter.entry)

        @staticmethod
        def load_creature_finisher_quest(unit_quest_finisher):
            if unit_quest_finisher.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_FINISHERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_FINISHERS[unit_quest_finisher.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_FINISHERS[unit_quest_finisher.entry]\
                .append(unit_quest_finisher)

            if unit_quest_finisher.quest not in WorldDatabaseManager.QuestRelationHolder.UNIT_FINISHER_BY_QUEST:
                WorldDatabaseManager.QuestRelationHolder.UNIT_FINISHER_BY_QUEST[unit_quest_finisher.quest] = []

            WorldDatabaseManager.QuestRelationHolder.UNIT_FINISHER_BY_QUEST[unit_quest_finisher.quest] \
                .append(unit_quest_finisher.entry)

        @staticmethod
        def load_gameobject_starter_quest(go_quest_starter):
            if go_quest_starter.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS[go_quest_starter.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS[go_quest_starter.entry] \
                .append(go_quest_starter)

        @staticmethod
        def load_gameobject_finisher_quest(go_quest_finisher):
            if go_quest_finisher.entry not in WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS:
                WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS[go_quest_finisher.entry] = []

            WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS[go_quest_finisher.entry] \
                .append(go_quest_finisher)

        @staticmethod
        def creature_quest_starter_get_by_entry(entry) -> List[t_creature_quest_starter]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_STARTERS.get(entry, [])

        @staticmethod
        def creature_quest_starter_entry_by_quest(quest_id):
            if quest_id not in WorldDatabaseManager.QuestRelationHolder.UNIT_STARTER_BY_QUEST:
                return 0
            return WorldDatabaseManager.QuestRelationHolder.UNIT_STARTER_BY_QUEST.get(quest_id, [])[0]

        @staticmethod
        def creature_quest_finisher_get_by_entry(entry) -> List[t_creature_quest_finisher]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_UNIT_FINISHERS.get(entry, [])

        @staticmethod
        def creature_quest_finisher_entry_by_quest(quest_id):
            if quest_id not in WorldDatabaseManager.QuestRelationHolder.UNIT_FINISHER_BY_QUEST:
                return 0
            return WorldDatabaseManager.QuestRelationHolder.UNIT_FINISHER_BY_QUEST.get(quest_id, [])[0]

        @staticmethod
        def gameobject_quest_starter_get_by_entry(entry) -> List[t_gameobject_quest_starter]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_STARTERS.get(entry, [])

        @staticmethod
        def gameobject_quest_finisher_get_by_entry(entry) -> List[t_gameobject_quest_finisher]:
            return WorldDatabaseManager.QuestRelationHolder.QUEST_GAMEOBJECT_FINISHERS.get(entry, [])

    @staticmethod
    def creature_quest_starter_get_all() -> List[t_creature_quest_starter]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_quest_starter).all()
        world_db_session.close()
        return res

    @staticmethod
    def creature_quest_finisher_get_all() -> List[t_creature_quest_finisher]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_quest_finisher).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_quest_starter_get_all() -> List[t_gameobject_quest_starter]:
        world_db_session = SessionHolder()
        res = world_db_session.query(t_gameobject_quest_starter).all()
        world_db_session.close()
        return res

    @staticmethod
    def gameobject_quest_finisher_get_all() -> List[t_gameobject_quest_finisher]:
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

    class QuestItemConditionsHolder:
        QUEST_CONDITION_ITEMS = set()

        @staticmethod
        def load_item_from_quest_item_condition(quest_condition):
            WorldDatabaseManager.QuestItemConditionsHolder.QUEST_CONDITION_ITEMS.add(quest_condition.value1)

        @staticmethod
        def is_condition_involved_for_item(item_entry):
            return item_entry in WorldDatabaseManager.QuestItemConditionsHolder.QUEST_CONDITION_ITEMS

    class QuestTemplateHolder:
        QUEST_TEMPLATES: dict[int, QuestTemplate] = {}

        @staticmethod
        def load_quest_template(quest_template):
            WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES[quest_template.entry] = quest_template
            WorldDatabaseManager.QuestExclusiveGroupsHolder.load_exclusive_group(quest_template)

        @staticmethod
        def get_quest_conditions_by_type(condition_type):
            result = set()
            for entry, quest_template in WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES.items():
                if not quest_template.RequiredCondition:
                    continue
                condition = WorldDatabaseManager.ConditionHolder.condition_get_by_id(quest_template.RequiredCondition)
                if not condition:
                    continue
                if condition.type != condition_type:
                    continue
                result.add(condition)

            return result

        @staticmethod
        def quest_get_by_entry(entry) -> Optional[QuestTemplate]:
            return WorldDatabaseManager.QuestTemplateHolder.QUEST_TEMPLATES.get(entry)

    # Event scripts.

    @staticmethod
    def event_scripts_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(t_event_scripts).all()
        world_db_session.close()
        return res

    class EventScriptHolder:
        SCRIPTS: Dict[int, List[t_event_scripts]] = {}

        @staticmethod
        def load_event_script(event_script):
            if event_script.id not in WorldDatabaseManager.EventScriptHolder.SCRIPTS:
                WorldDatabaseManager.EventScriptHolder.SCRIPTS[event_script.id] = []
            WorldDatabaseManager.EventScriptHolder.SCRIPTS[event_script.id].append(event_script)

        @staticmethod
        def event_scripts_get_by_id(script_id):
            return WorldDatabaseManager.EventScriptHolder.SCRIPTS.get(script_id, [])

    # Quest scripts.

    @staticmethod
    @lru_cache
    def quest_start_script_get_by_quest_id(quest_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(t_quest_start_scripts).filter_by(id=quest_id).all()
        world_db_session.close()
        return res

    @staticmethod
    @lru_cache
    def quest_end_script_get_by_quest_id(quest_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(t_quest_end_scripts).filter_by(id=quest_id).all()
        world_db_session.close()
        return res

    # Areatrigger scripts.

    @staticmethod
    @lru_cache
    def area_trigger_script_get_by_id(area_trigger_id):
        world_db_session = SessionHolder()
        res = world_db_session.query(t_area_trigger_scripts).filter_by(id=area_trigger_id).all()
        world_db_session.close()
        return res

    # Gameobject scripts.

    @staticmethod
    def gameobject_scripts_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(t_gameobject_scripts).all()
        world_db_session.close()
        return res

    class GameobjectScriptHolder:
        SCRIPTS: Dict[int, List[t_gameobject_scripts]] = {}

        @staticmethod
        def load_gameobject_script(script):
            if script.id not in WorldDatabaseManager.GameobjectScriptHolder.SCRIPTS:
                WorldDatabaseManager.GameobjectScriptHolder.SCRIPTS[script.id] = []
            WorldDatabaseManager.GameobjectScriptHolder.SCRIPTS[script.id].append(script)

        @staticmethod
        def gameobject_scripts_get_by_id(script_id):
            return WorldDatabaseManager.GameobjectScriptHolder.SCRIPTS.get(script_id, [])

        @staticmethod
        def has_script(spawn_id):
            return spawn_id in WorldDatabaseManager.GameobjectScriptHolder.SCRIPTS

    # Creature movement scripts.

    @staticmethod
    def creature_movement_scripts_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_movement_scripts).all()
        world_db_session.close()
        return res

    class CreatureMovementScriptHolder:
        SCRIPTS: Dict[int, List[t_creature_movement_scripts]] = {}

        @staticmethod
        def load_creature_movement_script(movement_script):
            if movement_script.id not in WorldDatabaseManager.CreatureMovementScriptHolder.SCRIPTS:
                WorldDatabaseManager.CreatureMovementScriptHolder.SCRIPTS[movement_script.id] = []
            WorldDatabaseManager.CreatureMovementScriptHolder.SCRIPTS[movement_script.id].append(movement_script)

        @staticmethod
        def creature_movement_scripts_get_by_id(script_id):
            return WorldDatabaseManager.CreatureMovementScriptHolder.SCRIPTS.get(script_id, [])

    # Creature AI scripts.

    @staticmethod
    def creature_ai_scripts_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(t_creature_ai_scripts).all()
        world_db_session.close()
        return res

    class CreatureAIScriptHolder:
        SCRIPTS: Dict[int, List[t_creature_ai_scripts]] = {}

        @staticmethod
        def load_creature_ai_script(ai_script):
            if ai_script.id not in WorldDatabaseManager.CreatureAIScriptHolder.SCRIPTS:
                WorldDatabaseManager.CreatureAIScriptHolder.SCRIPTS[ai_script.id] = []
            WorldDatabaseManager.CreatureAIScriptHolder.SCRIPTS[ai_script.id].append(ai_script)

        @staticmethod
        def creature_ai_scripts_get_by_id(script_id):
            return WorldDatabaseManager.CreatureAIScriptHolder.SCRIPTS.get(script_id, [])

    # Creature AI events.

    @staticmethod
    def creature_ai_event_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(CreatureAiEvent).all()
        world_db_session.close()
        return res

    class CreatureAiEventHolder:
        EVENTS_BY_ID: dict[int, CreatureAiEvent] = {}
        EVENTS_BY_CREATURE_ID: dict[int, dict[int, list[CreatureAiEvent]]] = {}

        @staticmethod
        def load_creature_ai_event(event):
            if event.id not in WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_ID:
                WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_ID[event.id] = event

            creature_id = event.creature_id
            event_type = event.event_type
            if creature_id not in WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID:
                WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID[creature_id] = {}

            if event_type not in WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID[creature_id]:
                WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID[creature_id][event_type] = []

            WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID[creature_id][event_type].append(event)

        @staticmethod
        def creature_ai_events_get_by_creature_entry(entry):
            if entry not in WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID:
                return {}
            return WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_CREATURE_ID[entry]

        @staticmethod
        def creature_ai_event_get_by_event_id(event_id):
            return WorldDatabaseManager.CreatureAiEventHolder.EVENTS_BY_ID.get(event_id, None)

    # Event conditions.

    @staticmethod
    def conditions_get_all() -> list[Condition]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(Condition).all()
        world_db_session.close()
        return res

    class ConditionHolder:
        CONDITIONS: dict[int, Condition] = {}

        @staticmethod
        def load_condition(condition: Condition):
            WorldDatabaseManager.ConditionHolder.CONDITIONS[condition.condition_entry] = condition

        @staticmethod
        def condition_get_by_id(condition_id: int) -> Optional[Condition]:
            return WorldDatabaseManager.ConditionHolder.CONDITIONS.get(condition_id)

    # Generic scripts.

    @staticmethod
    def generic_scripts_get_all():
        world_db_session = SessionHolder()
        res = world_db_session.query(t_generic_scripts).all()
        world_db_session.close()
        return res

    class GenericScriptsHolder:
        GENERIC_SCRIPTS: Dict[int, List[t_generic_scripts]] = {}

        @staticmethod
        def load_generic_script(generic_script):
            if generic_script.id not in WorldDatabaseManager.GenericScriptsHolder.GENERIC_SCRIPTS:
                WorldDatabaseManager.GenericScriptsHolder.GENERIC_SCRIPTS[generic_script.id] = []
            WorldDatabaseManager.GenericScriptsHolder.GENERIC_SCRIPTS[generic_script.id].append(generic_script)

        @staticmethod
        def generic_scripts_get_by_id(script_id):
            return WorldDatabaseManager.GenericScriptsHolder.GENERIC_SCRIPTS.get(script_id, [])

    # Trainer.

    @staticmethod
    @lru_cache
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
            key = (default_profession_spell.trainer_spell, default_profession_spell.default_spell)
            WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[key] = default_profession_spell

        @staticmethod
        def default_profession_spells_get_by_trainer_spell_id(trainer_spell_id: int) -> list[DefaultProfessionSpell]:
            default_profession_spells: list[DefaultProfessionSpell] = []
            for profession_spell in WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS:
                default = WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[profession_spell]
                if default.trainer_spell == trainer_spell_id:
                    default_profession_spells.append(
                        WorldDatabaseManager.DefaultProfessionSpellHolder.DEFAULT_PROFESSION_SPELLS[profession_spell])

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
            key = (trainer_spell.template_entry, trainer_spell.spell)
            WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[key] = trainer_spell
            # If this trainer template references a talent spell, load it in the corresponding table too.
            if trainer_spell.template_entry != WorldDatabaseManager.TrainerSpellHolder.TRAINER_TEMPLATE_TALENT_ID:
                return
            t_spell = trainer_spell.spell
            p_spell = trainer_spell.playerspell
            WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL[t_spell] = p_spell
            WorldDatabaseManager.TrainerSpellHolder.TALENTS.append(trainer_spell)

        @staticmethod
        def get_player_spell_by_trainer_spell_id(trainer_spell_id):
            return WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL[trainer_spell_id] if \
                trainer_spell_id in WorldDatabaseManager.TrainerSpellHolder.PLAYER_TALENT_SPELL_BY_TRAINER_SPELL else 0

        @staticmethod
        def trainer_spells_get_by_trainer(trainer_entry: int) -> list[TrainerTemplate]:
            creature_template: CreatureTemplate = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(
                trainer_entry)
            return WorldDatabaseManager.TrainerSpellHolder.spells_get_by_trainer_id(creature_template.trainer_id)

        @staticmethod
        def spells_get_by_trainer_id(template_id: int) -> list[TrainerTemplate]:
            trainer_spells: list[TrainerTemplate] = []
            for t_spell in WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS:
                if WorldDatabaseManager.TrainerSpellHolder.TRAINER_SPELLS[t_spell].template_entry == template_id:
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

    # Spell chain / trainer stuff (for chaining together spell ranks).

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

    # Scripted spell targets.

    class SpellScriptTargetHolder:
        SPELL_SCRIPT_TARGETS: dict[int, list[SpellScriptTarget]] = {}

        @staticmethod
        def load_spell_script_target(spell_script_target: SpellScriptTarget):
            if spell_script_target.entry not in WorldDatabaseManager.SpellScriptTargetHolder.SPELL_SCRIPT_TARGETS:
                WorldDatabaseManager.SpellScriptTargetHolder.SPELL_SCRIPT_TARGETS[spell_script_target.entry] = []
            WorldDatabaseManager.SpellScriptTargetHolder.SPELL_SCRIPT_TARGETS[spell_script_target.entry].append(spell_script_target)

        @staticmethod
        def spell_script_targets_get_by_spell(spell_id: int) -> list[SpellScriptTarget]:
            if spell_id in WorldDatabaseManager.SpellScriptTargetHolder.SPELL_SCRIPT_TARGETS:
                return WorldDatabaseManager.SpellScriptTargetHolder.SPELL_SCRIPT_TARGETS[spell_id]
            return []

    @staticmethod
    def spell_script_target_get_all() -> list[SpellScriptTarget]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(SpellScriptTarget).all()
        world_db_session.close()
        return res

    # Quest Gossip.

    class QuestGossipHolder:
        GOSSIP_MENU: dict[int, list[GossipMenu]] = {}
        NPC_GOSSIPS: dict[int, NpcGossip] = {}
        NPC_TEXTS: dict[int, NpcText] = {}
        DEFAULT_GREETING_TEXT_ID = 68  # Greetings $N

        @staticmethod
        def load_npc_gossip(npc_gossip: NpcGossip):
            WorldDatabaseManager.QuestGossipHolder.NPC_GOSSIPS[npc_gossip.npc_guid] = npc_gossip

        @staticmethod
        def load_gossip_menu(gossip_menu: GossipMenu):
            if gossip_menu.entry not in WorldDatabaseManager.QuestGossipHolder.GOSSIP_MENU:
                WorldDatabaseManager.QuestGossipHolder.GOSSIP_MENU[gossip_menu.entry] = []
            WorldDatabaseManager.QuestGossipHolder.GOSSIP_MENU[gossip_menu.entry].append(gossip_menu)

        @staticmethod
        def load_npc_text(npc_text: NpcText):
            WorldDatabaseManager.QuestGossipHolder.NPC_TEXTS[npc_text.id] = npc_text

        @staticmethod
        def gossip_menu_by_entry(entry):
            return WorldDatabaseManager.QuestGossipHolder.GOSSIP_MENU.get(entry, [])

        @staticmethod
        def npc_gossip_get_by_guid(spawn_id: int) -> Optional[NpcGossip]:
            return WorldDatabaseManager.QuestGossipHolder.NPC_GOSSIPS.get(spawn_id)

        @staticmethod
        def npc_text_get_by_id(text_id: int) -> Optional[NpcText]:
            return WorldDatabaseManager.QuestGossipHolder.NPC_TEXTS.get(text_id)

    @staticmethod
    def gossip_menu_get_all() -> list[GossipMenu]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(GossipMenu).all()
        world_db_session.close()
        return res

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

    # Broadcast Text.

    class BroadcastTextHolder:
        BROADCAST_TEXTS: dict[int, BroadcastText] = {}

        @staticmethod
        def load_broadcast_text(broadcast_text: BroadcastText):
            # Since the 0.5.3 client adds the speaker name by default we need to remove the placeholder from the 
            # broadcast text.
            broadcast_text.male_text = broadcast_text.male_text.replace('%s ', '')
            broadcast_text.female_text = broadcast_text.female_text.replace('%s ', '')
            broadcast_text.male_text = broadcast_text.male_text.replace('%s', '')
            broadcast_text.female_text = broadcast_text.female_text.replace('%s', '')
            # Default to LANG_UNIVERSAL for non-existent languages to prevent client crash.
            if broadcast_text.language_id > Languages.LANG_TROLL:
                Logger.warning(f'Invalid language id {broadcast_text.language_id} for '
                               f'broadcast text {broadcast_text.entry}.')
                broadcast_text.language_id = Languages.LANG_UNIVERSAL

            WorldDatabaseManager.BroadcastTextHolder.BROADCAST_TEXTS[broadcast_text.entry] = broadcast_text

        @staticmethod
        def broadcast_text_get_by_id(text_id: int) -> Optional[BroadcastText]:
            return WorldDatabaseManager.BroadcastTextHolder.BROADCAST_TEXTS.get(text_id)

    @staticmethod
    def broadcast_text_get_all() -> list[BroadcastText]:
        world_db_session: scoped_session = SessionHolder()
        res = world_db_session.query(BroadcastText).all()
        world_db_session.close()
        return res
