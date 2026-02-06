from struct import pack
from typing import Optional

from network.packet.PacketWriter import PacketWriter
from game.world.managers.objects.units.AttackRoundAdvancedLogging import AttackRoundAdvancedLogging
from game.world.managers.objects.units.SpellAdvancedLogging import SpellAdvancedLogging
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
                 victim_round_duration=0,
                 spell_damage_added=0,
                 spell_added_damage=0,
                 dual_wield_hit_roll=0.0,
                 dual_wield_hit_roll_needed=0.0,
                 advanced_logging: Optional[AttackRoundAdvancedLogging] = None,
                 spell_advanced_logging: Optional[SpellAdvancedLogging] = None,
                 raw_damage=0,
                 proc_victim_spell=0,
                 is_periodic=False,
                 target_state=0,
                 attack_round_hit_info=HitInfo.DAMAGE,
                 spell_hit_flags=SpellHitFlags.NONE,
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
        self.base_damage = base_damage  # Pre-absorb damage after bonuses/crit/crush.
        self.absorb = absorb
        self.resist = resist
        self.victim_round_duration = victim_round_duration
        self.spell_damage_added = spell_damage_added
        self.spell_added_damage = spell_added_damage
        self.dual_wield_hit_roll = dual_wield_hit_roll
        self.dual_wield_hit_roll_needed = dual_wield_hit_roll_needed
        self.advanced_logging = advanced_logging or AttackRoundAdvancedLogging()
        self.spell_advanced_logging = spell_advanced_logging or SpellAdvancedLogging()
        self.raw_damage = raw_damage
        self.proc_victim_spell = proc_victim_spell
        self.is_periodic = is_periodic
        self.target_state = target_state
        self.attack_round_hit_info = attack_round_hit_info
        self.spell_hit_flags = spell_hit_flags
        self.proc_attacker = proc_attacker
        self.proc_victim = proc_victim
        self.proc_ex = proc_ex
        self.spell_id = spell_id
        self.spell_school = spell_school
        self.spell_miss_reason = spell_miss_reason

    def get_damage_done_packet(self):
        flags = WorldTextFlags.NORMAL_DAMAGE

        if self.spell_hit_flags & SpellHitFlags.CRIT or self.attack_round_hit_info & HitInfo.CRITICAL_HIT:
            flags |= WorldTextFlags.CRIT
        if self.total_damage == 0 and self.absorb:
            flags |= WorldTextFlags.MISS_ABSORBED
        if self.attack_round_hit_info & HitInfo.DEFERRED_LOGGING:
            flags |= WorldTextFlags.DEFERRED

        # Periodic ticks should not be treated as combat swing spells by the client.
        spell_id = 0 if self.is_periodic else self.spell_id
        is_special_damage = self.spell_id != 0 or self.is_periodic
        # Client treats normalCombatDamage as a boolean: 0 => yellow damage (special/spell), non-zero => white damage (auto).
        normal_combat_damage = 0 if is_special_damage else self.base_damage
        data = pack('<Q2IiIQ', self.target.guid, self.total_damage, normal_combat_damage,
                    flags, spell_id, self.attacker.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DAMAGE_DONE, data)

    def get_attacker_state_update_spell_miss_packet(self):
        data = self._get_debug_spell_header(self._get_spell_hit_flags_for_logging(False))
        data += pack('<I', self.spell_miss_reason)
        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELLMISS, data)

    def get_attacker_state_update_spell_hit_packet(self, include_advanced_logging=False):
        include_advanced_logging = (
            include_advanced_logging
            and not self.spell_hit_flags & SpellHitFlags.NON_DAMAGE_SPELL
            and not self.spell_hit_flags & SpellHitFlags.NONE
        )
        spell_hit_flags = self._get_spell_hit_flags_for_logging(include_advanced_logging)
        data = self._get_debug_spell_header(spell_hit_flags)
        if not self.spell_hit_flags & SpellHitFlags.NON_DAMAGE_SPELL and not self.spell_hit_flags & SpellHitFlags.NONE:
            data += pack('<If3I', self.total_damage, self.base_damage, self.spell_school, self.base_damage, self.absorb)
            data += self._get_spell_advanced_logging_bytes_if_enabled(include_advanced_logging)

        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL, data)

    def _get_spell_advanced_logging_bytes_if_enabled(self, include_advanced_logging: bool) -> bytes:
        if not include_advanced_logging:
            return b''
        return self._get_spell_advanced_logging_bytes()

    def _get_spell_advanced_logging_bytes(self) -> bytes:
        logging = self.spell_advanced_logging
        return pack('<2I6fI2fIf',
                             int(logging.min_damage), int(logging.max_damage),
                             float(logging.net_damage_multiplier),  # netDamageMultiplier
                             float(logging.scaled_damage),  # scaledDamage
                             float(logging.crit_roll_needed),  # critRollNeededFloat
                             float(logging.crit_roll),  # critRollFloat
                             float(logging.max_damage_reduction),  # maxDamageReduction
                             float(logging.scaled_armor_reduction),  # scaledArmorReduction
                             int(logging.aura_effect_id),  # auraEffectID
                             float(logging.hit_roll_needed),  # hitRollNeededFloat
                             float(logging.hit_roll),  # hitRollFloat
                             int(logging.damage_type),  # damageType
                             float(logging.resistance_coefficient))  # resistanceCoefficient

    def _get_attack_round_advanced_logging_bytes_if_enabled(self, include_advanced_logging: bool) -> bytes:
        if not include_advanced_logging:
            return b''
        return self._get_attack_round_advanced_logging_bytes()

    def _get_attack_round_advanced_logging_bytes(self) -> bytes:
        logging = self.advanced_logging
        roll_info = logging.roll_info
        miss_roll = roll_info.miss_roll if roll_info else 0.0
        miss_roll_needed = roll_info.miss_roll_needed if roll_info else 0.0
        crit_roll = roll_info.crit_roll if roll_info else 0.0
        crit_roll_needed = roll_info.crit_roll_needed if roll_info else 0.0
        dodge_roll = roll_info.dodge_roll if roll_info else 0.0
        dodge_roll_needed = roll_info.dodge_roll_needed if roll_info else 0.0
        parry_roll = roll_info.parry_roll if roll_info else 0.0
        parry_roll_needed = roll_info.parry_roll_needed if roll_info else 0.0
        block_roll = roll_info.block_roll if roll_info else 0.0
        block_roll_needed = roll_info.block_roll_needed if roll_info else 0.0
        stun_roll = roll_info.stun_roll if roll_info else 0.0
        stun_roll_needed = roll_info.stun_roll_needed if roll_info else 0.0

        min_damage = int(logging.min_damage)
        max_damage = int(logging.max_damage)
        min_damage_values = (min_damage, 0, 0, 0, 0)
        max_damage_values = (max_damage, 0, 0, 0, 0)

        signature = '<I10fI10I9fI'
        values = (
            int(logging.armor_reduction),  # armorReduction
            miss_roll,  # hitRollFloat
            miss_roll_needed,  # hitRollNeededFloat
            crit_roll,  # critRollFloat
            crit_roll_needed,  # critRollNeededFloat
            dodge_roll,  # dodgeRollFloat
            dodge_roll_needed,  # dodgeRollNeededFloat
            parry_roll,  # parryRollFloat
            parry_roll_needed,  # parryRollNeededFloat
            block_roll,  # blockRollFloat
            block_roll_needed,  # blockRollNeededFloat
            int(logging.delay_time),  # delayTime
            *min_damage_values,  # minDamage[5]
            *max_damage_values,  # maxDamage[5]
            float(logging.net_damage_multiplier),  # netDamageMultiplier
            float(logging.scaled_damage),  # scaledDamage
            float(logging.scaled_armor_reduction),  # scaledArmorReduction
            float(logging.max_damage_reduction),  # maxDamageReduction
            stun_roll,  # stunRollFloat
            stun_roll_needed,  # stunRollNeededFloat
            float(logging.dps_scaler),  # DPSScaler
            float(logging.mod_damage_taken),  # modDamageTaken
            float(logging.mod_damage_done),  # modDamageDone
            int(logging.since_last_swing),  # sinceLastSwing
        )
        return pack(signature, *values)

    def get_attacker_state_update_packet(self, include_advanced_logging=False):
        victim_round_duration = self.victim_round_duration or self._get_victim_round_duration()
        attack_round_hit_info = self.attack_round_hit_info
        if include_advanced_logging:
            attack_round_hit_info |= HitInfo.ADVANCED_LOGGING
        else:
            attack_round_hit_info &= ~HitInfo.ADVANCED_LOGGING
        signature = '<I2QIBIfII4I'
        values = (
            attack_round_hit_info,  # flags
            self.attacker.guid,
            self.target.guid,
            self.total_damage,
            1,  # Sub damage count.
            self.damage_school_mask,
            float(self.base_damage),
            self.total_damage,
            self.absorb,
            self.target_state,
            victim_round_duration,
            self.spell_damage_added,
            self.spell_added_damage,
        )
        data = bytearray(pack(signature, *values))

        if attack_round_hit_info & HitInfo.OFFHAND:
            data.extend(pack('<2f',
                             self.dual_wield_hit_roll,
                             self.dual_wield_hit_roll_needed))

        data.extend(self._get_attack_round_advanced_logging_bytes_if_enabled(include_advanced_logging))

        data.extend(pack('<i', self.proc_victim_spell))
        return PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATE, data)

    def _get_debug_spell_header(self, spell_hit_flags: SpellHitFlags):
        return pack('<i2QI', spell_hit_flags, self.attacker.guid, self.target.guid, self.spell_id)

    def _get_spell_hit_flags_for_logging(self, include_advanced_logging: bool) -> SpellHitFlags:
        spell_hit_flags = self.spell_hit_flags
        if include_advanced_logging:
            spell_hit_flags |= SpellHitFlags.ADVANCED_SPELL_LOGGING
            if 0 < self.spell_advanced_logging.aura_effect_id < 0x59:
                spell_hit_flags |= SpellHitFlags.USE_AURA_EFFECT_ID
        else:
            spell_hit_flags &= ~SpellHitFlags.ADVANCED_SPELL_LOGGING
            spell_hit_flags &= ~SpellHitFlags.USE_AURA_EFFECT_ID
        return spell_hit_flags

    # VictimRoundDuration is used to time the victim animation when processing an attack round.
    # The data originates from the attack round info (attacker’s combat round).
    def _get_victim_round_duration(self):
        if not self.attacker or not self.attacker.is_unit(by_mask=True):
            return 0
        from game.world.managers.objects.units.player.StatManager import UnitStats
        if self.attack_type == AttackTypes.OFFHAND_ATTACK:
            return int(self.attacker.stat_manager.get_total_stat(UnitStats.OFF_HAND_DELAY))
        if self.attack_type == AttackTypes.RANGED_ATTACK:
            return int(self.attacker.stat_manager.get_total_stat(UnitStats.RANGED_DELAY))
        return int(self.attacker.stat_manager.get_total_stat(UnitStats.MAIN_HAND_DELAY))
