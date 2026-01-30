from functools import lru_cache
from struct import pack
from typing import Optional
from database.dbc.DbcModels import Spell

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.spell import ExtendedSpellData
from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import TrainerServices, TrainerTypes
from utils.constants.OpCodes import OpCode


class TalentManager:
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr

    @staticmethod
    def get_talent_cost_by_id(spell_id: int) -> int:
        spell_rank: int = DbcDatabaseManager.SpellHolder.spell_get_rank_by_id(spell_id)
        is_specialization = ExtendedSpellData.SpecializationTalents.is_specialization_spell(spell_id)

        # TODO Below statements might not be 100% correct, but works for now since we lack more data.
        # https://github.com/The-Alpha-Project/alpha-core/issues/1362
        if is_specialization:
            return 10 if spell_rank <= 2 else 15 if 2 < spell_rank <= 4 else 20 if 5 < spell_rank <= 6 \
                else 25 if 7 < spell_rank <= 8 else 30

        talent_points_cost: int = 10 + ((spell_rank - 1) * 5)
        return talent_points_cost

    @staticmethod
    @lru_cache
    def get_talents_sorted_by_rank():
        training_spells = WorldDatabaseManager.TrainerSpellHolder.TALENTS
        training_spells.sort(key=lambda spell: DbcDatabaseManager.SpellHolder.spell_get_rank_by_id(spell.playerspell))
        return training_spells

    def send_talent_list(self):
        talent_bytes: bytearray = bytearray()
        talent_count: int = 0
        excluded_spell_line_ranks = set()

        for training_spell in TalentManager.get_talents_sorted_by_rank():
            spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(training_spell.playerspell)

            if not spell:
                continue

            skill_line_ability = None
            if DbcDatabaseManager.SkillLineAbilityHolder.spell_has_skill_line_ability(spell.ID):
                skill_line_ability = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_ability_get_by_spell_race_and_class(
                    spell.ID, self.player_mgr.race, self.player_mgr.class_)

                # Talent is not available to player.
                if not skill_line_ability:
                    continue

            # Check item/skill requirements to see if player can ever learn talent.
            if not TrainerUtils.player_can_learn_talent(training_spell, spell, self.player_mgr, self_talent=True):
                continue

            required_skill = training_spell.reqskill
            fulfills_skill = True
            if required_skill:
                # Player should have the required skill for the spell.
                if not self.player_mgr.skill_manager.has_skill(required_skill):
                    continue
                if self.player_mgr.skill_manager.get_total_skill_value(required_skill) < training_spell.reqskillvalue:
                    fulfills_skill = False

            required_level = training_spell.reqlevel if training_spell.reqlevel else spell.BaseLevel
            preceded_spell = training_spell.req_spell_1

            talent_points_cost = training_spell.talentpointcost if training_spell.talentpointcost > 0 else \
                TalentManager.get_talent_cost_by_id(training_spell.playerspell)

            status = TrainerUtils.get_training_list_spell_status(spell, training_spell, required_level, self.player_mgr,
                                                                 fulfills_skill=fulfills_skill,
                                                                 preceded_spell=preceded_spell,
                                                                 req_spell_2=training_spell.req_spell_2,
                                                                 req_spell_3=training_spell.req_spell_3,
                                                                 )

            # Get succeeded spell (Next spell in chain).
            succeeded_spell = skill_line_ability.SupercededBySpell if skill_line_ability else 0

            # If this spell is excluded (previous rank not available), hide.
            # (We only want to show the first unavailable spell in a chain).
            if training_spell.playerspell in excluded_spell_line_ranks:
                status = TrainerServices.TRAINER_SERVICE_NOT_SHOWN
                # Add the next spell as unavailable.
                if succeeded_spell:
                    excluded_spell_line_ranks.add(succeeded_spell)

            # Only show spell as 'Used' if succeeding spell not used.
            if succeeded_spell and succeeded_spell in self.player_mgr.spell_manager.spells:
                status = TrainerServices.TRAINER_SERVICE_NOT_SHOWN

            # Flag the next rank of this spell as unavailable.
            if succeeded_spell and status == TrainerServices.TRAINER_SERVICE_UNAVAILABLE:
                excluded_spell_line_ranks.add(succeeded_spell)

            talent_bytes.extend(
                TrainerUtils.get_spell_data(training_spell.spell, status, 0,  # 0 Money cost.
                                            talent_points_cost, 0,  # 0 Skill point cost.
                                            required_level, training_spell.reqskill, training_spell.reqskillvalue,
                                            0,  # Required skill data.
                                            preceded_spell, training_spell.req_spell_2, training_spell.req_spell_3))
            talent_count += 1

        data = pack('<Q2I', self.player_mgr.guid, TrainerTypes.TRAINER_TYPE_TALENTS, talent_count) + talent_bytes
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))
