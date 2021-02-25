from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterSkill
from database.world.WorldDatabaseManager import WorldDatabaseManager
from utils.constants.ObjectCodes import SkillTypes
from utils.constants.UpdateFields import PlayerFields


class SkillManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.skills = {}

    def load_skills(self):
        for skill in RealmDatabaseManager.character_get_skills(self.player_mgr.guid):
            self.skills[skill.skill] = skill
        self.build_skill_update()

    def add_skill(self, skill_id):
        # Skill already learnt
        if skill_id in self.skills:
            return

        skill = DbcDatabaseManager.skill_get_by_id(skill_id)
        if not skill:
            return

        start_rank_value = 1
        if skill.CategoryID == SkillTypes.MAX_SKILL:
            start_rank_value = skill.MaxRank

        skill_to_set = CharacterSkill()
        skill_to_set.guid = self.player_mgr.guid
        skill_to_set.skill = skill_id
        skill_to_set.value = start_rank_value
        skill_to_set.max = skill.MaxRank

        RealmDatabaseManager.character_add_skill(skill_to_set)

        self.skills[skill_id] = skill_to_set

    def set_skill(self, skill_id, current_value, max_value=-1):
        if skill_id not in self.skills:
            return

        skill = self.skills[skill_id]
        skill.value = current_value
        if max_value > 0:
            skill.max = max_value

        RealmDatabaseManager.character_update_skill(skill)

    def update_skills_max_value(self):
        for skill_id, skill in self.skills.items():
            self.set_skill(skill_id, skill.value, SkillManager.get_max_rank(self.player_mgr.level, skill_id))

    @staticmethod
    def get_max_rank(player_level, skill_id):
        skill = DbcDatabaseManager.skill_get_by_id(skill_id)
        if not skill:
            return 0

        # Weapon, Defense, Spell
        if skill.SkillType == 0:
            return player_level * 5
        # Language, Riding, Secondary profs
        elif skill.SkillType == 4:
            # Language, Riding
            if skill.CategoryID == SkillTypes.MAX_SKILL:
                return skill.MaxRank
            else:
                return (player_level * 5) + 25

        return 0

    def can_dual_wield(self):
        # 118 is the Dual Wield skill
        return 118 in self.skills and self.player_mgr.level >= 10

    def build_skill_update(self):
        count = 0
        for skill_id, skill in self.skills.items():
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3),
                                       unpack('<I', pack('<2H', skill_id, skill.value))[0])
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 1,
                                       unpack('<I', pack('<2H', skill.max, 0))[0])  # max_rank, skill_mod
            self.player_mgr.set_uint32(PlayerFields.PLAYER_SKILL_INFO_1_1 + (count * 3) + 2,
                                       unpack('<I', pack('<2H', 0, 0))[0])  # skill_step, padding
            count += 1
