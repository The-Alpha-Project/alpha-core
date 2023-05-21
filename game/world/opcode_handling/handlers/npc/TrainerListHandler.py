from game.world.managers.objects.units.creature.CreatureManager import CreatureManager
from game.world.managers.maps.MapManager import MapManager
from struct import unpack

from game.world.managers.objects.units.creature.utils.TrainerUtils import TrainerUtils
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class TrainerListHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 8:  # Avoid handling empty trainer list packet.
            guid = unpack('<Q', reader.data[:8])[0]

            # Player talents.
            if guid == player_mgr.guid:
                player_mgr.talent_manager.send_talent_list()
                return 0
            # NPC offering.
            else:
                trainer: CreatureManager = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)

            if trainer and trainer.is_within_interactable_distance(player_mgr):
                available_quests: int = 0
                # Check if any quest is available.
                if trainer.is_quest_giver():
                    available_quests = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(trainer)

                # If player does not meet requirements to talk to this Trainer, just send the quest giver greeting.
                # Ineligible quests won't show up here, so this matches the behavior of classic WoW.
                if not TrainerUtils.can_train(trainer, player_mgr) or available_quests > 0:
                    player_mgr.quest_manager.handle_quest_giver_hello(trainer, guid)
                elif TrainerUtils.can_train(trainer, player_mgr):
                    TrainerUtils.send_trainer_list(trainer, player_mgr)

        return 0
