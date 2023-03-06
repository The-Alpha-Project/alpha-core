from database.world.WorldModels import NpcGossip, NpcText, QuestGreeting
from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterQuestState
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.gameobjects.utils.GoQueryUtils import GoQueryUtils
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.creature.utils.UnitQueryUtils import UnitQueryUtils
from game.world.managers.objects.units.player.quest.ActiveQuest import ActiveQuest
from game.world.managers.objects.units.player.quest.QuestHelpers import QuestHelpers
from game.world.managers.objects.units.player.quest.QuestMenu import QuestMenu
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants import UnitCodes
from utils.constants.ItemCodes import InventoryError
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.MiscCodes import QuestGiverStatus, QuestState, QuestFailedReasons, QuestMethod, \
    QuestFlags, GameObjectTypes, ObjectTypeIds, HighGuid, ScriptTypes
from utils.constants.UpdateFields import PlayerFields

# Terminology:
# - quest_template or plain quest refers to the quest template (the db record / read only).
# - active_quest refers to quests in the player's quest log.

MAX_QUEST_LOG = 16


class QuestManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.last_timer_update = 0
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

    def should_interact_with_go(self, game_object):
        if game_object.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            if game_object.gobject_template.data1 != 0:
                loot_template_id = game_object.gobject_template.data1
                loot_template = WorldDatabaseManager.GameObjectLootTemplateHolder.gameobject_loot_template_get_by_loot_id(loot_template_id)
                # Empty loot template.
                if len(loot_template) == 0:
                    return False
                # Check if any active quests requires this game_object as item source.
                for active_quest in list(self.active_quests.values()):
                    if active_quest.need_item_from_go(game_object.guid, loot_template):
                        return True
        elif game_object.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER:
            # Grab starters/finishers.
            relations_list = QuestManager.get_quest_giver_relations(game_object)
            involved_relations_list = QuestManager.get_quest_giver_involved_relations(game_object)

            # Grab quest ids only.
            relations_list = {r.quest for r in relations_list}
            involved_relations_list = {ir.quest for ir in involved_relations_list}

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
        elif game_object.gobject_template.type == GameObjectTypes.TYPE_GOOBER:
            for quest_id, active_quest in self.active_quests.items():
                if active_quest.requires_creature_or_go(game_object):
                    return True

        return False

    def get_dialog_status(self, quest_giver):
        dialog_status = QuestGiverStatus.QUEST_GIVER_NONE
        new_dialog_status = QuestGiverStatus.QUEST_GIVER_NONE

        if self.player_mgr.is_hostile_to(quest_giver):
            return dialog_status

        # Relation bounds, the quest giver; Involved relations bounds, the quest completer.
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
            relations_list = QuestManager.get_quest_giver_relations(quest_giver)
            involved_relations_list = QuestManager.get_quest_giver_involved_relations(quest_giver)
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
                if quest_entry in self.active_quests:
                    continue
                # Grab QuestTemplate.
                quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
                if not quest:
                    continue
                # Quest is completed and not repeatable.
                if quest_entry in self.completed_quests and not QuestHelpers.is_quest_repeatable(quest):
                    continue
                # Check requirements and also update display status no matter if player does not meet requirements.
                if self.check_quest_requirements(quest):
                    new_dialog_status = self.update_dialog_display_status(quest, new_dialog_status)
                else:
                    new_dialog_status = self.update_dialog_display_status(quest, new_dialog_status, checks_failed=True)

                # Update dialog result if needed.
                if new_dialog_status > dialog_status:
                    dialog_status = new_dialog_status

        return dialog_status

    def handle_quest_giver_hello(self, quest_giver, quest_giver_guid):
        quest_menu = QuestMenu()

        relations_list = QuestManager.get_quest_giver_relations(quest_giver)
        involved_relations_list = QuestManager.get_quest_giver_involved_relations(quest_giver)

        # Start quests lookup set.
        quest_giver_start_quests = {start_quest[1] for start_quest in relations_list if len(start_quest) > 0}
        # Finish quests lookup set.
        quest_giver_finish_quests = {finish_quest[1] for finish_quest in involved_relations_list if len(finish_quest) > 0}

        # Quest finish.
        for quest_entry in quest_giver_finish_quests:
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            if quest_entry in self.completed_quests and not QuestHelpers.is_quest_repeatable(quest):
                continue
            # Player is not in this quest, move on.
            if quest_entry not in self.active_quests:
                continue
            # Check quest requirements including quest level.
            if not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
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
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            if quest_entry in self.completed_quests and not QuestHelpers.is_quest_repeatable(quest):
                continue
            # Check quest requirements including quest level.
            if not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            quest_state = self.get_quest_state(quest_entry)
            if QuestHelpers.is_instant_with_no_requirements(quest) and quest_entry not in self.active_quests:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_REWARD, QuestState.QUEST_REWARD)
            elif QuestHelpers.is_instant_complete_quest(quest) and quest_entry not in self.active_quests:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_REWARD, QuestState.QUEST_ACCEPTED)
            elif quest_entry not in self.active_quests:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_NONE, QuestState.QUEST_OFFER)
            # If this npc is the finisher of this incomplete quest, display in 'Current Quests'.
            elif quest_entry in quest_giver_finish_quests and quest_state == QuestState.QUEST_ACCEPTED:
                quest_menu.add_menu_item(quest, QuestGiverStatus.QUEST_GIVER_QUEST, QuestState.QUEST_ACCEPTED)

        has_greeting, greeting_text, emote = QuestManager.get_quest_giver_gossip_string(quest_giver)

        # No quest menu items but has gossip greeting, display that.
        if len(quest_menu.items) == 0 and has_greeting:
            self.send_quest_giver_quest_list(greeting_text, emote, quest_giver_guid, quest_menu.items)
            return

        # Check for quest greeting if multiple quests.
        if not has_greeting and len(quest_menu.items) > 1:
            has_quest_greeting, q_greeting_text, q_emote = QuestManager.get_quest_giver_quest_greeting(quest_giver)
            if has_quest_greeting:
                has_greeting = True
                greeting_text = q_greeting_text
                emote = q_emote

        # If we only have 1 quest menu item, and it has no custom greeting, send the appropriate packet directly.
        if len(quest_menu.items) == 1 and not has_greeting:
            quest_menu_item = list(quest_menu.items.values())[0]
            if quest_menu_item.quest_state == QuestState.QUEST_REWARD:
                self.send_quest_giver_offer_reward(quest_menu_item.quest, quest_giver_guid, True)
                return
            elif quest_menu_item.quest_state == QuestState.QUEST_ACCEPTED:
                self.send_quest_giver_request_items(quest_menu_item.quest, quest_giver_guid, close_on_cancel=True)
                return
            else:
                self.send_quest_giver_quest_details(quest_menu_item.quest, quest_giver_guid, True)
        # We have 1 or more items and a custom greeting, send the greeting and quest menu item(s).
        elif len(quest_menu.items) > 0 or has_greeting:
            self.send_quest_giver_quest_list(greeting_text, emote, quest_giver_guid, quest_menu.items)
        # Landed here because player is talking to a trainer, which can't train the player and does not have any quest.
        # Display the default greeting, since gossip system was not a thing in 0.5.3.
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT and quest_giver.is_trainer():
            text = QuestManager.get_default_greeting_text(quest_giver)
            self.send_quest_giver_quest_list(text, 0, quest_giver_guid, quest_menu.items)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            # TODO: e.g. Stone of Remembrance - Needs broadcast_text table.
            Logger.warning(f'Missing handling for quest giver {quest_giver.get_name()}, '
                           f'Entry: {quest_giver.entry}.')

    def get_quest_state(self, quest_entry):
        if quest_entry in self.active_quests:
            return self.active_quests[quest_entry].get_quest_state()

        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
        # If this is a quest we can take, return quest offer.
        if quest and self.check_quest_requirements(quest) and self.check_quest_level(quest, False):
            return QuestState.QUEST_OFFER
        # Greeting - 'None'
        return QuestState.QUEST_GREETING

    def get_active_quest_num_from_quest_giver(self, quest_giver):
        quest_num: int = 0

        relations_list = QuestManager.get_quest_giver_relations(quest_giver)
        involved_relations_list = QuestManager.get_quest_giver_involved_relations(quest_giver)

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
            if quest_entry in self.completed_quests:
                continue
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

        # The given quest has to be active in the quest log to get this quest.
        if quest_template.PrevQuestId < 0 and abs(quest_template.PrevQuestId) not in self.active_quests:
            return False

        # The given quest needs to be completed prior to getting this quest.
        if quest_template.PrevQuestId > 0 and quest_template.PrevQuestId not in self.completed_quests:
            return False

        # The given quest has alternative exclusive options.
        if quest_template.ExclusiveGroup > 0:
            exclusive_quests = WorldDatabaseManager.QuestExclusiveGroupsHolder.get_quest_for_group_id(
                quest_template.ExclusiveGroup)
            for exclusive_quest in exclusive_quests:
                # Skip the quest triggering this check.
                if exclusive_quest == quest_template.entry:
                    continue
                # Check the alternative quest is completed or active.
                if exclusive_quest in self.completed_quests or exclusive_quest in self.active_quests:
                    return False

        return True

    def check_quest_level(self, quest_template, will_send_response):
        if self.player_mgr.level < quest_template.MinLevel:
            if will_send_response:
                self.send_cant_take_quest_response(QuestFailedReasons.QUEST_FAILED_LOW_LEVEL)
            return False
        else:
            return True

    @staticmethod
    def check_quest_giver_npc_is_related(quest_giver, quest_entry):
        for relation in QuestManager.get_quest_giver_relations(quest_giver):
            if relation.entry == quest_giver.entry and relation.quest == quest_entry:
                return True
        return False

    @staticmethod
    def get_quest_giver_quest_greeting(quest_giver) -> tuple:
        quest_greeting_entry: QuestGreeting = WorldDatabaseManager.quest_get_greeting_for_entry(quest_giver.entry)

        if quest_greeting_entry:
            return True, quest_greeting_entry.content_default, quest_greeting_entry.emote_id

        return False, '', 0

    @staticmethod
    def get_default_greeting_text(quest_giver):
        text_entry_id: int = WorldDatabaseManager.QuestGossipHolder.DEFAULT_GREETING_TEXT_ID
        text_entry: NpcText = WorldDatabaseManager.QuestGossipHolder.npc_text_get_by_id(text_entry_id)
        if not text_entry:
            return ''
        return QuestManager._gossip_text_choose_by_gender(quest_giver, text_entry)

    @staticmethod
    def get_quest_giver_gossip_string(quest_giver) -> tuple:  # has_custom_greeting, greeting str, emote
        quest_giver_gossip_entry: NpcGossip = WorldDatabaseManager.QuestGossipHolder.npc_gossip_get_by_guid(quest_giver.guid)
        text_entry: int = WorldDatabaseManager.QuestGossipHolder.DEFAULT_GREETING_TEXT_ID  # 68 textid = "Greetings $N".
        if quest_giver_gossip_entry:
            text_entry = quest_giver_gossip_entry.textid
        quest_giver_text_entry: NpcText = WorldDatabaseManager.QuestGossipHolder.npc_text_get_by_id(text_entry)

        # Gameobjects quest starters don't have this.
        if not quest_giver_text_entry:
            return False, '', 0

        quest_giver_greeting = QuestManager._gossip_text_choose_by_gender(quest_giver, quest_giver_text_entry)

        return True if quest_giver_gossip_entry else False, quest_giver_greeting, quest_giver_text_entry.em0_0

    @staticmethod
    def _gossip_text_choose_by_gender(quest_giver, text: NpcText):
        # Text based on gender.
        male_greeting = text.text0_0
        female_greeting = text.text0_1
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
            # If male or agnostic to gender.
            if quest_giver.gender == UnitCodes.Genders.GENDER_MALE or not female_greeting:
                return male_greeting
            else:
                return female_greeting
        return male_greeting

    # Quest status only works for units, sending a gameobject guid crashes the client.
    def update_surrounding_quest_status(self):
        known_objects = self.player_mgr.known_objects

        for guid, world_object in list(known_objects.items()):
            if world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
                unit = world_object
                if WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(
                        unit.entry) or WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(unit.entry):
                    quest_status = self.get_dialog_status(unit)
                    self.send_quest_giver_status(guid, quest_status)
            # Make the owner refresh gameobject dynamic flags if needed.
            # We can't detect dynamic flag changes, since it is unique for each observer.
            elif world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
                gameobject = world_object
                if gameobject.gobject_template.type == GameObjectTypes.TYPE_CHEST or \
                        gameobject.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER:
                    self.player_mgr.update_world_object_on_me(gameobject, has_changes=True)

    # Send item query details and return item struct byte segments.
    def _gen_item_struct(self, item_entry, count):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        display_id = 0
        if item_template:
            display_id = item_template.display_id
            query_data = ItemManager.generate_query_details_data(item_template)
            self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data))

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

        # Client has a 256 characters limitation, truncate.
        if len(message_bytes) > 256:
            message_bytes = message_bytes[:255] + b'\x00'

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
        for index in range(1, 5):
            detail_emote = int(eval(f'quest_template.DetailsEmote{index}'))
            detail_emote_delay = eval(f'quest_template.DetailsEmoteDelay{index}')
            data += pack('<2I', detail_emote, detail_emote_delay)

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

            # Send query details for gameobjects and creatures in case they are out of range.
            if creature_or_go < 0:
                go_template = WorldDatabaseManager.GameobjectTemplateHolder.gameobject_get_by_entry(-creature_or_go)
                if go_template:
                    self.player_mgr.enqueue_packet(GoQueryUtils.query_details(gobject_template=go_template))
            elif creature_or_go > 0:
                creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_or_go)
                if creature_template:
                    self.player_mgr.enqueue_packet(UnitQueryUtils.query_details(creature_template))

        # Objective texts.
        req_objective_text_list = QuestHelpers.generate_objective_text_list(quest)
        for index, objective_text in enumerate(req_objective_text_list):
            req_objective_text_bytes = PacketWriter.string_to_bytes(req_objective_text_list[index])
            data += pack(
                f'{len(req_objective_text_bytes)}s',
                req_objective_text_bytes
            )

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUEST_QUERY_RESPONSE, data))

    def send_quest_giver_request_items(self, quest, quest_giver_id, close_on_cancel):
        # We can always call to RequestItems, but this packet only goes out if there are actually
        # items.  Otherwise, we'll skip straight to the OfferReward.
        quest_title = quest.Title
        request_items_text = quest.RequestItemsText
        is_completable = quest.entry in self.active_quests and self.active_quests[quest.entry].is_quest_complete(quest_giver_id)

        # Not completable by normal means, check if this is an instant quest that requires items.
        if not is_completable and not QuestHelpers.is_instant_with_no_requirements(quest):
            if QuestHelpers.has_item_requirements(quest):
                is_completable = QuestHelpers.has_required_items_for_quest(self.player_mgr, quest)

        # Doesn't have request items text or does not require items and is completable, offer reward.
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
            close_on_cancel,  # Close Window after cancel
        )

        req_items = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(quest)))
        req_items_count_list = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(quest)))
        data += pack('<I', len(req_items))
        for index in range(len(req_items)):
            data += self._gen_item_struct(req_items[index], req_items_count_list[index])

        data += pack(
            '<3I',
            0x02,  # MaskMatch
            0x03 if is_completable else 0x00,  # Completable = Player has items?
            0x04,  # HasFaction
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_REQUEST_ITEMS, data)
        self.player_mgr.enqueue_packet(packet)

    def send_quest_giver_offer_reward(self, quest, quest_giver_guid, enable_next=True):
        # Validate if its active to player and if it's an instant complete quest.
        if quest.entry not in self.active_quests and not QuestHelpers.is_instant_complete_quest(quest):
            return

        # If this request is from an active quest (not an automatic instant complete dialog) validate again.
        if quest.entry in self.active_quests:
            # While the dialog was open displaying 'Quest Complete' the user destroyed items.
            # Validate if this quest can be completed.
            active_quest = self.active_quests[quest.entry]
            if not active_quest.can_complete_quest():
                self.send_cant_take_quest_response(QuestFailedReasons.QUEST_FAILED_MISSING_ITEMS)
                return

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
            offer_emote = eval(f'quest.OfferRewardEmote{i}')
            offer_emote_delay = eval(f'quest.OfferRewardEmoteDelay{i}')
            data += pack('<2I', offer_emote, offer_emote_delay)

        if QuestHelpers.has_pick_reward(quest):
            # Reward choices
            rew_choice_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_item_list(quest)))
            rew_choice_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_count_list(quest)))
            data += pack('<I', len(rew_choice_item_list))
            for index, item in enumerate(rew_choice_item_list):
                data += self._gen_item_struct(item, rew_choice_count_list[index])
        else:
            data += pack('<I', 0)

        #  Apart from available rewards to pick from, sometimes there are rewards you will also get, no matter what.
        if QuestHelpers.has_item_reward(quest):
            # Required items
            rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(quest)))
            rew_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(quest)))
            data += pack('<I', len(rew_item_list))
            for index, item in enumerate(rew_item_list):
                data += self._gen_item_struct(item, rew_count_list[index])
        else:
            data += pack('<I', 0)

        # Reward Money, 0.5.3 does not handle spells as a possible reward. CGPlayer_C::OnQuestGiverChooseReward.
        data += pack('<I', quest.RewOrReqMoney if quest.RewOrReqMoney >= 0 else -quest.RewOrReqMoney)
        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_OFFER_REWARD, data))

    def handle_accept_quest(self, quest_id, quest_giver_guid, shared=False, quest_giver=None, is_item=False):
        if quest_id in self.active_quests:
            self.send_cant_take_quest_response(QuestFailedReasons.QUEST_ALREADY_ON)
            return

        if quest_id in self.completed_quests:
            self.send_cant_take_quest_response(QuestFailedReasons.QUEST_ONLY_ONE_TIMED)
            return

        quest_item_starter = None if not is_item else quest_giver
        # Look for unit quest giver if it was not provided.
        if quest_giver_guid and not quest_giver:
            quest_giver = None
            high_guid = GuidUtils.extract_high_guid(quest_giver_guid)

            if high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(self.player_mgr, quest_giver_guid)
            elif high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(self.player_mgr, quest_giver_guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                quest_giver = self.player_mgr.inventory.get_item_by_guid(quest_giver_guid)
                quest_item_starter = quest_giver

            if not quest_giver:
                return

        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
        if not quest:
            return

        req_src_item = quest.SrcItemId
        req_src_item_count = quest.SrcItemCount
        if req_src_item != 0:
            # Check if the required source item is the item quest starter, else check if we can add it to the inventory.
            if not quest_item_starter or quest_item_starter.entry != req_src_item:
                if not self.player_mgr.inventory.add_item(req_src_item, count=req_src_item_count):
                    return
                # If the quest source item isn't required for the quest, remove it.
                if quest_item_starter:
                    self.player_mgr.inventory.remove_item(quest_item_starter.item_instance.bag,
                                                          quest_item_starter.item_instance.slot)

        active_quest = self._create_db_quest_status(quest)
        active_quest.save(is_new=True)
        self.add_to_quest_log(quest_id, active_quest)
        self.send_quest_query_response(quest)

        # Don't run scripts if not directly taken from NPC (either by sharing or .qadd command).
        # Otherwise the quest_giver would be None and this leads to a crash.
        if quest_giver:
            quest_giver.script_handler.enqueue_scripts(quest_giver, self.player_mgr,
                                                       ScriptTypes.SCRIPT_TYPE_QUEST_START, quest_id)

        # If player is in a group and quest has QUEST_FLAGS_PARTY_ACCEPT flag, let other members accept it too.
        if self.player_mgr.group_manager and not shared:
            quest_template = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
            if quest_template and quest_template.QuestFlags & QuestFlags.QUEST_FLAGS_PARTY_ACCEPT:
                self.share_quest_event(active_quest)

        # Check if the player already has related items.
        active_quest.update_required_items_from_inventory()
        if active_quest.can_complete_quest():
            self.complete_quest(active_quest, update_surrounding=False)

        self.update_surrounding_quest_status()

    def share_quest_event(self, active_quest):
        title_bytes = PacketWriter.string_to_bytes(active_quest.quest.Title)
        data = pack(f'<I{len(title_bytes)}sQ', active_quest.quest.entry, title_bytes, self.player_mgr.guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUEST_CONFIRM_ACCEPT, data)

        for guid in [*self.player_mgr.group_manager.members]:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(guid)
            if self.player_mgr.group_manager.is_close_member(self.player_mgr, player_mgr):
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
            self.remove_from_quest_log(quest_entry)
            RealmDatabaseManager.character_delete_quest(self.player_mgr.guid, quest_entry)

    def handle_complete_quest(self, quest_id, quest_giver_guid):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)

        # Validate if quest exists.
        if not quest:
            return

        # If not an instant complete quest, validate it.
        if not QuestHelpers.is_instant_complete_quest(quest):
            if quest_id not in self.active_quests and quest_id not in self.completed_quests:
                self.send_quest_giver_quest_details(quest, quest_giver_guid, activate_accept=True)
                return

            active_quest = self.active_quests[quest_id]
            if not active_quest.is_quest_complete(quest_giver_guid):
                self.send_quest_giver_request_items(quest, quest_giver_guid, close_on_cancel=False)
                return

        if quest_id in self.active_quests and self.active_quests[quest_id].requires_items():
            self.send_quest_giver_request_items(quest, quest_giver_guid, close_on_cancel=False)
        else:
            self.send_quest_giver_offer_reward(quest, quest_giver_guid, True)

    def handle_request_reward(self, quest_giver_guid, quest_id):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)

        # Validate if quest exists.
        if not quest:
            return

        if quest_id in self.active_quests:
            if not self.active_quests[quest_id].can_complete_quest():
                return

        self.send_quest_giver_offer_reward(quest, quest_giver_guid, True)

    def handle_choose_reward(self, quest_giver, quest_id, item_choice):
        quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_id)
        if not quest:
            return

        # If this is an instant complete quest, load or create its db state.
        if QuestHelpers.is_instant_complete_quest(quest) and quest_id not in self.active_quests:
            db_quest = RealmDatabaseManager.character_get_quest_by_id(self.player_mgr.guid, quest_id)
            if db_quest:
                self.active_quests[quest_id] = ActiveQuest(db_quest, self.player_mgr, quest)
            else:
                self.active_quests[quest_id] = self._create_db_quest_status(quest)
                self.active_quests[quest_id].save(is_new=True)

        # TODO: Mysterious Dovah crash, no one can reproduce.
        #  https://www.youtube.com/watch?v=vGtCHEKg9Qk
        if quest_id not in self.active_quests:
            Logger.error(f'Unable to locate active quest for id {quest_id}.')
            return

        active_quest = self.active_quests[quest_id]
        if not active_quest.is_quest_complete(quest_giver.guid):
            if not QuestHelpers.is_instant_with_no_requirements(quest):
                if not QuestHelpers.has_required_items_for_quest(self.player_mgr, quest):
                    return
            else:
                return

        # Check chosen reward item.
        reward_items = {}
        rew_item_choice_list = list(filter((0).__ne__, QuestHelpers.generate_rew_choice_item_list(quest)))

        if item_choice < len(rew_item_choice_list) and rew_item_choice_list[item_choice] > 0:
            reward_items[rew_item_choice_list[item_choice]] = 1

        # Check not chosen reward item(s).
        rew_item_list = list(filter((0).__ne__, QuestHelpers.generate_rew_item_list(quest)))
        rew_item_count_list = list(filter((0).__ne__, QuestHelpers.generate_rew_count_list(quest)))
        for index, rew_item in enumerate(rew_item_list):
            reward_items[rew_item_list[index]] = rew_item_count_list[index]

        # Check required quest items.
        required_items = {}
        req_item_list = QuestHelpers.generate_req_item_list(quest)
        req_item_count = QuestHelpers.generate_req_item_count_list(quest)
        for index, req_item in enumerate(req_item_list):
            if req_item != 0:
                required_items[req_item] = req_item_count[index]

        # Check if the rewards will fit player inventory.
        remaining_inventory_space = self.player_mgr.inventory.get_remaining_space()
        if len(reward_items) > remaining_inventory_space:
            self.player_mgr.inventory.send_equip_error(InventoryError.BAG_INV_FULL)
            return

        given_xp = active_quest.reward_xp()
        given_gold = active_quest.reward_gold()
        active_quest.reward_reputation()

        # Update db quest status as rewarded.
        active_quest.update_quest_status(rewarded=True)

        data = pack(
            '<4I',
            quest_id,
            3,  # Investigate
            int(given_xp * config.Server.Settings.xp_rate),
            given_gold
        )

        # Remove required quest items from player inventory.
        for req_item, count in required_items.items():
            self.player_mgr.inventory.remove_items(req_item, count)

        # Quest item(s) rewards. (Client will announce them).
        data += pack('<I', len(rew_item_list))
        for rew_item, count in reward_items.items():
            data += pack('<2I', rew_item, count)
            self.player_mgr.inventory.add_item(entry=rew_item, count=count, show_item_get=False)

        self.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTGIVER_QUEST_COMPLETE, data))

        # Cast spell if needed.
        if active_quest.quest.RewSpellCast:
            self.cast_reward_spell(quest_giver.guid, active_quest)

        if quest_giver.script_handler:
            quest_giver.script_handler.enqueue_scripts(quest_giver, self.player_mgr, ScriptTypes.SCRIPT_TYPE_QUEST_END,
                                                       quest_id)

        # Remove from active quests if needed.
        if quest.entry in self.active_quests:
            self.remove_from_quest_log(quest_id)

        if not QuestHelpers.is_quest_repeatable(active_quest.quest):
            self.completed_quests.add(quest_id)
        # Repeatable quests are not persisted.
        else:
            RealmDatabaseManager.character_delete_quest(self.player_mgr.guid, quest_id)

        # Update surrounding status.
        self.update_surrounding_quest_status()

        # Send next quest in chain if possible.
        next_quest = self.get_next_quest_in_chain(quest_giver, quest)
        if next_quest:
            self.send_quest_giver_quest_details(next_quest, quest_giver.guid, True)

    def get_next_quest_in_chain(self, quest_giver, current_quest):
        # Current quest has no linked next quest.
        if not current_quest.NextQuestInChain:
            return None

        relations_list = QuestManager.get_quest_giver_relations(quest_giver)

        # Start quests lookup set.
        quest_giver_start_quests = {start_quest[1] for start_quest in relations_list if len(start_quest) > 0}

        # Quest start.
        for quest_entry in quest_giver_start_quests:
            quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(quest_entry)
            if not quest:
                continue
            if quest_entry in self.completed_quests and not QuestHelpers.is_quest_repeatable(quest):
                continue
            # Check quest requirements including quest level.
            if not self.check_quest_requirements(quest) or not self.check_quest_level(quest, False):
                continue
            if quest_entry == current_quest.NextQuestInChain:
                return quest

        return None

    # Quest starters.
    @staticmethod
    def get_quest_giver_relations(quest_giver: ObjectManager):
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
            return WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            return WorldDatabaseManager.QuestRelationHolder.gameobject_quest_starter_get_by_entry(quest_giver.entry)
        else:
            return []

    # Quest finishers.
    @staticmethod
    def get_quest_giver_involved_relations(quest_giver: ObjectManager):
        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT:
            return WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            return WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(quest_giver.entry)
        else:
            return []

    def cast_reward_spell(self, quest_giver_guid, active_quest):
        quest_giver_unit = MapManager.get_surrounding_unit_by_guid(self.player_mgr, quest_giver_guid)
        if quest_giver_unit:
            quest_giver_unit.spell_manager.handle_cast_attempt(active_quest.quest.RewSpellCast, self.player_mgr,
                                                               SpellTargetMask.UNIT, validate=False)

    def remove_from_quest_log(self, quest_id):
        if quest_id in self.active_quests:
            del self.active_quests[quest_id]
            self.build_update()
            self.update_surrounding_quest_status()

    def add_to_quest_log(self, quest_id, active_quest):
        self.active_quests[quest_id] = active_quest
        self.build_update()

    def pop_item(self, item_entry):
        should_update = False
        for active_quest in list(self.active_quests.values()):
            if active_quest.requires_item(item_entry):
                active_quest.update_required_items_from_inventory()
                should_update = True

        if should_update:
            self.update_surrounding_quest_status()

    def reward_item(self, item_entry, item_count):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        if not item_template:
            return False

        for quest_id, active_quest in self.active_quests.items():
            if active_quest.still_needs_item(item_template):
                active_quest.update_item_count(item_entry, item_count)
                self.update_single_quest(quest_id)
                # If by this item we complete the quest, update surrounding so NPC can display new complete status.
                if active_quest.can_complete_quest():
                    self.complete_quest(active_quest, update_surrounding=True, notify=True)
                return True
        return False

    def handle_goober_use(self, gameobject, quest_id=0):
        return self.reward_creature_or_go(gameobject, quest_id)

    def reward_creature_or_go(self, world_object, to_quest_id=0):
        for quest_id, active_quest in self.active_quests.items():
            if to_quest_id and quest_id != to_quest_id:
                continue
            if active_quest.requires_creature_or_go(world_object):
                active_quest.update_creature_go_count(world_object, 1)
                self.update_single_quest(quest_id)
                # If by this kill we complete the quest, update surrounding so NPC can display new complete status.
                if active_quest.can_complete_quest():
                    self.complete_quest(active_quest, update_surrounding=True, notify=True)
                return True
        return False

    def reward_quest_exploration(self, area_trigger_id):
        for quest_id, active_quest in self.active_quests.items():
            if QuestHelpers.is_exploration_quest(active_quest.quest) \
                    and active_quest.apply_exploration_completion(area_trigger_id):
                if active_quest.can_complete_quest():
                    self.complete_quest(active_quest, update_surrounding=True, notify=True)
                    self.update_single_quest(quest_id)

    def complete_quest_by_id(self, quest_id):
        if quest_id not in self.active_quests:
            return
        active_quest = self.active_quests.get(quest_id)
        self.complete_quest(active_quest, update_surrounding=True, notify=True)
        self.update_single_quest(quest_id)

    def complete_quest(self, active_quest, update_surrounding=False, notify=False):
        active_quest.update_quest_state(QuestState.QUEST_REWARD)

        if notify:
            data = pack('<I', active_quest.quest.entry)
            packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_COMPLETE, data)
            self.player_mgr.enqueue_packet(packet)

        if update_surrounding:
            self.update_surrounding_quest_status()

    def item_needed_by_quests(self, item_entry):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)
        if not item_template:
            return False

        # Always allow items that are quest starters.
        if item_template.start_quest > 0:
            return True

        for active_quest in list(self.active_quests.values()):
            if active_quest.still_needs_item(item_template):
                return True
        return False

    def update(self, elapsed):
        self.last_timer_update += elapsed

        # Every second.
        if self.last_timer_update >= 1:
            for active_quest in list(self.active_quests.values()):
                if QuestHelpers.is_timed_quest(active_quest.quest):
                    active_quest.update_timer(self.last_timer_update)

            self.last_timer_update = 0

    def update_single_quest(self, quest_id, slot=-1):
        progress = 0
        timer = 0
        if quest_id in self.active_quests:
            progress = self.active_quests[quest_id].get_progress()
            timer = self.active_quests[quest_id].get_timer()
            if slot == -1:
                slot = list(self.active_quests.keys()).index(quest_id)

        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6), quest_id)
        # TODO Finish / investigate below values
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 1, 0)  # quest giver ID ?
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 2, 0)  # quest rewarder ID ?
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 3, progress)  # quest progress
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 4, timer)  # quest time failure
        self.player_mgr.set_uint32(PlayerFields.PLAYER_QUEST_LOG_1_1 + (slot * 6) + 5, 0)  # number of mobs to kill

    def build_update(self):
        active_quest_list = list(self.active_quests.keys())
        for slot in range(MAX_QUEST_LOG):
            self.update_single_quest(active_quest_list[slot] if slot < len(active_quest_list) else 0, slot)

    def save(self):
        [quest.save() for quest in list(self.active_quests.values())]

    def _create_db_quest_status(self, quest):
        db_quest_status = CharacterQuestState()
        db_quest_status.guid = self.player_mgr.guid
        db_quest_status.quest = quest.entry
        db_quest_status.timer = quest.LimitTime
        if quest.Method == QuestMethod.QUEST_AUTOCOMPLETE:
            db_quest_status.state = QuestState.QUEST_REWARD.value
        else:
            db_quest_status.state = QuestState.QUEST_ACCEPTED.value
        return ActiveQuest(db_quest_status, self.player_mgr, quest)
