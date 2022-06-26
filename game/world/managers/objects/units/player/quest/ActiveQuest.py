from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeIds, QuestFlags
from utils.constants.MiscCodes import HighGuid
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.player.quest.QuestHelpers import QuestHelpers
from network.packet.PacketWriter import PacketWriter, OpCode
from utils import Formulas
from utils.constants.MiscCodes import QuestState


class ActiveQuest:
    def __init__(self, quest_db_state, player_mgr, quest):
        self.owner = player_mgr
        self.db_state = quest_db_state
        self.quest = quest
        self.area_triggers = None
        self.failed = False
        if self.is_exploration_quest():
            self.load_area_triggers()

    def load_area_triggers(self):
        if self.quest.entry in WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION:
            self.area_triggers = WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[self.quest.entry]
        else:
            Logger.warning(f'Unable to locate area trigger/s for quest {self.quest.entry}')

    def is_exploration_quest(self):
        return self.quest.QuestFlags & QuestFlags.QUEST_FLAGS_EXPLORATION

    def is_quest_complete(self, quest_giver_guid):
        quest_giver = None
        high_guid = ObjectManager.extract_high_guid(quest_giver_guid)

        if high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
            quest_giver = MapManager.get_surrounding_gameobject_by_guid(self.owner, quest_giver_guid)
        elif high_guid == HighGuid.HIGHGUID_UNIT:
            quest_giver = MapManager.get_surrounding_unit_by_guid(self.owner, quest_giver_guid)

        if not quest_giver:
            return False

        if QuestHelpers.is_instant_complete_quest(self.quest):
            return True

        if self.db_state.state != QuestState.QUEST_REWARD:
            return False

        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT and quest_giver.get_type_id() != ObjectTypeIds.ID_PLAYER:
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(quest_giver.entry)
        else:
            return False

        # Return if this quest is finished by this quest giver.
        return self.quest.entry in {quest_entry[1] for quest_entry in involved_relations_list}

    def apply_exploration_completion(self, area_trigger_id):
        if self.area_triggers and area_trigger_id in self.area_triggers and \
                self.get_quest_state() != QuestState.QUEST_REWARD:
            self.update_quest_state(QuestState.QUEST_REWARD)
            return True
        return False

    def need_item_from_go(self, quest_giver, go_loot_template):
        # Quest is complete.
        if self.is_quest_complete(quest_giver):
            return False

        needed_items = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(self.quest)))

        # Not required items for this quest.
        if len(needed_items) == 0:
            return False

        # Check if any needed items match the provided go_loot_template.
        for entry in go_loot_template:
            if entry.item in needed_items:
                return True

        return False

    def reward_gold(self):
        if self.quest.RewOrReqMoney > 0:
            self.owner.mod_money(self.quest.RewOrReqMoney)
        return self.quest.RewOrReqMoney

    def reward_xp(self):
        xp = Formulas.PlayerFormulas.quest_xp_reward(self.quest.QuestLevel, self.owner.level, self.quest.RewXP)
        self.owner.give_xp([xp], notify=False)
        return xp

    def update_creature_go_count(self, creature, value):
        creature_go_index = QuestHelpers.generate_req_creature_or_go_list(self.quest).index(creature.entry)
        required = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)[creature_go_index]
        current = self._get_db_mob_or_go_count(creature_go_index)
        # Current < Required is already validated on requires_creature_or_go().
        self._update_db_creature_go_count(creature_go_index, 1)  # Update db memento
        # Notify the current objective count to the player.
        data = pack('<4IQ', self.db_state.quest, creature.entry, current + value, required, creature.guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_ADD_KILL, data)
        self.owner.enqueue_packet(packet)
        # Check if this makes it complete.
        if self.can_complete_quest():
            self.update_quest_state(QuestState.QUEST_REWARD)

    def _update_db_creature_go_count(self, index, value):
        if index == 0:
            self.db_state.mobcount1 += value
        elif index == 1:
            self.db_state.mobcount2 += value
        elif index == 2:
            self.db_state.mobcount3 += value
        elif index == 3:
            self.db_state.mobcount4 += value
        self.save()

    def update_item_count(self, item_entry, quantity):
        req_items = QuestHelpers.generate_req_item_list(self.quest)
        req_count = QuestHelpers.generate_req_item_count_list(self.quest)
        req_item_index = req_items.index(item_entry)
        # Persist new item count.
        self._update_db_item_count(req_item_index, quantity, req_count[req_item_index])  # Update db memento
        # Notify the current item count to the player.
        data = pack('<2I', item_entry, quantity)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_ADD_ITEM, data)
        self.owner.enqueue_packet(packet)
        # Check if this makes it complete.
        if self.can_complete_quest():
            self.update_quest_state(QuestState.QUEST_REWARD)

    # noinspection PyUnusedLocal
    def _update_db_item_count(self, index, value, required_count, override=False):
        if not override:
            current_db_count = self._get_db_item_count(index)
            value = current_db_count + value

        # Make sure we clamp between 0 and required.
        new_count = max(0, min(value, required_count))
        exec(f'self.db_state.itemcount{index + 1} = {new_count}')
        self.save(is_new=False)

    # noinspection PyMethodMayBeStatic
    def _get_db_item_count(self, index):
        return eval(f'self.db_state.itemcount{index + 1}')

    # noinspection PyMethodMayBeStatic
    def _get_db_mob_or_go_count(self, index):
        return eval(f'self.db_state.mobcount{index + 1}')

    def get_quest_state(self):
        return self.db_state.state

    def get_is_quest_rewarded(self):
        return self.db_state.rewarded == 1

    def update_quest_state(self, quest_state):
        self.db_state.state = quest_state.value
        self.save()

    def update_quest_status(self, rewarded):
        self.db_state.rewarded = 1 if rewarded else 0
        self.save()

    def save(self, is_new=False):
        if is_new:
            RealmDatabaseManager.character_add_quest_status(self.db_state)
        else:
            RealmDatabaseManager.character_update_quest_status(self.db_state)

    # TODO: Should handle other types of quests here: exploration, game object related, item usage, etc.
    def can_complete_quest(self):
        if QuestHelpers.is_instant_complete_quest(self.quest):
            return True

        # Check for required kills / gameobjects.
        required_creature_go = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for i in range(4):
            current_value = eval(f'self.db_state.mobcount{i + 1}')
            if current_value < required_creature_go[i]:
                return False

        # Check for required items.
        required_items = QuestHelpers.generate_req_item_count_list(self.quest)
        for i in range(4):
            current_value = eval(f'self.db_state.itemcount{i + 1}')
            if current_value < required_items[i]:
                return False

        # Handle exploration.
        if self.quest.QuestFlags & QuestFlags.QUEST_FLAGS_EXPLORATION:
            if self.get_quest_state() != QuestState.QUEST_REWARD:
                return False

        # TODO: Check ReqMoney
        return True

    def requires_creature_or_go(self, creature_entry):
        req_creature_or_go = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        required = creature_entry in req_creature_or_go
        if required:
            index = req_creature_or_go.index(creature_entry)
            required_kills = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)[index]
            current_kills = eval(f'self.db_state.mobcount{index + 1}')
            return current_kills < required_kills
        return False

    def still_needs_item(self, item_entry):
        req_item = QuestHelpers.generate_req_item_list(self.quest)
        required = item_entry in req_item
        if required:
            index = req_item.index(item_entry)
            required_items = QuestHelpers.generate_req_item_count_list(self.quest)[index]
            current_items = self._get_db_item_count(index)
            return current_items < required_items

    def update_required_items_from_inventory(self):
        req_item = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(self.quest)))
        req_count = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(self.quest)))
        for index, item in enumerate(req_item):
            current_count = self.owner.inventory.get_item_count(item)
            self._update_db_item_count(index, current_count, req_count[index], override=True)
        if self.can_complete_quest():
            self.update_quest_state(QuestState.QUEST_REWARD)
        else:
            self.update_quest_state(QuestState.QUEST_ACCEPTED)

    def requires_item(self, item_entry):
        req_item = QuestHelpers.generate_req_item_list(self.quest)
        req_src_item = QuestHelpers.generate_req_source_list(self.quest)
        return item_entry in req_item or item_entry in req_src_item

    # What's happening inside get_progress():
    # Required MobKills1 = 5
    # Required MobKills2 = 12
    # No Kills:					             Mob2                 Mob1
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 0 0 0] [0 0 0 0 0]
    # 1 kill on each
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 0 0 1] [0 0 0 0 1]
    # 3 kills on each
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 1 1 1] [0 0 1 1 1]
    def get_progress(self):
        total_count = 0

        # Handle exploration, all bits set if completed.
        if self.is_exploration_quest() and self.get_quest_state() == QuestState.QUEST_REWARD:
            return total_count ^ 0xFFFFFFFF

        # Creature or gameobject.
        req_creature_or_go = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        req_creature_or_go_count = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for index, creature_or_go in enumerate(req_creature_or_go):
            if req_creature_or_go[index] > 0:
                current_count = eval(f'self.db_state.mobcount{index + 1}')
                required = req_creature_or_go_count[index]
                # Consider how many bits the previous creature required.
                offset = index * req_creature_or_go_count[index - 1] if index > 0 else 0

                for i in range(required):
                    if i < current_count:  # Turn on actual kills
                        total_count += (1 & 1) << (1 * i) + offset
                    else:  # Fill remaining 0s (Missing kills)
                        total_count += 0 << (1 * i) + offset

                # Debug, enable this to take a look on whats happening at bit level.
                # Logger.debug(f'{bin(mob_kills)[2:].zfill(32)}')

        return total_count
