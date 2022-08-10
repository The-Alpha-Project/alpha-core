from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager

class QuestQueryHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        player_mgr = world_session.player_mgr
        if len(reader.data) >= 4:  # Avoid handling empty quest query packet.
            quest_id = unpack('<I', reader.data[:4])[0]
            quest_template = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
            if not quest_template:
                return 0

            player_mgr.quest_manager.send_quest_query_response(quest_template)

        return 0
