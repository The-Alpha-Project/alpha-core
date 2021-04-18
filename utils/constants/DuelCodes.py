from enum import IntEnum


class DuelStatus(IntEnum):
    DUEL_STATUS_OUTOFBOUNDS = 0
    DUEL_STATUS_INBOUNDS = 1


class DuelState(IntEnum):
    DUEL_STATE_REQUESTED = 0
    DUEL_STATE_STARTED = 1
    DUEL_STATE_FINISHED = 3


class DuelWinner(IntEnum):
    DUEL_WINNER_KNOCKOUT = 0
    DUEL_WINNER_RETREAT = 1


class DuelComplete(IntEnum):
    DUEL_CANCELED_INTERRUPTED = 0
    DUEL_FINISHED = 1
