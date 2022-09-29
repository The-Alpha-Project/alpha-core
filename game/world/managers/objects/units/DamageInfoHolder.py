from utils.constants.MiscCodes import AttackTypes, HitInfo, ProcFlags, ProcFlagsExLegacy


class DamageInfoHolder:
    def __init__(self,
                 attacker=None,
                 target=None,
                 damage_school_mask=0,
                 attack_type=AttackTypes.BASE_ATTACK,
                 total_damage=0,
                 damage=0,
                 absorb=0,
                 resist=0,
                 blocked_amount=0,
                 target_state=0,
                 hit_info=HitInfo.DAMAGE,
                 proc_attacker=ProcFlags.NONE,
                 proc_victim=ProcFlags.NONE,
                 proc_ex=ProcFlagsExLegacy.NONE):
        self.attacker = attacker
        self.target = target
        self.damage_school_mask = damage_school_mask
        self.attack_type = attack_type
        self.total_damage = total_damage
        self.original_damage = damage
        self.absorb = absorb
        self.resist = resist
        self.blocked_amount = blocked_amount
        self.target_state = target_state
        self.hit_info = hit_info
        self.proc_attacker = proc_attacker
        self.proc_victim = proc_victim
        self.proc_ex = proc_ex
