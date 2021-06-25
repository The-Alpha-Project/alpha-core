from database.world.WorldModels import CreatureTemplate
from game.world.managers.objects.creature.CreatureManager import CreatureManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from struct import unpack

class TrainerListHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty trainer list packet.
            guid = unpack('<Q', reader.data[:8])[0]

            # Player talents
            if guid == world_session.player_mgr.guid:
                world_session.player_mgr.talent_manager.send_talent_list()
            # NPC offering
            else:
                creature: CreatureManager = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
                creature_template: CreatureTemplate = WorldDatabaseManager.creature_get_by_entry(creature.entry)

                if creature and creature.is_within_interactable_distance(world_session.player_mgr):
                    if creature.is_trainer() and creature.is_questgiver():
                        if creature_template and creature_template.trainer_class == world_session.player_mgr.player.class_:
                            quests: int = world_session.player_mgr.quest_manager.get_active_quest_num_from_questgiver(creature)
                            if quests > 0:
                                from game.world.opcode_handling.handlers.quest.QuestGiverHelloHandler import QuestGiverHelloHandler
                                QuestGiverHelloHandler.handle(world_session, socket, reader)
                            else:
                                creature.send_trainer_list(world_session)
                        else:
                            from game.world.opcode_handling.handlers.quest.QuestGiverHelloHandler import QuestGiverHelloHandler
                            QuestGiverHelloHandler.handle(world_session, socket, reader)
                    elif creature.is_trainer() and not creature.is_questgiver():
                        if creature_template and creature_template.trainer_class == world_session.player_mgr.player.class_:
                            creature.send_trainer_list(world_session)
                        else:
                            return 0
        return 0