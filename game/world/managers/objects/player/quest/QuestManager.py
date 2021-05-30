from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterQuestState
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.player.quest.ActiveQuest import ActiveQuest
from game.world.managers.objects.player.quest.QuestHelpers import QuestHelpers
from game.world.managers.objects.player.quest.QuestMenu import QuestMenu
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.MiscCodes import QuestGiverStatus, QuestState, QuestFailedReasons, ObjectTypes, QuestMethod
from utils.constants.UpdateFields import PlayerFields

# Terminology:
# - quest_template or plain quest refers to the quest template (the db record / read only)
# - active_quest refers to quests in the player's quest log

MAX_QUEST_LOG = 16
QUEST_OBJECTIVES_COUNT = 4


class QuestManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.active_quests = {}
        self.completed_quests = set()

    def load_quests(self):
        quest_db_states = RealmDatabaseManager.character_get_quests(self.player_mgr.guid)
        for quest_db_state in quest_db_states:
            if quest_db_state.rewarded > 0:
                self.completed_quests.add(quest_db_state.quest)
            elif quest_db_state.state == QuestState.QUEST_ACCEPTED or quest_db_state.state == QuestState.QUEST_REWARD:
                active_quest = ActiveQuest(quest_db_state, self.player_mgr)
                self.active_quests[quest_db_state.quest] = active_quest
                # Needed in case the WDB has been deleted, otherwise non cached quests won't appear in the log.
                self.send_quest_query_response(active_quest)
            else:
                Logger.error(
                    f"Quest database (guid={quest_db_state.guid}, quest_id={quest_db_state.quest}) has state {quest_db_state.state}. No handling.")

    def get_dialog_status(self, world_object):
        dialog_status = QuestGiverStatus.QUEST_GIVER_NONE
        new_dialog_status = QuestGiverStatus.QUEST_GIVER_NONE

        if self.player_mgr.is_enemy_to(world_object):
            return dialog_status

        # Relations bounds, the quest giver; Involved relations bounds, the quest completer
        relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(world_object.entry)
        involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(world_object.entry)

        # Quest finish
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            quest_entry = involved_relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            if quest_entry not in self.active_quests:
                continue
            quest_state = self.active_quests[quest_entry].get_quest_state()
            if quest_state == QuestState.QUEST_REWARD:
                return QuestState.QUEST_REWARD

        # Quest start
        for relation in relations_list:
            quest_entry = relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest or not self.check_quest_requirements(quest):
                continue
            if quest_entry in self.active_quests:
                continue
            if quest_entry in self.completed_quests:
                continue
            if quest.Method == QuestMethod.QUEST_DISABLED:
                continue
            if quest.Method == QuestMethod.QUEST_AUTOCOMPLETE:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_REWARD  # Make the NPC shows quest already complete.
            elif quest.MinLevel > self.player_mgr.level >= quest.MinLevel - 4:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_FUTURE  # Gray '!', you are close to having a quest.
            elif quest.MinLevel <= self.player_mgr.level < quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_QUEST  # Yellow '!', available quest.
            elif self.player_mgr.level > quest.QuestLevel + 7:
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_TRIVIAL  # Not shown unless interacting.
            # TODO, Why all iterations and only returning 1 status? Could there be multiple? Should we break at first?
            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status

        return dialog_status

    def handle_quest_giver_hello(self, quest_giver, quest_giver_guid):
        quest_menu = QuestMenu()
        # Type is unit, but not player
        if quest_giver.get_type() == ObjectTypes.TYPE_UNIT and quest_giver.get_type() != ObjectTypes.TYPE_PLAYER:
            relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(
                quest_giver.entry)
        elif quest_giver.get_type() == ObjectTypes.TYPE_GAMEOBJECT:
            # TODO: Gameobjects
            relations_list = []
            involved_relations_list = []
        else:
            return

        # Quest finish
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            quest_entry = involved_relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest or not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            if quest_entry not in self.active_quests:
                continue
            quest_state = self.active_quests[quest_entry].get_quest_state()
            if quest_state < QuestState.QUEST_ACCEPTED:
                continue  # Quest accept is handled by relation_list
            quest_menu.add_menu_item(quest, quest_state)

        # Quest start
        for relation in relations_list:
            if len(relation) == 0:
                continue
            quest_entry = relation[1]
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest or not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            if quest_entry in self.completed_quests:
                continue
            quest_state = QuestState.QUEST_OFFER
            if quest_entry in self.active_quests:
                quest_state = self.active_quests[quest_entry].get_quest_state()
            if quest_state >= QuestState.QUEST_ACCEPTED:
                continue  # Quest turn-in is handled by involved_relations_list
            quest_menu.add_menu_item(quest, quest_state)

        if len(quest_menu.items) == 1:
            quest_menu_item = list(quest_menu.items.values())[0]
            if quest_menu_item.state == QuestState.QUEST_REWARD:
                self.send_quest_giver_offer_reward(self.active_quests[quest_menu_item.quest.entry], quest_giver_guid, True)
                return 0
            elif quest_menu_item.state == QuestState.QUEST_ACCEPTED:
                # TODO: Handle in progress quests
                return 0
            else:
                self.send_quest_giver_quest_details(quest_menu_item.quest, quest_giver_guid, True)
        else:
            # TODO: Send the proper greeting message
            self.send_quest_giver_quest_list("Greetings, $N.", quest_giver_guid, quest_menu.items)

        self.update_surrounding_quest_status()

    def check_quest_requirements(self, quest_template):
        # Is the player character the required race
        race_is_required = quest_template.RequiredRaces > 0
        if race_is_required and not (quest_template.RequiredRaces & self.player_mgr.race_mask):
            return False

        # Is the character the required class
        class_is_required = quest_template.RequiredClasses > 0
        if class_is_required and not (quest_template.RequiredClasses & self.player_mgr.class_mask):
            return False

        # Does the character have the required source item
        source_item_required = quest_template.SrcItemId > 0
        does_not_have_source_item = self.player_mgr.inventory.get_item_count(quest_template.SrcItemId) == 0
        if source_item_required and does_not_have_source_item:
            return False

        # Has the character already started the next quest in the chain
        if quest_template.NextQuestInChain > 0 and quest_template.NextQuestInChain in self.completed_quests:
            return False

        # Does the character have the previous quest
        if quest_template.PrevQuestId > 0 and quest_template.PrevQuestId not in self.completed_quests:
            return False

        # TODO: Does the character have the required skill

        return True

    def check_quest_level(self, quest_template, will_send_response):
        if self.player_mgr.level < quest_template.MinLevel:
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

    def update_surrounding_quest_status(self):
        for guid, unit in list(MapManager.get_surrounding_units(self.player_mgr).items()):
            if WorldDatabaseManager.QuestRelationHolder.creature_involved_quest_get_by_entry(
                    unit.entry) or WorldDatabaseManager.QuestRelationHolder.creature_quest_get_by_entry(unit.entry):
                quest_status = self.get_dialog_status(unit)
                self.send_quest_giver_status(guid, quest_status)

    # Send item query details and return item struct byte segments.
    def _gen_item_struct(self, item_entry, count):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        display_id = 0
        if item_template:
            item_mgr = ItemManager(item_template=item_template)
            self.player_mgr.session.enqueue_packet(item_mgr.query_details())
            display_id = item_template.display_id

        item_data = pack(
            '<3I',
            item_entry,
            count,
            display_id
        )

        return item_data

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

    def send_quest_giver_quest_list(self, message, quest_giver_guid, quest):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            f'<Q{len(message_bytes)}s2iB',
            quest_giver_guid,
            message_bytes,
            0,  # TODO: delay
            0,  # TODO: emoteID
            len(quest)
        )

        for entry in quest:
            quest_title = PacketWriter.string_to_bytes(quest[entry].quest.Title)
            data += pack(
                f'<3I{len(quest_title)}s',
                entry,
                quest[entry].state,
                quest[entry].quest.QuestLevel,
                quest_title
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_LIST, data))

    def send_quest_giver_quest_details(self, quest_template, quest_giver_guid, activate_accept):
        # Quest information
        quest_title = PacketWriter.string_to_bytes(quest_template.Title)
        quest_details = PacketWriter.string_to_bytes(quest_template.Details)
        quest_objectives = PacketWriter.string_to_bytes(quest_template.Objectives)
        data = pack(
            f'<QI{len(quest_title)}s{len(quest_details)}s{len(quest_objectives)}sI',
            quest_giver_guid,
            quest_template.entry,
            quest_title,
            quest_details,
            quest_objectives,
            1 if activate_accept else 0
        )

        # Reward choices
        rew_choice_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_item_list(quest_template)))
        rew_choice_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_count_list(quest_template)))
        data += pack('<I', len(rew_choice_item_list))
        for index, item in enumerate(rew_choice_item_list):
            data += self._gen_item_struct(item, rew_choice_count_list[index])

        # Reward items
        rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(quest_template)))
        rew_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(quest_template)))
        data += pack('<I', len(rew_item_list))
        for index, item in enumerate(rew_item_list):
            data += self._gen_item_struct(item, rew_count_list[index])

        # Reward money
        data += pack('<I', quest_template.RewOrReqMoney)

        # Required items
        req_item_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(quest_template)))
        req_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(quest_template)))
        data += pack('<I', len(req_item_list))
        for index, item in enumerate(req_item_list):
            data += self._gen_item_struct(item, req_count_list[index])

        # Required kill / go count
        req_creature_or_go_list = list(filter((0).__ne__, QuestHelpers.generate_req_creature_or_go_list(quest_template)))
        req_creature_or_go_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_creature_or_go_count_list(quest_template)))
        data += pack('<I', len(req_creature_or_go_list))
        for index, creature_or_go in enumerate(req_creature_or_go_list):
            data += pack(
                '<2I',
                creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
                req_creature_or_go_count_list[index]
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_DETAILS, data))

    def send_quest_query_response(self, active_quest):
        data = pack(
            f'<3Ii4I',
            active_quest.quest.entry,
            active_quest.quest.Method,
            active_quest.quest.QuestLevel,
            active_quest.quest.ZoneOrSort,
            active_quest.quest.Type,
            active_quest.quest.NextQuestInChain,
            active_quest.quest.RewOrReqMoney,
            active_quest.quest.SrcItemId
        )

        # Rewards given no matter what
        rew_item_list = QuestHelpers.generate_rew_item_list(active_quest.quest)
        rew_item_count_list = QuestHelpers.generate_rew_count_list(active_quest.quest)
        for index, item in enumerate(rew_item_list):
            data += pack('<2I', item, rew_item_count_list[index])

        # Reward choices
        rew_choice_item_list = QuestHelpers.generate_rew_choice_item_list(active_quest.quest)
        rew_choice_count_list = QuestHelpers.generate_rew_choice_count_list(active_quest.quest)
        for index, item in enumerate(rew_choice_item_list):
            data += pack('<2I', item, rew_choice_count_list[index])

        title_bytes = PacketWriter.string_to_bytes(active_quest.quest.Title)
        details_bytes = PacketWriter.string_to_bytes(active_quest.quest.Details)
        objectives_bytes = PacketWriter.string_to_bytes(active_quest.quest.Objectives)
        end_bytes = PacketWriter.string_to_bytes(active_quest.quest.EndText)
        data += pack(
            f'<I2fI{len(title_bytes)}s{len(details_bytes)}s{len(objectives_bytes)}s{len(end_bytes)}s',
            active_quest.quest.PointMapId,
            active_quest.quest.PointX,
            active_quest.quest.PointY,
            active_quest.quest.PointOpt,
            title_bytes,
            details_bytes,
            objectives_bytes,
            end_bytes,
        )

        # Required kills / Required items count
        req_creatures_or_gos = QuestHelpers.generate_req_creature_or_go_list(active_quest.quest)
        req_creatures_or_gos_count_list = QuestHelpers.generate_req_creature_or_go_count_list(active_quest.quest)
        req_items = QuestHelpers.generate_req_item_list(active_quest.quest)
        req_items_count_list = QuestHelpers.generate_req_item_count_list(active_quest.quest)
        for index, creature_or_go in enumerate(req_creatures_or_gos):
            data += pack(
                '<4IB',
                creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
                req_creatures_or_gos_count_list[index],
                req_items[index],
                req_items_count_list[index],
                0x0  # Unknown, if missing, multiple objective quests will not display properly.
            )

        # Objective texts
        req_objective_text_list = QuestHelpers.generate_objective_text_list(active_quest.quest)
        for index, objective_text in enumerate(req_objective_text_list):
            req_objective_text_bytes = PacketWriter.string_to_bytes(req_objective_text_list[index])
            data += pack(
                f'{len(req_objective_text_bytes)}s',
                req_objective_text_bytes
            )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUEST_QUERY_RESPONSE, data))

    def send_quest_giver_request_items(self, active_quest, quest_giver_id, close_on_cancel):
        is_complete = active_quest.is_quest_complete(quest_giver_id)
        quest_title_bytes = PacketWriter.string_to_bytes(active_quest.quest.Title)
        quest = active_quest.quest

        if quest.RequestItemsText:
            dialog_text_bytes = PacketWriter.string_to_bytes(quest.RequestItemsText)
        else:
            dialog_text_bytes = PacketWriter.string_to_bytes(quest.Objectives)

        data = pack(
            f'<QI{len(quest_title_bytes)}s{len(dialog_text_bytes)}s4I',
            quest_giver_id,
            quest.entry,
            quest_title_bytes,
            dialog_text_bytes,
            0,  # Emote delay
            0,  # Emote id
            1 if close_on_cancel else 0,  # Close Window after cancel
            quest.RewOrReqMoney if quest.RewOrReqMoney >= 0 else -quest.RewOrReqMoney
        )

        req_items = QuestHelpers.generate_req_item_list(quest)
        req_items_count_list = QuestHelpers.generate_req_item_count_list(quest)
        data += pack('<I', len(req_items))
        for index in range(0, 4):
            if req_items[index] == 0:
                continue
            data += self._gen_item_struct(req_items[index], req_items_count_list[index])

        data += pack(
            '<4I',
            0x02,
            0x03 if is_complete else 0x00,  # Completable = flags1 && flags2 && flags3 && flags4
            0x04,  # flags2
            0x08  # flags3
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_REQUEST_ITEMS, data)
        self.player_mgr.session.enqueue_packet(packet)

    def send_quest_giver_offer_reward(self, active_quest, quest_giver_guid, enable_next=True):
        # CGPlayer_C::OnQuestGiverChooseReward
        quest = active_quest.quest
        quest_title_bytes = PacketWriter.string_to_bytes(quest.Title)
        display_dialog_text = quest.OfferRewardText

        dialog_text_bytes = PacketWriter.string_to_bytes(display_dialog_text)
        data = pack(
            f'<QI{len(quest_title_bytes)}s{len(dialog_text_bytes)}sI',
            quest_giver_guid,
            active_quest.quest.entry,
            quest_title_bytes,
            dialog_text_bytes,
            1 if enable_next else 0  # enable_next
        )

        # Emote count, always 4.
        data += pack('<I', 4)
        for i in range(1, 5):
            emote = eval(f'active_quest.quest.OfferRewardEmote{i}')
            delay = eval(f'active_quest.quest.OfferRewardEmoteDelay{i}')
            data += pack('<2I', emote, delay)

        if active_quest.has_pick_reward():
            # Reward choices
            rew_choice_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_item_list(quest)))
            rew_choice_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_count_list(quest)))
            data += pack('<I', len(rew_choice_item_list))
            for index, item in enumerate(rew_choice_item_list):
                data += self._gen_item_struct(item, rew_choice_count_list[index])
        else:
            data += pack('<I', 0)

        #  Apart from available rewards to pick from, sometimes there are rewards you will also get, no matter what.
        if active_quest.has_item_reward():
            # Required items
            rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(quest)))
            rew_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(quest)))
            data += pack('<I', len(rew_item_list))
            for index, item in enumerate(rew_item_list):
                data += self._gen_item_struct(item, rew_count_list[index])
        else:
            data += pack('<I', 0)

        # Reward
        data += pack(
            '<3I',
            quest.RewOrReqMoney if quest.RewOrReqMoney >= 0 else -quest.RewOrReqMoney,
            quest.RewSpell,
            quest.RewSpellCast,
        )

        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_OFFER_REWARD, data))

    def handle_accept_quest(self, quest_id, quest_giver_guid):
        active_quest = self._create_db_quest_status(quest_id)
        active_quest.save(is_new=True)
        
        self.add_to_quest_log(quest_id, active_quest)
        self.send_quest_query_response(active_quest)
        # Check if the player already have related items.
        active_quest.fill_existent_items()
        if active_quest.can_complete_quest():
            self.complete_quest(active_quest, update_surrounding=False)

        self.update_surrounding_quest_status()

    def handle_remove_quest(self, slot):
        quest_id = self.player_mgr.get_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6))
        if quest_id in self.active_quests:
            self.remove_from_quest_log(quest_id)
            RealmDatabaseManager.character_delete_quest(self.player_mgr.guid, quest_id)

    def handle_complete_quest(self, quest_id, quest_giver_guid):
        if quest_id not in self.active_quests:
            return

        active_quest = self.active_quests[quest_id]
        if not active_quest.is_quest_complete(quest_giver_guid):
            return

        self.send_quest_giver_offer_reward(active_quest, quest_giver_guid, True)

    def handle_choose_reward(self, quest_giver_guid, quest_id, item_choice):
        if quest_id not in self.active_quests:
            return

        active_quest = self.active_quests[quest_id]
        if not active_quest.is_quest_complete(quest_giver_guid):
            return

        # Remove required items from the player inventory.
        req_item_list = QuestHelpers.generate_req_item_list(active_quest.quest)
        req_item_count = QuestHelpers.generate_req_item_count_list(active_quest.quest)
        for index, req_item in enumerate(req_item_list):
            if req_item != 0:
                self.player_mgr.inventory.remove_items(req_item, req_item_count[index])

        # Add the chosen item, if any.
        rew_item_choice_list = QuestHelpers.generate_rew_choice_item_list(active_quest.quest)
        if item_choice < len(rew_item_choice_list) and rew_item_choice_list[item_choice] > 0:
            self.player_mgr.inventory.add_item(entry=rew_item_choice_list[item_choice], show_item_get=False)

        given_xp = active_quest.reward_xp()
        given_gold = active_quest.reward_gold()

        # Remove from log and mark as rewarded
        self.remove_from_quest_log(quest_id)
        self.completed_quests.add(quest_id)

        # Update db quest status
        active_quest.update_quest_status(rewarded=True)

        data = pack(
            '<4I',
            quest_id,
            3,  # Investigate
            given_xp,
            given_gold
        )

        # Give player reward items, if any. Client will announce them.
        rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(active_quest.quest)))
        rew_item_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(active_quest.quest)))
        data += pack('<I', len(rew_item_list))
        for index, rew_item in enumerate(rew_item_list):
            data += pack('<2I', rew_item_list[index], rew_item_count_list[index])
            self.player_mgr.inventory.add_item(entry=rew_item_list[index], show_item_get=False)

        # TODO: Handle RewSpell and RewSpellCast upon completion.
        self.player_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_COMPLETE, data))

        # Update surrounding, NextQuestInChain was not working properly.
        self.update_surrounding_quest_status()

    def remove_from_quest_log(self, quest_id):
        self.active_quests.pop(quest_id)
        self.build_update()
        self.player_mgr.send_update_self()

    def add_to_quest_log(self, quest_id, active_quest):
        self.active_quests[quest_id] = active_quest
        self.build_update()
        self.player_mgr.send_update_self()

    def pop_item(self, item_entry, item_count):
        should_update = False
        for active_quest in list(self.active_quests.values()):
            if active_quest.requires_item(item_entry):
                if active_quest.pop_item(item_entry, item_count):
                    should_update = True

        if should_update:
            self.update_surrounding_quest_status()

    def reward_item(self, item_entry, item_count):
        for quest_id, active_quest in self.active_quests.items():
            if active_quest.still_needs_item(item_entry):
                active_quest.update_item_count(item_entry, item_count)
                self.update_single_quest(quest_id)
                # If by this item we complete the quest, update surrounding so NPC can display new complete status.
                if active_quest.can_complete_quest():
                    self.complete_quest(active_quest, update_surrounding=True, notify=True)
                return True
        return False

    # TODO: Handle Gameobjects
    def reward_creature_or_go(self, creature):
        for quest_id, active_quest in self.active_quests.items():
            if active_quest.requires_creature_or_go(creature.entry):
                active_quest.update_creature_go_count(creature, 1)
                self.update_single_quest(quest_id)
                # If by this kill we complete the quest, update surrounding so NPC can display new complete status.
                if active_quest.can_complete_quest():
                    self.complete_quest(active_quest, update_surrounding=True, notify=True)
                return True
        return False

    def complete_quest(self, active_quest, update_surrounding=False, notify=False):
        active_quest.update_quest_state(QuestState.QUEST_REWARD)

        if notify:
            data = pack('<I', active_quest.quest.entry)
            packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_COMPLETE, data)
            self.player_mgr.session.enqueue_packet(packet)

        if update_surrounding:
            self.update_surrounding_quest_status()

    def creature_go_is_required_by_quest(self, creature_entry):
        for active_quest in list(self.active_quests.values()):
            if active_quest.requires_creature_or_go(creature_entry):
                return True
        return False

    def item_is_still_needed_by_any_quest(self, item_entry):
        for active_quest in list(self.active_quests.values()):
            if active_quest.still_needs_item(item_entry):
                return True
        return False

    def update_single_quest(self, quest_id, slot=-1):
        progress = 0
        if quest_id in self.active_quests:
            progress = self.active_quests[quest_id].get_progress()
            if slot == -1:
                slot = list(self.active_quests.keys()).index(quest_id)

        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6), quest_id)
        # TODO Finish / investigate below values
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 1, 0)  # quest giver ID ?
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 2, 0)  # quest rewarder ID ?
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 3, progress)  # quest progress
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 4, 0)  # quest failure time
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 5, 0)  # number of mobs to kill

    def build_update(self):
        active_quest_list = list(self.active_quests.keys())
        for slot in range(0, MAX_QUEST_LOG):
            self.update_single_quest(active_quest_list[slot] if slot < len(active_quest_list) else 0, slot)

    def _create_db_quest_status(self, quest_id):
        db_quest_status = CharacterQuestState()
        db_quest_status.guid = self.player_mgr.guid
        db_quest_status.quest = quest_id
        db_quest_status.state = QuestState.QUEST_ACCEPTED.value
        return ActiveQuest(db_quest_status, self.player_mgr)
