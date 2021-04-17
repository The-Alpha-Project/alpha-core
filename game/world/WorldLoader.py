from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from game.world.managers.objects.GameObjectManager import GameObjectManager
from utils.ConfigManager import config
from utils.Logger import Logger


class WorldLoader:

    @staticmethod
    def load_data():
        if config.Server.Settings.load_gameobjects:
            WorldLoader.load_gameobjects()
        else:
            Logger.info('Skipped game object loading.')

        if config.Server.Settings.load_creatures:
            WorldLoader.load_creature_loot_templates()
            WorldLoader.load_creatures()
        else:
            Logger.info('Skipped creature loading.')

        WorldLoader.load_item_templates()
        WorldLoader.load_spells()
        WorldLoader.load_skills()
        WorldLoader.load_skill_line_abilities()
        WorldLoader.load_taxi_nodes()
        WorldLoader.load_taxi_path_nodes()

    @staticmethod
    def load_gameobjects():
        gobject_spawns, session = WorldDatabaseManager.gameobject_get_all_spawns()
        length = len(gobject_spawns)
        count = 0

        for gobject in gobject_spawns:
            if gobject.gameobject:
                gobject_mgr = GameObjectManager(
                    gobject_template=gobject.gameobject,
                    gobject_instance=gobject
                )
                gobject_mgr.load()
            count += 1
            Logger.progress('Spawning gameobjects...', count, length)

        session.close()
        return length

    @staticmethod
    def load_creatures():
        creature_spawns, session = WorldDatabaseManager.creature_get_all_spawns()
        length = len(creature_spawns)
        count = 0

        for creature in creature_spawns:
            if creature.creature_template:
                creature_mgr = CreatureManager(
                    creature_template=creature.creature_template,
                    creature_instance=creature
                )
                creature_mgr.load()
            count += 1
            Logger.progress('Spawning creatures...', count, length)

        session.close()
        return length

    @staticmethod
    def load_creature_loot_templates():
        creature_loot_templates = WorldDatabaseManager.creature_get_loot_template()
        length = len(creature_loot_templates)
        count = 0

        for loot_template in creature_loot_templates:
            WorldDatabaseManager.CreatureLootTemplateHolder.load_creature_loot_template(loot_template)
            count += 1
            Logger.progress('Loading creature loot templates...', count, length)

        return length

    @staticmethod
    def load_item_templates():
        item_templates = WorldDatabaseManager.item_template_get_all()
        length = len(item_templates)
        count = 0

        for item_template in item_templates:
            WorldDatabaseManager.ItemTemplateHolder.load_item_template(item_template)

            count += 1
            Logger.progress('Loading item templates...', count, length)

        return length

    @staticmethod
    def load_spells():
        spells = DbcDatabaseManager.spell_get_all()
        length = len(spells)
        count = 0

        for spell in spells:
            DbcDatabaseManager.SpellHolder.load_spell(spell)

            count += 1
            Logger.progress('Loading spells...', count, length)

        return length

    @staticmethod
    def load_skills():
        skills = DbcDatabaseManager.skill_get_all()
        length = len(skills)
        count = 0

        for skill in skills:
            DbcDatabaseManager.SkillHolder.load_skill(skill)

            count += 1
            Logger.progress('Loading skills...', count, length)

        return length

    @staticmethod
    def load_skill_line_abilities():
        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_all()
        length = len(skill_line_abilities)
        count = 0

        for skill_line_ability in skill_line_abilities:
            DbcDatabaseManager.SkillLineAbilityHolder.load_skill_line_ability(skill_line_ability)

            count += 1
            Logger.progress('Loading skill line abilities...', count, length)

        return length

    @staticmethod
    def load_taxi_nodes():
        taxi_nodes = DbcDatabaseManager. taxi_nodes_get_all()
        length = len(taxi_nodes)
        count = 0

        for taxi_node in taxi_nodes:
            DbcDatabaseManager.TaxiNodesHolder.load_taxi_node(taxi_node)

            count += 1
            Logger.progress('Loading taxi nodes...', count, length)

        return length

    @staticmethod
    def load_taxi_path_nodes():
        taxi_path_nodes = DbcDatabaseManager.taxi_path_nodes_get_all()
        length = len(taxi_path_nodes)
        count = 0

        for taxi_path_node in taxi_path_nodes:
            DbcDatabaseManager.TaxiPathNodesHolder.load_taxi_path_node(taxi_path_node)

            count += 1
            Logger.progress('Loading taxi path nodes...', count, length)

        return length
