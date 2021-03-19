from struct import pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import QuestGiverStatuses, QuestStatuses, QuestFailedReasons, ObjectTypes

MAX_QUEST_LOG = 20

class QuestManager(object):
    def __init__(self, owner):
        self.owner = owner
        self.quests = {}

    def get_dialog_status(self, world_obj):
        dialog_status = QuestGiverStatuses.QUEST_GIVER_NONE
        #   relations bounds, the quest giver. involved relations bounds, the quest completer
        relations_list = WorldDatabaseManager.creature_quest_get_by_entry(world_obj.entry)
        involved_relations_list = WorldDatabaseManager.creature_involved_quest_get_by_entry(world_obj.entry)
        if self.owner.is_enemy_to(world_obj): return dialog_status

        #   TODO: Quest finish
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0: continue
            quest_entry = involved_relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            # TODO: put in a check for quest status when you have quests that are already accepted by player

        # Quest start
        for relation in relations_list:
            new_dialog_status = QuestGiverStatuses.QUEST_GIVER_NONE
            quest_entry = relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not self.check_quest_requirements(quest): continue
            
            if (quest.Method == 0):
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_REWARD
            elif self.owner.level < quest.MinLevel and self.owner.level >= quest.MinLevel - 4:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_FUTURE
            elif self.owner.level >= quest.MinLevel and self.owner.level < quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_QUEST
            elif self.owner.level > quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_TRIVIAL

            #   Update the status if it appears to be a "higher" code then any of the previous
            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status
        return dialog_status

    def prepare_quest_giver_gossip_menu(self, quest_giver, guid):
        quest_menu = QuestMenu()

        #   Type unit, but not type player
        if ObjectTypes.TYPE_UNIT in quest_giver.object_type and not ObjectTypes.TYPE_PLAYER in quest_giver.object_type:
            relations_list = WorldDatabaseManager.creature_quest_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.creature_involved_quest_get_by_entry(quest_giver.entry)
        elif ObjectTypes.TYPE_GAMEOBJECT in quest_giver.object_type:
            #   TODO: Gameobjects
            pass

        #   TODO: Finish quests
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0: continue
            continue

        #   Starting quests
        for relation in relations_list:
            if len(relation) == 0: continue
            quest_entry = relation[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            if not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False): continue
            quest_menu.add_menu_item(quest, QuestStatuses.QUEST_STATUS_AVAILABLE)

        if len(quest_menu.items) == 1:
            # TODO: handle a single quest situation, open the quest directly
            quest = list(quest_menu.items.values())[0]
            self.send_quest_giver_quest_list("Greetings, $N", guid, quest_menu.items)

        else:
            # TODO: Send the quest list, Send the proper greeting message
            self.send_quest_giver_quest_list("Greetings, $N", guid, quest_menu.items)
        # TODO: Update surroundings

    def check_quest_requirements(self, quest):
        # Is the player character the required race
        race_is_required = quest.RequiredRaces > 0
        is_not_required_race = quest.RequiredRaces & self.owner.player.race != self.owner.player.race
        if race_is_required and is_not_required_race:
            return False
        #   Does the character have the required source item
        source_item_required = quest.SrcItemId > 0
        does_not_have_source_item = self.owner.inventory.get_item_count(quest.SrcItemId) == 0
        if source_item_required and does_not_have_source_item:
            return False
        #   Is the character the required class
        class_is_required = quest.RequiredClasses > 0
        is_not_required_class = quest.RequiredClasses & self.owner.player.class_ != self.owner.player.class_
        if class_is_required and is_not_required_class:
            return False
        #  Has the character already started the next quest in the chain
        if quest.NextQuestInChain > 0 and quest.NextQuestInChain in self.quests:
            return False
        #  Does the character have the previous quest
        if quest.PrevQuestId > 0 and not quest.PrevQuestId in self.quests:
            return False
        #   TODO: Does the character have the required skill
        
        return True

    def check_quest_level(self, quest, will_send_response):
        if self.owner.level < quest.MinLevel:
            if will_send_response:
                self.send_cant_take_quest_response(QuestFailedReasons.INVALIDREASON_QUEST_FAILED_LOW_LEVEL)
            return False
        else:
            return True

    def send_cant_take_quest_response(self, reason_code):
        data = [ '<I', reason_code ]
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_INVALID, data))


    def send_quest_status(self, quest_giver_guid, quest_status):
        data = pack(
            '<2Q',
            quest_giver_guid if quest_giver_guid > 0 else self.owner.guid,
            quest_status
        )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))

    def send_quest_giver_quest_list(self, message, quest_giver_guid, quests):
        message = bytes(message, 'utf-8')
        packet_format = '<Q%ss2iB' %(len(message) + 1)
        packet_values = [
            quest_giver_guid,
            message,
            0,                          #   TODO: Gossip menu count
            0,                          #   TODO: Gossip menu items
            len(quests)
        ]

        for entry in quests:
            packet_values.append(entry)
            status = quests[entry]["status"]
            packet_values.append(status)
            packet_values.append(quests[entry]["quest"].QuestLevel)
            quest_title = bytes(quests[entry]["quest"].Title, 'utf-8')
            packet_values.append(quest_title)
            title_format = "%ss" %(len(quest_title) + 1)
            quest_format = '3I' + title_format
            packet_format += quest_format

        data = pack(packet_format, *packet_values)
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_LIST, data))



class QuestMenu:
    def __init__(self):
        self.items = {}

    # @staticmethod
    def add_menu_item(self, quest, status):
        self.items[quest.entry] = {
            "status": status,
            "quest": quest
        }

    @staticmethod
    def clear_menu(self):
        self.items = {}