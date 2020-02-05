from sqlalchemy import create_engine, func
from sqlalchemy.orm import sessionmaker, scoped_session

from database.world.WorldModels import *
from utils.ConfigManager import *

world_db_engine = create_engine('mysql+pymysql://%s:%s@%s/%s?charset=utf8mb4' % (config.Database.Connection.username,
                                                                                 config.Database.Connection.password,
                                                                                 config.Database.Connection.host,
                                                                                 config.Database.DBNames.world_db))
SessionHolder = scoped_session(sessionmaker(bind=world_db_engine))
world_db_session = SessionHolder()
# To always keep the db data in memory (this database should be read only anyway).
world_db_session.expire_on_commit = False


class WorldDatabaseManager(object):
    @staticmethod
    def load_tables():
        WorldDatabaseManager.load_single_table(AreatriggerTeleport)
        WorldDatabaseManager.load_single_table(CreatureModelInfo)
        WorldDatabaseManager.load_single_table(CreatureSpell)
        WorldDatabaseManager.load_single_table(Creatures)
        WorldDatabaseManager.load_single_table(Gameobjects)
        WorldDatabaseManager.load_single_table(ItemTemplate)
        WorldDatabaseManager.load_single_table(NpcText)
        WorldDatabaseManager.load_single_table(PlayerClasslevelstats)
        WorldDatabaseManager.load_single_table(PlayerLevelstats)
        WorldDatabaseManager.load_single_table(Playercreateinfo)
        WorldDatabaseManager.load_single_table(PlayercreateinfoAction)
        WorldDatabaseManager.load_single_table(PlayercreateinfoItem)
        WorldDatabaseManager.load_single_table(PlayercreateinfoSkill)
        WorldDatabaseManager.load_single_table(PlayercreateinfoSpell)
        WorldDatabaseManager.load_single_table(Quests)
        WorldDatabaseManager.load_single_table(Worldports)
        WorldDatabaseManager.load_single_table(CreatureLootTemplate)
        WorldDatabaseManager.load_single_table(GameobjectLootTemplate)
        WorldDatabaseManager.load_single_table(ItemLootTemplate)
        WorldDatabaseManager.load_single_table(NpcVendor)
        WorldDatabaseManager.load_single_table(PickpocketingLootTemplate)
        WorldDatabaseManager.load_single_table(ReferenceLoot)
        WorldDatabaseManager.load_single_table(ReferenceLootTemplate)
        WorldDatabaseManager.load_single_table(SkinningLootTemplate)
        WorldDatabaseManager.load_single_table(SpawnsCreatures)
        WorldDatabaseManager.load_single_table(SpawnsGameobjects)

    @staticmethod
    def load_single_table(table):  # Hackfix
        world_db_session.add_all(world_db_session.query(table).all())

    # Player stuff

    @staticmethod
    def player_create_info_get(race, class_):
        return world_db_session.query(Playercreateinfo).filter_by(race=race, _class=class_).first()
