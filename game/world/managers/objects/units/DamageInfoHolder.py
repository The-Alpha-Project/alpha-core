from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.constants.MiscCodes import AttackTypes, HitInfo, ProcFlags, ProcFlagsExLegacy
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellMissReason, SpellHitFlags, WorldTextFlags


class DamageInfoHolder:
    def __init__(self,
                 attacker=None,
                 target=None,
                 damage_school_mask=0,
                 attack_type=AttackTypes.BASE_ATTACK,
                 total_damage=0,
                 base_damage=0,
                 absorb=0,
                 resist=0,
                 proc_victim_spell=0,
                 target_state=0,
                 hit_info=HitInfo.DAMAGE,
                 proc_attacker=ProcFlags.NONE,
                 proc_victim=ProcFlags.NONE,
                 proc_ex=ProcFlagsExLegacy.NONE,
                 spell_id=0,
                 spell_school=0,
                 spell_miss_reason=SpellMissReason.MISS_REASON_NONE):
        self.attacker = attacker
        self.target = target
        self.damage_school_mask = damage_school_mask
        self.attack_type = attack_type
        self.total_damage = total_damage
        self.base_damage = base_damage
        self.absorb = absorb
        self.resist = resist
        self.proc_victim_spell = proc_victim_spell
        self.target_state = target_state
        self.hit_info = hit_info
        self.proc_attacker = proc_attacker
        self.proc_victim = proc_victim
        self.proc_ex = proc_ex
        self.spell_id = spell_id
        self.spell_school = spell_school
        self.spell_miss_reason = spell_miss_reason

    def get_damage_done_packet(self):
        flags = WorldTextFlags.NORMAL_DAMAGE

        if self.hit_info & (SpellHitFlags.CRIT | HitInfo.CRITICAL_HIT):
            flags |= WorldTextFlags.CRIT
        if self.total_damage == 0 and self.absorb:
            flags |= WorldTextFlags.MISS_ABSORBED
        if self.hit_info & HitInfo.DEFERRED_LOGGING:
            flags |= WorldTextFlags.DEFERRED

        data = pack('<Q2IiIQ', self.target.guid, self.total_damage, self.base_damage, flags, self.spell_id, self.attacker.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DAMAGE_DONE, data)

    def get_attacker_state_update_spell_info_packet(self):
        advanced_spell_logging = config.Server.Settings.advanced_spell_logging
        if self.proc_ex & ProcFlagsExLegacy.REFLECT:
            self.hit_info |= SpellHitFlags.REFLECTED
        if advanced_spell_logging:
            self.hit_info |= SpellHitFlags.ADVANCED_SPELL_LOGGING
        data = self._get_debug_spell_header()
        # Spell cast not successful.
        if self.spell_miss_reason > SpellMissReason.MISS_REASON_NONE:
            data += pack('<I', self.spell_miss_reason)
            return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELLMISS, data)
        # Spell cast did damage or healed.
        elif not self.hit_info & SpellHitFlags.NON_DAMAGE_SPELL and not self.hit_info & SpellHitFlags.NONE:
            data += pack('<If3I', self.total_damage, self.base_damage, self.spell_school, self.base_damage, self.absorb)
            if advanced_spell_logging:
                data += self._get_advanced_logging_bytes()

        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL, data)

    def _get_advanced_logging_bytes(self):
        return pack('<2I6fI2fIf',
                             int(self.base_damage), int(self.base_damage),
                             1.0,  # netDamageMultiplier
                             float(self.base_damage),  # scaledDamage
                             0.0,  # critRollNeededFloat
                             0.0,  # critRollFloat
                             0.0,  # maxDamageReduction
                             0.0,  # scaledArmorReduction
                             0,  # auraEffectID
                             0.0,  # hitRollNeededFloat
                             0.0,  # hitRollFloat
                             int(self.spell_school),  # damageType
                             0.0)  # resistanceCoefficient

    def get_attacker_state_update_packet(self):
        data = pack('<I2QIBIf7I',
                    self.hit_info,
                    self.attacker.guid,
                    self.target.guid,
                    self.total_damage,
                    1,  # Sub damage count.
                    self.damage_school_mask,
                    self.total_damage,
                    self.base_damage,
                    self.absorb,
                    self.target_state,
                    self.resist,
                    0, self.spell_id,
                    self.proc_victim_spell)
        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATE, data)

    def _get_debug_spell_header(self):
        return pack('<i2QI', self.hit_info, self.attacker.guid, self.target.guid, self.spell_id)
