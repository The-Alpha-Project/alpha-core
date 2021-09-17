from typing import NamedTuple
from database.world.WorldModels import QuestTemplate
from utils.constants.MiscCodes import QuestState


class QuestMenu:
    class QuestMenuItem(NamedTuple):
        quest: QuestTemplate
        state: QuestState

    def __init__(self):
        self.items = {}

    def add_menu_item(self, quest, state):
        self.items[quest.entry] = QuestMenu.QuestMenuItem(quest=quest, state=state)

    def clear_menu(self):
        self.items.clear()
