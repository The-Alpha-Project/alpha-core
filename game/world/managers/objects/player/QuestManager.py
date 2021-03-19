from struct import pack
from typing import NamedTuple

from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import QuestTemplate
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import QuestGiverStatuses, QuestStatuses, QuestFailedReasons, ObjectTypes

MAX_QUEST_LOG = 20


class QuestManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.quests = {}

    def get_dialog_status(self, world_obj):
        dialog_status = QuestGiverStatuses.QUEST_GIVER_NONE
        # Relations bounds, the quest giver. involved relations bounds, the quest completer
        relations_list = WorldDatabaseManager.creature_quest_get_by_entry(world_obj.entry)
        involved_relations_list = WorldDatabaseManager.creature_involved_quest_get_by_entry(world_obj.entry)
        if self.player_mgr.is_enemy_to(world_obj):
            return dialog_status

        # TODO: Quest finish
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            quest_entry = involved_relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            # TODO: put in a check for quest status when you have quests that are already accepted by player

        # Quest start
        for relation in relations_list:
            new_dialog_status = QuestGiverStatuses.QUEST_GIVER_NONE
            quest_entry = relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not self.check_quest_requirements(quest):
                continue
            
            if quest.Method == 0:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_REWARD
            elif quest.MinLevel > self.player_mgr.level >= quest.MinLevel - 4:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_FUTURE
            elif quest.MinLevel <= self.player_mgr.level < quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_QUEST
            elif self.player_mgr.level > quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_TRIVIAL

            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status

        return dialog_status

    def prepare_quest_giver_gossip_menu(self, quest_giver, guid):
        quest_menu = QuestMenu()
        # Type is unit, but not player
        if quest_giver.get_type() == ObjectTypes.TYPE_UNIT and quest_giver.get_type() != ObjectTypes.TYPE_PLAYER:
            relations_list = WorldDatabaseManager.creature_quest_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.creature_involved_quest_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            # TODO: Gameobjects
            relations_list = []
            involved_relations_list = []
        else:
            return

        # TODO: Finish quests
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            continue

        # Starting quests
        for relation in relations_list:
            if len(relation) == 0:
                continue
            quest_entry = relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            quest_menu.add_menu_item(quest, QuestStatuses.QUEST_STATUS_AVAILABLE)

        if len(quest_menu.items) == 1:
            # TODO: handle a single quest situation, open the quest directly
            quest = list(quest_menu.items.values())[0]
            self.send_quest_giver_quest_list("Greetings, $N.", guid, quest_menu.items)
        else:
            # TODO: Send the proper greeting message
            self.send_quest_giver_quest_list("Greetings, $N.", guid, quest_menu.items)
        # TODO: Update surroundings

    def check_quest_requirements(self, quest):
        # Is the player character the required race
        race_is_required = quest.RequiredRaces > 0
        is_not_required_race = quest.RequiredRaces & self.player_mgr.player.race != self.player_mgr.player.race
        if race_is_required and is_not_required_race:
            return False

        # Does the character have the required source item
        source_item_required = quest.SrcItemId > 0
        does_not_have_source_item = self.player_mgr.inventory.get_item_count(quest.SrcItemId) == 0
        if source_item_required and does_not_have_source_item:
            return False

        # Is the character the required class
        class_is_required = quest.RequiredClasses > 0
        is_not_required_class = quest.RequiredClasses & self.player_mgr.player.class_ != self.player_mgr.player.class_
        if class_is_required and is_not_required_class:
            return False

        # Has the character already started the next quest in the chain
        if quest.NextQuestInChain > 0 and quest.NextQuestInChain in self.quests:
            return False

        # Does the character have the previous quest
        if quest.PrevQuestId > 0 and quest.PrevQuestId not in self.quests:
            return False

        # TODO: Does the character have the required skill
        
        return True

    def check_quest_level(self, quest, will_send_response):
        if self.player_mgr.level < quest.MinLevel:
            if will_send_response:
                self.send_cant_take_quest_response(QuestFailedReasons.INVALIDREASON_QUEST_FAILED_LOW_LEVEL)
            return False
        else:
            return True

    def send_cant_take_quest_response(self, reason_code):
        data = pack('<I', reason_code)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_INVALID, data))

    def send_quest_giver_status(self, quest_giver_guid, quest_status):
        data = pack(
            '<QI',
            quest_giver_guid if quest_giver_guid > 0 else self.player_mgr.guid,
            quest_status
        )
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))

    def send_quest_giver_quest_list(self, message, quest_giver_guid, quests):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            '<Q%us2iB' % len(message_bytes),
            quest_giver_guid,
            message_bytes,
            0,  # TODO: Gossip menu count
            0,  # TODO: Gossip menu items
            len(quests)
        )

        for entry in quests:
            quest_title = PacketWriter.string_to_bytes(quests[entry].quest.Title)
            data += pack(
                '<3I%us' % len(quest_title),
                entry,
                quests[entry].status,
                quests[entry].quest.QuestLevel,
                quest_title
            )

        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_LIST, data))


class QuestMenu:
    class QuestMenuItem(NamedTuple):
        quest: QuestTemplate
        status: QuestStatuses

    def __init__(self):
        self.items = {}

    def add_menu_item(self, quest, status):
        self.items[quest.entry] = QuestMenu.QuestMenuItem(quest, status)

    def clear_menu(self):
        self.items.clear()
