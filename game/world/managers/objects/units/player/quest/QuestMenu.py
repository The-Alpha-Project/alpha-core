from typing import NamedTuple
from database.world.WorldModels import QuestTemplate
from utils.constants.MiscCodes import QuestGiverStatus, QuestState


class QuestMenu:
    class QuestMenuItem(NamedTuple):
        quest: QuestTemplate
        quest_giver_state: QuestGiverStatus
        quest_state: QuestState

    def __init__(self):
        self.items = {}

    def add_menu_item(self, quest, quest_giver_status, quest_state):
        self.items[quest.entry] = QuestMenu.QuestMenuItem(
            quest=quest,
            quest_giver_state=quest_giver_status,
            quest_state=quest_state
        )

    def clear_menu(self):
        self.items.clear()
