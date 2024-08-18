import time
from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.GuidUtils import GuidUtils
from utils.constants.MiscCodes import ObjectTypeIds
from utils.constants.MiscCodes import HighGuid
from game.world.managers.objects.units.player.quest.QuestHelpers import QuestHelpers
from network.packet.PacketWriter import PacketWriter
from utils import Formulas
from utils.constants.MiscCodes import QuestState
from utils.constants.OpCodes import OpCode


class ActiveQuest:
    def __init__(self, quest_db_state, player_mgr, quest):
        self.owner = player_mgr
        self.quest_starter_entry = 0
        self.quest_finisher_entry = 0
        self.db_state = quest_db_state
        self.quest = quest
        self.area_triggers = None
        self.failed = False
        self.load_area_triggers()
        self.set_quest_givers_entries()

    def set_quest_givers_entries(self):
        self.quest_starter_entry = WorldDatabaseManager.QuestRelationHolder.creature_quest_starter_entry_by_quest(
            self.quest.entry)
        self.quest_finisher_entry = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_entry_by_quest(
            self.quest.entry)

    def load_area_triggers(self):
        if self.quest.entry not in WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION:
            return
        self.area_triggers = WorldDatabaseManager.QuestRelationHolder.AREA_TRIGGER_RELATION[self.quest.entry]

    def requires_area_trigger(self, trigger_id):
        return self.area_triggers and trigger_id in self.area_triggers and self.db_state.explored == 0

    def is_quest_complete(self, quest_giver_guid):
        quest_giver = None
        high_guid = GuidUtils.extract_high_guid(quest_giver_guid)

        if high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
            quest_giver = self.owner.get_map().get_surrounding_gameobject_by_guid(self.owner, quest_giver_guid)
        elif high_guid == HighGuid.HIGHGUID_UNIT or high_guid == HighGuid.HIGHGUID_PET:
            quest_giver = self.owner.get_map().get_surrounding_unit_by_guid(self.owner, quest_giver_guid)

        if not quest_giver:
            return False

        if self.db_state.state != QuestState.QUEST_REWARD:
            return False

        if quest_giver.get_type_id() == ObjectTypeIds.ID_UNIT and quest_giver.get_type_id() != ObjectTypeIds.ID_PLAYER:
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.creature_quest_finisher_get_by_entry(quest_giver.entry)
        elif quest_giver.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            involved_relations_list = WorldDatabaseManager.QuestRelationHolder.gameobject_quest_finisher_get_by_entry(quest_giver.entry)
        else:
            return False

        # Return if this quest is finished by this quest giver.
        if self.quest.entry not in {quest_entry[1] for quest_entry in involved_relations_list}:
            return False

        return self.can_complete_quest()

    def apply_exploration_completion(self, area_trigger_id):
        if self.area_triggers and area_trigger_id in self.area_triggers and not self.db_state.explored:
            self.set_explored_or_event_complete()
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

        req_count = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(self.quest)))
        # Check if any needed items match the provided go_loot_template and if the player still needs them.
        for entry in go_loot_template:
            if entry.item not in needed_items:
                continue
            index = needed_items.index(entry.item)
            req_count = req_count[index]
            count = self._get_db_item_count(index)
            if count < req_count:
                return True

        return False

    def reward_reputation(self):
        faction_reputation_rewards = QuestHelpers.generate_rew_faction_reputation_list(self.quest)
        faction_reputation_gain = QuestHelpers.generate_rew_faction_reputation_gain_list(self.quest)
        for index, faction in enumerate(faction_reputation_rewards):
            if faction:
                gain = faction_reputation_gain[index]
                self.owner.reputation_manager.modify_reputation(faction, gain)

    def reward_gold(self):
        if self.quest.RewOrReqMoney > 0:
            self.owner.mod_money(self.quest.RewOrReqMoney)
        return self.quest.RewOrReqMoney

    def reward_xp(self):
        xp = Formulas.PlayerFormulas.quest_xp_reward(self.quest.QuestLevel, self.owner.level, self.quest.RewXP)
        return self.owner.give_xp([xp], notify=False)

    def update_timer(self, elapsed):
        if self.failed:
            return
        self.db_state.timer = max(0, self.db_state.timer - elapsed)
        if not self.db_state.timer:
            self.failed = True

    def send_quest_failed(self):
        data = pack('<I', self.quest.entry)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_FAILED, data)
        self.owner.enqueue_packet(packet)

    def update_creature_go_count(self, world_object, value):
        # Creatures > 0, Gameobjects < 0.
        entry = world_object.entry if world_object.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT else -world_object.entry

        creature_go_index = QuestHelpers.generate_req_creature_or_go_list(self.quest).index(entry)
        required = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)[creature_go_index]
        current = self._get_db_mob_or_go_count(creature_go_index)
        # Current < Required is already validated on requires_creature_or_go().
        self._update_db_creature_go_count(creature_go_index, 1)  # Update db memento

        # Notify the current objective count to the player if this was a kill.
        if world_object.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT:
            data = pack('<4IQ', self.db_state.quest, world_object.entry, current + value, required, world_object.guid)
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
        # Only req items get persisted, not src items.
        if item_entry not in req_items:
            return
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
        setattr(self.db_state, f'itemcount{index + 1}', new_count)
        self.save(is_new=False)

    # noinspection PyMethodMayBeStatic
    def _get_db_item_count(self, index):
        return getattr(self.db_state, f'itemcount{index + 1}')

    # noinspection PyMethodMayBeStatic
    def _get_db_mob_or_go_count(self, index):
        return getattr(self.db_state, f'mobcount{index + 1}')

    def get_quest_state(self):
        return self.db_state.state

    def get_is_quest_rewarded(self):
        return self.db_state.rewarded == 1

    def update_quest_state(self, quest_state):
        self.db_state.state = quest_state.value
        self.save()

    def set_explored_or_event_complete(self):
        self.db_state.explored = 1
        self.save()

    def update_quest_status(self, rewarded: bool):
        self.db_state.rewarded = int(rewarded)
        self.save()

    def save(self, is_new=False):
        if is_new:
            RealmDatabaseManager.character_add_quest_status(self.db_state)
        else:
            RealmDatabaseManager.character_update_quest_status(self.db_state)

    def can_complete_quest(self):
        if self.failed:
            return False

        # Check for required kills / gameobjects.
        required_creature_go = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for i in range(1, 5):
            current_value = getattr(self.db_state, f'mobcount{i}')
            if current_value < required_creature_go[i]:
                return False

        # Check for required items.
        required_items_count = QuestHelpers.generate_req_item_count_list(self.quest)
        for i in range(1, 5):
            current_value = getattr(self.db_state, f'itemcount{i}')
            if current_value < required_items_count[i]:
                return False

        # Handle exploration.
        if QuestHelpers.is_exploration_or_event(self.quest) and not self.db_state.explored:
            return False

        # Timed quests.
        if QuestHelpers.is_timed_quest(self.quest) and self.db_state.timer <= 0:
            return False

        return True

    def requires_creature_or_go(self, world_object):
        # Creatures > 0, Gameobjects < 0.
        entry = world_object.entry if world_object.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT else -world_object.entry
        
        req_creatures_or_gos = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        required = entry in req_creatures_or_gos
        if required:
            index = req_creatures_or_gos.index(entry)
            required_qty = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)[index]
            current_qty = getattr(self.db_state, f'mobcount{index + 1}')
            return current_qty < required_qty
        return False

    def still_needs_item(self, item_template):
        item_entry = item_template.entry
        req_items = QuestHelpers.generate_req_item_list(self.quest)
        req_src_items = QuestHelpers.generate_req_source_list(self.quest)

        # Required items, based on db item count fields.
        required = item_entry in req_items
        if required:
            index = req_items.index(item_entry)
            required_items = QuestHelpers.generate_req_item_count_list(self.quest)[index]
            current_items = self._get_db_item_count(index)
            if current_items < required_items:
                return True

        # Required src item, based on owner inventory count.
        required = item_entry in req_src_items
        if required:
            index = req_src_items.index(item_entry)
            required_items = QuestHelpers.generate_req_source_count_list(self.quest)[index]
            current_items = self.owner.inventory.get_item_count(item_entry)

            # Unique item.
            if item_template.max_count and current_items < item_template.max_count:
                return True

            # Allows custom amount drop when not 0.
            if required_items and current_items < required_items:
                return True
            elif current_items < item_template.stackable:
                return True

        return False

    def update_required_items_from_inventory(self):
        req_items = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(self.quest)))
        req_count = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(self.quest)))
        for index, item in enumerate(req_items):
            current_count = self.owner.inventory.get_item_count(item)
            self._update_db_item_count(index, current_count, req_count[index], override=True)
        if self.can_complete_quest():
            self.update_quest_state(QuestState.QUEST_REWARD)
        else:
            self.update_quest_state(QuestState.QUEST_ACCEPTED)

    def requires_item(self, item_entry):
        req_items = QuestHelpers.generate_req_item_list(self.quest)
        req_src_items = QuestHelpers.generate_req_source_list(self.quest)
        return item_entry in req_items or item_entry in req_src_items

    def get_timer(self):
        if not QuestHelpers.is_timed_quest(self.quest):
            return 0
        return int(time.time()) + int(self.db_state.timer)

    # What's happening inside get_progress():
    # Required MobKills1 = 5
    # Required MobKills2 = 12
    # No Kills:					             Mob2                 Mob1
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 0 0 0] [0 0 0 0 0]
    # 1 kill on each.
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 0 0 1] [0 0 0 0 1]
    # 3 kills on each.
    # 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 [0 0 0 0 0 0 0 0 0 1 1 1] [0 0 1 1 1]
    # Extras:
    # Last bit ON (LittleEndian) = Failed
    # Bit before last ON (LE) = Completed
    def get_progress(self):
        if self.failed:
            return 1 << 31

        total_count = 0
        # Creature or gameobject.
        req_creature_or_go = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        req_creature_or_go_count = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        offset = 0
        for index, creature_or_go in enumerate(req_creature_or_go):
            if req_creature_or_go[index] == 0:
                continue
            current_count = getattr(self.db_state, f'mobcount{index + 1}')
            required = req_creature_or_go_count[index]
            # Consider how many bits the previous creature required.
            offset += req_creature_or_go_count[index - 1] if index > 0 else 0

            for i in range(required):
                if i < current_count:  # Turn on actual kills
                    total_count += (1 & 1) << (1 * i) + offset
                else:  # Fill remaining 0s (Missing kills)
                    total_count += 0 << (1 * i) + offset

        # Handle exploration / event. (Read 'Extras')
        if QuestHelpers.is_exploration_or_event(self.quest) and self.db_state.explored:
            total_count += 1 << 30

        # Debug, enable this to take a look on what's happening at bit level.
        # Logger.debug(f'{bin(total_count)[2:].zfill(32)}')

        return total_count
