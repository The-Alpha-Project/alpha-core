from struct import pack
from typing import Optional
from database.dbc.DbcModels import Spell

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from game.world.managers.objects.units.player.SkillManager import SkillLineType
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import TrainerServices, TrainerTypes


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

            # Check item/skill requirements to see if player can ever learn talent.
            if not TrainerUtils.player_can_ever_learn_talent(training_spell, spell, skill_line_ability, self.player_mgr):
                continue

            has_skill = self.player_mgr.skill_manager.has_skill(skill_id=skill_line_ability.SkillLine)
            skill = DbcDatabaseManager.SkillHolder.skill_get_by_id(skill_id=skill_line_ability.SkillLine)
            # Handle talent skills as known. (Weapon Talents, Attribute Enhancements, Slayer Talents, etc)
            if not has_skill and skill.SkillType == SkillLineType.TALENTS:
                has_skill = True

            # Search previous spell.
            preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(spell.ID)
            preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell
            
            talent_points_cost = training_spell.talentpointcost if training_spell.talentpointcost > 0 else \
                TalentManager.get_talent_cost_by_id(training_spell.playerspell)
            status = TrainerUtils.get_training_list_spell_status(spell, training_spell, spell.BaseLevel,
                                                                 preceded_spell, self.player_mgr,
                                                                 fulfills_skill=has_skill)

            # If the spell before this one exists and is unavailable, don't show this one.
            # (We only want to show the first unavailable spell in a chain).
            if preceded_spell != 0:
                preceded_preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(preceded_spell)
                preceded_preceded_spell = 0 if not preceded_preceded_skill_line else preceded_preceded_skill_line.Spell

                preceded_spell_entry: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(preceded_spell)
                preceded_trainer_spell_id = WorldDatabaseManager.TrainerSpellHolder.trainer_spell_id_get_from_player_spell_id(WorldDatabaseManager.TrainerSpellHolder.TRAINER_TEMPLATE_TALENT_ID, preceded_spell)
                preceded_trainer_spell = WorldDatabaseManager.TrainerSpellHolder.trainer_spell_entry_get_by_trainer_and_spell(WorldDatabaseManager.TrainerSpellHolder.TRAINER_TEMPLATE_TALENT_ID, preceded_trainer_spell_id)
                preceded_status = TrainerUtils.get_training_list_spell_status(preceded_spell_entry, preceded_trainer_spell, preceded_spell_entry.BaseLevel, 
                                                                              preceded_preceded_spell, self.player_mgr)
                                                                                                                                                            
                if preceded_status == TrainerServices.TRAINER_SERVICE_UNAVAILABLE:
                    status = TrainerServices.TRAINER_SERVICE_NOT_SHOWN

            # Get succeeded spell.
            succeeded_spell = skill_line_ability.SupercededBySpell

            # Only show spell in used if succeeding spell not used.
            if succeeded_spell != 0 and succeeded_spell in self.player_mgr.spell_manager.spells:
                status = TrainerServices.TRAINER_SERVICE_NOT_SHOWN

            talent_bytes += TrainerUtils.get_spell_data(training_spell.spell, status, 0,  # 0 Money cost.
                                                        talent_points_cost, 0,  # 0 Skill point cost.
                                                        spell.BaseLevel,
                                                        training_spell.reqskill,
                                                        training_spell.reqskillvalue,
                                                        0,  # Required skill data.
                                                        preceded_spell)
            talent_count += 1

        data = pack('<Q2I', self.player_mgr.guid, TrainerTypes.TRAINER_TYPE_TALENTS, talent_count) + talent_bytes
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))
