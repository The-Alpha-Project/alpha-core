from struct import unpack
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator


class QuestQueryHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        if len(reader.data) >= 4:  # Avoid handling empty quest query packet.
            quest_id = unpack('<I', reader.data[:4])[0]
            quest_template = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
            if not quest_template:
                return 0

            player_mgr.quest_manager.send_quest_query_response(quest_template)

        return 0
