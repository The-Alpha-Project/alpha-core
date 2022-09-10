from struct import pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import TrainerTemplate, SpellChain
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.TextUtils import GameTextFormatter
from utils.constants.MiscCodes import TrainerServices, TrainerTypes
from utils.constants.OpCodes import OpCode


class TrainerUtils:

    # TODO Add skills (Two-Handed Swords etc.) to trainers for skill points https://i.imgur.com/tzyDDqL.jpg
    @staticmethod
    def send_trainer_list(creature_mgr, player_mgr):
        if not TrainerUtils.can_train(creature_mgr, player_mgr):
            Logger.anticheat(f'send_trainer_list called from NPC {creature_mgr.entry} by player with GUID '
                             f'{player_mgr.guid} but this unit does not train that '
                             f'player\'s class. Possible cheating')
            return

        train_spell_bytes: bytes = b''
        train_spell_count: int = 0

        trainer_ability_list: list[
            TrainerTemplate] = WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_mgr.entry)

        if not trainer_ability_list or trainer_ability_list.count == 0:
            Logger.warning(f'send_trainer_list called from NPC {creature_mgr.entry} but no trainer spells found!')
            return

        # trainer_spell: The spell the trainer uses to teach the player.
        for trainer_spell in trainer_ability_list:
            player_spell_id = trainer_spell.playerspell

            ability_spell_chain: SpellChain = WorldDatabaseManager.SpellChainHolder.spell_chain_get_by_spell(
                player_spell_id)

            # Use this and not spell data, there are differences between (2003 Game Guide) and what is in spell table.
            # TODO: Client validates spell data versus dbc information, might not be a good idea to send custom stuff.
            spell_level: int = trainer_spell.reqlevel
            spell_rank: int = ability_spell_chain.rank
            prev_spell: int = ability_spell_chain.prev_spell

            spell_is_too_high_level: bool = spell_level > player_mgr.level

            if player_spell_id in player_mgr.spell_manager.spells:
                status = TrainerServices.TRAINER_SERVICE_USED
            else:
                if prev_spell in player_mgr.spell_manager.spells and spell_rank > 1 and not spell_is_too_high_level:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                elif spell_rank == 1 and not spell_is_too_high_level:
                    status = TrainerServices.TRAINER_SERVICE_AVAILABLE
                else:
                    status = TrainerServices.TRAINER_SERVICE_UNAVAILABLE

            data: bytes = pack(
                '<IBI3B6I',
                trainer_spell.spell,  # Trainer Spell id.
                status,  # Status.
                trainer_spell.spellcost,  # Cost.
                trainer_spell.talentpointcost,  # Talent Point Cost.
                trainer_spell.skillpointcost,  # Skill Point Cost.
                spell_level,  # Required Level.
                trainer_spell.reqskill,  # Required Skill Line.
                trainer_spell.reqskillvalue,  # Required Skill Rank.
                0,  # Required Skill Step.
                prev_spell,  # Required Ability (1).
                0,  # Required Ability (2).
                0  # Required Ability (3).
            )
            train_spell_bytes += data
            train_spell_count += 1

        placeholder_greeting: str = f'Hello, $c!  Ready for some training?'
        trainer_greeting = WorldDatabaseManager.get_npc_trainer_greeting(creature_mgr.entry)
        greeting_to_use = trainer_greeting.content_default if trainer_greeting else placeholder_greeting
        greeting_bytes = PacketWriter.string_to_bytes(GameTextFormatter.format(player_mgr, greeting_to_use))
        greeting_bytes_packed = pack(f'<{len(greeting_bytes)}s', greeting_bytes)

        data_header = pack('<Q2I', creature_mgr.guid, TrainerTypes.TRAINER_TYPE_GENERAL, train_spell_count)
        data = data_header + train_spell_bytes + greeting_bytes_packed
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRAINER_LIST, data))

    @staticmethod
    def trainer_has_spell(creature_mgr, spell_id):
        if not creature_mgr.is_trainer():
            return False

        trainer_spells: list[TrainerTemplate] = \
            WorldDatabaseManager.TrainerSpellHolder.trainer_spells_get_by_trainer(creature_mgr.entry)

        for trainer_spell in trainer_spells:
            if trainer_spell.spell == spell_id:
                return True

        return False

    # TODO: Validate trainer_spell field and Pet trainers.
    @staticmethod
    def can_train(creature_mgr, player_mgr) -> bool:
        if not creature_mgr.is_trainer():
            return False

        if not creature_mgr.is_within_interactable_distance(player_mgr) and not player_mgr.is_gm:
            return False

        # If expecting a specific class, check if they match.
        if creature_mgr.creature_template.trainer_class > 0:
            return creature_mgr.creature_template.trainer_class == player_mgr.player.class_

        # Mount, TradeSkill or Pet trainer.
        return True
