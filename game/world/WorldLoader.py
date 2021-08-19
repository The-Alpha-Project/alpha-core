from database.world.WorldModels import SpellChain
from database.dbc.DbcModels import Spell
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.GameObjectManager import GameObjectManager
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from game.world.managers.objects.player.GroupManager import GroupManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from utils.ConfigManager import config
from utils.Logger import Logger


class WorldLoader:

    @staticmethod
    def load_data():
        # Map tiles
        MapManager.initialize_maps()
        MapManager.initialize_area_tables()

        # Gameobject spawns
        # if config.Server.Settings.load_gameobjects:
        #     WorldLoader.load_gameobjects()
        #     WorldLoader.load_gameobject_loot_templates()
        # else:
        #     Logger.info('Skipped game object loading.')
        #
        # # Creature spawns
        # if config.Server.Settings.load_creatures:
        #     WorldLoader.load_creature_loot_templates()
        #     WorldLoader.load_creature_equip_templates()
        #     WorldLoader.load_creatures()
        #     WorldLoader.load_creature_quest_starters()
        #     WorldLoader.load_creature_quest_finishers()
        #     WorldLoader.load_creature_display_info()
        #     WorldLoader.load_creature_model_info()
        #     WorldLoader.load_npc_gossip()
        #     WorldLoader.load_npc_text()
        # else:
        #     Logger.info('Skipped creature loading.')

        WorldLoader.load_item_templates()
        WorldLoader.load_quests()
        WorldLoader.load_spells()
        WorldLoader.load_spell_chains()
        WorldLoader.load_trainer_spells()
        WorldLoader.load_skills()
        WorldLoader.load_skill_line_abilities()
        WorldLoader.load_char_base_infos()
        WorldLoader.load_taxi_nodes()
        WorldLoader.load_taxi_path_nodes()
        WorldLoader.load_factions()
        WorldLoader.load_faction_templates()

        # Character related data
        WorldLoader.load_groups()
        WorldLoader.load_guilds()

    # World data holders

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
    def load_creature_equip_templates():
        creature_equip_templates = WorldDatabaseManager.creature_equip_template_get_all()
        length = len(creature_equip_templates)
        count = 0

        for creature_equip_template in creature_equip_templates:
            WorldDatabaseManager.CreatureEquipmentHolder.load_creature_equip_template(creature_equip_template)
            count += 1
            Logger.progress('Loading creature equipment templates...', count, length)

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
    def load_gameobject_loot_templates():
        gameobject_loot_templates = WorldDatabaseManager.gameobject_get_loot_template()
        length = len(gameobject_loot_templates)
        count = 0

        for loot_template in gameobject_loot_templates:
            WorldDatabaseManager.GameObjectLootTemplateHolder.load_gameobject_loot_template(loot_template)
            count += 1
            Logger.progress('Loading gameobject loot templates...', count, length)

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
    def load_factions():
        factions = DbcDatabaseManager.faction_get_all()
        length = len(factions)
        count = 0

        for faction in factions:
            DbcDatabaseManager.FactionHolder.load_faction(faction)

            count += 1
            Logger.progress('Loading factions...', count, length)

        return length

    @staticmethod
    def load_faction_templates():
        faction_templates = DbcDatabaseManager.faction_template_get_all()
        length = len(faction_templates)
        count = 0

        for faction_template in faction_templates:
            DbcDatabaseManager.FactionTemplateHolder.load_faction_template(faction_template)

            count += 1
            Logger.progress('Loading faction templates...', count, length)

        return length

    @staticmethod
    def load_quests():
        quest_templates = WorldDatabaseManager.quest_template_get_all()
        length = len(quest_templates)
        count = 0

        for quest_template in quest_templates:
            WorldDatabaseManager.QuestTemplateHolder.load_quest_template(quest_template)

            count += 1
            Logger.progress('Loading quest templates...', count, length)

        return length

    @staticmethod
    def load_spells():
        spells: list[Spell] = DbcDatabaseManager.spell_get_all()
        length = len(spells)
        count = 0

        for spell in spells:
            DbcDatabaseManager.SpellHolder.load_spell(spell)

            count += 1
            Logger.progress('Loading spells...', count, length)

        return length

    @staticmethod
    def load_spell_chains():
        spell_chains: list[SpellChain] = WorldDatabaseManager.spell_chain_get_all()
        length = len(spell_chains)
        count = 0

        for spell_chain in spell_chains:
            WorldDatabaseManager.SpellChainHolder.load_spell_chain(spell_chain)

            count += 1
            Logger.progress('Loading spell chains...', count, length)

        return length

    @staticmethod
    def load_trainer_spells():
        trainer_spells = WorldDatabaseManager.trainer_spell_get_all()
        length = len(trainer_spells)
        count = 0

        for trainer_spell in trainer_spells:
            WorldDatabaseManager.TrainerSpellHolder.load_trainer_spell(trainer_spell)

            count += 1
            Logger.progress('Loading trainer spells...', count, length)

        return length

    @staticmethod
    def load_skills():
        skills = DbcDatabaseManager.skill_get_all()
        length = len(skills)
        count = 0

        for skill in skills:
            DbcDatabaseManager.SkillHolder.load_skill(skill)

            count += 1
            Logger.progress('Loading skill...', count, length)

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
    def load_char_base_infos():
        char_base_infos = DbcDatabaseManager.char_base_info_get_all()
        length = len(char_base_infos)
        count = 0

        for char_base_info in char_base_infos:
            DbcDatabaseManager.CharBaseInfoHolder.load_base_info(char_base_info)

            count += 1
            Logger.progress('Loading char base infos...', count, length)

        return length

    @staticmethod
    def load_taxi_nodes():
        taxi_nodes = DbcDatabaseManager.taxi_nodes_get_all()
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

    @staticmethod
    def load_creature_quest_starters():
        creature_quest_starters = WorldDatabaseManager.creature_quest_starter_get_all()
        length = len(creature_quest_starters)
        count = 0

        for creature_quest_starter in creature_quest_starters:
            WorldDatabaseManager.QuestRelationHolder.load_creature_starter_quest(creature_quest_starter)

            count += 1
            Logger.progress('Loading creature quest starters...', count, length)

        return length

    @staticmethod
    def load_creature_quest_finishers():
        creature_quest_finishers = WorldDatabaseManager.creature_quest_finisher_get_all()
        length = len(creature_quest_finishers)
        count = 0

        for creature_quest_finisher in creature_quest_finishers:
            WorldDatabaseManager.QuestRelationHolder.load_creature_finisher_quest(creature_quest_finisher)

            count += 1
            Logger.progress('Loading creature quest finishers...', count, length)

        return length

    @staticmethod
    def load_creature_display_info():
        creature_display_infos = DbcDatabaseManager.creature_display_info_get_all()
        length = len(creature_display_infos)
        count = 0

        for creature_display_info in creature_display_infos:
            DbcDatabaseManager.CreatureDisplayInfoHolder.load_creature_display_info(creature_display_info)

            count += 1
            Logger.progress('Loading creature display info...', count, length)

        return length

    @staticmethod
    def load_creature_model_info():
        creature_model_infos = WorldDatabaseManager.creature_model_info_get_all()
        length = len(creature_model_infos)
        count = 0

        for creature_model_info in creature_model_infos:
            WorldDatabaseManager.CreatureModelInfoHolder.load_creature_model_info(creature_model_info)

            count += 1
            Logger.progress('Loading creature model info...', count, length)

        return length

    @staticmethod
    def load_npc_gossip():
        npc_gossips = WorldDatabaseManager.npc_gossip_get_all()
        length = len(npc_gossips)
        count = 0

        for npc_gossip in npc_gossips:
            WorldDatabaseManager.QuestGossipHolder.load_npc_gossip(npc_gossip)

            count += 1
            Logger.progress('Loading npc gossip...', count, length)

        return length

    @staticmethod
    def load_npc_text():
        npc_texts = WorldDatabaseManager.npc_text_get_all()
        length = len(npc_texts)
        count = 0

        for npc_text in npc_texts:
            WorldDatabaseManager.QuestGossipHolder.load_npc_text(npc_text)

            count += 1
            Logger.progress('Loading npc gossip texts...', count, length)

        return length

    # Character data holders

    @staticmethod
    def load_groups():
        groups = RealmDatabaseManager.group_get_all()
        length = len(groups)
        count = 0

        for group in groups:
            GroupManager.load_group(group)

            count += 1
            Logger.progress('Loading groups...', count, length)

        return length

    @staticmethod
    def load_guilds():
        guilds = RealmDatabaseManager.guild_get_all()
        length = len(guilds)
        count = 0

        for guild in guilds:
            if guild.name not in GuildManager.GUILDS:
                GuildManager.load_guild(guild)

                count += 1
                Logger.progress('Loading guilds...', count, length)

        return length
