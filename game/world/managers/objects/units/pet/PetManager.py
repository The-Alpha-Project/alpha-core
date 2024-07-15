from struct import pack, unpack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.spell.CastingSpell import CastingSpell
from game.world.managers.objects.units.creature.CreatureBuilder import CreatureBuilder
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.objects.units.movement.behaviors.PetMovement import PetMovement
from game.world.managers.objects.units.pet.ActivePet import ActivePet
from game.world.managers.objects.units.pet.PetData import PetData
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants import CustomCodes
from utils.constants.MiscCodes import ObjectTypeIds, ObjectTypeFlags
from utils.constants.OpCodes import OpCode
from utils.constants.PetCodes import PetActionBarIndex, PetCommandState, PetTameResult, PetSlot
from utils.constants.SpellCodes import SpellCheckCastResult, TotemSlots, SpellTargetMask
from utils.constants.UnitCodes import MovementTypes
from utils.constants.UpdateFields import UnitFields


class PetManager:
    def __init__(self, owner):
        self.owner = owner
        self.permanent_pets: list[PetData] = []
        self.active_pets: dict[PetSlot, ActivePet] = {}

    def load_pets(self):
        if self.owner.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        character_pets = RealmDatabaseManager.character_get_pets(self.owner.guid)
        for character_pet in character_pets:
            spells = RealmDatabaseManager.character_get_pet_spells(self.owner.guid, character_pet.pet_id)
            self.permanent_pets.append(PetData(
                character_pet.pet_id,
                character_pet.name,
                character_pet.rename_time,
                WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(character_pet.creature_id),
                self.owner.guid,
                character_pet.level,
                character_pet.xp,
                character_pet.created_by_spell,
                permanent=True,
                spells=[spell.spell_id for spell in spells],
                action_bar=list(unpack('10I', character_pet.action_bar)),
                is_active=character_pet.is_active))

    def save(self):
        [pet.save() for pet in self.permanent_pets]

    def set_creature_as_pet(self, creature: CreatureManager, summon_spell_id: int, pet_slot: PetSlot,
                            pet_level=-1, pet_index=-1, is_permanent=False) -> Optional[ActivePet]:
        if not self._try_detach_dead_pet(pet_slot):
            return  # Pet slot already occupied by alive creature.

        # Modify and link owner and creature.
        self._handle_creature_spawn_detach(creature, is_permanent)
        if PetSlot.PET_SLOT_TOTEM_START <= pet_slot < PetSlot.PET_SLOT_END:
            creature.subtype = CustomCodes.CreatureSubtype.SUBTYPE_TOTEM
        elif is_permanent:
            creature.subtype = CustomCodes.CreatureSubtype.SUBTYPE_PET
        else:
            creature.subtype = CustomCodes.CreatureSubtype.SUBTYPE_TEMP_SUMMON

        if pet_index == -1:
            # Pet not in database.
            if pet_level == -1:
                # No level given and no pet data - default to creature level.
                # If pet data exists, set_active_pet_level will assign the proper level.
                pet_level = creature.level

            pet_data = self._add_pet(creature, summon_spell_id, pet_level, is_permanent)
            if is_permanent:
                pet_index = len(self.permanent_pets) - 1
        else:
            # Pet index provided, load from persistent pet data.
            pet_data = self.get_pet_data(pet_index)

        active_pet = ActivePet(self, pet_index, pet_slot, creature, pet_data)
        self.active_pets[pet_slot] = active_pet

        active_pet.attach()
        creature.movement_manager.initialize_or_reset()
        creature.leave_combat()

        self.send_pet_spell_info()
        active_pet.set_level(pet_level)

        if pet_data.is_hunter_pet():
            creature.set_can_rename(pet_data.rename_time == 0)  # Only allow one rename.
            creature.set_can_abandon(True)
            creature.set_uint32(UnitFields.UNIT_FIELD_PETNUMBER, pet_data.pet_id)
            creature.set_uint32(UnitFields.UNIT_FIELD_PET_NAME_TIMESTAMP, pet_data.rename_time)

        return active_pet

    def add_totem_from_spell(self, totem_creature: CreatureManager, totem_spell: CastingSpell) -> Optional[ActivePet]:
        totem_slot = totem_spell.get_totem_slot_type()
        if self.get_active_totem(totem_slot):
            return None

        return self.set_creature_as_pet(totem_creature, totem_spell.spell_entry.ID,
                                        PetSlot.PET_SLOT_TOTEM_START + totem_slot)

    def _add_pet(self, creature: CreatureManager, summon_spell_id: int, level: int, permanent: bool) -> PetData:
        pet_data = PetData(-1, creature.creature_template.name, 0,
                           creature.creature_template, self.owner.guid, level,
                           0, summon_spell_id, permanent=permanent)

        if pet_data.permanent:
            pet_data.save(creature_instance=creature)
            self.permanent_pets.append(pet_data)
        return pet_data

    def summon_permanent_pet(self, spell_id, creature_id=0):
        if not self._try_detach_dead_pet(PetSlot.PET_SLOT_PERMANENT):
            return  # Permanent pet is already active and alive.

        # If a creature ID isn't provided, the pet to summon is the player's only pet (hunters).
        # Otherwise, the pet is owned by a warlock or a creature.
        is_creature_summon = creature_id != 0

        pet_index = -1
        if not creature_id:
            if not len(self.permanent_pets):
                return

            # Summoning hunter pet, always in first slot.
            pet_index = 0
            creature_id = self.permanent_pets[pet_index].creature_template.entry
        else:
            # Other summon casts happen by creature ID reference.
            # If no pet is found, a new entry is created as pet_index remains -1.
            for i in range(len(self.permanent_pets)):
                if self.permanent_pets[i].creature_template.entry == creature_id:
                    pet_index = i
                    break

        spawn_position = self.owner.location.get_point_in_radius_and_angle(PetMovement.PET_FOLLOW_DISTANCE,
                                                                           PetMovement.PET_FOLLOW_ANGLE)
        creature_manager = CreatureBuilder.create(creature_id, spawn_position,
                                                  self.owner.map_id, self.owner.instance_id,
                                                  summoner=self.owner, faction=self.owner.faction,
                                                  movement_type=MovementTypes.IDLE,
                                                  spell_id=spell_id,
                                                  subtype=CustomCodes.CreatureSubtype.SUBTYPE_PET)

        if not creature_manager:
            Logger.warning(f"Attempted to summon nonexistent creature {creature_id} via spell {spell_id}.")
            return

        # Match summoner level for creature summons. Otherwise, set to the level in PetData.
        pet_level = self.owner.level if is_creature_summon else -1
        active_pet = self.set_creature_as_pet(creature_manager, spell_id, PetSlot.PET_SLOT_PERMANENT,
                                              pet_level=pet_level, pet_index=pet_index, is_permanent=True)

        # On initial creature summon, teach available spells according to the summon spell's level.
        if is_creature_summon and pet_index == -1:
            spell_level = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id).SpellLevel
            active_pet.initialize_spells(level_override=spell_level)

        self.owner.get_map().spawn_object(world_object_instance=creature_manager)

    def detach_active_pets(self, is_logout=False):
        for index, pet in list(self.active_pets.items()):
            if not is_logout:
                # If this pet is being detached on logout, don't overwrite its activity status.
                pet.get_pet_data().set_active(False)

            self.active_pets.pop(index)
            pet.detach()

    def handle_login(self):
        if self.owner.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        for pet in self.permanent_pets:
            if not pet.is_active:
                continue
            self.summon_permanent_pet(pet.summon_spell_id, creature_id=pet.creature_template.entry)
            return

    def handle_pet_death(self, creature):
        active_pet = self.get_active_pet_by_guid(creature.guid)
        if not active_pet:
            return

        if active_pet.is_controlled():
            self.send_pet_spell_info(reset=True)

        pet_data = active_pet.get_pet_data()
        if pet_data.summon_spell_id:
            self.owner.spell_manager.unlock_spell_cooldown(pet_data.summon_spell_id)

        pet_data.set_active(False)

    def detach_pet_by_slot(self, pet_slot: PetSlot):
        active_pet = self.active_pets.get(pet_slot)
        if active_pet:
            active_pet.get_pet_data().set_active(False)
            self.active_pets.pop(pet_slot)
            active_pet.detach()

    def _try_detach_dead_pet(self, pet_slot: PetSlot) -> bool:
        active_pet = self.active_pets.get(pet_slot)
        if not active_pet:
            return True
        if active_pet.creature.is_alive:
            return False

        active_pet.detach()
        return True

    def detach_totem(self, totem_slot: TotemSlots):
        self.detach_pet_by_slot(PetSlot.PET_SLOT_TOTEM_START + totem_slot)

    def detach_pet_by_guid(self, guid):
        for slot, active_pet in list(self.active_pets.items()):
            if active_pet.creature.guid == guid:
                self.detach_pet_by_slot(slot)
                break

    def get_active_controlled_pet(self) -> Optional[ActivePet]:
        permanent_pet = self.active_pets.get(PetSlot.PET_SLOT_PERMANENT)
        charm = self.active_pets.get(PetSlot.PET_SLOT_CHARM)
        # Return alive controlled pet, prioritizing permanent slot.
        return permanent_pet if (permanent_pet and permanent_pet.creature.is_alive or
                                 (not charm or not charm.creature.is_alive)) else charm

    def get_active_pet_by_guid(self, guid) -> Optional[ActivePet]:
        for active_pet in self.active_pets.values():
            if active_pet.creature.guid == guid:
                return active_pet
        return None

    def get_active_totem(self, totem_slot: TotemSlots) -> Optional[ActivePet]:
        return self.active_pets.get(PetSlot.PET_SLOT_TOTEM_START + totem_slot)

    def get_active_permanent_pet(self) -> Optional[ActivePet]:
        return self.active_pets.get(PetSlot.PET_SLOT_PERMANENT)

    def handle_action(self, pet_guid, target_guid, action):
        active_pet = self.get_active_controlled_pet()
        if not active_pet:
            return

        # Spell ID or 0/1/2/3 for setting command/react state.
        action_id = action & 0xFFFF

        active_pet_unit = active_pet.creature
        if active_pet_unit.guid != pet_guid:
            return

        if target_guid == 0:
            target_unit = self.owner
        else:
            target_unit = self.owner.get_map().get_surrounding_unit_by_guid(active_pet_unit, target_guid,
                                                                            include_players=True)

        if not target_unit:
            return

        if action_id > PetCommandState.COMMAND_DISMISS:  # Highest action ID.
            if active_pet_unit.spell_manager.is_spell_active(action_id):
                # If using an area aura spell that's already active (and not on autocast),
                # cancel it instead of recasting.
                if not active_pet.get_pet_data().is_spell_autocast(action_id):
                    active_pet_unit.spell_manager.remove_cast_by_id(action_id, interrupted=False)
                return

            spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(action_id)
            casting_spell = active_pet_unit.spell_manager.try_initialize_spell(spell, target_unit,
                                                                               SpellTargetMask.SELF, validate=False)
            if casting_spell.has_only_harmful_effects():
                if target_unit is self.owner:
                    return
                # Should pet enter combat here? We need this for delayed spell casting.
                active_pet_unit.combat_target = target_unit
            elif active_pet_unit.can_attack_target(target_unit):
                target_unit = self.owner

            active_pet_unit.object_ai.pending_spell_cast = None
            active_pet_unit.object_ai.do_spell_cast(spell, target_unit)

        elif action & (0x01 << 24):
            # Command state action.
            if action_id in {PetCommandState.COMMAND_FOLLOW, PetCommandState.COMMAND_STAY}:
                active_pet.get_pet_data().command_state = action_id
                active_pet.creature.object_ai.command_state_update()

            if action_id == PetCommandState.COMMAND_ATTACK and target_unit:
                active_pet.creature.attack(target_unit)
            if action_id == PetCommandState.COMMAND_DISMISS:
                self.detach_pet_by_slot(active_pet.pet_slot)

        else:
            # Always trigger react state update for stopping pet attack even when already passive.
            active_pet.get_pet_data().react_state = action_id
            active_pet.creature.object_ai.react_state_update()

    def handle_set_action(self, pet_guid, slot, action):
        active_pet = self.get_active_controlled_pet()
        if not active_pet:
            return
        pet_data = active_pet.get_pet_data()

        if slot < 0 or slot >= len(pet_data.action_bar):
            return

        if active_pet.creature.guid != pet_guid:
            return

        if action & 0xFFFF > PetCommandState.COMMAND_DISMISS and action != 0:  # Highest action ID - spell.
            if action & 0xFFFF not in pet_data.spells:
                return
            action |= 0x80 << 24  # Add usable flag - client doesn't include this.

        pet_data.action_bar[slot] = action
        pet_data.set_dirty()

        self.send_pet_spell_info()

    def handle_pet_abandon(self, pet_guid):
        pet = self.active_pets.get(PetSlot.PET_SLOT_PERMANENT)
        if not pet or pet_guid != pet.creature.guid:
            return

        self.detach_pet_by_slot(PetSlot.PET_SLOT_PERMANENT)
        self.permanent_pets[pet.pet_index].delete()
        self.permanent_pets.pop(pet.pet_index)

    def handle_pet_rename(self, pet_guid, name):
        pet_creature = self.active_pets.get(PetSlot.PET_SLOT_PERMANENT)
        if not pet_creature or pet_guid != pet_creature.creature.guid:
            return

        pet_data = pet_creature.get_pet_data()
        if pet_data.rename_time or not pet_data.is_hunter_pet():
            return  # Only allow renaming once, and only for hunter pets.

        pet_data.set_name(name)
        pet_creature.creature.set_uint32(UnitFields.UNIT_FIELD_PET_NAME_TIMESTAMP, pet_data.rename_time)
        pet_creature.creature.set_can_rename(False)

    def add_active_pet_experience(self, experience: int):
        active_pet = self.get_active_controlled_pet()
        if not active_pet:
            return

        pet_data = active_pet.get_pet_data()
        if self.owner.level <= pet_data.get_level() or not pet_data.is_hunter_pet():
            return

        level_gain = pet_data.add_experience(experience)
        if not level_gain:
            return

        active_pet.set_level(replenish=True)

    def handle_owner_level_change(self):
        active_pet = self.get_active_controlled_pet()
        if not active_pet:
            return
        pet_data = active_pet.get_pet_data()
        if pet_data.is_hunter_pet() or self.owner.level == pet_data.get_level():
            return

        active_pet.set_level(self.owner.level, replenish=True)

    def handle_cast_result(self, spell_id, result):
        if self.owner.get_type_id() != ObjectTypeIds.ID_PLAYER or \
                result == SpellCheckCastResult.SPELL_NO_ERROR:
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
        if self.permanent_pets:
            self._send_tame_result(PetTameResult.TAME_TOO_MANY)
            return SpellCheckCastResult.SPELL_FAILED_DONT_REPORT

        if not target.is_tameable():
            self._send_tame_result(PetTameResult.TAME_NOT_TAMABLE)
            return SpellCheckCastResult.SPELL_FAILED_DONT_REPORT

        return SpellCheckCastResult.SPELL_NO_ERROR

    def _send_tame_result(self, result):
        if self.owner.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if result == PetTameResult.TAME_SUCCESS:
            return

        data = pack('<B', result)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_TAME_FAILURE, data))

    def get_pet_data(self, pet_index: int) -> Optional[PetData]:
        if pet_index < 0 or pet_index >= len(self.permanent_pets):
            return None

        return self.permanent_pets[pet_index]

    def _handle_creature_spawn_detach(self, creature: CreatureManager, is_permanent):
        # Creatures which are linked to a CreatureSpawn.
        if creature.get_type_id() != ObjectTypeIds.ID_UNIT or creature.is_dynamic_spawn:
            return

        spawn = self.owner.get_map().get_surrounding_creature_spawn_by_spawn_id(self.owner, creature.spawn_id)
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

    def send_pet_spell_info(self, reset=False):
        if self.owner.get_type_id() != ObjectTypeIds.ID_PLAYER:
            return

        if not reset:
            active_pet = self.get_active_controlled_pet()
            if not active_pet:
                return

            pet_data = active_pet.get_pet_data()
            spell_count = len(pet_data.spells) if pet_data.permanent else 0

            # Creature guid, time limit, react state (0 = passive, 1 = defensive, 2 = aggressive),
            # command state (0 = stay, 1 = follow, 2 = attack, 3 = dismiss),
            # ??, Enabled (0x0 : 0x8)
            signature = f'<QI4B{PetActionBarIndex.INDEX_END}IB'
            data = [active_pet.creature.guid, 0, pet_data.react_state, pet_data.command_state, 0, 0]
            data.extend(pet_data.action_bar)

            data.append(spell_count)
            if spell_count:
                data.extend(pet_data.spells)
                signature += f'{spell_count}H'

            signature += 'B'
            data.append(0)  # TODO pet spellbook cooldowns.
        else:
            signature = '<Q'
            data = [0]

        packet = pack(signature, *data)
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_SPELLS, packet))
