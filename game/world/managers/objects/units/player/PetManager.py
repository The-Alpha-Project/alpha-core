import time
from struct import pack
from typing import Optional, NamedTuple

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldModels import CreatureTemplate
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask, SpellCheckCastResult
from utils.constants.UnitCodes import MovementTypes
from utils.constants.UpdateFields import UnitFields


class PetData:
    def __init__(self, name: str, template: CreatureTemplate, owner_guid, permanent: bool):
        self.name = name
        self.creature_template = template
        self.owner_guid = owner_guid
        self.permanent = permanent

        self.react_state = 1
        self.command_state = 1

        self.spells = self._get_default_spells()

    def _get_default_spells(self) -> list[int]:
        creature_family = self.creature_template.beast_family
        if not creature_family:
            return []

        family_entry = DbcDatabaseManager.CreatureFamilyHolder.creature_family_get_by_id(creature_family)
        skill_lines = [family_entry.SkillLine_1, family_entry.SkillLine_2]  # TODO 2 is pet talents or 0, ignore for now.

        if not skill_lines[0]:
            return []

        skill_line_abilities = DbcDatabaseManager.skill_line_ability_get_by_skill_lines([skill_lines[0]])
        if not skill_line_abilities:
            return []

        return [skill_line_ability.Spell for skill_line_ability in skill_line_abilities]

    def get_action_bar_values(self):
        pet_bar = [
                2 | (0x07 << 24), 1 | (0x07 << 24), 0 | (0x07 << 24),  # Attack, Follow, Stay.
                2 | (0x06 << 24), 1 | (0x06 << 24), 0 | (0x06 << 24)  # Aggressive, Defensive, Passive.
        ]

        # All pet actions seem to have |0x1.
        # Pet action bar flags: 0x40 for auto cast on, 0x80 for castable.

        spells_index = PetManager.PET_BAR_SPELL_START

        spell_ids = [spell | ((0x1 | 0x40 | 0x80) << 24) for spell in self.spells]
        spell_ids += [0] * (PetManager.PET_BAR_SPELL_COUNT - len(spell_ids))  # Always 4 spells, pad with 0.
        pet_bar[spells_index:spells_index] = spell_ids  # Insert spells to action bar.

        return pet_bar


class ActivePet(NamedTuple):
    pet_index: int
    creature: CreatureManager
    expiration_time: int


class PetManager:
    def __init__(self, player):
        self.player = player
        self.pets: list[PetData] = []
        self.active_pet: Optional[ActivePet] = None  # TODO Multiple active pets - totems?

    def add_pet_from_world(self, creature: CreatureManager, lifetime_sec=-1):
        if self.active_pet:
            return  # TODO

        self._tame_creature(creature)
        index = self.add_pet(creature.creature_template, lifetime_sec)
        self._set_active_pet(index, creature)

    def _set_active_pet(self, pet_index: int, creature: CreatureManager):
        pet_info = self._get_pet_info(pet_index)

        if self.active_pet or not pet_info:
            return

        self.active_pet = ActivePet(pet_index, creature, -1 if pet_info.permanent else 60)  # ??
        self._send_pet_spell_info()

    def add_pet(self, creature_template: CreatureTemplate, lifetime_sec=-1) -> int:
        # TODO: default name by beast_family - resolve id reference.

        pet = PetData(creature_template.name, creature_template, self.player.guid, permanent=lifetime_sec == -1)
        self.pets.append(pet)
        return len(self.pets) - 1

    def update(self, timestamp):
        if not self.active_pet or self.active_pet.expiration_time == -1:
            return

        if self.active_pet.expiration_time < timestamp:
            Logger.info("Pet expired.")
            self.active_pet.expiration_time = -1
            return

    def handle_action(self, pet_guid, target_guid, action):
        # Spell ID or 0/1/2 for default pet bar actions.
        action_id = action & 0xFFFF

        active_pet_unit = self.active_pet.creature
        # Single active pet assumed.
        if active_pet_unit.guid != pet_guid:
            return

        target_unit = MapManager.get_surrounding_unit_by_guid(active_pet_unit, target_guid, include_players=True)
        if not target_unit:
            return

        if action_id > 2:
            Logger.info(f"Spellcast action: {action_id}")
            target_mask = SpellTargetMask.SELF if target_unit.guid == active_pet_unit.guid \
                else SpellTargetMask.UNIT
            active_pet_unit.spell_manager.handle_cast_attempt(action_id, target_unit, target_mask)

        elif action & (0x01 << 24):
            if action_id == 2:
                active_pet_unit.attack(target_unit)
            Logger.info(f"Attack (2)/Follow (1)/Stay(0): {action_id}")

        else:
            Logger.info(f"Aggressive (2)/Defensive (1)/Passive(0): {action_id}")

    def handle_cast_result(self, spell_id, result):
        if result == SpellCheckCastResult.SPELL_NO_ERROR:
            return

        data = pack('<IB', spell_id, result)
        self.player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_CAST_FAILED, data))

    def _get_pet_info(self, pet_index: int) -> Optional[PetData]:
        if pet_index < 0 or pet_index >= len(self.pets):
            return None

        return self.pets[pet_index]

    def _tame_creature(self, creature: CreatureManager):
        creature.set_uint64(UnitFields.UNIT_FIELD_SUMMONEDBY, self.player.guid)
        creature.set_uint64(UnitFields.UNIT_FIELD_CREATEDBY, self.player.guid)

        creature.faction = self.player.faction
        creature.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, creature.faction)
        creature.set_uint32(UnitFields.UNIT_FIELD_PET_NAME_TIMESTAMP, int(time.time()))

        creature.set_uint32(UnitFields.UNIT_FIELD_PETNUMBER, 1)
        # Just disable random movement for now.
        creature.creature_instance.movement_type = MovementTypes.IDLE  # TODO pet movement.

        self.player.set_uint64(UnitFields.UNIT_FIELD_SUMMON, creature.guid)

        # Required?
        # creature.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, casting_spell.spell_entry.ID)


    def _send_pet_spell_info(self):
        if not self.active_pet:
            return

        # This packet contains the both the action bar of the pet and the spellbook entries.

        pet_info = self._get_pet_info(self.active_pet.pet_index)

        bar_slots = 10
        # Creature guid, time limit, react state (0 = passive, 1 = defensive, 2 = aggressive),
        # command state (0 = stay, 1 = follow, 2 = attack, 3 = dismiss),
        # ??, Enabled (0x0 : 0x8)
        signature = f'<QI4B{bar_slots}I2B'
        data = [self.active_pet.creature.guid, 0, pet_info.react_state, pet_info.command_state, 0, 0]

        data.extend(pet_info.get_action_bar_values())

        data.append(0)  # Spellbook entry count. TODO
        data.append(0)  # Cooldown count. TODO

        packet = pack(signature, *data)
        self.player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_PET_SPELLS, packet))

    # TODO As enum.
    PET_BAR_SLOTS = 10
    PET_BAR_SPELL_START = 3
    PET_BAR_SPELL_COUNT = 4
    PET_BAR_REACTION_START = 7

