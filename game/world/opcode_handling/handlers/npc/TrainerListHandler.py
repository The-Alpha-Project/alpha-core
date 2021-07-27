from game.world.managers.objects.creature.CreatureManager import CreatureManager
from game.world.managers.maps.MapManager import MapManager
from struct import unpack


class TrainerListHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty trainer list packet.
            guid = unpack('<Q', reader.data[:8])[0]
            player_mgr = world_session.player_mgr

            # Player talents.
            if guid == player_mgr.guid:
                player_mgr.talent_manager.send_talent_list()
                return 0
            # NPC offering.
            else:
                trainer: CreatureManager = MapManager.get_surrounding_unit_by_guid(player_mgr, guid)

            if trainer and trainer.is_within_interactable_distance(world_session.player_mgr):
                available_quests: int = 0
                # Check if any quest is available.
                if trainer.is_quest_giver():
                    available_quests = player_mgr.quest_manager.get_active_quest_num_from_quest_giver(trainer)

                # If player does not meet requirements to talk to this Trainer, just send the quest giver greeting.
                # Ineligible quests won't show up here, so this matches the behavior of classic WoW.
                if not trainer.can_train(player_mgr):
                    player_mgr.quest_manager.handle_quest_giver_hello(trainer, guid)
                # Give quests priority over trainer list.
                elif available_quests > 0:
                    player_mgr.quest_manager.handle_quest_giver_hello(trainer, guid)
                else:
                    trainer.send_trainer_list(world_session)

        return 0
