from database.world.WorldModels import NpcGossip, NpcText
from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterQuestState
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ItemQueryDetailCache import ItemQueryDetailCache
from game.world.managers.objects.units.player.quest.ActiveQuest import ActiveQuest
from game.world.managers.objects.units.player.quest.QuestHelpers import QuestHelpers
from game.world.managers.objects.units.player.quest.QuestMenu import QuestMenu
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants import UnitCodes
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.MiscCodes import QuestGiverStatus, QuestState, QuestFailedReasons, QuestMethod, \
    QuestFlags, GameObjectTypes, ObjectTypeIds
from utils.constants.UpdateFields import PlayerFields

# Terminology:
# - quest_template or plain quest refers to the quest template (the db record / read only).
# - active_quest refers to quests in the player's quest log.

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
                quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_db_state.quest)
                # If this quest no longer exists, make sure to delete it from player's log.
                if not quest:
                    RealmDatabaseManager.character_delete_quest(self.player_mgr.guid, quest_db_state.quest)
                    continue
                active_quest = ActiveQuest(quest_db_state, self.player_mgr, quest)
                self.active_quests[quest_db_state.quest] = active_quest
                # Needed in case the WDB has been deleted, otherwise non cached quests won't appear in the log.
                self.send_quest_query_response(active_quest.quest)
            else:
                Logger.error(
                    f"Quest database (guid={quest_db_state.guid}, quest_id={quest_db_state.quest}) has state {quest_db_state.state}. No handling.")

    def is_quest_log_full(self):
        return len(self.active_quests) >= MAX_QUEST_LOG

    # TODO: Cache the return value by GO guid, flush this cache on any QuestManager state change.
    def should_interact_with_go(self, game_object):
        if game_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            if game_object.gobject_template.data1 != 0:
                loot_template_id = game_object.gobject_template.data1
                loot_template = WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_entry(loot_template_id)
                # Empty loot template.
                if len(loot_template) == 0:
                    return False
                # Check if any active quests requires this game_object as item source.
                for active_quest in list(self.active_quests.values()):
                    if active_quest.need_item_from_go(loot_template):
                        return True
        elif game_object.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER:
            # Grab starters/finishers.
            relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_starter_get_by_entry(game_object.gobject_template.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(game_object.gobject_template.entry)

            # Grab quest ids only.
            relations_list = [r.quest for r in relations_list]
            involved_relations_list = [ir.quest for ir in involved_relations_list]

            # Check if this quest has been already rewarded.
            for active_quest in list(self.active_quests.values()):
                if active_quest.quest.entry in relations_list:
                    if active_quest.db_state.rewarded == 1:
                        # Already rewarded.
                        return False

            # Check finishers.
            for active_quest in list(self.active_quests.values()):
                if active_quest.quest.entry in involved_relations_list:
                    # This go finishes a quest we have, make it interactive.
                    return True

            # Check starters.
            for quest_id in relations_list:
                if quest_id not in self.active_quests and quest_id not in self.completed_quests:
                    quest_template = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
                    if quest_template and self.check_quest_requirements(quest_template):
                        # This go offers a quest we don't have, and we match the requirements for it.
                        return True

        return False

    def get_dialog_status(self, world_object):
        dialog_status = QuestGiverStatus.QUEST_GIVER_NONE
        new_dialog_status = QuestGiverStatus.QUEST_GIVER_NONE

        if self.player_mgr.is_enemy_to(world_object):
            return dialog_status

        # Relation bounds, the quest giver; Involved relations bounds, the quest completer.
        if world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
            relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(world_object.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(world_object.entry)
        else:
            return QuestGiverStatus.QUEST_GIVER_NONE

        # Quest finishers
        for involved_relation in involved_relations_list:
            if len(involved_relation) == 0:
                continue
            quest_entry = involved_relation[1]
            # Check if player is already on this quest.
            if quest_entry not in self.active_quests:
                continue
            # Grab QuestTemplate.
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            quest_state = self.active_quests[quest_entry].get_quest_state()
            if quest_state == QuestState.QUEST_REWARD or QuestHelpers.is_instant_complete_quest(quest) and self.check_quest_requirements(quest):
                new_dialog_status = QuestGiverStatus.QUEST_GIVER_REWARD
            if new_dialog_status > dialog_status:
                dialog_status = new_dialog_status

        new_dialog_status = dialog_status
        # Quest starters
        if new_dialog_status < QuestGiverStatus.QUEST_GIVER_REWARD:
            for relation in relations_list:
                quest_entry = relation[1]
                # Check if player is already on this quest or completed the quest.
                if quest_entry in self.active_quests or quest_entry in self.completed_quests:
                    continue
                # Grab QuestTemplate.
                quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
                if quest:
                    # Check requirements and also update display status no matter if player does not meet requirements.
                    if self.check_quest_requirements(quest):
                        if QuestHelpers.is_instant_complete_quest(quest) or QuestHelpers.is_quest_repeatable(quest):
                            new_dialog_status = QuestGiverStatus.QUEST_GIVER_REWARD  # Make the NPC shows quest already complete.
                        else: # See if we can set status Trivial, Future, etc..
                            new_dialog_status = self.update_dialog_display_status(quest, new_dialog_status)
                    else:
                        new_dialog_status = self.update_dialog_display_status(quest, new_dialog_status, checks_failed=True)

                # Update dialog result if needed.
                if new_dialog_status > dialog_status:
                    dialog_status = new_dialog_status

        return dialog_status

    def handle_quest_giver_hello(self, quest_giver, quest_giver_guid):
        quest_menu = QuestMenu()
        # Type is unit, but not player.
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT and quest_giver.get_type_id() != ObjectTypeIds.ID_PLAYER:
            relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_starter_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(quest_giver.entry)
        else:
            return

        # Start quests lookup set.
        quest_giver_start_quests = {start_quest[1] for start_quest in relations_list if len(start_quest) > 0}
        # Finish quests lookup set.
        quest_giver_finish_quests = {finish_quest[1] for finish_quest in involved_relations_list if len(finish_quest) > 0}

        # Quest finish.
        for quest_entry in quest_giver_finish_quests:
            if quest_entry in self.completed_quests:
                continue
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            # Handle repeatable quest.
            if QuestHelpers.is_quest_repeatable(quest) and quest_entry not in self.active_quests:
                self.active_quests[quest_entry] = self._create_db_quest_status(quest)
            # Not repeatable and player is not in this quest, move on.
            elif not QuestHelpers.is_quest_repeatable(quest) and quest_entry not in self.active_quests:
                continue
            # Check quest requirements including quest level.
            if not quest or not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            quest_state = self.active_quests[quest_entry].get_quest_state()
            # Quest has not been rewarded and it should.
            if not self.active_quests[quest_entry].get_is_quest_rewarded() and quest_state == QuestState.QUEST_REWARD:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_REWARD, quest_state)
            # Quest is incomplete.
            elif quest_state == QuestState.QUEST_ACCEPTED:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_QUEST, quest_state)
            # Quest is available from this finisher.
            elif quest_state == QuestState.QUEST_OFFER:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_NONE, quest_state)
            elif quest_state == QuestState.QUEST_REWARD:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_REWARD, quest_state)

        # Quest start.
        for quest_entry in quest_giver_start_quests:
            if quest_entry in self.completed_quests:
                continue
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            if QuestHelpers.is_quest_repeatable(quest) and quest_entry not in self.active_quests:
                self.active_quests[quest_entry] = self._create_db_quest_status(quest)
             # Check quest requirements including quest level.
            if not quest or not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            quest_state = self.get_quest_state(quest_entry)
            if QuestHelpers.is_instant_complete_quest(quest) and quest_entry not in self.active_quests:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_REWARD, QuestState.QUEST_REWARD)
            elif quest_entry not in self.active_quests:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_NONE, QuestState.QUEST_OFFER)
            # If this npc is the finisher of this incomplete quest, display in 'Current Quests'.
            elif quest_entry in quest_giver_finish_quests and quest_state == QuestState.QUEST_ACCEPTED:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_QUEST, QuestState.QUEST_ACCEPTED)

        # No quest menu items, do not display anything.
        if len(quest_menu.items) == 0:
            return

        if len(quest_menu.items) == 1:
            quest_menu_item = list(quest_menu.items.values())[0]
            if quest_menu_item.quest_state == QuestState.QUEST_REWARD:
                self.send_quest_giver_offer_reward(quest_menu_item.quest, quest_giver_guid, True)
                return
            elif quest_menu_item.quest_state == QuestState.QUEST_ACCEPTED:
                self.send_quest_giver_request_items(quest_menu_item.quest, quest_giver_guid, auto_launched=True)
                return
            else:
                self.send_quest_giver_quest_details(quest_menu_item.quest, quest_giver_guid, True)
        else:
            quest_giver_greeting, emote = QuestManager.get_quest_giver_gossip_string(quest_giver)
            self.send_quest_giver_quest_list(quest_giver_greeting, emote, quest_giver_guid, quest_menu.items)

        self.update_surrounding_quest_status()

    def get_quest_state(self, quest_entry):
        if quest_entry in self.active_quests:
            return self.active_quests[quest_entry].get_quest_state()

        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
        # If this is a quest we can take, return quest offer.
        if self.check_quest_requirements(quest) and self.check_quest_level(quest, False):
            return QuestState.QUEST_OFFER
        # Greeting - 'None'
        return QuestState.QUEST_GREETING

    def get_active_quest_num_from_quest_giver(self, quest_giver):
        quest_num: int = 0

        # Type is unit, but not player.
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT and quest_giver.get_type_id() != ObjectTypeIds.ID_PLAYER:
            relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_starter_get_by_entry(quest_giver.entry)
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(quest_giver.entry)
        else:
            return

        # Start quests lookup set.
        quest_giver_start_quests = {start_quest[1] for start_quest in relations_list if len(start_quest) > 0}
        # Finish quests lookup set.
        quest_giver_finish_quests = {finish_quest[1] for finish_quest in involved_relations_list if len(finish_quest) > 0}

        # Quest finish.
        for quest_entry in quest_giver_finish_quests:
            quest_status = self.get_quest_state(quest_entry)
            if quest_status == QuestState.QUEST_REWARD:
                quest_num += 1

        # Quest start.
        for quest_entry in quest_giver_start_quests:
            quest_status = self.get_quest_state(quest_entry)
            if quest_status == QuestState.QUEST_OFFER:
                quest_num += 1

        return quest_num

    # Updates the dialog_status display.
    def update_dialog_display_status(self, quest_template, dialog_status, checks_failed=False):
        # If general quest requirements failed, we just care about 'Future' display status.
        if quest_template.MinLevel > self.player_mgr.level >= quest_template.MinLevel - 4:
            dialog_status = QuestGiverStatus.QUEST_GIVER_FUTURE  # Gray '!', you are close to having a quest.
        elif not checks_failed and quest_template.MinLevel <= self.player_mgr.level < quest_template.QuestLevel + 7:
            dialog_status = QuestGiverStatus.QUEST_GIVER_QUEST  # Yellow '!', available quest.
        elif not checks_failed and self.player_mgr.level > quest_template.QuestLevel + 7:
            dialog_status = QuestGiverStatus.QUEST_GIVER_TRIVIAL  # Not shown unless interacting.
        return dialog_status

    # TODO: RequiredCondition, ExclusiveGroups
    def check_quest_requirements(self, quest_template):
        # First check if quest is disabled.
        if quest_template.Method == QuestMethod.QUEST_DISABLED:
            return False

        # Satisfies required min level?
        if self.player_mgr.level < quest_template.MinLevel:
            return False

        # Satisfies required race?
        race_is_required = quest_template.RequiredRaces > 0
        if race_is_required and not (quest_template.RequiredRaces & self.player_mgr.race_mask):
            return False

        # Satisfies required class?
        class_is_required = quest_template.RequiredClasses > 0
        if class_is_required and not (quest_template.RequiredClasses & self.player_mgr.class_mask):
            return False

        # Satisfies required skill?
        skill_is_required = quest_template.RequiredSkill > 0
        if skill_is_required:
            skill_required_value = quest_template.RequiredSkillValue
            player_skill_value = self.player_mgr.skill_manager.get_total_skill_value(quest_template.RequiredSkill)
            if player_skill_value < skill_required_value:
                return False

        # Has the character already started the next quest in the chain.
        if quest_template.NextQuestInChain > 0 and quest_template.NextQuestInChain in self.completed_quests:
            return False

        # Does the character have the previous quest.
        if quest_template.PrevQuestId > 0 and quest_template.PrevQuestId not in self.completed_quests:
            return False

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
        relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(quest_giver_entry)
        for relation in relations_list:
            if relation.entry == quest_giver_entry and relation.quest == quest_entry:
                is_related = True
        return is_related

    @staticmethod
    def get_quest_giver_gossip_string(quest_giver):
        quest_giver_gossip_entry: NpcGossip = WorldDatabaseManager.QuestGossipHolder.npc_gossip_get_by_guid(quest_giver.guid)
        text_entry: int = WorldDatabaseManager.QuestGossipHolder.DEFAULT_GREETING_TEXT_ID  # 68 textid = "Greetings $N".
        if quest_giver_gossip_entry:
            text_entry = quest_giver_gossip_entry.textid
        quest_giver_text_entry: NpcText = WorldDatabaseManager.QuestGossipHolder.npc_text_get_by_id(text_entry)

        quest_giver_greeting = ''
        # Get text based on creature gender.
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
            if quest_giver.gender == UnitCodes.Genders.GENDER_MALE:
                quest_giver_greeting: str = quest_giver_text_entry.text0_0
            else:
                quest_giver_greeting: str = quest_giver_text_entry.text0_1

        return quest_giver_greeting, quest_giver_text_entry.em0_0

    # Quest status only works for units, sending a gameobject guid crashes the client.
    def update_surrounding_quest_status(self):
        units = MapManager.get_surrounding_objects(self.player_mgr, [ObjectTypeIds.ID_UNIT])[0]
        for guid, unit in units.items():
            if WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(
                    unit.entry) or WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(unit.entry):
                quest_status = self.get_dialog_status(unit)
                self.send_quest_giver_status(guid, quest_status)

    # Send item query details and return item struct byte segments.
    def _gen_item_struct(self, item_entry, count):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        display_id = 0
        if item_template:
            display_id = item_template.display_id
            item_query_packet = ItemQueryDetailCache.get_item_detail_query(item_template)
            self.player_mgr.enqueue_packet(item_query_packet)

        item_data = pack(
            '<3I',
            item_entry,
            count,
            display_id
        )

        return item_data

    def send_cant_take_quest_response(self, reason_code):
        data = pack('<I', reason_code)
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_INVALID, data))

    def send_quest_giver_status(self, quest_giver_guid, quest_status):
        data = pack(
            '<QI',
            quest_giver_guid if quest_giver_guid > 0 else self.player_mgr.guid,
            quest_status
        )
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_STATUS, data))

    # TODO: There are several emote fields in npc_text.
    def send_quest_giver_quest_list(self, message, emote, quest_giver_guid, quests):
        message_bytes = PacketWriter.string_to_bytes(message)
        data = pack(
            f'<Q{len(message_bytes)}s2iB',
            quest_giver_guid,
            message_bytes,
            0,
            emote,
            len(quests)
        )

        for entry in quests:
            quest_title = PacketWriter.string_to_bytes(quests[entry].quest.Title)
            data += pack(
                f'<3I{len(quest_title)}s',
                entry,
                quests[entry].quest_giver_state,
                quests[entry].quest.QuestLevel,
                quest_title
            )

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_LIST, data))

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

        # Emotes
        data += pack('<I', 4)
        for index in range (1, 5):
            detail_emote = int(eval(f'quest_template.DetailsEmote{index}'))
            detail_emote_delay = eval(f'quest_template.DetailsEmoteDelay{index}')
            data += pack('<2I', detail_emote, detail_emote_delay )

        # TODO: This code below does not belong on this packet.
        # # Required items
        # req_item_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(quest_template)))
        # req_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(quest_template)))
        # data += pack('<I', len(req_item_list))
        # for index, item in enumerate(req_item_list):
        #     data += self._gen_item_struct(item, req_count_list[index])
        #
        # # Required kill / go count
        # req_creature_or_go_list = list(filter((0).__ne__, QuestHelpers.generate_req_creature_or_go_list(quest_template)))
        # req_creature_or_go_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_creature_or_go_count_list(quest_template)))
        # data += pack('<I', len(req_creature_or_go_list))
        # for index, creature_or_go in enumerate(req_creature_or_go_list):
        #     data += pack(
        #         '<2I',
        #         creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
        #         req_creature_or_go_count_list[index]
        #     )

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_DETAILS, data))

    def send_quest_query_response(self, quest):
        data = pack(
            f'<3Ii4I',
            quest.entry,
            quest.Method,
            quest.QuestLevel,
            quest.ZoneOrSort,
            quest.Type,
            quest.NextQuestInChain,
            quest.RewOrReqMoney,
            quest.SrcItemId
        )

        # Rewards given no matter what.
        rew_item_list = QuestHelpers.generate_rew_item_list(quest)
        rew_item_count_list = QuestHelpers.generate_rew_count_list(quest)
        for index, item in enumerate(rew_item_list):
            data += pack('<2I', item, rew_item_count_list[index])

        # Reward choices.
        rew_choice_item_list = QuestHelpers.generate_rew_choice_item_list(quest)
        rew_choice_count_list = QuestHelpers.generate_rew_choice_count_list(quest)
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

        # Required kills / Required items count.
        req_creatures_or_gos = QuestHelpers.generate_req_creature_or_go_list(quest)
        req_creatures_or_gos_count_list = QuestHelpers.generate_req_creature_or_go_count_list(quest)
        req_items = QuestHelpers.generate_req_item_list(quest)
        req_items_count_list = QuestHelpers.generate_req_item_count_list(quest)
        for index, creature_or_go in enumerate(req_creatures_or_gos):
            data += pack(
                '<4IB',
                creature_or_go if creature_or_go >= 0 else (creature_or_go * -1) | 0x80000000,
                req_creatures_or_gos_count_list[index],
                req_items[index],
                req_items_count_list[index],
                0x0  # Unknown, if missing, multiple objective quests will not display properly.
            )

        # Objective texts.
        req_objective_text_list = QuestHelpers.generate_objective_text_list(quest)
        for index, objective_text in enumerate(req_objective_text_list):
            req_objective_text_bytes = PacketWriter.string_to_bytes(req_objective_text_list[index])
            data += pack(
                f'{len(req_objective_text_bytes)}s',
                req_objective_text_bytes
            )

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUEST_QUERY_RESPONSE, data))

    def send_quest_giver_request_items(self, quest, quest_giver_id, auto_launched):
        # We can always call to RequestItems, but this packet only goes out if there are actually
        # items.  Otherwise, we'll skip straight to the OfferReward.
        quest_title = quest.Title
        request_items_text = quest.RequestItemsText
        is_completable = quest.entry in self.active_quests and self.active_quests[quest.entry].is_quest_complete(quest_giver_id)

        if not request_items_text or (not QuestHelpers.has_item_requirements(quest) and is_completable):
            self.send_quest_giver_offer_reward(quest, quest_giver_id, enable_next=True)
            return

        quest_title_bytes = PacketWriter.string_to_bytes(quest_title)
        request_items_text_bytes = PacketWriter.string_to_bytes(request_items_text)
        data = pack(
            f'<QI{len(quest_title_bytes)}s{len(request_items_text_bytes)}s3I',
            quest_giver_id,
            quest.entry,
            quest_title_bytes,
            request_items_text_bytes,
            0,  # Emote delay
            quest.CompleteEmote if is_completable else quest.IncompleteEmote,
            auto_launched,  # Close Window after cancel
        )

        req_items = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(quest)))
        req_items_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(quest)))
        data += pack('<I', len(req_items))
        for index in range(0, len(req_items)):
            data += self._gen_item_struct(req_items[index], req_items_count_list[index])

        data += pack(
            '<3I',
            0x02, # MaskMatch
            0x03 if is_completable else 0x00,  # Completable = Player has items?
            0x04,  # HasFaction
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_REQUEST_ITEMS, data)
        self.player_mgr.enqueue_packet(packet)

    def send_quest_giver_offer_reward(self, quest, quest_giver_guid, enable_next=True):
        # Validate if its active to player.
        if quest.entry not in self.active_quests:
            return
        active_quest = self.active_quests[quest.entry]
        # CGPlayer_C::OnQuestGiverChooseReward
        quest_title_bytes = PacketWriter.string_to_bytes(quest.Title)
        display_dialog_text = quest.OfferRewardText

        dialog_text_bytes = PacketWriter.string_to_bytes(display_dialog_text)
        data = pack(
            f'<QI{len(quest_title_bytes)}s{len(dialog_text_bytes)}sI',
            quest_giver_guid,
            quest.entry,
            quest_title_bytes,
            dialog_text_bytes,
            1 if enable_next else 0  # enable_next
        )

        # Emote count, always 4.
        data += pack('<I', 4)
        for i in range(1, 5):
            offer_emote = eval(f'active_quest.quest.OfferRewardEmote{i}')
            offer_emote_delay = eval(f'active_quest.quest.OfferRewardEmoteDelay{i}')
            data += pack('<2I', offer_emote, offer_emote_delay)

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

        # Reward Money, 0.5.3 does not handle RewSpell, RewSpellCast.
        data += pack('<I', quest.RewOrReqMoney if quest.RewOrReqMoney >= 0 else -quest.RewOrReqMoney)

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_OFFER_REWARD, data))

    def handle_accept_quest(self, quest_id, quest_giver_guid, shared=False):
        if quest_id in self.active_quests:
            self.send_cant_take_quest_response(QuestFailedReasons.QUEST_ALREADY_ON)
            return

        if quest_id in self.completed_quests:
            self.send_cant_take_quest_response(QuestFailedReasons.QUEST_ONLY_ONE_TIMED)
            return

        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
        if not quest:
            return

        req_src_item = quest.SrcItemId
        req_src_item_count = quest.SrcItemCount
        if req_src_item != 0:
            if not self.player_mgr.inventory.add_item(req_src_item, count=req_src_item_count, update_inventory=True):
                return

        active_quest = self._create_db_quest_status(quest)
        active_quest.save(is_new=True)
        self.add_to_quest_log(quest_id, active_quest)
        self.send_quest_query_response(quest)

        # If player is in a group and quest has QUEST_FLAGS_PARTY_ACCEPT flag, let other members accept it too.
        if self.player_mgr.group_manager and not shared:
            quest_template = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
            if quest_template and quest_template.QuestFlags & QuestFlags.QUEST_FLAGS_PARTY_ACCEPT:
                self.share_quest_event(active_quest)

        # Check if the player already has related items.
        active_quest.fill_existent_items()
        if active_quest.can_complete_quest():
            self.complete_quest(active_quest, update_surrounding=False)

        self.update_surrounding_quest_status()
        self.player_mgr.update_known_world_objects(force_update=True)

    def share_quest_event(self, active_quest):
        title_bytes = PacketWriter.string_to_bytes(active_quest.quest.Title)
        data = pack(f'<I{len(title_bytes)}sQ', active_quest.quest.entry, title_bytes, self.player_mgr.guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUEST_CONFIRM_ACCEPT, data)

        surrounding_party_players = self.player_mgr.group_manager.get_surrounding_members(self.player_mgr)
        for player_mgr in surrounding_party_players:
            if player_mgr.guid == self.player_mgr.guid:
                continue

            # Check which party member fulfills all requirements
            if not player_mgr.quest_manager.check_quest_requirements(active_quest.quest):
                continue
            if not player_mgr.quest_manager.check_quest_level(active_quest.quest, False):
                continue
            if active_quest.quest.entry in player_mgr.quest_manager.active_quests:
                continue
            if active_quest.quest.entry in player_mgr.quest_manager.completed_quests:
                continue

            player_mgr.enqueue_packet(packet)

    def handle_remove_quest(self, slot):
        quest_entry = self.player_mgr.get_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6))
        if quest_entry in self.active_quests:
            active_quest = self.active_quests[quest_entry]
            # Remove required items from the player inventory.
            req_item_list = QuestHelpers.generate_req_item_list(active_quest.quest)
            req_item_count = QuestHelpers.generate_req_item_count_list(active_quest.quest)
            for index, req_item in enumerate(req_item_list):
                if req_item != 0:
                    self.player_mgr.inventory.remove_items(req_item, req_item_count[index])

            self.remove_from_quest_log(quest_entry)
            RealmDatabaseManager.character_delete_quest(self.player_mgr.guid, quest_entry)
            self.update_surrounding_quest_status()
            self.player_mgr.update_known_world_objects(force_update=True)

    def handle_complete_quest(self, quest_id, quest_giver_guid):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)

        # Validate if quest exist.
        if not quest:
            return

        if quest_id not in self.active_quests and quest_id not in self.completed_quests:
            self.send_quest_giver_quest_details(quest, quest_giver_guid, activate_accept=True)
            return

        active_quest = self.active_quests[quest_id]
        if not active_quest.is_quest_complete(quest_giver_guid):
            self.send_quest_giver_request_items(quest, quest_giver_guid, auto_launched=False)
            return

        self.send_quest_giver_offer_reward(quest, quest_giver_guid, True)

    # TODO: Handle RewSpell? Not sure if available by looking at 0.5.3 code.
    def handle_choose_reward(self, quest_giver_guid, quest_id, item_choice):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
        if not quest:
            return

        # If this is an instant complete quest, and we haven't created its db state, do so.
        if QuestHelpers.is_instant_complete_quest(quest) and quest_id not in self.active_quests:
            self.active_quests[quest_id] = self._create_db_quest_status(quest)
            self.active_quests[quest_id].save(is_new=True)

        active_quest = self.active_quests[quest_id]
        if not active_quest.is_quest_complete(quest_giver_guid):
            return

        # Remove required items from the player inventory.
        req_item_list = QuestHelpers.generate_req_item_list(quest)
        req_item_count = QuestHelpers.generate_req_item_count_list(quest)
        for index, req_item in enumerate(req_item_list):
            if req_item != 0:
                self.player_mgr.inventory.remove_items(req_item, req_item_count[index])

        # Add the chosen item, if any.
        rew_item_choice_list = QuestHelpers.generate_rew_choice_item_list(quest)
        if item_choice < len(rew_item_choice_list) and rew_item_choice_list[item_choice] > 0:
            self.player_mgr.inventory.add_item(entry=rew_item_choice_list[item_choice], show_item_get=False, update_inventory=True)

        given_xp = active_quest.reward_xp()
        given_gold = active_quest.reward_gold()

        # Repeatable quests are not persisted.
        if not QuestHelpers.is_quest_repeatable(active_quest.quest):
            # Remove from log and mark as rewarded.
            self.remove_from_quest_log(quest_id)
            self.completed_quests.add(quest_id)
            # Update db quest status.
            active_quest.update_quest_status(rewarded=True)

        # Remove from active quests if needed.
        if quest.entry in self.active_quests:
            del self.active_quests[quest.entry]

        data = pack(
            '<4I',
            quest_id,
            3,  # Investigate
            int(given_xp * config.Server.Settings.xp_rate),
            given_gold
        )

        # Give player reward items, if any. Client will announce them.
        rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(active_quest.quest)))
        rew_item_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(active_quest.quest)))
        data += pack('<I', len(rew_item_list))
        for index, rew_item in enumerate(rew_item_list):
            data += pack('<2I', rew_item_list[index], rew_item_count_list[index])
            self.player_mgr.inventory.add_item(entry=rew_item_list[index], show_item_get=False, update_inventory=True)

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_COMPLETE, data))

        # Cast spell if needed.
        if active_quest.quest.RewSpellCast:
            self.cast_reward_spell(quest_giver_guid, active_quest)

        # Update surrounding, NextQuestInChain was not working properly.
        self.update_surrounding_quest_status()
        self.player_mgr.update_known_world_objects(force_update=True)

    def cast_reward_spell(self, quest_giver_guid, active_quest):
        quest_giver_unit = MapManager.get_surrounding_unit_by_guid(self.player_mgr, quest_giver_guid)
        if quest_giver_unit:
            quest_giver_unit.spell_manager.handle_cast_attempt(active_quest.quest.RewSpellCast,
                                                            self.player_mgr,
                                                            SpellTargetMask.SELF, validate=False)
        return

    def remove_from_quest_log(self, quest_id):
        self.active_quests.pop(quest_id)
        self.build_update()

    def add_to_quest_log(self, quest_id, active_quest):
        self.active_quests[quest_id] = active_quest
        self.build_update()

    def pop_item(self, item_entry, item_count):
        should_update = False
        for active_quest in list(self.active_quests.values()):
            if active_quest.requires_item(item_entry):
                if active_quest.pop_item(item_entry, item_count):
                    should_update = True

        if should_update:
            self.update_surrounding_quest_status()
            self.player_mgr.update_known_world_objects(force_update=True)

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

    def quest_failed(self, active_quest):
        data = pack('<I', active_quest.quest.entry)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_FAILED, data)
        self.player_mgr.enqueue_packet(packet)

    def complete_quest(self, active_quest, update_surrounding=False, notify=False):
        active_quest.update_quest_state(QuestState.QUEST_REWARD)

        if notify:
            data = pack('<I', active_quest.quest.entry)
            packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_COMPLETE, data)
            self.player_mgr.enqueue_packet(packet)

        if update_surrounding:
            self.update_surrounding_quest_status()
            self.player_mgr.update_known_world_objects(force_update=True)

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

    def _create_db_quest_status(self, quest):
        db_quest_status = CharacterQuestState()
        db_quest_status.guid = self.player_mgr.guid
        db_quest_status.quest = quest.entry
        if quest.Method == QuestMethod.QUEST_AUTOCOMPLETE:
            db_quest_status.state = QuestState.QUEST_REWARD.value
        else:
            db_quest_status.state = QuestState.QUEST_ACCEPTED.value
        return ActiveQuest(db_quest_status, self.player_mgr, quest)
