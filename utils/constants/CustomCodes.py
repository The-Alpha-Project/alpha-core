from enum import IntEnum


class CanCastResult(IntEnum):
    CAST_OK = 0
    CAST_FAIL_IS_CASTING = 1
    CAST_FAIL_OTHER = 2
    CAST_FAIL_TOO_FAR = 3
    CAST_FAIL_TOO_CLOSE = 4
    CAST_FAIL_POWER = 5
    CAST_FAIL_STATE = 6
    CAST_FAIL_TARGET_AURA = 7
    CAST_FAIL_NOT_IN_LOS = 8


class Permits(IntEnum):
    PERMIT_BASE_NO = -1
    PERMIT_BASE_IDLE = 1
    PERMIT_BASE_NORMAL = 100
    PERMIT_BASE_SPECIAL = 200


class PetSelectTargetReason(IntEnum):
    FAIL_DEFAULT = 0
    FAIL_NOT_ENABLED = 1
    FAIL_PASSIVE = 2
    FAIL_NO_OWNER = 3
    FAIL_RETURNING = 4
    SUCCESS_OWNER_ATTACKER = 5
    SUCCESS_AGGRO_RANGE = 6


class RelativeChaseState(IntEnum):
    NEUTRAL = 0
    AWAY = 1
    CLASH = 2


# TODO: Replace by UnitCodes.UnitSummonType?
class CreatureSubtype(IntEnum):
    SUBTYPE_GENERIC = 0
    SUBTYPE_PET = 1
    SUBTYPE_TOTEM = 2
    SUBTYPE_TEMP_SUMMON = 3


class AccountSecurityLevel(IntEnum):
    PLAYER = 0
    GM = 1
    DEV = 2
