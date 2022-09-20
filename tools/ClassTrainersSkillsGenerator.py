from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldLoader import WorldLoader
from utils.Logger import Logger
from utils.constants.MiscCodes import SkillCategories, TrainerTypes
from utils.constants.UnitCodes import Races, Classes


class TrainerHolder:
    def __init__(self, trainer):
        self.trainer = trainer
        self.trainer_spells = []
        self.player_spells = []


class RaceClassHolder:
    def __init__(self, race, class_):
        self.race_name = Races(race).name.replace('RACE_', '')
        self.class_name = Classes(class_).name.replace('CLASS_', '')
        self.race = race
        self.class_ = class_
        self.spells = {}

    def push_spell(self, trainer, trainer_spell, player_spell):
        if trainer.trainer_id not in self.spells:
            self.spells[trainer.trainer_id] = {}

        if trainer_spell.ID not in self.spells[trainer.trainer_id]:
            print(f'{self.race_name}-{self.class_name} | Spell {player_spell.Name_enUS}')
            self.spells[trainer.trainer_id][trainer_spell.ID] = player_spell


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
        inserts = {}
        for rId, race in enumerate(Races):
            for cId, class_ in enumerate(Classes):
                chr_base_info = DbcDatabaseManager.CharBaseInfoHolder.char_base_info_get(race.value, class_.value)
                if not chr_base_info:
                    Logger.warning(f'Unable to locate ChrBaseInfo for race {race.name} class {class_.name}')
                    continue

                # Initialize race-class dict if necessary.
                if race not in results:
                    results[race] = {}
                if class_ not in results[race]:
                    results[race][class_] = RaceClassHolder(race, class_)

                # Grab masks.
                race_mask = 1 << race.value - 1
                class_mask = 1 << class_.value - 1

                #results[race][class_].append(
                #    f'\n\n{race.name}({race}) - {class_.name}({class_}) | Race Mask {race_mask} Class Mask {class_mask}')

                # Grab initial spells for this race and class.
                initial_spells = WorldDatabaseManager.player_create_spell_get(race.value, class_.value)

                # Search for all spells which are part of this race/class skill line abilities.
                for skill in DbcDatabaseManager.SkillHolder.SKILLS.values():
                    # Validate that this mix of race and class have access to these skills.
                    if not ClassTrainersSkillGenerator.validate_skill(skill, race.value, class_.value,
                                                                      race_mask, class_mask):
                        continue

                    skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_by_skill_line_id(
                        skill.ID)

                    # Did not find skill line abilities.
                    if not skill_line_ability:
                        Logger.warning(f'Did not find skill line abilities for skill id {skill.ID}')
                        continue

                    spells = []
                    for skill_ab in skill_line_ability:
                        # Validate if the skill line ability is usable by this mix of race/class.
                        if not ClassTrainersSkillGenerator.validate_skill_line(skill_ab, race.value, class_.value,
                                                                               race_mask, class_mask):
                            continue

                        # Validate if it points to an existent spell.
                        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(skill_ab.Spell)
                        if not spell:
                            Logger.warning(f'Did not find spell for id {skill_ab.Spell}')
                            continue

                        # If this spell is already part of the initial spells, skip.
                        if any(iSpell.Spell == spell.ID for iSpell in initial_spells):
                            continue

                        # Which trainer spells teaches this player spell.
                        trainer_spell = DbcDatabaseManager.SpellHolder.spell_get_trainer_spell_by_id(spell.ID)

                        # Validate this player spell can actually be trained by another spell.
                        if not trainer_spell:
                            Logger.warning(f'Did not find trainer spell for id {spell.ID}')
                            continue

                        # Find trainers for the current mix of race/class.
                        trainers = WorldDatabaseManager.CreatureTemplateHolder.creature_trainers_by_race_class(
                            race, class_, TrainerTypes.TRAINER_TYPE_GENERAL)

                        if not trainers:
                            Logger.warning(f'Did not find trainers for race {race.name} class {class_.name} type {0}')
                            continue

                        # Validate if the spell is already trained by any trainer.
                        already_trained_spell = WorldDatabaseManager.get_trainer_spell(trainer_spell.ID)
                        if already_trained_spell:
                            continue

                        for trainer in trainers:
                            if not trainer.trainer_id:
                                continue

                            results[race][class_].push_spell(trainer, trainer_spell, spell)
                            # if trainer.trainer_id not in inserts:
                            #     inserts[trainer.trainer_id] = {}
                            #
                            # if spell.ID in inserts[trainer.trainer_id]:
                            #      # Logger.warning('Duple')
                            #     continue
                            #
                            # # if spell.BaseLevel > trainer.level_min:
                            # #    continue
                            #
                            # inserts[trainer.trainer_id][spell.ID] = None
                            #
                            # # Insert.
                            # insert = f"INSERT INTO `trainer_template` (`template_entry`, `spell`, `playerspell`, `spellcost`, `talentpointcost`, `skillpointcost`, `reqskill`, `reqskillvalue`, `reqlevel`) VALUES ('{trainer.trainer_id}', '{trainer_spell.ID}', '{spell.ID}', '0', '0', '2', '0', '0', '{spell.BaseLevel}');"
                            # trainer_templates.add(trainer.trainer_id)
                            # results[race][class_].append(f'-- Trainer Template ID: [{trainer.trainer_id}]')
                            # results[race][class_].append(f'-- Trainer Spell: {trainer_spell.Name_enUS} {trainer_spell.ID}')
                            # results[race][class_].append(f'-- Player Spell: {spell.Name_enUS}')
                            # results[race][class_].append(insert)

                    # spells.append(f' - Player Spell {spell.ID} - {spell.Name_enUS} {sub_name}')
                    # sub_name = f'- ({trainer_spell.NameSubtext_enUS})' if trainer_spell.NameSubtext_enUS else ''
                    # spells.append(f' * Trainer Spell {trainer_spell.ID} - {trainer_spell.Name_enUS} {sub_name} {trainer_spell.Description_enUS}')

            # if len(spells) > 0:
            #     results[race][class_].append(
            #         f'Can use weapon skill [{skill.DisplayName_enUS}] ({skill.ID})')
            #     for spell_ in spells:
            #         results[race][class_].append(spell_)
            #
            # if len(results[race][class_]) > 1:
            #     for line in results[race][class_]:
            #         print(line)
