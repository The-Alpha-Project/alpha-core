from database.world.WorldModels import SpellChain
from database.dbc.DbcModels import Spell
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.GameObjectSpawn import GameObjectSpawn
from game.world.managers.objects.units.creature.CreatureSpawn import CreatureSpawn
from game.world.managers.objects.units.player.GroupManager import GroupManager
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellAttributes
from utils.constants.UnitCodes import Races, Classes


class WorldLoader:

    @staticmethod
    def load_data():
        # Map tiles
        MapManager.initialize_maps()
        MapManager.initialize_area_tables()

        # Below order matters.

        WorldLoader.load_creature_templates()
        # WorldLoader.load_gameobject_templates()

        # Loot related, even if not loading creatures or gameobjects, loot might be referenced.
        # WorldLoader.load_gameobject_loot_templates()
        # WorldLoader.load_fishing_loot_templates()
        # WorldLoader.load_creature_loot_templates()
        # WorldLoader.load_skinning_loot_templates()
        # WorldLoader.load_item_templates()
        # WorldLoader.load_reference_loot_templates()
        # WorldLoader.load_pickpocketing_loot_templates()
        # WorldLoader.load_item_loot_templates()

        # Spells.
        WorldLoader.load_spells()
        # WorldLoader.load_creature_spells()

        # # Gameobject spawns
        # if config.Server.Settings.load_gameobjects:
        #     WorldLoader.load_gameobject_quest_starters()
        #     WorldLoader.load_gameobject_quest_finishers()
        #     WorldLoader.load_gameobjects_spawns()
        # else:
        #     Logger.info('Skipped game object loading.')
        #
        # # Creature spawns
        # if config.Server.Settings.load_creatures:
        #     WorldLoader.load_creature_equip_templates()
        #     WorldLoader.load_creature_spawns()
        #     WorldLoader.load_creature_on_kill_reputation()
        #     WorldLoader.load_creature_quest_starters()
        #     WorldLoader.load_creature_quest_finishers()
        #     WorldLoader.load_creature_display_info()
        #     WorldLoader.load_creature_model_info()
        #     WorldLoader.load_creature_families()
        #     WorldLoader.load_npc_gossip()
        #     WorldLoader.load_npc_text()
        # else:
        #     Logger.info('Skipped creature loading.')

        # WorldLoader.load_area_trigger_quest_relations()
        # WorldLoader.load_quests()
        # WorldLoader.load_spell_chains()
        WorldLoader.load_trainer_spells()
        WorldLoader.load_char_base_infos()
        WorldLoader.load_skill_line_abilities()
        WorldLoader.load_skills()
        return


        WorldLoader.load_taxi_nodes()
        WorldLoader.load_taxi_path_nodes()
        WorldLoader.load_factions()
        WorldLoader.load_faction_templates()
        WorldLoader.load_locks()

        # Character related data
        WorldLoader.load_groups()
        WorldLoader.load_guilds()

    # World data holders

    @staticmethod
    def load_gameobject_templates():
        gobject_templates = WorldDatabaseManager.gameobject_template_get_all()
        length = len(gobject_templates)
        count = 0

        for gobject_template in gobject_templates:
            WorldDatabaseManager.GameobjectTemplateHolder.load_gameobject_template(gobject_template)
            count += 1
            Logger.progress('Loading gameobject templates...', count, length)

        return length

    @staticmethod
    def load_gameobjects_spawns():
        gobject_spawns = WorldDatabaseManager.gameobject_get_all_spawns()
        length = len(gobject_spawns)
        count = 0

        for gobject_spawn in gobject_spawns:
            gameobject_spawn = GameObjectSpawn(gobject_spawn)
            gameobject_spawn.spawn_gameobject()
            count += 1

            Logger.progress('Loading gameobject spawns...', count, length)

        return length

    @staticmethod
    def load_gameobject_quest_starters():
        gameobject_quest_starters = WorldDatabaseManager.gameobject_quest_starter_get_all()
        length = len(gameobject_quest_starters)
        count = 0

        for gameobject_quest_starter in gameobject_quest_starters:
            WorldDatabaseManager.QuestRelationHolder.load_gameobject_starter_quest(gameobject_quest_starter)

            count += 1
            Logger.progress('Loading gameobject quest starters...', count, length)

        return length

    @staticmethod
    def load_gameobject_quest_finishers():
        gameobject_quest_finishers = WorldDatabaseManager.gameobject_quest_finisher_get_all()
        length = len(gameobject_quest_finishers)
        count = 0

        for gameobject_quest_finisher in gameobject_quest_finishers:
            WorldDatabaseManager.QuestRelationHolder.load_gameobject_finisher_quest(gameobject_quest_finisher)

            count += 1
            Logger.progress('Loading gameobject quest finishers...', count, length)

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
    def load_creature_spawns():
        creature_spawns = WorldDatabaseManager.creature_get_all_spawns()
        length = len(creature_spawns)
        count = 0

        for creature_spawn in creature_spawns:
            creature_spawn = CreatureSpawn(creature_spawn)
            creature_spawn.spawn_creature()
            count += 1
            Logger.progress('Loading creature spawns...', count, length)

        return length

    @staticmethod
    def load_creature_on_kill_reputation():
        creature_on_kill_reputations = WorldDatabaseManager.creature_on_kill_reputation_get_all()
        length = len(creature_on_kill_reputations)
        count = 0

        for creature_on_kill_reputation in creature_on_kill_reputations:
            WorldDatabaseManager.CreatureOnKillReputationHolder.load_creature_on_kill_reputation(
                creature_on_kill_reputation)
            count += 1
            Logger.progress('Loading creature on kill reputations...', count, length)

        return length

    @staticmethod
    def load_creature_spells():
        creature_spells = WorldDatabaseManager.creature_get_spell()
        length = len(creature_spells)
        count = 0

        for creature_spell in creature_spells:
            WorldDatabaseManager.CreatureSpellHolder.load_creature_spells(creature_spell)
            count += 1
            Logger.progress('Loading creature spells...', count, length)

        return length

    @staticmethod
    def load_creature_loot_templates():
        creature_loot_templates = WorldDatabaseManager.creature_get_loot_templates()
        length = len(creature_loot_templates)
        count = 0

        for loot_template in creature_loot_templates:
            WorldDatabaseManager.CreatureLootTemplateHolder.load_creature_loot_template(loot_template)
            count += 1
            Logger.progress('Loading creature loot templates...', count, length)

        return length

    @staticmethod
    def load_skinning_loot_templates():
        skinning_loot_templates = WorldDatabaseManager.skinning_get_loot_templates()
        length = len(skinning_loot_templates)
        count = 0

        for loot_template in skinning_loot_templates:
            WorldDatabaseManager.SkinningLootTemplateHolder.load_skinning_loot_template(loot_template)
            count += 1
            Logger.progress('Loading skinning loot templates...', count, length)

        return length

    @staticmethod
    def load_fishing_loot_templates():
        fishing_loot_templates = WorldDatabaseManager.fishing_get_loot_templates()
        length = len(fishing_loot_templates)
        count = 0

        for loot_template in fishing_loot_templates:
            WorldDatabaseManager.FishingLootTemplateHolder.load_fishing_loot_template(loot_template)
            count += 1
            Logger.progress('Loading fishing loot templates...', count, length)

        return length

    @staticmethod
    def load_creature_templates():
        creature_templates = WorldDatabaseManager.creature_template_get_all()
        length = len(creature_templates)
        count = 0

        for creature_template in creature_templates:
            WorldDatabaseManager.CreatureTemplateHolder.load_creature_template(creature_template)
            count += 1
            Logger.progress('Loading creature templates...', count, length)

        return length

    @staticmethod
    def load_gameobject_loot_templates():
        gameobject_loot_templates = WorldDatabaseManager.gameobject_get_loot_templates()
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
    def load_item_loot_templates():
        item_loot_templates = WorldDatabaseManager.item_get_loot_template()
        length = len(item_loot_templates)
        count = 0

        for item_loot_template in item_loot_templates:
            WorldDatabaseManager.ItemLootTemplateHolder.load_item_loot_template(item_loot_template)
            count += 1
            Logger.progress('Loading item loot templates...', count, length)

        return length

    @staticmethod
    def load_pickpocketing_loot_templates():
        pickpocketing_loot_templates = WorldDatabaseManager.pickpocketing_loot_template_get_all()
        length = len(pickpocketing_loot_templates)
        count = 0

        for pickpocketing_loot_template in pickpocketing_loot_templates:
            WorldDatabaseManager.PickPocketingLootTemplateHolder.load_pickpocketing_loot_template(pickpocketing_loot_template)
            count += 1
            Logger.progress('Loading pickpocketing loot templates...', count, length)

        return length

    @staticmethod
    def load_reference_loot_templates():
        reference_loot_templates = WorldDatabaseManager.reference_loot_template_get_all()
        length = len(reference_loot_templates)
        count = 0

        for reference_loot_template in reference_loot_templates:
            WorldDatabaseManager.ReferenceLootTemplateHolder.load_reference_loot_template(reference_loot_template)
            count += 1
            Logger.progress('Loading reference loot templates...', count, length)

        return length

    @staticmethod
    def load_locks():
        locks = DbcDatabaseManager.locks_get_all()
        length = len(locks)
        count = 0

        for lock in locks:
            DbcDatabaseManager.LocksHolder.load_lock(lock)

            count += 1
            Logger.progress('Loading locks...', count, length)

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

        results = {}
        inserts = {}
        for id, race in enumerate(Races):
            for cId, class_ in enumerate(Classes):
                if race not in results:
                    results[race] = {}
                if class_ not in results[race]:
                    results[race][class_] = []
                info = DbcDatabaseManager.CharBaseInfoHolder.char_base_info_get(race.value, class_.value)
                if info:
                    race_mask = 1 << race.value - 1
                    class_mask = 1 << class_.value - 1

                    results[race][class_].append(f'\n\n{race.name}({race}) - {class_.name}({class_}) | Race Mask {race_mask} Class Mask {class_mask}')
                    initial_spells = WorldDatabaseManager.player_create_spell_get(race.value, class_.value)
                    trainer_spells = set()

                    for skill in DbcDatabaseManager.SkillHolder.SKILLS.values():
                        if skill.CategoryID == 2:  # Weapons
                            if skill.RaceMask and not skill.RaceMask & race_mask:
                                continue

                            if skill.ClassMask and not skill.ClassMask & class_mask:
                                continue

                            if skill.ExcludeRace and skill.ExcludeRace & race.value:
                                continue

                            if skill.ExcludeClass and skill.ExcludeClass & class_.value:
                                continue

                            if 'First Aid' in skill.DisplayName_enUS:
                                continue
                            # if 'First Aid' in skill.DisplayName_enUS or 'Advanced Combat' in skill.DisplayName_enUS or \
                            #         'Dueling' in skill.DisplayName_enUS or 'Savage Combat' in skill.DisplayName_enUS or \
                            #         'Shields' in skill.DisplayName_enUS or 'Curses' in skill.DisplayName_enUS or \
                            #         'Assassination' in skill.DisplayName_enUS or 'Shouts' in skill.DisplayName_enUS or \
                            #         'Street Fighting' in skill.DisplayName_enUS \
                            #         or 'Holy Strikes' in skill.DisplayName_enUS or \
                            #         'Expert Shots' in skill.DisplayName_enUS or 'Fire Shots' in skill.DisplayName_enUS or 'Frost Shots' in skill.DisplayName_enUS or 'Shapeshifting' in skill.DisplayName_enUS:
                            #     continue

                            skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_by_skill_line_id(skill.ID)

                            spells = []
                            if skill_line_ability:
                                for skill_ab in skill_line_ability:
                                    spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(skill_ab.Spell)
                                    if not spell:
                                        continue

                                    # Which spells trains this.
                                    trainer_spell = DbcDatabaseManager.SpellHolder.spell_get_trainer_spell_by_id(spell.ID)

                                    if skill_ab.RaceMask and not skill_ab.RaceMask & race_mask:
                                        continue
                                    if skill_ab.ClassMask and not skill_ab.ClassMask & class_mask:
                                        continue
                                    if skill_ab.ExcludeRace and skill_ab.ExcludeRace & race.value:
                                        continue
                                    if skill_ab.ExcludeClass and skill_ab.ExcludeClass & class_.value:
                                        continue

                                    if any(iSpell.Spell == spell.ID for iSpell in initial_spells):
                                        continue

                                    sub_name = f'- ({spell.NameSubtext_enUS})' if spell.NameSubtext_enUS else ''
                                    if trainer_spell:
                                        if trainer_spell.ID in trainer_spells:
                                            continue

                                        trainers = WorldDatabaseManager.CreatureTemplateHolder.creature_trainers_by_race_class(
                                            race, class_, 0)  # Trainer type. (Class)
                                        if trainers:
                                            exist = WorldDatabaseManager.get_trainer_spell(trainer_spell.ID)
                                            if exist:
                                                continue

                                            trainer_templates = set()
                                            for trainer in trainers:
                                                if not trainer.trainer_id:
                                                    continue

                                                if trainer.trainer_id in trainer_templates:
                                                    continue

                                                if trainer.trainer_id not in inserts:
                                                    inserts[trainer.trainer_id] = {}

                                                if spell.ID in inserts[trainer.trainer_id]:
                                                    #Logger.warning('Duple')
                                                    continue

                                                #if spell.BaseLevel > trainer.level_min:
                                                #    continue

                                                inserts[trainer.trainer_id][spell.ID] = None

                                                if spell.Attributes & SpellAttributes.SPELL_ATTR_DO_NOT_DISPLAY:
                                                    Logger.warning(f'Do not display {spell.Name_enUS}')

                                                # Insert.
                                                insert = f"INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('{trainer.trainer_id}', '{trainer_spell.ID}', '{spell.ID}', '0', '0', '2', '0', '0', '{spell.BaseLevel}');"
                                                trainer_templates.add(trainer.trainer_id)
                                                results[race][class_].append(f'-- Trainer Template ID: [{trainer.trainer_id}]')
                                                results[race][class_].append(f'-- Trainer Spell: {trainer_spell.Name_enUS} {trainer_spell.ID}')
                                                results[race][class_].append(f'-- Player Spell: {spell.Name_enUS}')
                                                results[race][class_].append(insert)
                                        else:
                                            Logger.error("No trainers!")
                                        trainer_spells.add(trainer_spell.ID)
                                        #spells.append(f' - Player Spell {spell.ID} - {spell.Name_enUS} {sub_name}')
                                        #sub_name = f'- ({trainer_spell.NameSubtext_enUS})' if trainer_spell.NameSubtext_enUS else ''
                                        #spells.append(f' * Trainer Spell {trainer_spell.ID} - {trainer_spell.Name_enUS} {sub_name} {trainer_spell.Description_enUS}')

                            if len(spells) > 0:
                                results[race][class_].append(f'Can use weapon skill [{skill.DisplayName_enUS}] ({skill.ID})')
                                for spell_ in spells:
                                    results[race][class_].append(spell_)

                if len(results[race][class_]) > 1:
                    for line in results[race][class_]:
                        print(line)

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
    def load_area_trigger_quest_relations():
        area_trigger_quest_relations = WorldDatabaseManager.area_trigger_quest_relations_get_all()
        length = len(area_trigger_quest_relations)
        count = 0

        for area_trigger_relation in area_trigger_quest_relations:
            WorldDatabaseManager.QuestRelationHolder.load_area_trigger_quest_relation(area_trigger_relation)

            count += 1
            Logger.progress('Loading area trigger quest relations...', count, length)

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
    def load_creature_families():
        creature_families = DbcDatabaseManager.creature_family_get_all()
        length = len(creature_families)
        count = 0

        for creature_family in creature_families:
            DbcDatabaseManager.CreatureFamilyHolder.load_creature_family(creature_family)

            count += 1
            Logger.progress('Loading creature families...', count, length)

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
