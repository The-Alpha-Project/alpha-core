import time
from struct import pack
from typing import List

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterPet, CharacterPetSpell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import CreatureTemplate
from utils import Formulas
from utils.GuidUtils import GuidUtils
from utils.constants.MiscCodes import HighGuid
from utils.constants.PetCodes import PetReactState, PetCommandState, PetActionBarIndex
from utils.constants.SpellCodes import SpellAttributes


class PetData:
    SUMMON_PET_SPELL_ID = 883

    def __init__(self, pet_id: int, name: str, rename_time: int, template: CreatureTemplate, owner_guid,
                 level: int, experience: int, summon_spell_id: int, permanent: bool,
                 spells=None, action_bar=None, is_active: bool = False):
        self.pet_id = pet_id

        self.name = name
        self.creature_template = template
        self.owner_guid = owner_guid
        self.permanent = permanent
        self.summon_spell_id = summon_spell_id
        self.rename_time = rename_time
        self.is_active = is_active  # Used for tracking pet state between logins. Only set for permanent pets.

        self._level = level
        self._experience = experience
        self.next_level_xp = PetData._get_xp_to_next_level_for(self._level)

        self.react_state = PetReactState.REACT_DEFENSIVE
        self.command_state = PetCommandState.COMMAND_FOLLOW

        self.spells = spells if spells else []

        self.action_bar = action_bar if action_bar else self.get_default_action_bar_values()

        self._dirty = pet_id == -1

    def save(self, creature_instance=None):
        if not self.permanent or not self._dirty or not self._is_player_owned():
            return

        if not creature_instance:
            # TODO How should pet health/mana be calculated?
            stats = WorldDatabaseManager.CreatureClassLevelStatsHolder.creature_class_level_stats_get_by_class_and_level(
                self.creature_template.unit_class, min(self._level, 255)
            )
            health = stats.health
            mana = stats.mana
        else:
            health = creature_instance.health
            mana = creature_instance.power_1

        character_pet = self._get_character_pet(health=health, mana=mana)

        if self.pet_id == -1:
            RealmDatabaseManager.character_add_pet(character_pet)
            self.pet_id = character_pet.pet_id
        else:
            RealmDatabaseManager.character_update_pet(character_pet)

        self._dirty = False

    def delete(self):
        if not self.permanent or not self._is_player_owned():
            return
        RealmDatabaseManager.character_delete_pet(self.pet_id)

    def set_dirty(self):
        self._dirty = True

    def _get_character_pet(self, health, mana) -> CharacterPet:
        character_pet = CharacterPet(
            pet_id=self.pet_id if self.pet_id != -1 else None,
            owner_guid=self.owner_guid,
            creature_id=self.creature_template.entry,
            created_by_spell=self.summon_spell_id,
            level=self._level,
            xp=self._experience,
            react_state=int(self.react_state),
            command_state=int(self.command_state),
            name=self.name,
            rename_time=self.rename_time,
            is_active=self.is_active,
            health=health,
            mana=mana,
            action_bar=pack('10I', *self.action_bar)
        )

        return character_pet

    def _get_character_pet_spells(self) -> List[CharacterPetSpell]:
        character_pet_spells = []
        for spell in self.spells:
            character_pet_spells.append(CharacterPetSpell(
                guid=self.owner_guid,
                pet_id=self.pet_id,
                spell_id=spell
            ))

        return character_pet_spells

    def add_experience(self, xp_amount: int) -> int:
        if not xp_amount:
            return 0

        level_amount = 0
        if self._experience + xp_amount < self.next_level_xp:  # Not enough xp to level up.
            self._experience += xp_amount
        else:
            # Level up.
            xp_to_level = self.next_level_xp - self._experience
            # Do the actual XP conversion into level(s).
            while xp_amount >= xp_to_level:
                level_amount += 1
                xp_amount -= xp_to_level
                xp_to_level = PetData._get_xp_to_next_level_for(self._level + level_amount)

            self.set_level(self._level + level_amount)
            self._experience = xp_amount  # Set the remaining amount XP as current.

        self.set_dirty()
        return level_amount

    def set_level(self, level: int):
        if not level:
            return

        self._level = level
        self.next_level_xp = PetData._get_xp_to_next_level_for(self._level)
        self._experience = 0
        self.set_dirty()

    def set_name(self, name: str):
        self.name = name
        self.rename_time = int(time.time())
        self.set_dirty()

    def set_active(self, active: bool):
        if not self.permanent:
            return

        self.is_active = active
        self.set_dirty()

    def add_spell(self, spell_id) -> bool:
        if spell_id in self.spells:
            return False

        self.spells.append(spell_id)

        if not self._is_player_owned():
            return True

        button = CharacterPetSpell(guid=self.owner_guid, pet_id=self.pet_id, spell_id=spell_id)
        RealmDatabaseManager.character_add_pet_spell(button)
        return True

    def get_experience(self):
        return self._experience

    def get_level(self):
        return self._level

    @staticmethod
    def _get_xp_to_next_level_for(level: int) -> int:
        return int(Formulas.PlayerFormulas.xp_to_level(level) / 4)

    def get_available_spells(self, ignore_level=False, level_override=-1) -> list[int]:
        creature_family = self.creature_template.beast_family
        if not creature_family:
            return []

        family_entry = DbcDatabaseManager.CreatureFamilyHolder.creature_family_get_by_id(creature_family)
        if not family_entry:
            # No spells for this type of pet yet (bats, hyenas etc.)
            # TODO Make these pets untamable?
            return []

        skill_lines = [family_entry.SkillLine_1,
                       family_entry.SkillLine_2 if self.is_hunter_pet() else 0]  # Include talents for this check (if any).

        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_by_skill_lines(skill_lines)
        if not skill_line_abilities:
            return []

        # Load spell info.
        line_spells = [DbcDatabaseManager.SpellHolder.spell_get_by_id(line.Spell) for line in skill_line_abilities]

        # Filter spells by pet level.
        level = level_override if level_override != -1 else self._level
        # TODO This level isn't always correct. We should do a lookup on the teaching spell instead.
        return [spell.ID for spell in line_spells if ignore_level or spell.SpellLevel <= level]

    def can_learn_spell(self, spell_id):
        return spell_id in self.get_available_spells()

    def can_ever_learn_spell(self, spell_id):
        return spell_id in self.get_available_spells(ignore_level=True)

    def get_default_action_bar_values(self) -> List[int]:
        pet_bar = [
                2 | (0x07 << 24), 1 | (0x07 << 24), 0 | (0x07 << 24),  # Attack, Follow, Stay.
                2 | (0x06 << 24), 1 | (0x06 << 24), 0 | (0x06 << 24)  # Aggressive, Defensive, Passive.
        ]

        spells_index = PetActionBarIndex.INDEX_SPELL_START
        max_spell_count = PetActionBarIndex.INDEX_REACT_START - spells_index

        spells = []
        for spell_id in self.spells:
            line_entry = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_by_spell(spell_id)[0]
            if line_entry.SupercededBySpell in self.spells:
                continue  # Only place highest ranks on action bar.

            template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
            if not template.Attributes & SpellAttributes.SPELL_ATTR_PASSIVE:
                spells.append(spell_id)

        spell_ids = [PetData.get_action_button_for(spell) for spell in spells[:4]]
        spell_ids += [0] * (max_spell_count - len(spell_ids))  # Always 4 spells, pad with 0.
        pet_bar[spells_index:spells_index] = spell_ids  # Insert spells to action bar.

        return pet_bar

    def is_hunter_pet(self):
        return self.permanent and self.summon_spell_id == PetData.SUMMON_PET_SPELL_ID

    def _is_player_owned(self):
        return GuidUtils.extract_high_guid(self.owner_guid) == HighGuid.HIGHGUID_PLAYER

    @staticmethod
    def get_action_button_for(spell_id: int, auto_cast: bool = False, castable: bool = True):
        # All pet actions have |0x1.
        # Pet action bar flags: 0x40 for auto cast on, 0x80 for castable.
        return spell_id | ((0x1 | (0x40 if auto_cast else 0x0) | (0x80 if castable else 0x0)) << 24)