from typing import Optional
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell
from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.SpellCodes import SpellTargetMask
from network.packet.PacketReader import PacketReader
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from utils.Logger import Logger
from utils.constants.MiscCodes import TrainerServices, TrainerTypes, TrainingFailReasons
from struct import unpack
from network.packet.PacketWriter import *


class TrainerBuySpellHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 12:  # Avoid handling empty trainer buy spell packet.
            trainer_guid: int = unpack('<Q', reader.data[:8])[0]
            training_spell_id: int = unpack('<I', reader.data[8:12])[0]

            # If the guid equals to player guid, training through a talent.
            if trainer_guid == world_session.player_mgr.guid:
                TrainerBuySpellHandler.handle_player_buy_spell(player_mgr, training_spell_id)
            # NPC Trainer.
            else:
                TrainerBuySpellHandler.handle_trainer_buy_spell(world_session, player_mgr, trainer_guid, training_spell_id)

        return 0

    @staticmethod
    def handle_player_buy_spell(player_mgr, training_spell_id):
        # Spell that should be taught to the player.
        spell_id = WorldDatabaseManager.TrainerSpellHolder.get_player_spell_by_trainer_spell_id(training_spell_id)
        if not spell_id:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, player_mgr.guid, training_spell_id, fail_reason)
            return

        talent_cost = player_mgr.talent_manager.get_talent_cost_by_id(spell_id)
        fail_reason = None
        if talent_cost > player_mgr.talent_points:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS
        elif spell_id in player_mgr.spell_manager.spells:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not player_mgr.spell_manager.can_learn_spell(spell_id):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE

        if fail_reason:
            TrainerBuySpellHandler.send_trainer_buy_fail(player_mgr, player_mgr.guid, training_spell_id, fail_reason)
        else:
            player_mgr.remove_talent_points(talent_cost)
            player_mgr.spell_manager.handle_cast_attempt(training_spell_id, player_mgr, SpellTargetMask.SELF,
                                                         validate=False)
            TrainerBuySpellHandler.send_trainer_buy_succeeded(player_mgr, player_mgr.guid, training_spell_id)

    @staticmethod
    def handle_trainer_buy_spell(world_session, trainer_guid, training_spell_id):
        unit = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, trainer_guid)
        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(unit.entry)
        trainer_templates = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_template.entry)

        trainer_spell = None
        for t_template in trainer_templates:
            if t_template.spell == training_spell_id:
                trainer_spell = t_template
                break

        if not trainer_spell:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(world_session.player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        player_spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell.playerspell)
        if not player_spell:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            TrainerBuySpellHandler.send_trainer_buy_fail(world_session.player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        spell_money_cost = trainer_spell.spellcost
        spell_skill_cost = trainer_spell.skillpointcost

        fail_reason = -1
        anti_cheat = False
        if not unit.is_trainer() or not TrainerUtils.can_train(unit, world_session.player_mgr) or \
                not TrainerUtils.trainer_has_spell(unit, training_spell_id):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True
        elif spell_money_cost > 0 and spell_money_cost > world_session.player_mgr.coinage:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_MONEY
        elif spell_skill_cost > 0 and spell_skill_cost > world_session.player_mgr.skill_points:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_NOT_ENOUGH_POINTS
        elif trainer_spell.reqlevel > world_session.player_mgr.level:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True
        elif trainer_spell.playerspell in world_session.player_mgr.spell_manager.spells:
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not world_session.player_mgr.spell_manager.can_learn_spell(player_spell.ID):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
        elif not world_session.account_mgr.is_gm() and not unit.is_within_interactable_distance(world_session.player_mgr):
            fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE
            anti_cheat = True

        # If this is a profession trainer, do checks that apply only to profession trainers.
        if creature_template.trainer_type == TrainerTypes.TRAINER_TYPE_TRADESKILLS:
            default_spells = WorldDatabaseManager.DefaultProfessionSpellHolder.default_profession_spells_get_by_trainer_spell_id(training_spell_id)

            # Check for any spells that should be learned by default with profession and learn them.
            if len(default_spells) > 0:
                for profession_spell_entry in default_spells:
                    world_session.player_mgr.spell_manager.learn_spell(profession_spell_entry.default_spell)

            # Get data required to verify spell status.
            spell: Optional[Spell] = DbcDatabaseManager.SpellHolder.spell_get_by_id(trainer_spell.playerspell)
            preceded_skill_line = DbcDatabaseManager.SkillLineAbilityHolder.skill_line_abilities_get_preceded_by_spell(spell.ID)
            preceded_spell = 0 if not preceded_skill_line else preceded_skill_line.Spell
            req_level = trainer_spell.reqlevel if trainer_spell.reqlevel else spell.BaseLevel

            # Get spell status again to verify that client check was correct.
            verify_status = TrainerUtils.get_training_list_spell_status(spell, trainer_spell, req_level, preceded_spell, world_session.player_mgr)

            # Check spell status, fail if spell should be unavailable.
            if verify_status == TrainerServices.TRAINER_SERVICE_UNAVAILABLE:
                fail_reason = TrainingFailReasons.TRAIN_FAIL_UNAVAILABLE

        if fail_reason != -1:
            if anti_cheat:
                Logger.anticheat(f'Player {world_session.player_mgr.guid} tried to train spell {trainer_spell.playerspell} '
                                 f'(entry {trainer_spell.template_entry}) from NPC {unit.entry}.')
            TrainerBuySpellHandler.send_trainer_buy_fail(world_session.player_mgr, trainer_guid, training_spell_id, fail_reason)
            return

        if spell_money_cost > 0:
            world_session.player_mgr.mod_money(-spell_money_cost)

        # Some trainer spells cost SP in alpha - class trainers trained weapon skills, which cost skill points.
        if spell_skill_cost > 0:
            world_session.player_mgr.remove_skill_points(spell_skill_cost)
        
        # Succeeded.
        unit.spell_manager.handle_cast_attempt(training_spell_id, world_session.player_mgr, SpellTargetMask.UNIT, validate=False)
        TrainerBuySpellHandler.send_trainer_buy_succeeded(world_session.player_mgr, trainer_guid, training_spell_id)

    @staticmethod
    def send_trainer_buy_fail(player_mgr, trainer_guid: int, spell_id: int, reason: TrainingFailReasons):
        data = pack('<Q2I', trainer_guid, spell_id, reason)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_FAILED, data))

    @staticmethod
    def send_trainer_buy_succeeded(player_mgr, trainer_guid: int, spell_id: int):
        data = pack('<QI', trainer_guid, spell_id)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_BUY_SUCCEEDED, data))
