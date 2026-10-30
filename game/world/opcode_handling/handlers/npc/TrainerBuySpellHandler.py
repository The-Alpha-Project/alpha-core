from typing import Optional
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from game.world.managers.objects.units.player.TalentManager import TalentManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Formulas import Distances
from utils.constants.SpellCodes import SpellTargetMask
from network.packet.PacketReader import PacketReader
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.MiscCodes import TrainerServices, TrainerTypes, TrainingFailReasons
from struct import unpack
from network.packet.PacketWriter import *


class TrainerBuySpellHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty trainer buy spell packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=12):
            return 0

        trainer_guid: int = unpack('<Q', reader.data[:8])[0]
        training_spell_id: int = unpack('<I', reader.data[8:12])[0]

        # If the guid equals to player guid, training through a talent.
        if trainer_guid == player_mgr.guid:
            TrainerBuySpellHandler.handle_player_buy_spell(player_mgr, training_spell_id)
            return 0

        TrainerBuySpellHandler.handle_trainer_buy_spell(player_mgr, trainer_guid, training_spell_id)

        return 0

    @staticmethod
    def handle_player_buy_spell(player_mgr, training_spell_id):
        # Spell that should be taught to the player.
        spell_id = WorldDatabaseManager.TrainerSpellHolder.get_player_spell_by_trainer_spell_id(training_spell_id)
        if not spell_id:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, player_mgr.guid, training_spell_id, fail_reason)
            return

        # Get data required to verify spell status.
        trainer_templates = WorldDatabaseManager.TrainerSpellHolder.TALENTS

        trainer_spell = None
        for t_template in trainer_templates:
            if t_template.spell == training_spell_id:
                trainer_spell = t_template
                break

        if not trainer_spell:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, player_mgr.guid, training_spell_id, fail_reason)
            return

        talent_cost = TalentManager.get_talent_cost_from_training_spell(trainer_spell)

        fail_reason = None
        if talent_cost > player_mgr.talent_points:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS
        elif spell_id in player_mgr.spell_manager.spells:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not player_mgr.spell_manager.can_learn_spell(spell_id):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE

        spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell.playerspell)
        preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(spell.ID)
        preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell
        req_level = trainer_spell.reqlevel if trainer_spell.reqlevel else spell.BaseLevel

        # Get talent status again to verify that client check was correct.
        verify_status = TrainerUtils.get_training_list_spell_status(spell, trainer_spell, req_level, player_mgr,
                                                                    preceded_spell=preceded_spell)

        # Check talent status, fail if spell should be unavailable.
        if verify_status == TrainerServices.TRAINER_SERVICE_UNAVAILABLE or not \
                TrainerUtils.player_can_learn_talent(trainer_spell, spell, player_mgr):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            player_mgr.talent_manager.send_talent_list()

        # TRAIN_FAIL_UNAVAILABLE is 0, check against None.
        if fail_reason is not None:
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, player_mgr.guid, training_spell_id, fail_reason)
            return
    
        # Success.
        player_mgr.remove_talent_points(talent_cost)
        player_mgr.spell_manager.handle_cast_attempt(training_spell_id, player_mgr, SpellTargetMask.SELF,
                                                     validate=False)
        TrainerBuySpellHandler.send_trainer_buy_succeeded(player_mgr, player_mgr.guid, training_spell_id)

    @staticmethod
    def handle_trainer_buy_spell(player_mgr, trainer_guid, training_spell_id):
        unit = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, trainer_guid)
        if not unit:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(unit.entry)
        if not creature_template:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        trainer_templates = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_template.entry)

        trainer_spell = None
        for t_template in trainer_templates:
            if t_template.spell == training_spell_id:
                trainer_spell = t_template
                break

        if not trainer_spell:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        player_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell.playerspell)
        if not player_spell:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        spell_money_cost = trainer_spell.spellcost
        spell_skill_cost = trainer_spell.skillpointcost
        # Pet abilities are checked against the pet by get_training_list_spell_status, not the player.
        is_taught_to_pet = TrainerUtils.is_taught_to_pet(trainer_spell)

        fail_reason = None
        anti_cheat = False
        if not unit.is_trainer() or not TrainerUtils.can_train(unit, player_mgr) or \
                not TrainerUtils.trainer_has_spell(unit, training_spell_id) or \
                not TrainerUtils.is_trainer_spell_offered(unit, player_mgr, trainer_spell, player_spell):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True
        elif spell_money_cost > 0 and spell_money_cost > player_mgr.coinage:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_MONEY
        elif spell_skill_cost > 0 and spell_skill_cost > player_mgr.skill_points:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS
        elif trainer_spell.reqlevel > player_mgr.level:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True
        elif not is_taught_to_pet and trainer_spell.playerspell in player_mgr.spell_manager.spells:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not is_taught_to_pet and not player_mgr.spell_manager.can_learn_spell(player_spell.ID):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not player_mgr.is_gm and not Distances.is_within_shop_distance(player_mgr, unit):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True

        # Verify the status again with the same rules send_trainer_list uses, for every trainer type.
        if fail_reason is None:
            preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(
                player_spell.ID)
            preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell
            req_level = trainer_spell.reqlevel if trainer_spell.reqlevel else player_spell.BaseLevel
            fulfill_skill_reqs = True
            if trainer_spell.reqskill:
                skill_value = player_mgr.skill_manager.get_total_skill_value(trainer_spell.reqskill, no_bonus=True)
                fulfill_skill_reqs = skill_value >= trainer_spell.reqskillvalue

            verify_status = TrainerUtils.get_training_list_spell_status(player_spell, trainer_spell, req_level,
                                                                        player_mgr, fulfill_skill_reqs,
                                                                        preceded_spell=preceded_spell,
                                                                        req_spell_2=trainer_spell.req_spell_2,
                                                                        req_spell_3=trainer_spell.req_spell_3)
            # Also refuses spells the pet already knows (TRAINER_SERVICE_USED).
            if verify_status != TrainerServices.TRAINER_SERVICE_AVAILABLE:
                fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
                TrainerUtils.send_trainer_list(unit, player_mgr)

        # TRAIN_FAIL_UNAVAILABLE is 0, check against None.
        if fail_reason is not None:
            if anti_cheat:
                Logger.anticheat(f'Player {player_mgr.guid} tried to train spell {trainer_spell.playerspell} '
                                 f'(entry {trainer_spell.template_entry}) from NPC {unit.entry}.')
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        # Profession trainers teach the profession default spells, only once the request is valid.
        if creature_template.trainer_type == TrainerTypes.TRAINER_TYPE_TRADESKILLS:
            for profession_spell_entry in WorldDatabaseManager.DefaultProfessionSpellHolder \
                    .default_profession_spells_get_by_trainer_spell_id(training_spell_id):
                player_mgr.spell_manager.learn_spell(profession_spell_entry.default_spell)

        if spell_money_cost > 0:
            player_mgr.mod_money(-spell_money_cost)

        # Some trainer spells cost SP in alpha - class trainers trained weapon skills, which cost skill points.
        if spell_skill_cost > 0:
            player_mgr.remove_skill_points(spell_skill_cost)
        
        # Succeeded.
        unit.spell_manager.handle_cast_attempt(training_spell_id, player_mgr, SpellTargetMask.UNIT, validate=False)
        TrainerBuySpellHandler.send_trainer_buy_succeeded(player_mgr, trainer_guid, training_spell_id)

    @staticmethod
    def send_trainer_buy_fail(player_mgr, trainer_guid: int, spell_id: int, reason: TrainingFailReasons):
        data = pack('<Q2I', trainer_guid, spell_id, reason)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_FAILED, data))

    @staticmethod
    def send_trainer_buy_succeeded(player_mgr, trainer_guid: int, spell_id: int):
        data = pack('<QI', trainer_guid, spell_id)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))
