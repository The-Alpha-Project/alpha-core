from functools import lru_cache
from utils.constants.MiscCodes import QuestSpecialFlags, QuestMethod, QuestFlags


class QuestHelpers:

    @staticmethod
    def can_ever_take_quest(quest_template, player_mgr):
        # First check if quest is disabled.
        if quest_template.Method == QuestMethod.QUEST_DISABLED:
            return False

        # Satisfies required race?
        race_is_required = quest_template.RequiredRaces > 0
        if race_is_required and not (quest_template.RequiredRaces & player_mgr.race_mask):
            return False

        # Satisfies required class?
        class_is_required = quest_template.RequiredClasses > 0
        if class_is_required and not (quest_template.RequiredClasses & player_mgr.class_mask):
            return False

        return True

    @staticmethod
    def is_instant_complete_quest(quest_template):
        return quest_template.Method == QuestMethod.QUEST_AUTOCOMPLETE

    @staticmethod
    @lru_cache
    def is_instant_with_no_requirements(quest_template):
        return QuestHelpers.is_instant_complete_quest(quest_template) and \
               not QuestHelpers.requires_items_creatures_or_gos(quest_template)

    @staticmethod
    def is_instant_requires_only_items(quest_template):
        return (QuestHelpers.is_instant_complete_quest(quest_template) and QuestHelpers.requires_items(quest_template)
                and not QuestHelpers.requires_creatures_or_gos(quest_template))

    @staticmethod
    @lru_cache
    def requires_items(quest_template):
        req_items = list(filter((0).__ne__, QuestHelpers.generate_req_item_list(quest_template)))
        return len(req_items) > 0

    @staticmethod
    def is_quest_repeatable(quest_template):
        return quest_template.SpecialFlags & QuestSpecialFlags.QUEST_SPECIAL_FLAG_REPEATABLE

    @staticmethod
    def is_event_quest(quest_template):
        return quest_template.SpecialFlags & QuestSpecialFlags.QUEST_SPECIAL_FLAG_SCRIPT

    @staticmethod
    def is_exploration_quest(quest_template):
        return quest_template.QuestFlags & QuestFlags.QUEST_FLAGS_EXPLORATION

    @staticmethod
    def is_exploration_or_event(quest_template):
        return QuestHelpers.is_exploration_quest(quest_template) or QuestHelpers.is_event_quest(quest_template)

    @staticmethod
    def is_timed_quest(quest_template):
        return quest_template.LimitTime > 0

    @staticmethod
    # noinspection PyUnusedLocal
    def has_required_items_for_quest(player_mgr, quest_template):
        for index in range(1, 5):
            req_item = getattr(quest_template, f'ReqItemId{index}')
            req_item_count = getattr(quest_template, f'ReqItemCount{index}')
            if req_item and not player_mgr.inventory.get_item_count(req_item) >= req_item_count:
                return False
        return True

    @staticmethod
    @lru_cache
    # noinspection PyUnusedLocal
    def has_item_reward(quest_template):
        for index in range(1, 5):
            if getattr(quest_template, f'RewItemId{index}') > 0:
                return True
        return False

    @staticmethod
    @lru_cache
    # noinspection PyUnusedLocal
    def requires_items_creatures_or_gos(quest_template):
        for index in range(1, 5):
            if getattr(quest_template, f'ReqItemId{index}') > 0:
                return True
            if getattr(quest_template, f'ReqCreatureOrGOId{index}') > 0:
                return True
        return False

    @staticmethod
    @lru_cache
    # noinspection PyUnusedLocal
    def requires_creatures_or_gos(quest_template):
        for index in range(1, 5):
            if getattr(quest_template, f'ReqCreatureOrGOId{index}') > 0:
                return True
        return False

    @staticmethod
    @lru_cache
    # noinspection PyUnusedLocal
    def has_pick_reward(quest_template):
        for index in range(1, 5):
            if getattr(quest_template, f'RewChoiceItemId{index}') > 0:
                return True
        return False

    @staticmethod
    @lru_cache
    def generate_rew_choice_item_list(quest_template):
        return [quest_template.RewChoiceItemId1, quest_template.RewChoiceItemId2, quest_template.RewChoiceItemId3, quest_template.RewChoiceItemId4,
                quest_template.RewChoiceItemId5, quest_template.RewChoiceItemId6]

    @staticmethod
    @lru_cache
    def generate_rew_choice_count_list(quest_template):
        return [quest_template.RewChoiceItemCount1, quest_template.RewChoiceItemCount2, quest_template.RewChoiceItemCount3,
                quest_template.RewChoiceItemCount4, quest_template.RewChoiceItemCount5, quest_template.RewChoiceItemCount6]

    @staticmethod
    @lru_cache
    def generate_rew_item_list(quest_template):
        return [quest_template.RewItemId1, quest_template.RewItemId2, quest_template.RewItemId3, quest_template.RewItemId4]

    @staticmethod
    @lru_cache
    def generate_rew_count_list(quest_template):
        return [quest_template.RewItemCount1, quest_template.RewItemCount2, quest_template.RewItemCount3, quest_template.RewItemCount4]

    @staticmethod
    @lru_cache
    def generate_req_item_list(quest_template):
        return [quest_template.ReqItemId1, quest_template.ReqItemId2, quest_template.ReqItemId3, quest_template.ReqItemId4]

    @staticmethod
    @lru_cache
    def generate_req_item_count_list(quest_template):
        return [quest_template.ReqItemCount1, quest_template.ReqItemCount2, quest_template.ReqItemCount3, quest_template.ReqItemCount4]

    @staticmethod
    @lru_cache
    def has_item_requirements(quest_template):
        return quest_template.ReqItemCount1 + quest_template.ReqItemCount2 + quest_template.ReqItemCount3 + quest_template.ReqItemCount4 > 0

    @staticmethod
    @lru_cache
    def generate_req_source_list(quest_template):
        return [quest_template.ReqSourceId1, quest_template.ReqSourceId2, quest_template.ReqSourceId3, quest_template.ReqSourceId4]

    @staticmethod
    @lru_cache
    def generate_req_source_count_list(quest_template):
        return [quest_template.ReqSourceCount1, quest_template.ReqSourceCount2, quest_template.ReqSourceCount3, quest_template.ReqSourceCount4]

    @staticmethod
    @lru_cache
    def generate_req_creature_or_go_list(quest_template):
        return [quest_template.ReqCreatureOrGOId1, quest_template.ReqCreatureOrGOId2, quest_template.ReqCreatureOrGOId3, quest_template.ReqCreatureOrGOId4]

    @staticmethod
    @lru_cache
    def generate_req_creature_or_go_count_list(quest_template):
        return [quest_template.ReqCreatureOrGOCount1, quest_template.ReqCreatureOrGOCount2, quest_template.ReqCreatureOrGOCount3,
                quest_template.ReqCreatureOrGOCount4]

    @staticmethod
    @lru_cache
    def generate_req_spell_cast_list(quest_template):
        return [quest_template.ReqSpellCast1, quest_template.ReqSpellCast2, quest_template.ReqSpellCast3, quest_template.ReqSpellCast4]

    @staticmethod
    @lru_cache
    def generate_objective_text_list(quest_template):
        return [quest_template.ObjectiveText1, quest_template.ObjectiveText2, quest_template.ObjectiveText3, quest_template.ObjectiveText4]

    @staticmethod
    @lru_cache
    def generate_rew_faction_reputation_list(quest_template):
        return [quest_template.RewRepFaction1, quest_template.RewRepFaction2, quest_template.RewRepFaction3,
                quest_template.RewRepFaction4, quest_template.RewRepFaction5]

    @staticmethod
    @lru_cache
    def generate_rew_faction_reputation_gain_list(quest_template):
        return [quest_template.RewRepValue1, quest_template.RewRepValue2, quest_template.RewRepValue3,
                quest_template.RewRepValue4, quest_template.RewRepValue5]
