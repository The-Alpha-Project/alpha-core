from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from struct import unpack

from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Formulas import Distances


class TrainerListHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling an empty trainer list packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0

        guid = unpack('<Q', reader.data[:8])[0]

        # Player talents.
        if guid == player_mgr.guid:
            player_mgr.talent_manager.send_talent_list()
            return 0

        trainer: CreatureManager = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, guid)
        if not trainer:
            return 0
        if not Distances.is_within_shop_distance(player_mgr, trainer):
            return 0

        if trainer.is_unit():
            trainer.object_ai.player_interacted()

        available_quests: int = 0
        # Check if any quest is available.
        if trainer.is_quest_giver():
            available_quests = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(trainer)

        # If player does not meet requirements to talk to this Trainer, just send the quest giver greeting.
        # Ineligible quests won't show up here, so this matches the behavior of classic WoW.
        if not TrainerUtils.can_train(trainer, player_mgr) or available_quests > 0:
            player_mgr.quest_manager.handle_quest_giver_hello(trainer, guid)
            return 0

        if not TrainerUtils.send_trainer_list(trainer, player_mgr):
            player_mgr.quest_manager.handle_quest_giver_hello(trainer, guid)

        return 0
