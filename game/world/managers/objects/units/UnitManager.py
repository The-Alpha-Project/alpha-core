import math
import random
from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.MovementManager import MovementManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.units.player.StatManager import StatManager, UnitStats
from game.world.managers.objects.spell.AuraManager import AuraManager
from game.world.managers.objects.spell.SpellManager import SpellManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, AttackTypes, ProcFlags, \
    HitInfo, AttackSwingError, MoveFlags, VictimStates, UnitDynamicTypes, HighGuid
from utils.constants.SpellCodes import SpellMissReason, SpellHitFlags, SpellSchools, ShapeshiftForms
from utils.constants.UnitCodes import UnitFlags, StandState, WeaponMode, SplineFlags, PowerTypes, SplineType, UnitStates
from utils.constants.UpdateFields import UnitFields


class UnitManager(ObjectManager):
    def __init__(self,
                 channel_spell=0,
                 channel_object=0,
                 health=0,
                 power_type=0,
                 power_1=0,  # mana
                 power_2=0,  # rage
                 power_3=100,  # focus
                 power_4=100,  # energy
                 max_health=0,
                 max_power_1=0,
                 max_power_2=1000,
                 max_power_3=100,
                 max_power_4=100,
                 level=0,
                 gender=0,
                 bytes_0=0,  # race, class, gender, power_type
                 creature_type=0,
                 stat_0=0,
                 stat_1=0,
                 stat_2=0,
                 stat_3=0,
                 stat_4=0,
                 base_stat_0=0,
                 base_stat_1=0,
                 base_stat_2=0,
                 base_stat_3=0,
                 base_stat_4=0,
                 flags=0,
                 coinage=0,
                 combat_reach=config.Unit.Defaults.combat_reach,
                 weapon_reach=0,
                 mount_display_id=0,
                 resistance_buff_mods_positive_0=0,  # Armor
                 resistance_buff_mods_positive_1=0,  # Holy
                 resistance_buff_mods_positive_2=0,  # Fire
                 resistance_buff_mods_positive_3=0,  # Nature
                 resistance_buff_mods_positive_4=0,  # Frost
                 resistance_buff_mods_positive_5=0,  # Shadow
                 resistance_buff_mods_negative_0=0,
                 resistance_buff_mods_negative_1=0,
                 resistance_buff_mods_negative_2=0,
                 resistance_buff_mods_negative_3=0,
                 resistance_buff_mods_negative_4=0,
                 resistance_buff_mods_negative_5=0,
                 base_attack_time=config.Unit.Defaults.base_attack_time,
                 offhand_attack_time=config.Unit.Defaults.offhand_attack_time,
                 resistance_0=0,  # Armor
                 resistance_1=0,
                 resistance_2=0,
                 resistance_3=0,
                 resistance_4=0,
                 resistance_5=0,
                 stand_state=0,
                 sheathe_state=WeaponMode.SHEATHEDMODE,
                 shapeshift_form=0,
                 bytes_1=0,  # stand state, shapeshift form, sheathstate
                 mod_cast_speed=1,
                 dynamic_flags=0,
                 damage=0,  # current damage, max damage
                 bytes_2=0,  # combo points, 0, 0, 0
                 current_target=0,  # guid
                 combat_target=None,  # victim
                 **kwargs):
        super().__init__(**kwargs)

        self.combat_target = combat_target
        self.channel_spell = channel_spell
        self.channel_object = channel_object
        self.health = health
        self.power_type = power_type
        self.power_1 = power_1
        self.power_2 = power_2
        self.power_3 = power_3
        self.power_4 = power_4
        self.max_health = max_health
        self.max_power_1 = max_power_1
        self.max_power_2 = max_power_2
        self.max_power_3 = max_power_3
        self.max_power_4 = max_power_4
        self.level = level
        self.gender = gender
        self.bytes_0 = bytes_0  # race, class, gender, power_type
        self.creature_type = creature_type
        self.str = stat_0
        self.agi = stat_1
        self.sta = stat_2
        self.int = stat_3
        self.spi = stat_4
        self.base_str = base_stat_0
        self.base_agi = base_stat_1
        self.base_sta = base_stat_2
        self.base_int = base_stat_3
        self.base_spi = base_stat_4
        self.flags = flags
        self.coinage = coinage
        self.combat_reach = combat_reach
        self.weapon_reach = weapon_reach
        self.mount_display_id = mount_display_id
        self.resistance_buff_mods_positive_0 = resistance_buff_mods_positive_0
        self.resistance_buff_mods_positive_1 = resistance_buff_mods_positive_1
        self.resistance_buff_mods_positive_2 = resistance_buff_mods_positive_2
        self.resistance_buff_mods_positive_3 = resistance_buff_mods_positive_3
        self.resistance_buff_mods_positive_4 = resistance_buff_mods_positive_4
        self.resistance_buff_mods_positive_5 = resistance_buff_mods_positive_5
        self.resistance_buff_mods_negative_0 = resistance_buff_mods_negative_0
        self.resistance_buff_mods_negative_1 = resistance_buff_mods_negative_1
        self.resistance_buff_mods_negative_2 = resistance_buff_mods_negative_2
        self.resistance_buff_mods_negative_3 = resistance_buff_mods_negative_3
        self.resistance_buff_mods_negative_4 = resistance_buff_mods_negative_4
        self.resistance_buff_mods_negative_5 = resistance_buff_mods_negative_5
        self.base_attack_time = base_attack_time
        self.offhand_attack_time = offhand_attack_time
        self.resistance_0 = resistance_0  # Armor
        self.resistance_1 = resistance_1
        self.resistance_2 = resistance_2
        self.resistance_3 = resistance_3
        self.resistance_4 = resistance_4
        self.resistance_5 = resistance_5
        self.stand_state = stand_state
        self.sheath_state = sheathe_state
        self.shapeshift_form = shapeshift_form
        self.bytes_1 = bytes_1  # stand state, shapeshift form, sheathstate
        self.mod_cast_speed = mod_cast_speed
        self.dynamic_flags = dynamic_flags
        self.damage = damage  # current damage, max damage
        self.bytes_2 = bytes_2  # combo points, 0, 0, 0
        self.current_target = current_target

        self.object_type_mask |= ObjectTypeFlags.TYPE_UNIT
        self.update_packet_factory.init_values(UnitFields.UNIT_END)

        self.is_alive = True
        self.in_combat = False
        self.fleeing_waypoints = []
        self.swing_error = AttackSwingError.NONE
        self.extra_attacks = 0
        self.disarmed_mainhand = False
        self.disarmed_offhand = False
        self.attackers = {}
        self.attack_timers = {AttackTypes.BASE_ATTACK: 0,
                              AttackTypes.OFFHAND_ATTACK: 0,
                              AttackTypes.RANGED_ATTACK: 0}

        # Used to determine the current state of the unit (internal usage).
        self.unit_state = UnitStates.NONE

        # Defensive passive spells are not handled through the aura system.
        # The effects will instead flag the unit with these fields.
        self.has_block_passive = False
        self.has_parry_passive = False
        self.has_dodge_passive = False

        self.stat_manager = StatManager(self)
        self.spell_manager = SpellManager(self)
        self.aura_manager = AuraManager(self)
        self.movement_manager = MovementManager(self)

    def is_within_interactable_distance(self, victim):
        current_distance = self.location.distance(victim.location)
        return current_distance <= UnitFormulas.interactable_distance(self, victim)

    def attack(self, victim, is_melee=True):
        if not victim or victim == self:
            return False

        # Dead units can neither attack nor be attacked
        if not self.is_alive or not victim.is_alive:
            return False

        # Mounted players can't attack
        if self.get_type_id() == ObjectTypeIds.ID_PLAYER and self.mount_display_id > 0:
            return False

        # In fight already
        if self.combat_target:
            if self.combat_target == victim:
                if is_melee and self.is_within_interactable_distance(self.combat_target):
                    self.send_attack_start(victim.guid)
                    return True
                return False

            self.attack_stop(target_switch=True)

        self.set_current_target(victim.guid)
        self.combat_target = victim
        victim.attackers[self.guid] = self

        # Reset offhand weapon attack
        if self.has_offhand_weapon():
            self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

        self.send_attack_start(self.combat_target.guid)

        return True

    def attack_stop(self, target_switch=False):
        # Clear target
        self.set_current_target(0)
        victim = self.combat_target
        self.combat_target = None

        self.send_attack_stop(victim.guid if victim else self.guid)

    def send_attack_start(self, victim_guid):
        data = pack('<2Q', self.guid, victim_guid)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTART, data), self)

    def send_attack_stop(self, victim_guid):
        # Last uint32 is "deceased"; can be either 1 (self is dead), or 0, (self is alive).
        # Forces the unit to face the corpse and disables clientside
        # turning (UnitFlags.DisableMovement) CGUnit_C::OnAttackStop
        data = pack('<2QI', self.guid, victim_guid, 0 if self.is_alive else 1)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data), self)

    def attack_update(self, elapsed):
        # If we have a combat target, no attackers and target is no longer alive or is fleeing, leave combat.
        if self.combat_target and (not self.combat_target.is_alive or self.combat_target.is_fleeing()) and len(self.attackers) == 0:
            self.leave_combat()
            return
        # We have attackers, last target is dead or fleeing, switch to next alive target.
        elif self.combat_target and (not self.combat_target.is_alive or self.combat_target.is_fleeing()) and len(self.attackers) > 0:
            for guid, attacker in self.attackers.items():
                if attacker.is_alive and not attacker.is_fleeing():
                    self.attack(attacker)
                    return
            # If we did not find a target, leave combat.
            self.leave_combat()
            return

        self.update_attack_time(AttackTypes.BASE_ATTACK, elapsed * 1000.0)
        if self.has_offhand_weapon():
            self.update_attack_time(AttackTypes.OFFHAND_ATTACK, elapsed * 1000.0)

        self.update_melee_attacking_state()

    def update_melee_attacking_state(self):
        if self.unit_state & UnitStates.STUNNED:
            return

        swing_error = AttackSwingError.NONE
        combat_angle = math.pi

        if not self.combat_target:
            if self.in_combat and len(self.attackers) == 0:
                self.leave_combat()
            return False

        if not self.is_attack_ready(AttackTypes.BASE_ATTACK) and not self.is_attack_ready(AttackTypes.OFFHAND_ATTACK) or self.spell_manager.is_casting():
            return False

        # Out of reach
        if not self.is_within_interactable_distance(self.combat_target):
            swing_error = AttackSwingError.NOTINRANGE
        # Not proper angle
        elif not self.location.has_in_arc(self.combat_target.location, combat_angle):
            swing_error = AttackSwingError.BADFACING
        # Moving
        elif self.movement_flags & MoveFlags.MOVEFLAG_MOTION_MASK:
            swing_error = AttackSwingError.MOVING
        # Not standing
        elif self.stand_state != StandState.UNIT_STANDING:
            swing_error = AttackSwingError.NOTSTANDING
        # Dead target
        elif not self.combat_target.is_alive:
            self.attackers.pop(self.combat_target.guid)
            swing_error = AttackSwingError.DEADTARGET
        else:
            # Main hand attack
            if self.is_attack_ready(AttackTypes.BASE_ATTACK):
                # Prevent both and attacks at the same time
                if self.has_offhand_weapon():
                    if self.attack_timers[AttackTypes.OFFHAND_ATTACK] < 500:
                        self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, 500)

                self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK, False)
                self.set_attack_timer(AttackTypes.BASE_ATTACK, self.base_attack_time)

            # Off hand attack
            if self.has_offhand_weapon() and self.is_attack_ready(AttackTypes.OFFHAND_ATTACK):
                # Prevent both and attacks at the same time
                if self.attack_timers[AttackTypes.BASE_ATTACK] < 500:
                    self.set_attack_timer(AttackTypes.BASE_ATTACK, 500)

                self.attacker_state_update(self.combat_target, AttackTypes.OFFHAND_ATTACK, False)
                self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

        if self.get_type_id() == ObjectTypeIds.ID_PLAYER:
            if swing_error != AttackSwingError.NONE:
                self.set_attack_timer(AttackTypes.BASE_ATTACK, self.base_attack_time)
                if self.has_offhand_weapon():
                    self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

                if swing_error == AttackSwingError.NOTINRANGE:
                    self.send_attack_swing_not_in_range(self.combat_target)
                elif swing_error == AttackSwingError.BADFACING:
                    self.send_attack_swing_facing_wrong_way(self.combat_target)
                elif swing_error == AttackSwingError.DEADTARGET:
                    self.send_attack_swing_dead_target(self.combat_target)
                elif swing_error == AttackSwingError.NOTSTANDING:
                    self.send_attack_swing_not_standing(self.combat_target)

                self.send_attack_stop(self.combat_target.guid)

        self.swing_error = swing_error
        return swing_error == AttackSwingError.NONE

    def attacker_state_update(self, victim, attack_type, extra):
        if attack_type == AttackTypes.BASE_ATTACK:
            # No recent extra attack only at any non extra attack
            if not extra and self.extra_attacks > 0:
                self.execute_extra_attacks()
                return

            if self.spell_manager.cast_queued_melee_ability(attack_type):
                return  # Melee ability replaces regular attack

        damage_info = self.calculate_melee_damage(victim, attack_type)
        if not damage_info:
            return

        if damage_info.total_damage > 0:
            victim.spell_manager.check_spell_interrupts(received_auto_attack=True, hit_info=damage_info.hit_info)

        victim.aura_manager.check_aura_procs(damage_info=damage_info, is_melee_swing=True)
        self.aura_manager.check_aura_procs(damage_info=damage_info, is_melee_swing=True)

        self.send_attack_state_update(damage_info)

        # Extra attack only at any non extra attack
        if not extra and self.extra_attacks > 0:
            self.execute_extra_attacks()

    def execute_extra_attacks(self):
        while self.extra_attacks > 0:
            self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK, True)
            self.extra_attacks -= 1

    def calculate_melee_damage(self, victim, attack_type):
        damage_info = DamageInfoHolder()

        if not victim:
            return None

        if not self.is_alive or not victim.is_alive:
            return None

        damage_info.attacker = self
        damage_info.target = victim
        damage_info.attack_type = attack_type

        hit_info = victim.stat_manager.get_attack_result_against_self(self, attack_type,
                                                                      0.19 if self.has_offhand_weapon() else 0)  # Dual wield penalty.

        damage_info.damage = self.calculate_base_attack_damage(attack_type, SpellSchools.SPELL_SCHOOL_NORMAL, victim)
        damage_info.clean_damage = damage_info.total_damage = damage_info.damage
        damage_info.hit_info = hit_info
        damage_info.target_state = VictimStates.VS_WOUND  # Default state on successful attack.

        if hit_info != HitInfo.SUCCESS:
            damage_info.hit_info = HitInfo.MISS
            damage_info.total_damage = 0
            # Check evade, there is no HitInfo flag for this.
            if victim.is_fleeing():
                damage_info.target_state = VictimStates.VS_EVADE
                damage_info.proc_victim |= ProcFlags.NONE
            elif hit_info == HitInfo.DODGE:
                damage_info.target_state = VictimStates.VS_DODGE
                damage_info.proc_victim |= ProcFlags.DODGE
            elif hit_info == HitInfo.PARRY:
                damage_info.target_state = VictimStates.VS_PARRY
                damage_info.proc_victim |= ProcFlags.PARRY
            elif hit_info == HitInfo.BLOCK:
                # 0.6 patch notes: "Blocking an attack no longer avoids all of the damage of an attack."
                # Completely mitigate damage on block.
                damage_info.target_state = VictimStates.VS_BLOCK
                damage_info.proc_victim |= ProcFlags.BLOCK

        # Generate rage (if needed)
        self.generate_rage(damage_info, is_player=self.get_type_id() == ObjectTypeIds.ID_PLAYER)

        # Note: 1.1.0 patch: "Skills will not increase from use while dueling or engaged in PvP."
        self.handle_combat_skill_gain(damage_info)
        victim.handle_combat_skill_gain(damage_info)

        if damage_info.total_damage > 0:
            damage_info.proc_victim |= ProcFlags.TAKE_COMBAT_DMG
            damage_info.proc_attacker |= ProcFlags.DEAL_COMBAT_DMG

        if attack_type == AttackTypes.BASE_ATTACK:
            damage_info.proc_attacker |= ProcFlags.SWING
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            damage_info.proc_attacker |= ProcFlags.SWING
            damage_info.hit_info |= HitInfo.OFFHAND

        return damage_info

    def send_attack_state_update(self, damage_info):
        data = pack('<I2QIBIf7I',
                    damage_info.hit_info,
                    damage_info.attacker.guid,
                    damage_info.target.guid,
                    damage_info.total_damage,
                    1,  # Sub damage count
                    damage_info.damage_school_mask,
                    damage_info.total_damage,
                    damage_info.damage,
                    damage_info.absorb,
                    damage_info.target_state,
                    damage_info.resist,
                    0, 0,
                    damage_info.blocked_amount)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATE, data), self,
                                    include_self=self.get_type_id() == ObjectTypeIds.ID_PLAYER)

        # Damage effects
        self.deal_damage(damage_info.target, damage_info.total_damage)

    def calculate_base_attack_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target, apply_bonuses=True):
        min_damage, max_damage = self.calculate_min_max_damage(attack_type, attack_school, target)

        if min_damage > max_damage:
            tmp_min = min_damage
            min_damage = max_damage
            max_damage = tmp_min

        return random.randint(min_damage, max_damage)

    # Implemented by PlayerManager
    def generate_rage(self, damage_info):
        return

    # Implemented by PlayerManager
    def generate_rage_on_received_damage(self, damage_info, is_player=False):
        return

    # Implemented by PlayerManager
    def handle_combat_skill_gain(self, damage_info):
        return

    def calculate_min_max_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target):
        return self.stat_manager.get_base_attack_base_min_max_damage(AttackTypes(attack_type))

    # Implemented by PlayerManager
    def calculate_spell_damage(self, base_damage, spell_school: SpellSchools, target, spell_attack_type: AttackTypes = -1):
        return base_damage

    def deal_damage(self, target, damage, is_periodic=False):
        if not target or not target.is_alive:
            return

        if target.is_fleeing():
            return

        if target is not self:
            if self.guid not in target.attackers:
                target.attackers[self.guid] = self

            if not self.in_combat:
                self.enter_combat()

            if not target.in_combat:
                target.enter_combat()

        target.receive_damage(damage, source=self, is_periodic=False)

    def receive_damage(self, amount, source=None, is_periodic=False):
        is_player = self.get_type_id() == ObjectTypeIds.ID_PLAYER

        if source is not self and not is_periodic and amount > 0:
            self.aura_manager.check_aura_interrupts(received_damage=True)
            self.spell_manager.check_spell_interrupts(received_damage=True)

        new_health = self.health - amount
        if new_health <= 0:
            self.die(killer=source)
        else:
            damage_info = DamageInfoHolder()
            damage_info.damage = amount
            damage_info.victim = self                                    
            self.set_health(new_health)
            self.generate_rage_on_received_damage(damage_info, is_player)


        # If unit is a creature and it's being attacked by another unit, automatically set combat target.
        if not self.combat_target and not is_player and source and source.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT:
            # Make sure to first stop any movement right away.
            if len(self.movement_manager.pending_waypoints) > 0:
                self.movement_manager.send_move_stop()
            # Attack.
            self.attack(source)

    def receive_healing(self, amount, source=None):
        new_health = self.health + amount
        if new_health > self.max_health:
            self.set_health(self.max_health)
        else:
            self.set_health(new_health)

    def receive_power(self, amount, power_type, source=None):
        if self.power_type != power_type:
            return

        new_power = self.get_power_type_value() + amount
        if power_type == PowerTypes.TYPE_MANA:
            self.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            self.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.set_energy(new_power)

    def apply_spell_damage(self, target, damage, casting_spell, is_periodic=False):
        if target.guid in casting_spell.object_target_results:
            miss_reason = casting_spell.object_target_results[target.guid].result
        else:  # TODO Proc damage effects (SPELL_AURA_PROC_TRIGGER_DAMAGE) can't fill target results - should they be able to miss?
            miss_reason = SpellMissReason.MISS_REASON_NONE

        # Overwrite if fleeing.
        if target.is_fleeing():
            miss_reason = SpellMissReason.MISS_REASON_EVADED

        damage = self.calculate_spell_damage(damage, casting_spell.spell_entry.School, target, casting_spell.spell_attack_type)

        # TODO Handle misses, absorbs etc. for spells.
        damage_info = casting_spell.get_cast_damage_info(self, target, damage, 0)

        if miss_reason == SpellMissReason.MISS_REASON_EVADED:
            damage_info.total_damage = 0
            damage_info.hit_info = HitInfo.MISS
            damage_info.proc_victim |= ProcFlags.NONE

        if casting_spell.casts_on_swing() or casting_spell.is_ranged_weapon_attack():  # TODO Should other spells give skill too?
            self.handle_combat_skill_gain(damage_info)
            target.handle_combat_skill_gain(damage_info)

        self.send_spell_cast_debug_info(damage_info, miss_reason, casting_spell.spell_entry.ID, is_periodic=is_periodic)

        self.deal_damage(target, damage, is_periodic)

    def apply_spell_healing(self, target, healing, casting_spell, is_periodic=False):
        miss_info = casting_spell.object_target_results[target.guid].result
        damage_info = casting_spell.get_cast_damage_info(self, target, healing, 0)
        self.send_spell_cast_debug_info(damage_info, miss_info, casting_spell.spell_entry.ID, healing=True, is_periodic=is_periodic)
        target.receive_healing(healing, self)

    def send_spell_cast_debug_info(self, damage_info, miss_reason, spell_id, healing=False, is_periodic=False):
        flags = SpellHitFlags.HIT_FLAG_HEALED if healing else SpellHitFlags.HIT_FLAG_DAMAGE
        if is_periodic:  # Periodic damage/healing does not show in combat log - only on character frame.
            flags |= SpellHitFlags.HIT_FLAG_PERIODIC

        if miss_reason != SpellMissReason.MISS_REASON_NONE:
            combat_log_data = pack('<i2Q2i', flags, damage_info.attacker.guid, damage_info.target.guid, spell_id, miss_reason)
            combat_log_opcode = OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELLMISS
        else:

            combat_log_data = pack('<I2Q2If3I', flags, damage_info.attacker.guid, damage_info.target.guid, spell_id,
                                   damage_info.total_damage, damage_info.damage, damage_info.damage_school_mask,
                                   damage_info.damage, damage_info.absorb)
            combat_log_opcode = OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL

        MapManager.send_surrounding(PacketWriter.get_packet(combat_log_opcode, combat_log_data), self,
                                    include_self=self.get_type_id() == ObjectTypeIds.ID_PLAYER)

        if not healing:
            damage_data = pack('<Q2i2IQ', damage_info.target.guid, damage_info.total_damage, damage_info.damage,
                               miss_reason, spell_id, damage_info.attacker.guid)
            MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_DAMAGE_DONE, damage_data), self,
                                        include_self=self.get_type_id() == ObjectTypeIds.ID_PLAYER)

    def set_current_target(self, guid):
        self.current_target = guid
        self.set_uint64(UnitFields.UNIT_FIELD_TARGET, guid)

    # Implemented by PlayerManager
    def send_attack_swing_not_in_range(self, victim):
        pass

    # Implemented by PlayerManager
    def send_attack_swing_facing_wrong_way(self, victim):
        pass

    # Implemented by PlayerManager
    def send_attack_swing_cant_attack(self, victim):
        pass

    # Implemented by PlayerManager
    def send_attack_swing_dead_target(self, victim):
        pass

    # Implemented by PlayerManager
    def send_attack_swing_not_standing(self, victim):
        pass

    # Implemented by PlayerManager and CreatureManager
    def has_offhand_weapon(self):
        return False

    # Implemented by PlayerManager and CreatureManager
    def has_ranged_weapon(self):
        return False

    # Location is used by PlayerManager if provided.
    # According to 1.3.0 notes, creatures were able to block/parry from behind.
    def can_block(self, attacker_location=None):
        return self.has_block_passive  # TODO Stunned/casting checks

    def can_parry(self, attacker_location=None):
        return self.has_parry_passive  # TODO Stunned/casting checks

    def can_dodge(self, attacker_location=None):
        return self.has_dodge_passive  # TODO Stunned/casting checks

    def enter_combat(self):
        self.in_combat = True
        self.unit_flags |= UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def leave_combat(self, force=False):
        if not self.in_combat and not force:
            return

        # Remove self from attacker list of attackers
        for victim in list(self.attackers.values()):
            if self.guid in victim.attackers:
                victim.attackers.pop(self.guid)
        self.attackers.clear()

        self.send_attack_stop(self.combat_target.guid if self.combat_target else self.guid)
        self.swing_error = 0

        self.fleeing_waypoints.clear()
        self.combat_target = None
        self.in_combat = False
        self.unit_flags &= ~UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def can_use_attack_type(self, attack_type):
        if attack_type == AttackTypes.BASE_ATTACK:
            return self.disarmed_mainhand
        if attack_type == AttackTypes.OFFHAND_ATTACK:
            return self.disarmed_offhand
        return True

    def is_attack_ready(self, attack_type):
        return self.attack_timers[attack_type] <= 0

    def update_attack_time(self, attack_type, value):
        new_value = self.attack_timers[attack_type] - value
        if new_value < 0:
            new_value = 0
        if not self.is_attack_ready(attack_type):
            self.set_attack_timer(attack_type, new_value)

    def set_attack_timer(self, attack_type, value):
        self.attack_timers[attack_type] = value

    def is_sitting(self):
        return self.stand_state == StandState.UNIT_SITTING

    def set_stand_state(self, stand_state):
        self.stand_state = stand_state

    def set_fleeing(self, state):
        if state:
            self.unit_flags |= UnitFlags.UNIT_FLAG_FLEEING
        else:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_FLEEING
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def is_fleeing(self):
        return self.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    # override
    def change_speed(self, speed=0):
        # Assign new base speed.
        self.stat_manager.base_stats[UnitStats.SPEED_RUNNING] = speed if speed > 0 else config.Unit.Defaults.run_speed
        # Get new total speed.
        speed = self.stat_manager.get_total_stat(UnitStats.SPEED_RUNNING)
        # Limit to 0-56 and assign object field.
        return super().change_speed(speed)

    def set_root(self, active):
        if active:
            # Stop movement if the unit has pending waypoints.
            if len(self.movement_manager.pending_waypoints) > 0:
                self.movement_manager.send_move_stop()

            self.movement_flags |= MoveFlags.MOVEFLAG_ROOTED
            self.unit_state |= UnitStates.ROOTED
        else:
            self.movement_flags &= ~MoveFlags.MOVEFLAG_ROOTED
            self.unit_state &= ~UnitStates.ROOTED

    def play_emote(self, emote):
        if emote != 0:
            data = pack('<IQ', emote, self.guid)
            MapManager.send_surrounding_in_range(PacketWriter.get_packet(OpCode.SMSG_EMOTE, data),
                                                 self, config.World.Chat.ChatRange.emote_range)

    def summon_mount(self, creature_entry):
        creature_template = WorldDatabaseManager.creature_get_by_entry(creature_entry)
        if not creature_template:
            return False

        self.mount(creature_template.display_id1)
        return True

    def mount(self, mount_display_id):
        if mount_display_id > 0 and DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(mount_display_id):
            self.mount_display_id = mount_display_id
            self.unit_flags |= UnitFlags.UNIT_MASK_MOUNTED
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def unmount(self):
        self.mount_display_id = 0
        self.unit_flags &= ~UnitFlags.UNIT_MASK_MOUNTED
        self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    # Implemented by Creature/PlayerManager.
    def update_power_type(self):
        pass

    def get_power_type_value(self):
        if self.power_type == PowerTypes.TYPE_MANA:
            return self.power_1
        elif self.power_type == PowerTypes.TYPE_RAGE:
            return self.power_2
        elif self.power_type == PowerTypes.TYPE_FOCUS:
            return self.power_3
        elif self.power_type == PowerTypes.TYPE_ENERGY:
            return self.power_4
        return 0

    def get_max_power_value(self):
        if self.power_type == PowerTypes.TYPE_MANA:
            return self.max_power_1
        elif self.power_type == PowerTypes.TYPE_RAGE:
            return self.max_power_2
        elif self.power_type == PowerTypes.TYPE_FOCUS:
            return self.max_power_3
        elif self.power_type == PowerTypes.TYPE_ENERGY:
            return self.max_power_4
        return 0

    def recharge_power(self):
        max_power = self.get_max_power_value()
        if self.power_type == PowerTypes.TYPE_MANA:
            self.set_mana(max_power)
        elif self.power_type == PowerTypes.TYPE_RAGE:
            self.set_rage(max_power)
        elif self.power_type == PowerTypes.TYPE_FOCUS:
            self.set_focus(max_power)
        elif self.power_type == PowerTypes.TYPE_ENERGY:
            self.set_energy(max_power)

    def set_health(self, health):
        if health < 0:
            health = 0
        self.health = health
        self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, health)

    def set_max_health(self, health):
        self.max_health = health
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, health)

    def set_mana(self, mana):
        if mana < 0:
            mana = 0
        self.power_1 = min(mana, self.max_power_1)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER1, mana)

    def set_rage(self, rage):
        if rage < 0:
            rage = 0
        self.power_2 = min(rage, self.max_power_2)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER2, rage)

    def set_focus(self, focus):
        if focus < 0:
            focus = 0
        self.power_3 = min(focus, self.max_power_3)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER3, focus)

    def set_energy(self, energy):
        if energy < 0:
            energy = 0
        self.power_4 = min(energy, self.max_power_4)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER4, energy)

    def set_max_mana(self, mana):
        self.max_power_1 = mana
        self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_armor(self, total_armor, item_armor):
        self.resistance_0 = total_armor
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS, item_armor)

    def set_holy_res(self, total_holy_res, item_holy_res):
        self.resistance_1 = total_holy_res
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + 1, item_holy_res)

    def set_fire_res(self, total_fire_res, item_fire_res):
        self.resistance_2 = total_fire_res
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + 2, item_fire_res)

    def set_nature_res(self, total_nature_res, item_nature_res):
        self.resistance_3 = total_nature_res
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + 3, item_nature_res)

    def set_frost_res(self, total_frost_res, item_frost_res):
        self.resistance_4 = total_frost_res
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + 4, item_frost_res)

    def set_shadow_res(self, total_shadow_res, item_shadow_res):
        self.resistance_5 = total_shadow_res
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + 5, item_shadow_res)

    def set_bonus_armor(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE, negative_mods)

    def set_bonus_holy_res(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 1, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 1, negative_mods)

    def set_bonus_fire_res(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 2, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 2, negative_mods)

    def set_bonus_nature_res(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 3, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 3, negative_mods)

    def set_bonus_frost_res(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 4, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 4, negative_mods)

    def set_bonus_shadow_res(self, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 5, positive_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 5, negative_mods)

    def set_bonus_damage_done_for_school(self, value, school):  # TODO Fields
        self.set_int32(UnitFields.UNIT_FIELD_MOD_DAMAGE_DONE + school, value)

    def set_melee_damage(self, min_dmg, max_dmg):
        damages = unpack('<I', pack('<2H', min_dmg, max_dmg))[0]
        self.damage = damages
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, damages)

    def set_melee_attack_time(self, attack_time):
        self.base_attack_time = attack_time
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, attack_time)

    def set_offhand_attack_time(self, attack_time):
        self.offhand_attack_time = attack_time
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, attack_time)

    def set_weapon_mode(self, weapon_mode):
        self.sheath_state = weapon_mode

        # TODO: Implement temp enchants updates.
        if WeaponMode.NORMALMODE:
            # Update main hand temp enchants
            # Update off hand temp enchants
            pass
        elif WeaponMode.RANGEDMODE:
            # Update ranged temp enchants
            pass

    def set_shapeshift_form(self, shapeshift_form):
        self.shapeshift_form = shapeshift_form

    def has_form(self, shapeshift_form):
        return self.shapeshift_form == shapeshift_form

    def is_in_feral_form(self):
        return self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BEAR) or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_CAT)

    # Implemented by PlayerManager
    def add_combo_points_on_target(self, target, combo_points):
        pass

    # Implemented by PlayerManager
    def remove_combo_points(self):
        pass

    def set_taxi_flying_state(self, is_flying, mount_display_id=0):
        if is_flying:
            self.mount(mount_display_id)
            self.unit_flags |= (UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)
        else:
            self.unmount()
            self.unit_flags &= ~(UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)

        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    # override
    def set_display_id(self, display_id):
        super().set_display_id(display_id)
        if display_id <= 0 or not \
                DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(display_id):
            return False

        self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.current_display_id)
        return True

    def set_channel_object(self, guid):
        self.channel_object = guid
        self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, guid)

    def set_channel_spell(self, spell_id):
        self.channel_spell = spell_id
        self.set_uint64(UnitFields.UNIT_CHANNEL_SPELL, spell_id)

    def die(self, killer=None):
        if not self.is_alive:
            return False
        self.is_alive = False

        # Reset movement and unit state flags.
        self.movement_flags = MoveFlags.MOVEFLAG_NONE
        self.unit_state = UnitStates.NONE

        # Stop movement on death.
        if len(self.movement_manager.pending_waypoints) > 0:
            self.movement_manager.send_move_stop()

        self.set_health(0)
        self.set_stand_state(StandState.UNIT_DEAD)

        self.unit_flags = UnitFlags.UNIT_MASK_DEAD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_DEAD
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            if killer.current_selection == self.guid:
                killer.set_current_selection(killer.guid)

            # Clear combo of killer if this unit was the target
            if killer.combo_target == self.guid:
                killer.remove_combo_points()

        if killer and killer.object_type_mask & ObjectTypeFlags.TYPE_UNIT:
            killer.spell_manager.remove_unit_from_all_cast_targets(self.guid)  # Interrupt casting on target death
            killer.aura_manager.check_aura_procs(killed_unit=True)

        self.spell_manager.remove_all_casts()
        self.aura_manager.handle_death()

        self.leave_combat()
        return True

    def respawn(self):
        super().respawn()

        # Force leave combat just in case.
        self.leave_combat(force=True)
        self.set_current_target(0)
        self.is_alive = True

        self.unit_flags = UnitFlags.UNIT_FLAG_STANDARD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags = UnitDynamicTypes.UNIT_DYNAMIC_NONE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        self.set_stand_state(StandState.UNIT_STANDING)

    # override
    def on_cell_change(self):
        pass

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_UNIT
