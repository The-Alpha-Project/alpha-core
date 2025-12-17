from game.world.managers.objects.units.pet.PetData import PetData
from utils.Logger import Logger
from utils.constants.PetCodes import PetSlot
from utils.constants.UnitCodes import MovementTypes
from utils.constants.UpdateFields import UnitFields


class ActivePet:
    def __init__(self, pet_manager, pet_index, pet_slot, creature_manager, pet_data):
        self._pet_manager = pet_manager
        self.pet_index = pet_index
        self.pet_slot = pet_slot
        self._pet_data = pet_data if not pet_data.permanent else None
        self.creature = creature_manager
        self.attach()

    def get_pet_data(self) -> PetData:
        return self._pet_manager.get_pet_data(self.pet_index) if not self._pet_data else self._pet_data

    def is_permanent(self):
        return self._pet_data is None

    def is_controlled(self):
        return self.pet_slot in {PetSlot.PET_SLOT_PERMANENT, PetSlot.PET_SLOT_CHARM}

    def get_created_by_spell(self):
        return self.get_pet_data().summon_spell_id

    def teach_spell(self, spell_id, force=False, update=True) -> bool:
        pet_data = self.get_pet_data()
        if not pet_data.permanent:
            return False

        if not force and not pet_data.can_learn_spell(spell_id):
            return False

        if not pet_data.add_spell(spell_id):
            return False

        if update:
            self._pet_manager.send_pet_spell_info()

        return True

    def get_command_state(self):
        return self.get_pet_data().command_state

    def initialize_spells(self, level_override=-1):
        pet_data = self.get_pet_data()

        spells = pet_data.get_available_spells(level_override=level_override)
        update = any([self.teach_spell(spell_id, update=False) for spell_id in spells])
        if update:
            pet_data.action_bar = pet_data.get_default_action_bar_values()
            self._pet_manager.send_pet_spell_info()
            pet_data.set_dirty()

    def set_level(self, level=-1, replenish=False):
        pet_data = self.get_pet_data()

        if level == -1:
            level = pet_data.get_level()
        elif pet_data.get_level() != level:
            pet_data.set_level(level)

        self.creature.set_uint32(UnitFields.UNIT_FIELD_PETEXPERIENCE, pet_data.get_experience())

        # TODO Creature leveling should be handled by CreatureManager.
        self.creature.level = level
        self.creature.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.creature.level)
        self.creature.set_uint32(UnitFields.UNIT_FIELD_PETNEXTLEVELEXP, pet_data.next_level_xp)

        self.creature.stat_manager.set_creature_stats()
        self.creature.stat_manager.apply_bonuses(replenish=replenish)

    def attach(self):
        self.get_pet_data().set_active(True)

        if self.is_permanent() or not self.is_controlled():
            # Permanent pet/totem/guardian.
            self.creature.set_summoned_by(self._pet_manager.owner, spell_id=self.get_created_by_spell(),
                                          subtype=self.creature.subtype,
                                          movement_type=MovementTypes.IDLE)
        else:
            # Temporary charm.
            self.creature.set_charmed_by(self._pet_manager.owner, subtype=self.creature.subtype,
                                         movement_type=MovementTypes.IDLE)

    def detach(self):
        pet_data = self.get_pet_data()

        movement_type = MovementTypes.IDLE
        map_ = self.creature.get_map()
        # Check if this is a borrowed creature instance.
        if not self.creature.is_dynamic_spawn:
            spawn = map_.get_surrounding_creature_spawn_by_spawn_id(self.creature, self.creature.spawn_id)
            # This creature might be too far from its spawn upon detach, search in all map cells.
            if not spawn:
                spawn = map_.get_creature_spawn_by_id(self.creature.spawn_id)
            # Creature spawn should be found at this point.
            if spawn:
                if not spawn.restore_creature_instance(self.creature):
                    Logger.error(f'Unable to restore creature from spawn id {self.creature.spawn_id} upon pet detach.')
                movement_type = spawn.movement_type
            else:
                Logger.error(f'Unable to locate SpawnCreature with id {self.creature.spawn_id} upon pet detach.')

        if pet_data.summon_spell_id and self.creature.is_alive and self._pet_manager.owner.is_unit(by_mask=True):
            self._pet_manager.owner.spell_manager.unlock_spell_cooldown(pet_data.summon_spell_id)

        if self.is_permanent():
            pet_data.save(self.creature)

        # Flush ThreatManager before releasing this creature in order to avoid evade trigger.
        self.creature.leave_combat()

        if self.is_controlled():
            self._pet_manager.send_pet_spell_info(reset=True)

        # Orphan creature. In some cases, the creature may already be destroyed.
        if self.creature.is_spawned and self.creature.is_dynamic_spawn:
            self.creature.despawn()

        # Releasing a pet. Restore state.
        if self.is_permanent() or not self.is_controlled():
            self.creature.set_summoned_by(self._pet_manager.owner, movement_type=movement_type, remove=True)
        else:
            self.creature.set_charmed_by(self._pet_manager.owner, movement_type=movement_type, remove=True)

        if not self.creature.is_spawned:
            return  # Destroyed and detached.

        # Update stats to clear pet-specific values.
        self.creature.stat_manager.set_creature_stats()
        self.creature.stat_manager.apply_bonuses()

        # Generate threat against owner.
        self.creature.threat_manager.add_threat(self._pet_manager.owner)

        # Notify about owner proximity.
        self.creature.object_ai.move_in_line_of_sight(self._pet_manager.owner)
