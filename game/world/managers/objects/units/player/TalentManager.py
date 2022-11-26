from struct import pack
from typing import Optional
from database.dbc.DbcModels import Spell

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import TrainerServices, TrainerTypes
from utils.constants.SpellCodes import SpellEffects


class TalentManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr

    @staticmethod
    def get_talent_cost_by_id(spell_id: int) -> int:
        spell_rank: int = DbcDatabaseManager.SpellHolder.spell_get_rank_by_id(spell_id)

        # TODO Below statement is not 100% correct, but works -for now- since we lack more data.
        # We do know that Rank 1 cost 10 TP and Rank 2 cost 15 TP (https://i.imgur.com/eFi3cf4.jpg),
        # so we assume each rank cost 5 TP more.
        talent_points_cost: int = 10 + ((spell_rank - 1) * 5)
        return talent_points_cost

    def send_talent_list(self):
        talent_bytes: bytes = b''
        talent_count: int = 0

        for training_spell in WorldDatabaseManager.TrainerSpellHolder.TALENTS:
            spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(training_spell.playerspell)

            if not spell:
                continue

            skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell_race_and_class(
                spell.ID, self.player_mgr.race, self.player_mgr.class_)

            # Talent is not available to player.
            if not skill_line_ability:
                continue

            spell_item_class = spell.EquippedItemClass
            spell_item_subclass_mask = spell.EquippedItemSubclass
            # Check for required proficiencies for this talent.
            if spell_item_class != -1 and spell_item_subclass_mask != 1:
                # Don't display talent if the player can never learn the proficiency needed.
                if not self.player_mgr.skill_manager.can_ever_use_equipment(spell_item_class, spell_item_subclass_mask):
                    continue

            # Search previous spell.
            preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(spell.ID)
            preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell

            talent_points_cost = TalentManager.get_talent_cost_by_id(training_spell.playerspell)
            status = TrainerUtils.get_training_list_spell_status(spell, preceded_spell, self.player_mgr)

            if status[0] == TrainerServices.TRAINER_SERVICE_UNAVAILABLE and status[1] == 'NEED_PREVIOUS_RANK':
                previous_previous_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(preceded_spell)
                previous_previous_spell = 0 if not previous_previous_skill_line else previous_previous_skill_line.Spell

                if previous_previous_spell != 0:
                    previous_spell_entry: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(previous_previous_spell)
                    previous_previous_status = TrainerUtils.get_training_list_spell_status(previous_spell_entry, previous_previous_spell, self.player_mgr)
                    if previous_previous_status[0] == TrainerServices.TRAINER_SERVICE_UNAVAILABLE and previous_previous_status[1] == 'NEED_PREVIOUS_RANK':
                        continue

            talent_bytes += TrainerUtils.get_spell_data(training_spell.spell, status[0], 0,  # 0 Money cost.
                                                        talent_points_cost, 0,  # 0 Skill point cost.
                                                        spell.BaseLevel,
                                                        0, 0, 0,  # Required skill data, 0 for now.
                                                        preceded_spell)
            talent_count += 1

        data = pack('<Q2I', self.player_mgr.guid, TrainerTypes.TRAINER_TYPE_TALENTS, talent_count) + talent_bytes
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))
