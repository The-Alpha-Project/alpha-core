from struct import pack
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.player.quest.QuestHelpers import QuestHelpers
from network.packet.PacketWriter import PacketWriter, OpCode
from utils import Formulas
from utils.constants.MiscCodes import QuestState


class ActiveQuest:
    def __init__(self, quest_db_state, player_mgr):
        self.owner = player_mgr
        self.db_state = quest_db_state
        self.quest = WorldDatabaseManager.QuestTemplateHolder.quest_get_by_entry(self.db_state.quest)

    def is_quest_complete(self, quest_giver_guid):
        if self.db_state.state != QuestState.QUEST_REWARD:
            return False
        # TODO: check that quest_giver_guid is turn-in for quest_id
        return True

    # Can't be static.
    def has_item_reward(self):
        for index in range(1, 5):
            if eval(f'self.quest.RewItemId{index}') > 0:
                return True
        return False

    # Can't be static.
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
        self.owner.give_xp([xp])
        return xp

    def update_creature_go_count(self, creature, value):
        creature_go_index = QuestHelpers.generate_req_creature_or_go_list(self.quest).index(creature.entry)
        required = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)[creature_go_index]
        current = eval(f'self.db_state.mobcount{creature_go_index + 1}')
        # Current < Required is already validate on requires_mob_kill()
        self._update_db_creature_go_count(creature_go_index, 1)  # Update db memento
        # Notify the current objective count to the player
        data = pack('<4IQ', self.db_state.quest, creature.entry, current + value, required, creature.guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_ADD_KILL, data)
        self.owner.session.enqueue_packet(packet)

    def _update_db_creature_go_count(self, index, value):
        # Can't assign value with dynamic func eval. :/
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
        req_item_index = req_items.index(item_entry)
        # Persist new item count
        self._update_db_item_count(req_item_index, quantity)  # Update db memento
        # Notify the current item count to the player
        data = pack('<2I', item_entry, quantity)  # TODO: Investigate, this counter is wrong.
        packet = PacketWriter.get_packet(OpCode.SMSG_QUESTUPDATE_ADD_ITEM, data)
        self.owner.session.enqueue_packet(packet)

    def _update_db_item_count(self, index, value):
        # Can't assign value with dynamic func eval. :/
        if index == 0:
            self.db_state.itemcount1 += value
        elif index == 1:
            self.db_state.itemcount2 += value
        elif index == 2:
            self.db_state.itemcount3 += value
        elif index == 3:
            self.db_state.itemcount4 += value
        self.save(is_new=False)

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

        # Check for required kills/go's
        required_creature_go = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for i in range(0, 4):
            current_value = eval(f'self.db_state.mobcount{i + 1}')
            if current_value != required_creature_go[i]:
                return False

        # Check for required items
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

    def requires_item(self, item_entry):
        req_item = QuestHelpers.generate_req_item_list(self.quest)
        required = item_entry in req_item
        if required:
            index = req_item.index(item_entry)
            required_items = QuestHelpers.generate_req_item_count_list(self.quest)[index]
            current_items = eval(f'self.db_state.itemcount{index + 1}')
            return current_items < required_items
        return False

    # TODO: This is wrong, need to figure how to properly fill the int, how many bits per counter, etc.
    #  1.12 implementations doesn't work here.
    def get_progress(self):
        required_bits = [0, 0, 0, 0]
        count = [0, 0, 0, 0]
        req_creature_or_go = QuestHelpers.generate_req_creature_or_go_list(self.quest)
        req_creature_or_go_count = QuestHelpers.generate_req_creature_or_go_count_list(self.quest)
        for index, creature_or_go in enumerate(req_creature_or_go):
            if req_creature_or_go[index] > 0:
                current_count = eval(f'self.db_state.mobcount{index + 1}')
                count[index] = current_count
                required_bits[index] = req_creature_or_go_count[index].bit_length()
            else:
                required_bits[index] = 8

        val = ((1 << count[0]) - 1) | ((1 << count[1]) - 1) << sum(required_bits[:2]) | ((1 << count[2]) - 1) << sum(required_bits[:3]) | ((1 << count[3]) - 1) << sum(required_bits)
        return val
