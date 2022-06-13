from database.dbc.DbcModels import Lock


# Lock.dbc holder.
class LockHolder:
    def __init__(self, lock: Lock):
        self.lock_entry = lock
        self.types = [lock.Type_1, lock.Type_2, lock.Type_3, lock.Type_4]
        self.indexes = [lock.Index_1, lock.Index_2, lock.Index_3, lock.Index_4]
        self.skills = [lock.Skill_1, lock.Skill_2, lock.Skill_3, lock.Skill_4]
        self.actions = [lock.Action_1, lock.Action_2, lock.Action_3, lock.Action_4]
