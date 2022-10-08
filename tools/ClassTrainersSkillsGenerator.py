from typing import NamedTuple

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldLoader import WorldLoader
from utils.constants.MiscCodes import SkillCategories, TrainerTypes
from utils.constants.UnitCodes import Races, Classes


class TrainerSpellEntry(NamedTuple):
    trainer_spell: Spell
    player_spell: Spell


class RaceClassHolder:
    def __init__(self, race, class_):
        self.race_name = Races(race).name.replace('RACE_', '')
        self.class_name = Classes(class_).name.replace('CLASS_', '')
        self.race = race
        self.class_ = class_
        self.spells = {}
        self.trainers = {}
        self.trainer_entries = set()
        self.results = {}

    def push_spell(self, trainer, trainer_spell, player_spell):
        # Ignore wrong spells. (Probably deprecated)
        if trainer_spell.Name_enUS != player_spell.Name_enUS:
            return

        if trainer.trainer_id not in self.spells:
            self.spells[trainer.trainer_id] = {}

        if trainer.trainer_id not in self.trainers:
            self.trainers[trainer.trainer_id] = []

        if trainer.entry not in self.trainer_entries:
            self.trainer_entries.add(trainer.entry)
            self.trainers[trainer.trainer_id].append(trainer)

        if trainer_spell.ID not in self.spells[trainer.trainer_id]:
            self.spells[trainer.trainer_id][trainer_spell.ID] = TrainerSpellEntry(trainer_spell, player_spell)

    def print(self):
        print('\n')
        for trainer_id, trainer_list in self.trainers.items():
            print(f'-- {self.race_name} {self.class_name}')
            print(f'-- Trainer template ID {trainer_id}')
            print(f'-- Trainers:')
            for trainer in trainer_list:
                print(f'--  {trainer.name}')

        trainer_ids = list(self.spells.keys())
        trainer_id_len = len(self.spells.keys())

        print('\n')
        for trainer_id, trainer_spell_id in self.spells.items():
            print(f'-- New spells for trainer template ID {trainer_id}')
            for _id, trainer_spell_entry in trainer_spell_id.items():
                trainer_spell = trainer_spell_entry.trainer_spell
                player_spell = trainer_spell_entry.player_spell
                trainer_id_index = trainer_ids.index(trainer_id)
                # Do not use noob trainers.
                if trainer_id_index > 0 or trainer_id_len == 1:
                    # Add this entry as a result for later use in the sql query.
                    if trainer_id not in self.results:
                        self.results[trainer_id] = list()
                    self.results[trainer_id].append(trainer_spell_entry)
                    # Print information.
                    sub_name = f' - ({trainer_spell.NameSubtext_enUS})' if trainer_spell.NameSubtext_enUS else ''
                    print(f'--  {trainer_spell.Name_enUS}{sub_name}, Trainer Spell {_id}, Player Spell {player_spell.ID}')

    @staticmethod
    def _get_spell_price(spell):
        skill_point_spells = ['sword', 'axe', 'mace', 'bow', 'polearm', 'dual wield', 'gun', 'thrown']
        # SP.
        if any(name.lower() in spell.Name_enUS.lower() for name in skill_point_spells):
            return 2, 0
        # Money.
        else:
            spell_level = 1 if not spell.BaseLevel else spell.BaseLevel
            cost = WorldDatabaseManager.get_trainer_spell_price_by_level(spell_level)
            cost = 10 if not cost else cost.spellcost
            return 0, cost

    def process_query(self, touched_trainer_ids, sql_query):
        for trainer_id, result in self.results.items():
            # If we already touched this trainer_id from another race/class mix, skip.
            if trainer_id in touched_trainer_ids:
                continue
            touched_trainer_ids.add(trainer_id)
            # Iterate trainer spell/player spell pairs.
            for trainer_spell_entry in result:
                trainer_spell = trainer_spell_entry.trainer_spell
                player_spell = trainer_spell_entry.player_spell
                sp_cost, money_cost = RaceClassHolder._get_spell_price(player_spell)
                sub_name = f' - ({trainer_spell.NameSubtext_enUS})' if trainer_spell.NameSubtext_enUS else ''
                sql_query.append(f'-- Trainer Template ID {trainer_id} - {self.class_name}')
                sql_query.append(f'-- Spell: {player_spell.Name_enUS}{sub_name}')
                insert = f"INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('{trainer_id}', '{trainer_spell.ID}', '{player_spell.ID}', '{money_cost if money_cost else 0}', '0', '{sp_cost if sp_cost else 0}', '0', '0', '{player_spell.BaseLevel}');"
                sql_query.append(insert)


class ClassTrainersSkillGenerator:

    @staticmethod
    def validate_skill(skill, race, class_, race_mask, class_mask):
        # Only interested in weapon skills.
        if skill.CategoryID != SkillCategories.WEAPON_SKILL:  # Weapons
            return False
        if skill.RaceMask and not skill.RaceMask & race_mask:
            return False
        if skill.ClassMask and not skill.ClassMask & class_mask:
            return False
        if skill.ExcludeRace and skill.ExcludeRace & race:
            return False
        if skill.ExcludeClass and skill.ExcludeClass & class_:
            return False
        # Skip First Aid related.
        if 'First Aid' in skill.DisplayName_enUS:
            return False

        return True

    @staticmethod
    def validate_skill_line(skill_line, race, class_, race_mask, class_mask):
        if skill_line.RaceMask and not skill_line.RaceMask & race_mask:
            return False
        if skill_line.ClassMask and not skill_line.ClassMask & class_mask:
            return False
        if skill_line.ExcludeRace and skill_line.ExcludeRace & race:
            return False
        if skill_line.ExcludeClass and skill_line.ExcludeClass & class_:
            return False

        return True

    @staticmethod
    def generate():
        WorldLoader.load_char_base_infos()
        WorldLoader.load_creature_templates()
        WorldLoader.load_spells()
        WorldLoader.load_skills()
        WorldLoader.load_skill_line_abilities()
        WorldLoader.load_trainer_spells()

        results = {}
        for rId, race in enumerate(Races):
            for cId, class_ in enumerate(Classes):
                chr_base_info = DbcDatabaseManager.CharBaseInfoHolder.char_base_info_get(race.value, class_.value)
                if not chr_base_info:
                    #Logger.warning(f'Unable to locate ChrBaseInfo for race {race.name} class {class_.name}')
                    continue

                # Initialize race-class dict if necessary.
                if race not in results:
                    results[race] = {}
                if class_ not in results[race]:
                    results[race][class_] = RaceClassHolder(race, class_)

                # Grab masks.
                race_mask = 1 << race.value - 1
                class_mask = 1 << class_.value - 1

                # Grab initial spells for this race and class.
                initial_spells = WorldDatabaseManager.player_create_spell_get(race.value, class_.value)

                # Search for all spells which are part of this race/class skill line abilities.
                for skill in DbcDatabaseManager.SkillHolder.SKILLS.values():
                    # Validate that this mix of race and class have access to these skills.
                    if not ClassTrainersSkillGenerator.validate_skill(skill, race.value, class_.value,
                                                                      race_mask, class_mask):
                        continue

                    skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_by_skill_id(
                        skill.ID)

                    # Did not find skill line abilities.
                    if not skill_line_ability:
                        # Logger.warning(f'Did not find skill line abilities for skill id {skill.ID}')
                        continue

                    for skill_ab in skill_line_ability:
                        # Validate if the skill line ability is usable by this mix of race/class.
                        if not ClassTrainersSkillGenerator.validate_skill_line(skill_ab, race.value, class_.value,
                                                                               race_mask, class_mask):
                            continue

                        # Validate if it points to an existent spell.
                        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(skill_ab.Spell)
                        if not spell:
                            # Logger.warning(f'Did not find spell for id {skill_ab.Spell}')
                            continue

                        # Deprecated.
                        if 'Spears' in spell.Name_enUS:
                            continue

                        # If this spell is already part of the initial spells, skip.
                        if any(iSpell.Spell == spell.ID for iSpell in initial_spells):
                            continue

                        # Which trainer spells teaches this player spell.
                        trainer_spell = DbcDatabaseManager.SpellHolder.spell_get_trainer_spell_by_id(spell.ID)

                        # Validate this player spell can actually be trained by another spell.
                        if not trainer_spell:
                            #Logger.warning(f'Did not find trainer spell for id {spell.ID}')
                            continue

                        # Find trainers for the current mix of race/class.
                        trainers = WorldDatabaseManager.CreatureTemplateHolder.creature_trainers_by_race_class(
                            race, class_, TrainerTypes.TRAINER_TYPE_GENERAL)

                        if not trainers:
                            #Logger.warning(f'Did not find trainers for race {race.name} class {class_.name} type {0}')
                            continue

                        # Validate if the spell is already trained by any trainer.
                        already_trained_spell = WorldDatabaseManager.get_trainer_spell(trainer_spell.ID)
                        if already_trained_spell:
                            continue

                        for trainer in trainers:
                            if not trainer.trainer_id:
                                continue

                            results[race][class_].push_spell(trainer, trainer_spell, spell)

                # First, print all 'debug' information about trainers.
                results[race][class_].print()

        # Dictionary of dictionaries. (Trainer ID, Trainer Spell ID) : Player Spell.
        touched_trainer_ids = set()
        sql_query = []
        for rId, race in enumerate(Races):
            for cId, class_ in enumerate(Classes):
                if race not in results:
                    continue
                if class_ not in results[race]:
                    continue
                results[race][class_].process_query(touched_trainer_ids, sql_query)

        for sql_line in sql_query:
            print(sql_line)
