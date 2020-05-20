# TODO: Dynat: Move your shit into here
from struct import pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import QuestGiverStatuses


class QuestManager(object):
    def __init__(self, owner):
        self.owner = owner

    
    def get_dialog_status(self, world_obj, defstatus):
        dialog_status = defstatus
        rbounds = WorldDatabaseManager.creature_quest_get_by_entry(world_obj.entry)               #   realtions bounds, the quest giver
        irbounds = WorldDatabaseManager.creature_involved_quest_get_by_entry(world_obj.entry)     #   involved relations bounds, the quest completer

        # Quest finish, Loop through all the completion quests offered by this quest giver
        #   TODO: Dynat: This loop
        for irbound in irbounds:
            if len(irbound) == 0: continue
            quest_entry = irbound[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)
            # TODO: Dynat: put in a check for quest status when you have quests accepted by player

        # Quest start, Loop through all the acceptable quests offered by this quest giver
        for rbound in rbounds:
            new_dialog_status = QuestGiverStatuses.QUEST_GIVER_NONE
            quest_entry = rbound[1]
            quest = WorldDatabaseManager.quest_get_by_entry(quest_entry)

            # TODO: Dynat: put in a check for quest status when you have quests accepted by player
            if (quest.Method == 0):
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_REWARD
            elif (self.owner.level < quest.MinLevel & self.owner.level >= quest.MinLevel - 4):
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_FUTURE                   # Silver !
            elif (self.owner.level >= quest.MinLevel & self.owner.level < quest.QuestLevel + 7):
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_QUEST                    # Yellow !
            elif (self.owner.level > quest.QuestLevel + 7):
                new_dialog_status = QuestGiverStatuses.QUEST_GIVER_TRIVIAL                  # ez quest

            print("Classes: %s"%(quest.RequiredClasses))

            #   Update the status if it appears to be a "higher" code then any of the previous
            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status

        # return the status 
        return dialog_status



    # def get_quest_status(self, quest_entry):
    #     pass

    def send_quest_status(self, questgiver_guid, quest_status):
        data = pack(
            '<QQ',
            questgiver_guid if questgiver_guid > 0 else self.owner.guid,
            quest_status
        )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))