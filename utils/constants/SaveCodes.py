from enum import IntEnum


class SaveReason(IntEnum):
    MANUAL = 0
    PERIODIC = 1
    SHUTDOWN = 2
    LOGOUT = 3
    TELEPORT = 4
    XP = 5
    LEVEL_CHANGE = 6
    BANK_SLOT = 7
    MONEY = 8
    ZONE_CHANGE = 9
    QUEST_REWARD = 10

    @property
    def label(self):
        return self.name.lower()
