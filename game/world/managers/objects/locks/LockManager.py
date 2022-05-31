from dataclasses import dataclass

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.units.player.SkillManager import SkillTypes
from utils.constants.MiscCodes import LockKeyTypes, LockType, ObjectTypeIds
from utils.constants.SpellCodes import SpellCheckCastResult


@dataclass
class OpenLockResult:
    result: SpellCheckCastResult = SpellCheckCastResult.SPELL_NO_ERROR
    skill_type: SkillTypes = SkillTypes.NONE
    required_skill_value: int = 0
    raw_skill_value: int = 0
    bonus_skill_value: int = 0


class LockManager:

    @staticmethod
    def can_open_lock(caster, lock_type, lock_id, cast_item=None, bonus_points=0) -> OpenLockResult:
        # Some cases for gameobjects and items.
        if not lock_id:
            return OpenLockResult(SpellCheckCastResult.SPELL_NO_ERROR)

        required_skill_value = 0
        raw_skill_value = 0
        bonus_skill_value = 0
        lock_info = DbcDatabaseManager.LocksHolder.get_lock_by_id(lock_id)
        if not lock_info:
            return OpenLockResult(SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)

        for index, _lock_type in enumerate(lock_info.types):
            # Check key item.
            if _lock_type == LockKeyTypes.LOCK_KEY_ITEM:
                if lock_info.indexes[index] and cast_item and \
                        ObjectManager.extract_high_guid(cast_item.guid) == lock_info.indexes[index]:
                    return OpenLockResult(SpellCheckCastResult.SPELL_NO_ERROR)
            elif _lock_type == LockKeyTypes.LOCK_KEY_SKILL:
                # Wrong lock type, skip.
                if lock_type != lock_info.indexes[index]:
                    continue

                skill_type = LockManager.get_skill_by_lock_type(LockType(lock_info.indexes[index]))
                if skill_type != SkillTypes.NONE:
                    required_skill_value = lock_info.skills[index]
                    raw_skill_value = 0 if cast_item or caster.get_type_id() != ObjectTypeIds.ID_PLAYER else \
                        caster.skill_manager.get_total_skill_value(skill_type)
                    bonus_skill_value = raw_skill_value + bonus_points
                    if bonus_skill_value < required_skill_value:
                        return OpenLockResult(SpellCheckCastResult.SPELL_FAILED_LOW_CASTLEVEL)

                return OpenLockResult(SpellCheckCastResult.SPELL_NO_ERROR, skill_type,
                                      required_skill_value, raw_skill_value, bonus_skill_value)

        # No requirement met, locked.
        return OpenLockResult(SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)

    @staticmethod
    def get_skill_by_lock_type(lock_type: LockType) -> SkillTypes:
        if lock_type == LockType.LOCKTYPE_PICKLOCK:
            return SkillTypes.LOCKPICKING
        elif lock_type == LockType.LOCKTYPE_HERBALISM:
            return SkillTypes.HERBALISM
        elif lock_type == LockType.LOCKTYPE_MINING:
            return SkillTypes.MINING
        elif lock_type == LockType.LOCKTYPE_FISHING:
            return SkillTypes.FISHING
        return SkillTypes.NONE
