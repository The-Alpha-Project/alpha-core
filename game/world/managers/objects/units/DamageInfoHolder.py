from struct import pack

from network.packet.PacketWriter import PacketWriter
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

    # TODO: Need better understanding of how the client is handling this opcode in order to produce
    #  the right packet structure.
    def get_damage_done_packet(self):
        flags = WorldTextFlags.NORMAL_DAMAGE
        if self.hit_info & SpellHitFlags.CRIT:
            flags |= WorldTextFlags.CRIT
        if self.hit_info & SpellHitFlags.REFLECTED:
            flags &= ~(WorldTextFlags.NORMAL_DAMAGE | WorldTextFlags.CRIT)
            flags |= WorldTextFlags.MISS_ABSORBED
        if self.absorb:
            flags |= WorldTextFlags.MISS_ABSORBED

        data = pack('<Q2IiIQ', self.target.guid, self.total_damage, self.base_damage, flags, self.spell_id, self.attacker.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DAMAGE_DONE, data)

    def get_attacker_state_update_spell_info_packet(self):
        data = self._get_debug_spell_header()
        # Spell cast not successful.
        if self.spell_miss_reason > SpellMissReason.MISS_REASON_NONE:
            data += pack('<I', self.spell_miss_reason)
            return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELLMISS, data)
        # Spell cast did damage or healed.
        elif not self.hit_info & SpellHitFlags.NON_DAMAGE_SPELL and not self.hit_info & SpellHitFlags.NONE:
            data += pack('<If3I', self.total_damage, self.base_damage, self.spell_school, self.base_damage, self.absorb)

        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL, data)

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
