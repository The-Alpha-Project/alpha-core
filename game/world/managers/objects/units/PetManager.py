from struct import pack, unpack
from typing import Optional, NamedTuple, List

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterPet
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import CreatureTemplate
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ai.PetAI import PetAI
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.player.StatManager import UnitStats
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.OpCodes import OpCode
from utils.constants.PetCodes import PetActionBarIndex, PetCommandState, PetTameResult, PetReactState
from utils.constants.SpellCodes import SpellTargetMask, SpellCheckCastResult, SpellAttributesEx
from utils.constants.UnitCodes import MovementTypes
from utils.constants.UpdateFields import UnitFields


class PetData:
    def __init__(self, pet_id: int, name: str, template: CreatureTemplate, owner_guid,
                 level: int, experience: int, summon_spell_id: int, permanent: bool, action_bar=None):
        self.pet_id = pet_id

        self.name = name
        self.creature_template = template
        self.owner_guid = owner_guid
        self.permanent = permanent
        self.summon_spell_id = summon_spell_id

        self._level = level
        self._experience = experience
        self.next_level_xp = PetData._get_xp_to_next_level_for(self._level)

        self.react_state = PetReactState.REACT_DEFENSIVE
        self.command_state = PetCommandState.COMMAND_FOLLOW

        self.spells = []

        # TODO Not handling CMSG_PET_SET_ACTION yet.
        # TODO Use saved action bar once pet spellbook is working;
        # otherwise pets will be stuck with the spells they had when first summoned.
        self.action_bar = self.get_default_action_bar_values()

        self._dirty = pet_id == -1

    def save(self, creature_instance=None):
        if not self.permanent or not self._dirty:
            return

        health = -1 if not creature_instance else creature_instance.health
        mana = -1 if not creature_instance else creature_instance.power_1

        character_pet = self._as_character_pet(health=health, mana=mana)

        if self.pet_id == -1:
            RealmDatabaseManager.character_add_pet(character_pet)
            self.pet_id = character_pet.pet_id
        else:
            RealmDatabaseManager.character_update_pet(character_pet)

        self._dirty = False

    def set_dirty(self):
        self._dirty = True

    def _as_character_pet(self, health=-1, mana=-1) -> CharacterPet:
        # TODO Stats probably shouldn't be directly from creature data.
        health = health if health != -1 else self.creature_template.health_max
        mana = mana if mana != -1 else self.creature_template.mana_max

        character_pet = CharacterPet(
            pet_id=self.pet_id if self.pet_id != -1 else None,
            owner_guid=self.owner_guid,
            creature_id=self.creature_template.entry,
            created_by_spell=self.summon_spell_id,
            level=self._level,
            xp=self._experience,
            react_state=int(self.react_state),
            command_state=int(self.command_state),
            loyalty=0,  # TODO Loyalty/training
            loyalty_points=0,
            training_points=0,
            name=self.name,
            renamed=0,  # TODO pet naming
            health=health,
            mana=mana,
            happiness=0,  # TODO
            action_bar=pack('10I', *self.action_bar)
            # TODO Pet spellbook persistence.
        )

        return character_pet

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

    def add_spell(self, spell_id) -> bool:
        if spell_id in self.spells:
            return False

        self.spells.append(spell_id)
        self.set_dirty()
        return True


    def get_experience(self):
        return self._experience

    def get_level(self):
        return self._level

    @staticmethod
    def _get_xp_to_next_level_for(level: int) -> int:
        return int(Formulas.PlayerFormulas.xp_to_level(level) / 4)

    def get_available_spells(self, ignore_level=False) -> list[int]:
        creature_family = self.creature_template.beast_family
        if not creature_family:
            return []

        family_entry = DbcDatabaseManager.CreatureFamilyHolder.creature_family_get_by_id(creature_family)
        if not family_entry:
            # No spells for this type of pet yet (bats, hyenas etc.)
            # TODO Make these pets untamable?
            return []

        skill_lines = [family_entry.SkillLine_1, family_entry.SkillLine_2]  # Include talents for this check (if any).

        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_by_skill_lines(skill_lines)
        if not skill_line_abilities:
            return []

        # Load spell info.
        line_spells = [DbcDatabaseManager.SpellHolder.spell_get_by_id(line.Spell) for line in skill_line_abilities]

        # Filter spells by pet level.
        # TODO This level isn't always correct. We should do a lookup on the teaching spell instead.
        return [spell.ID for spell in line_spells if ignore_level or spell.SpellLevel <= self._level]

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

        spell_ids = [PetManager.get_action_button_for(spell) for spell in self.spells[:4]]
        spell_ids += [0] * (max_spell_count - len(spell_ids))  # Always 4 spells, pad with 0.
        pet_bar[spells_index:spells_index] = spell_ids  # Insert spells to action bar.

        return pet_bar


class ActivePet(NamedTuple):
    pet_index: int
    creature: CreatureManager


class PetManager:
    def __init__(self, owner):
        self.owner = owner
        self.pets: list[PetData] = []
        self.active_pet: Optional[ActivePet] = None  # TODO Multiple active pets - totems?

    def load_pets(self):
        character_pets = RealmDatabaseManager.character_get_pets(self.owner.guid)
        for character_pet in character_pets:
            self.pets.append(PetData(
                character_pet.pet_id,
                character_pet.name,
                WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(character_pet.creature_id),
                self.owner.guid,
                character_pet.level,
                character_pet.xp,
                character_pet.created_by_spell,
                True,
                action_bar=unpack('10I', character_pet.action_bar)))

    def save(self):
        if self.active_pet:
            self.get_active_pet_info().save()

    def set_creature_as_pet(self, creature: CreatureManager, summon_spell_id: int,
                            pet_level=-1, pet_index=-1, is_permanent=False) -> Optional[ActivePet]:
        if self.active_pet:
            return None

        # Modify and link owner and creature.
        if is_permanent:
            # Permanent pet summon.
            creature.set_summoned_by(self.owner, spell_id=summon_spell_id,
                                     subtype=CustomCodes.CreatureSubtype.SUBTYPE_PET,
                                     movement_type=MovementTypes.IDLE)
        else:
            # Temporary charm.
            creature.set_charmed_by(self.owner, subtype=CustomCodes.CreatureSubtype.SUBTYPE_PET,
                                    movement_type=MovementTypes.IDLE)

        self._handle_creature_spawn_detach(creature, is_permanent)
        creature.leave_combat()

        if pet_index == -1:
            # Pet not in database.
            if pet_level == -1:
                # No level given and no pet data - default to creature level.
                # If pet data exists, set_active_pet_level will assign the proper level.
                pet_level = creature.level

            # Add as a new pet.
            pet_index = self.add_pet(creature.creature_template, summon_spell_id, pet_level, is_permanent)

        self._set_active_pet(pet_index, creature)
        self.set_active_pet_level(pet_level)
        return self.active_pet

    def _set_active_pet(self, pet_index: int, creature: CreatureManager):
        pet_info = self._get_pet_info(pet_index)

        if self.active_pet or not pet_info:
            return

        self.active_pet = ActivePet(pet_index, creature)
        self._send_pet_spell_info()

    def add_pet(self, creature_template: CreatureTemplate, summon_spell_id: int, level: int, permanent: bool) -> int:
        pet = PetData(-1, creature_template.name, creature_template, self.owner.guid, level,
                      0, summon_spell_id, permanent=permanent)

        pet.save()
        self.pets.append(pet)
        return len(self.pets) - 1

    def teach_active_pet_spell(self, spell_id, force=False, update=True) -> bool:
        pet = self.get_active_pet_info()
        if not pet or not pet.permanent:
            return False

        if not force and not pet.can_learn_spell(spell_id):
            return False

        if not pet.add_spell(spell_id):
            return False

        if update:
            self._send_pet_spell_info()

    def teach_active_pet_all_available_spells(self):
        pet = self.get_active_pet_info()
        if not pet:
            return

        update = any([self.teach_active_pet_spell(spell_id, update=False) for spell_id in pet.spells])
        if update:
            self._send_pet_spell_info()

    def summon_permanent_pet(self, spell_id, creature_id=0):
        if self.active_pet:
            return

        # If a creature ID isn't provided, the pet to summon is the player's only pet (hunters).
        # In this case, the pet ignores the summoner's levels and levels up independently.
        match_summoner_level = creature_id != 0

        pet_index = -1
        if not creature_id:
            if not len(self.pets):
                return

            # TODO Assume permanent pet in slot 0 for now. This might (?) lead to some unexpected behavior.
            pet_index = 0
            creature_id = self.pets[pet_index].creature_template.entry
        else:
            # Other summon casts happen by creature ID reference.
            # If no pet is found, a new entry is simply created as pet_index remains -1.
            for i in range(len(self.pets)):
                if self.pets[i].creature_template.entry == creature_id:
                    pet_index = i
                    break

        spawn_position = self.owner.location.get_point_in_radius_and_angle(PetAI.PET_FOLLOW_DISTANCE,
                                                                           PetAI.PET_FOLLOW_ANGLE)

        creature_manager = CreatureBuilder.create(creature_id, spawn_position, self.owner.map_,
                                                  summoner=self.owner, faction=self.owner.faction,
                                                  movement_type=MovementTypes.IDLE,
                                                  spell_id=spell_id,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_PET)

        # Match summoner level if a creature ID is provided (warlock pets). Otherwise, set to the level in PetData.
        pet_level = self.owner.level if match_summoner_level else -1
        self.set_creature_as_pet(creature_manager, spell_id, pet_level=pet_level, pet_index=pet_index, is_permanent=True)
        MapManager.spawn_object(world_object_instance=creature_manager)

    def remove_pet(self, pet_index):
        if self._get_pet_info(pet_index):
            self.pets.pop(pet_index)

    def detach_active_pet(self, spell_entry=None):
        if not self.active_pet:
            return

        creature = self.active_pet.creature
        pet_info = self.get_active_pet_info()

        # If this does not come from aura handling, check if we can retrieve the spell from the channel spell field.
        if not spell_entry:
            channel_spell = self.owner.get_int32(UnitFields.UNIT_CHANNEL_SPELL)
            if channel_spell:
                spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(channel_spell)
            elif pet_info.summon_spell_id:
                spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(pet_info.summon_spell_id)

        is_permanent = self.get_active_pet_info().permanent
        pet_index = self.active_pet.pet_index
        self._update_active_pet_stats(reset=True)

        movement_type = MovementTypes.IDLE
        # Check if this is a borrowed creature instance.
        if creature.spawn_id:
            spawn = MapManager.get_surrounding_creature_spawn_by_spawn_id(creature, creature.spawn_id)
            # This creature might be too far from its spawn upon detach, search in all map cells.
            if not spawn:
                spawn = MapManager.get_creature_spawn_by_id(creature.map_, creature.spawn_id)

            # Creature spawn should be found already at this point.
            if spawn:
                if not spawn.restore_creature_instance(creature):
                    Logger.error(f'Unable to restore creature from spawn id {creature.spawn_id} upon pet detach.')
                movement_type = spawn.movement_type
            # Still no spawn found? Something is wrong...
            else:
                Logger.error(f'Unable to locate SpawnCreature with id {creature.spawn_id} upon pet detach.')

        self.active_pet = None
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_SPELLS, pack('<Q', 0)))

        if is_permanent:
            pet_info.save(creature)
            # Summon Pet cooldown is locked by default - unlock on despawn.
            self.owner.spell_manager.unlock_spell_cooldown(pet_info.summon_spell_id)
        else:
            self.remove_pet(pet_index)

        # Flush ThreatManager before releasing this creature in order to avoid evade trigger.
        creature.leave_combat()

        # Restore creature state.
        if pet_info.permanent:
            # Remove summoned.
            creature.set_summoned_by(self.owner, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                                     movement_type=movement_type, remove=True)
        # Remove charmed.
        creature.set_charmed_by(self.owner, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC,
                                movement_type=movement_type, remove=True)

        # Orphan creature, destroy.
        if not creature.spawn_id:
            creature.destroy()
        # Check if the spell entry exists and if it generates threat.
        elif spell_entry and creature.get_type_id() == ObjectTypeIds.ID_UNIT and \
                not spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_NO_THREAT:
            # TODO: Proper threat value.
            creature.threat_manager.add_threat(self.owner)

        # Notify creature about owner proximity if we restored creature spawn.
        if creature.spawn_id and creature.get_type_id() == ObjectTypeIds.ID_UNIT:
            creature.notify_moved_in_line_of_sight(self.owner)

        # Handle channeled interrupt if needed.
        if spell_entry and self.owner.spell_manager.is_casting_spell(spell_entry.ID):
            self.owner.spell_manager.remove_cast_by_id(spell_entry.ID)

    def get_active_pet_info(self) -> Optional[PetData]:
        if not self.active_pet:
            return None
        return self._get_pet_info(self.active_pet.pet_index)

    def handle_action(self, pet_guid, target_guid, action):
        if not self.active_pet:
            return

        # Spell ID or 0/1/2/3 for setting command/react state.
        action_id = action & 0xFFFF

        active_pet_unit = self.active_pet.creature
        # Single active pet assumed.
        if active_pet_unit.guid != pet_guid:
            return

        if target_guid == 0:
            target_unit = self.owner
        else:
            target_unit = MapManager.get_surrounding_unit_by_guid(active_pet_unit, target_guid, include_players=True)

        if not target_unit:
            return

        if action_id > PetCommandState.COMMAND_DISMISS:  # Highest action ID.
            target_mask = SpellTargetMask.SELF if target_unit.guid == active_pet_unit.guid else SpellTargetMask.UNIT
            active_pet_unit.spell_manager.handle_cast_attempt(action_id, target_unit, target_mask)

        elif action & (0x01 << 24):
            # Command state action.
            self.get_active_pet_info().command_state = action_id
            self.active_pet.creature.object_ai.command_state_update()
            if action_id == PetCommandState.COMMAND_ATTACK and target_unit:
                self.active_pet.creature.attack(target_unit)
            if action_id == PetCommandState.COMMAND_DISMISS:
                self.detach_active_pet()

        else:
            self.get_active_pet_info().react_state = action_id

    def add_active_pet_experience(self, experience: int):
        active_pet_info = self.get_active_pet_info()
        if not active_pet_info or self.owner.level <= active_pet_info.get_level():
            return

        level_gain = active_pet_info.add_experience(experience)
        if not level_gain:
            return

        self.set_active_pet_level()

    def set_active_pet_level(self, level=-1):
        active_pet_info = self.get_active_pet_info()
        if not active_pet_info:
            return

        if level == -1:
            level = active_pet_info.get_level()
        elif active_pet_info.get_level() != level:
            active_pet_info.set_level(level)

        pet_creature = self.active_pet.creature
        pet_creature.set_uint32(UnitFields.UNIT_FIELD_PETEXPERIENCE, active_pet_info.get_experience())

        # TODO Creature leveling should be handled by CreatureManager.
        pet_creature.level = level
        pet_creature.set_uint32(UnitFields.UNIT_FIELD_LEVEL, pet_creature.level)
        pet_creature.set_uint32(UnitFields.UNIT_FIELD_PETNEXTLEVELEXP, active_pet_info.next_level_xp)

        self._update_active_pet_stats()

    def get_active_pet_command_state(self):
        pet_info = self.get_active_pet_info()
        if not pet_info:
            return 0

        return pet_info.command_state

    def handle_cast_result(self, spell_id, result):
        if result == SpellCheckCastResult.SPELL_NO_ERROR:
            return

        data = pack('<IB', spell_id, result)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_CAST_FAILED, data))

    def handle_tame_result(self, tame_effect, target) -> SpellCheckCastResult:
        # Taming level restriction.
        max_tame_level = tame_effect.get_effect_points()
        if target.level > max_tame_level:
            self._send_tame_result(PetTameResult.TAME_TOO_HIGH_LEVEL)
            return SpellCheckCastResult.SPELL_FAILED_DONT_REPORT

        # Only one tamed pet at a time.
        if self.pets:
            self._send_tame_result(PetTameResult.TAME_TOO_MANY)
            return SpellCheckCastResult.SPELL_FAILED_DONT_REPORT

        if not target.is_tameable():
            self._send_tame_result(PetTameResult.TAME_NOT_TAMABLE)
            return SpellCheckCastResult.SPELL_FAILED_DONT_REPORT

        return SpellCheckCastResult.SPELL_NO_ERROR

    def _update_active_pet_stats(self, reset=False):
        active_pet_info = self.get_active_pet_info()
        if not active_pet_info:
            return

        if not reset:
            # From VMaNGOS.
            delay_mod = active_pet_info.creature_template.base_attack_time / 2000
            damage_base = active_pet_info.get_level() * 1.05
            damage_min = damage_base * 1.15 * delay_mod
            damage_max = damage_base * 1.45 * delay_mod
        else:
            damage_min = active_pet_info.creature_template.dmg_min
            damage_max = active_pet_info.creature_template.dmg_max

        pet_stats = WorldDatabaseManager.get_pet_level_stats_by_entry_and_level(active_pet_info.creature_template.entry,
                                                                                active_pet_info.get_level())

        if pet_stats:
            self.active_pet.creature.stat_manager.base_stats[UnitStats.HEALTH] = pet_stats.hp
            self.active_pet.creature.stat_manager.base_stats[UnitStats.MANA] = pet_stats.mana
            self.active_pet.creature.stat_manager.base_stats[UnitStats.RESISTANCE_PHYSICAL] = pet_stats.armor
            self.active_pet.creature.stat_manager.base_stats[UnitStats.STRENGTH] = pet_stats.str
            self.active_pet.creature.stat_manager.base_stats[UnitStats.AGILITY] = pet_stats.agi
            self.active_pet.creature.stat_manager.base_stats[UnitStats.STAMINA] = pet_stats.sta
            self.active_pet.creature.stat_manager.base_stats[UnitStats.INTELLECT] = pet_stats.inte
            self.active_pet.creature.stat_manager.base_stats[UnitStats.SPIRIT] = pet_stats.spi
        else:
            Logger.warning(f'Unable to locate pet level stats for creature entry '
                           f'{active_pet_info.creature_template.entry} level {active_pet_info.get_level()}')

        self.active_pet.creature.set_melee_damage(int(damage_min), int(damage_max))
        self.active_pet.creature.stat_manager.apply_bonuses()

    def _send_tame_result(self, result):
        if result == PetTameResult.TAME_SUCCESS:
            return

        data = pack('<B', result)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_TAME_FAILURE, data))

    def _get_pet_info(self, pet_index: int) -> Optional[PetData]:
        if pet_index < 0 or pet_index >= len(self.pets):
            return None

        return self.pets[pet_index]

    def _handle_creature_spawn_detach(self, creature: CreatureManager, is_permanent):
        # Creatures which are linked to a CreatureSpawn.
        if creature.get_type_id() != ObjectTypeIds.ID_UNIT or not creature.spawn_id:
            return

        spawn = MapManager.get_surrounding_creature_spawn_by_spawn_id(self.owner, creature.spawn_id)
        if not spawn:
            Logger.error(f'Unable to locate spawn {creature.spawn_id} for creature.')
            return
        # Detach creature instance from spawn.
        if is_permanent:
            if not spawn.detach_creature_from_spawn(creature):
                Logger.error(f'Unable to locate spawn {creature.spawn_id} for creature.')
                return
        # Borrow the creature instance.
        elif not is_permanent:
            if not spawn.lend_creature_instance(creature):
                Logger.error(f'Unable to locate spawn {creature.spawn_id} for creature.')
                return

    def _send_pet_spell_info(self):
        if not self.active_pet:
            return

        # This packet contains both the action bar of the pet and the spellbook entries.

        pet_info: PetData = self._get_pet_info(self.active_pet.pet_index)
        spell_count = len(pet_info.spells) if pet_info.permanent else 0

        # Creature guid, time limit, react state (0 = passive, 1 = defensive, 2 = aggressive),
        # command state (0 = stay, 1 = follow, 2 = attack, 3 = dismiss),
        # ??, Enabled (0x0 : 0x8)
        signature = f'<QI4B{PetActionBarIndex.INDEX_END}IB'
        data = [self.active_pet.creature.guid, 0, pet_info.react_state, pet_info.command_state, 0, 0]

        data.extend(pet_info.action_bar)

        # TODO Spell action buttons should be savable to preserve spellbook order and cast flags.
        data.append(spell_count)
        if spell_count:
            data.extend([spell for spell in pet_info.spells])
            signature += f'{spell_count}H'

        signature += 'B'
        data.append(0)  # TODO: Cooldown count.

        packet = pack(signature, *data)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_SPELLS, packet))


    @staticmethod
    def get_action_button_for(spell_id: int, auto_cast: bool = True, castable: bool = True):
        # All pet actions have |0x1.
        # Pet action bar flags: 0x40 for auto cast on, 0x80 for castable.
        return spell_id | ((0x1 | (0x40 if auto_cast else 0x0) | (0x80 if castable else 0x0)) << 24)
