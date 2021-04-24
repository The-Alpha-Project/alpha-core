from struct import pack
from typing import NamedTuple

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from database.world.WorldModels import QuestTemplate
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import QuestGiverStatus, QuestStatus, QuestFailedReasons, ObjectTypes
from utils.constants.UpdateFields import PlayerFields

MAX_QUEST_LOG = 20


class QuestManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.quests = {}

    def get_dialog_status(self, world_obj):
        dialog_status = QuestGiverStatus.QUEST_GIVER_NONE
        # Relations bounds, the quest giver; Involved relations bounds, the quest completer
        relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(world_obj.entry)
        involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(world_obj.entry)
        if self.player_mgr.is_enemy_to(world_obj):
            return dialog_status

        # TODO: Quest finish
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            quest_entry = involved_relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            # TODO: put in a check for quest status when you have quests that are already accepted by player

        # Quest start
        for relation in relations_list:
            new_dialog_status = QuestGiverStatus.QUEST_GIVER_NONE
            quest_entry = relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest or not self.check_quest_requirements(quest):
                continue
            
            if quest.Method == 0:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_REWARD
            elif quest.MinLevel > self.player_mgr.level >= quest.MinLevel - 4:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_FUTURE
            elif quest.MinLevel <= self.player_mgr.level < quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_QUEST
            elif self.player_mgr.level > quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_TRIVIAL

            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status

        return dialog_status

    def prepare_quest_giver_gossip_menu(self, quest_giver, guid):
        quest_menu = QuestMenu()
        # Type is unit, but not player
        if quest_giver.get_type() == ObjectTypes.TYPE_UNIT and quest_giver.get_type() != ObjectTypes.TYPE_PLAYER:
            relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(quest_giver.entry)
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
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest or not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            quest_menu.add_menu_item(quest, QuestStatus.QUEST_OFFER)

        if len(quest_menu.items) == 1:
            quest_menu_item = list(quest_menu.items.values())[0]
            if quest_menu_item.status == QuestStatus.QUEST_REWARD:
                # TODO: Handle completed quest
                return 0
            elif quest_menu_item.status == QuestStatus.QUEST_ACCEPTED:
                # TODO: Handle in progress quests
                return 0
            else:
                self.send_quest_giver_quest_details(quest_menu_item.quest, guid, True)
        else:
            # TODO: Send the proper greeting message
            self.send_quest_giver_quest_list("Greetings, $N.", guid, quest_menu.items)
        self.update_surrounding_quest_status()

    def check_quest_requirements(self, quest):
        # Is the player character the required race
        race_is_required = quest.RequiredRaces > 0
        if race_is_required and not (quest.RequiredRaces & self.player_mgr.race_mask):
            return False

        # Is the character the required class
        class_is_required = quest.RequiredClasses > 0
        if class_is_required and not (quest.RequiredClasses & self.player_mgr.class_mask):
            return False

        # Does the character have the required source item
        source_item_required = quest.SrcItemId > 0
        does_not_have_source_item = self.player_mgr.inventory.get_item_count(quest.SrcItemId) == 0
        if source_item_required and does_not_have_source_item:
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
    
    @staticmethod
    def check_quest_giver_npc_is_related(quest_giver_entry, quest_entry):
        is_related = False
        relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(quest_giver_entry)
        for relation in relations_list:
            if relation.entry == quest_giver_entry and relation.quest == quest_entry:
                is_related = True
        return is_related

    @staticmethod
    def generate_rew_choice_item_list(quest):
        return [quest.RewChoiceItemId1, quest.RewChoiceItemId2, quest.RewChoiceItemId3, quest.RewChoiceItemId4,
                quest.RewChoiceItemId5, quest.RewChoiceItemId6]

    @staticmethod
    def generate_rew_choice_count_list(quest):
        return [quest.RewChoiceItemCount1, quest.RewChoiceItemCount2, quest.RewChoiceItemCount3,
                quest.RewChoiceItemCount4, quest.RewChoiceItemCount5, quest.RewChoiceItemCount6]

    @staticmethod
    def generate_rew_item_list(quest):
        return [quest.RewItemId1, quest.RewItemId3, quest.RewItemId2, quest.RewItemId4]

    @staticmethod
    def generate_rew_count_list(quest):
        return [quest.RewItemCount1, quest.RewItemCount2, quest.RewItemCount3, quest.RewItemCount4]

    @staticmethod
    def generate_req_item_list(quest):
        return [quest.ReqItemId1, quest.ReqItemId2, quest.ReqItemId3, quest.ReqItemId4]

    @staticmethod
    def generate_req_count_list(quest):
        return [quest.ReqItemCount1, quest.ReqItemCount2, quest.ReqItemCount3, quest.ReqItemCount4]

    @staticmethod
    def generate_req_creature_or_go_list(quest):
        return [quest.ReqCreatureOrGOId1, quest.ReqCreatureOrGOId2, quest.ReqCreatureOrGOId3, quest.ReqCreatureOrGOId4]

    @staticmethod
    def generate_req_creature_or_go_count_list(quest):
        return [quest.ReqCreatureOrGOCount1, quest.ReqCreatureOrGOCount2, quest.ReqCreatureOrGOCount3, quest.ReqCreatureOrGOCount4]

    @staticmethod
    def generate_objective_text_list(quest):
        return [quest.ObjectiveText1, quest.ObjectiveText2, quest.ObjectiveText3, quest.ObjectiveText4]

    def update_surrounding_quest_status(self):
        for guid, unit in list(GridManager.get_surrounding_units(self.player_mgr).items()):
            if WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(unit.entry) or WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(unit.entry):
                quest_status = self.get_dialog_status(unit)
                self.send_quest_giver_status(guid, quest_status)

    def send_cant_take_quest_response(self, reason_code):
        data = pack('<I', reason_code)
        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_INVALID, data))

    def send_quest_giver_status(self, quest_giver_guid, quest_status):
        data = pack(
            '<QI',
            quest_giver_guid if quest_giver_guid > 0 else self.player_mgr.guid,
            quest_status
        )
        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))

    def send_quest_giver_quest_list(self, message, quest_giver_guid, quests):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            f'<Q{len(message_bytes)}s2iB',
            quest_giver_guid,
            message_bytes,
            0,  # TODO: Gossip menu count
            0,  # TODO: Gossip menu items
            len(quests)
        )

        for entry in quests:
            quest_title = PacketWriter.string_to_bytes(quests[entry].quest.Title)
            data += pack(
                f'<3I{len(quest_title)}s',
                entry,
                quests[entry].status,
                quests[entry].quest.QuestLevel,
                quest_title
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_LIST, data))

    def send_quest_giver_quest_details(self, quest, quest_giver_guid, activate_accept):
        # Send item query details and return item struct segments of SMSG_QUESTGIVER_QUEST_DETAILS
        def _gen_item_struct(item_entry, count, include_display_id=True):
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
            display_id = 0
            if item_template:
                item_mgr = ItemManager(item_template=item_template)
                self.player_mgr.session.enqueue_packet(item_mgr.query_details())
                display_id = item_template.display_id

            item_data = pack(
                '<2I',
                item_entry,
                count
            )
            if include_display_id:
                item_data += pack('<I', display_id)

            return item_data

        # Quest information
        quest_title = PacketWriter.string_to_bytes(quest.Title)
        quest_details = PacketWriter.string_to_bytes(quest.Details)
        quest_objectives = PacketWriter.string_to_bytes(quest.Objectives)
        data = pack(
            f'<QI{len(quest_title)}s{len(quest_details)}s{len(quest_objectives)}sI',
            quest_giver_guid,
            quest.entry,
            quest_title,
            quest_details,
            quest_objectives,
            1 if activate_accept else 0
        )

        # Reward choices
        rew_choice_item_list = list(filter((0).__ne__, self.generate_rew_choice_item_list(quest)))
        rew_choice_count_list = list(filter((0).__ne__, self.generate_rew_choice_count_list(quest)))
        data += pack('<I', len(rew_choice_item_list))
        for index, item in enumerate(rew_choice_item_list):
            data += _gen_item_struct(item, rew_choice_count_list[index])

        # Reward items
        rew_item_list = list(filter((0).__ne__, self.generate_rew_item_list(quest)))
        rew_count_list = list(filter((0).__ne__, self.generate_rew_count_list(quest)))
        data += pack('<I', len(rew_item_list))
        for index, item in enumerate(rew_item_list):
            data += _gen_item_struct(item, rew_count_list[index])

        # Reward money
        data += pack('<I', quest.RewOrReqMoney)

        # Required items
        req_item_list = list(filter((0).__ne__, self.generate_req_item_list(quest)))
        req_count_list = list(filter((0).__ne__, self.generate_req_count_list(quest)))
        data += pack('<I', len(req_item_list))
        for index, item in enumerate(req_item_list):
            data += _gen_item_struct(item, req_count_list[index], include_display_id=False)

        # Required kill / item count
        req_creature_or_go_list = list(filter((0).__ne__, self.generate_req_creature_or_go_list(quest)))
        req_creature_or_go_count_list = list(filter((0).__ne__, self.generate_req_creature_or_go_count_list(quest)))
        data += pack('<I', len(req_creature_or_go_list))
        for index, creature_or_go in enumerate(req_creature_or_go_list):
            data += pack(
                '<2I',
                creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
                req_creature_or_go_count_list[index]
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_DETAILS, data))

    def send_quest_query_response(self, quest_id):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)

        data = pack(
            f'<8I',
            quest_id,
            quest.Method,
            quest.QuestLevel,
            quest.ZoneOrSort,
            quest.Type,
            quest.NextQuestInChain,
            quest.RewOrReqMoney,
            quest.SrcItemId,
        )

        # Rew items
        rew_item_list = self.generate_rew_item_list(quest)
        rew_item_count_list = self.generate_rew_count_list(quest)
        for index, item in enumerate(rew_item_list):
            data += pack('<2I', item, rew_item_count_list[index])

        # Reward choices
        rew_choice_item_list = self.generate_rew_choice_item_list(quest)
        rew_choice_count_list = self.generate_rew_choice_count_list(quest)
        for index, item in enumerate(rew_choice_item_list):
            data += pack('<2I', item, rew_choice_count_list[index])

        title_bytes = PacketWriter.string_to_bytes(quest.Title)
        details_bytes = PacketWriter.string_to_bytes(quest.Details)
        objectives_bytes = PacketWriter.string_to_bytes(quest.Objectives)
        end_bytes = PacketWriter.string_to_bytes(quest.EndText)
        data += pack(
            f'<I2fI{len(title_bytes)}s{len(details_bytes)}s{len(objectives_bytes)}s{len(end_bytes)}s',
            quest.PointMapId,
            quest.PointX,
            quest.PointY,
            quest.PointOpt,
            title_bytes,
            details_bytes,
            objectives_bytes,
            end_bytes,
        )

        # Required kills / Required items count
        req_creature_or_go_list = self.generate_req_creature_or_go_list(quest)
        req_creature_or_go_count_list = self.generate_req_creature_or_go_count_list(quest)
        req_item_list = self.generate_req_item_list(quest)
        req_count_list = self.generate_req_count_list(quest)
        for index, creature_or_go in enumerate(req_creature_or_go_list):
            data += pack(
                '<4I',
                creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
                req_creature_or_go_count_list[index],
                req_item_list[index],
                req_count_list[index]
            )

        # Objective texts
        req_objective_text_list = self.generate_objective_text_list(quest)
        for index, objective_text in enumerate(req_objective_text_list):
            req_objective_text_bytes = PacketWriter.string_to_bytes(req_objective_text_list[index])
            data += pack(
                f'{len(req_objective_text_bytes)}s',
                req_objective_text_bytes
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUEST_QUERY_RESPONSE, data))

    def add_quest(self, quest_id, quest_giver_guid):
        self.quests[quest_id] = True  # TODO: Use a real quest status
        self.send_quest_query_response(quest_id)
        data = pack('QI', quest_giver_guid, 0)  # TODO: figure out this quest giver status
        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))

        self.build_update()
        self.player_mgr.set_dirty()

    def build_update(self):
        for index, quest_id in enumerate(self.quests.keys()):
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6), quest_id)
            # TODO Finish / investigate below values
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6) + 1, 0)  # quest giver ID ?
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6) + 2, 0)  # quest rewarder ID ?
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6) + 3, 0)  # quest progress
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6) + 4, 0)  # quest failure time
            self.player_mgr.set_uint64(PlayerFields.PLAYER_QUEST_LOG_1_1 + (index * 6) + 5, 0)  # number of mobs to kill


class QuestMenu:
    class QuestMenuItem(NamedTuple):
        quest: QuestTemplate
        status: QuestStatus

    def __init__(self):
        self.items = {}

    def add_menu_item(self, quest, status):
        self.items[quest.entry] = QuestMenu.QuestMenuItem(quest, status)

    def clear_menu(self):
        self.items.clear()
