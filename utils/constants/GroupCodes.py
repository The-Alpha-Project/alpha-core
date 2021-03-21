from enum import IntEnum


class PartyOperation(IntEnum):
    PARTY_OP_INVITE = 0
    PARTY_OP_LEAVE = 2


class PartyResult(IntEnum):
    OK_PARTY_RESULT = 0,
    ERR_BAD_PLAYER_NAME_S = 1,
    ERR_TARGET_NOT_IN_YOUR_GROUP_S = 2,
    ERR_GROUP_FULL = 3,
    ERR_ALREADY_IN_GROUP_S = 4,
    ERR_NOT_IN_GROUP = 5,
    ERR_NOT_LEADER = 6,
    ERR_PLAYER_WRONG_FACTION = 7,
    ERR_IGNORING_YOU_S = 8,
    ERR_INVITE_RESTRICTED = 9,
