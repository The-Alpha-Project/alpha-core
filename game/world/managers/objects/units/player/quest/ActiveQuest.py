from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.player.quest.QuestHelpers import QuestHelpers
from network.packet.PacketWriter import PacketWriter, OpCode
from utils import Formulas
from utils.constants.MiscCodes import QuestState


class ActiveQuest:
    def __init__(self, quest_db_state, player_mgr, quest):
        self.owner = player_mgr
        self.db_state = quest_db_state
        self.quest = quest
        self.failed = False

    def is_quest_complete(self, quest_giver_guid):
        if self.db_state.state != QuestState.QUEST_REWARD:
            return False
        # TODO: check that quest_giver_guid is turn-in for quest_id
        return True

    def is_go_starter_finisher(self, relations_list, involved_relations_list):
        if relations_list:
            if self.quest.entry in [r.quest for r in relations_list]:
                return True
        if involved_relations_list:
            if self.quest.entry in [ir.quest for ir in involved_relations_list]:
                return True

        return False

    def need_item_from_go(self, go_loot_template):
        # Quest is complete.
        if self.is_quest_complete(0):
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

    # noinspection PyMethodMayBeStatic
    def has_item_reward(self):
        for index in range(1, 5):
            if eval(f'self.quest.RewItemId{index}') > 0:
                return True
        return False

    # noinspection PyMethodMayBeStatic
    def has_pick_reward(self):
        for index in range(1, 5):
            if eval(f'self.quest.RewChoiceItemId{index}') > 0:
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

    def _update_db_item_count(self, index, value, required_count=None):
        if not required_count:
            required_count = QuestHelpers.generate_req_item_count_list(self.quest)[index]

        # Be sure we clamp between 0 and required.
        current_db_count = self._get_db_item_count(index)
        if current_db_count + value > required_count:
            value = required_count
        if current_db_count + value < 0:
            value = 0

        if index == 0:
            self.db_state.itemcount1 += value
        elif index == 1:
            self.db_state.itemcount2 += value
        elif index == 2:
            self.db_state.itemcount3 += value
        elif index == 3:
            self.db_state.itemcount4 += value
        self.save(is_new=False)

    # noinspection PyMethodMayBeStatic
    def _get_db_item_count(self, index):
        return eval(f'self.db_state.itemcount{index + 1}')

    # noinspection PyMethodMayBeStatic
    def _get_db_mob_or_go_count(self, index):
        return eval(f'self.db_state.mobcount{index + 1}')

    def get_quest_state(self):
        return self.db_state.state

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

    def is_instant_complete_quest(self):
        for reqSource in QuestHelpers.generate_req_source_list(self.quest):
            if reqSource != 0:
                return False

        for reqItem in QuestHelpers.generate_req_item_list(self.quest):
            if reqItem != 0:
                return False

        for reqCreatureGo in QuestHelpers.generate_req_creature_or_go_list(self.quest):
            if reqCreatureGo != 0:
                return False

        for reqSpellCast in QuestHelpers.generate_req_spell_cast_list(self.quest):
            if reqSpellCast != 0:
                return False

        return True

    def can_complete_quest(self):
        if self.is_instant_complete_quest():
            return True

        # Check for required kills / gameobjects.
        required_creature_go = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for i in range(0, 4):
            current_value = eval(f'self.db_state.mobcount{i + 1}')
            if current_value != required_creature_go[i]:
                return False

        # Check for required items.
        required_items = QuestHelpers.generate_req_item_count_list(self.quest)
        for i in range(0, 4):
            current_value = eval(f'self.db_state.itemcount{i + 1}')
            if current_value != required_items[i]:
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

    def fill_existent_items(self):
        req_item = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(self.quest)))
        req_count = list(filter((0).__ne__, QuestHelpers.generate_req_item_count_list(self.quest)))
        for index, item in enumerate(req_item):
            current_count = self.owner.inventory.get_item_count(item)
            if current_count:
                self._update_db_item_count(index, current_count, req_count[index])

    def requires_item(self, item_entry):
        req_item = QuestHelpers.generate_req_item_list(self.quest)
        req_src_item = QuestHelpers.generate_req_source_list(self.quest)
        return item_entry in req_item or item_entry in req_src_item

    def pop_item(self, item_entry, count):
        req_item = QuestHelpers.generate_req_item_list(self.quest)
        required = item_entry in req_item
        if required:
            req_item_count = QuestHelpers.generate_req_item_count_list(self.quest)
            index = req_item.index(item_entry)
            current_count = self.owner.inventory.get_item_count(item_entry)
            if current_count - count < req_item_count[index]:
                self._update_db_item_count(index, -count, req_item_count[index])
                self.update_quest_state(QuestState.QUEST_ACCEPTED)
                return True
        return False

    # Whats happening inside get_progress():
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
        req_creature_or_go = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        req_creature_or_go_count = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for index, creature_or_go in enumerate(req_creature_or_go):
            if req_creature_or_go[index] > 0:
                current_count = eval(f'self.db_state.mobcount{index + 1}')
                required = req_creature_or_go_count[index]
                # Consider how many bits the previous creature required.
                offset = index * req_creature_or_go_count[index - 1] if index > 0 else 0

                for i in range(0, required):
                    if i < current_count:  # Turn on actual kills
                        total_count += (1 & 1) << (1 * i) + offset
                    else:  # Fill remaining 0s (Missing kills)
                        total_count += 0 << (1 * i) + offset

                # Debug, enable this to take a look on whats happening at bit level.
                # Logger.debug(f'{bin(mob_kills)[2:].zfill(32)}')

        return total_count
