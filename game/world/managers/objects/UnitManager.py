import math
import random
from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.MovementManager import MovementManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.AuraManager import AuraManager
from game.world.managers.objects.spell.SpellManager import SpellManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils import Formulas
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, AttackTypes, ProcFlags, \
    ProcFlagsExLegacy, HitInfo, AttackSwingError, MoveFlags, VictimStates, UnitDynamicTypes
from utils.constants.UnitCodes import UnitFlags, StandState, WeaponMode, SplineFlags
from utils.constants.UpdateFields import UnitFields


class DamageInfoHolder:
    def __init__(self,
                 attacker=None,
                 target=None,
                 damage_school_mask=0,
                 attack_type=AttackTypes.BASE_ATTACK,
                 total_damage=0,
                 damage=0,
                 clean_damage=0,
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
        self.damage = damage
        self.clean_damage = clean_damage
        self.absorb = absorb
        self.resist = resist
        self.blocked_amount = blocked_amount
        self.target_state = target_state
        self.hit_info = hit_info
        self.proc_attacker = proc_attacker
        self.proc_victim = proc_victim
        self.proc_ex = proc_ex


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

        self.object_type.append(ObjectTypes.TYPE_UNIT)
        self.update_packet_factory.init_values(UnitFields.UNIT_END)

        self.is_alive = True
        self.is_sitting = False
        self.in_combat = False
        self.swing_error = AttackSwingError.NONE
        self.extra_attacks = 0
        self.disarmed_mainhand = False
        self.disarmed_offhand = False
        self.attackers = {}
        self.attack_timers = {AttackTypes.BASE_ATTACK: 0,
                              AttackTypes.OFFHAND_ATTACK: 0,
                              AttackTypes.RANGED_ATTACK: 0}

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
        if self.get_type() == ObjectTypes.TYPE_PLAYER and self.mount_display_id > 0:
            return False

        # In fight already
        if self.combat_target:
            if self.combat_target == victim:
                if is_melee and self.is_within_interactable_distance(self.combat_target):
                    self.send_melee_attack_start(victim.guid)
                    return True
                return False

            self.attack_stop(target_switch=True)

        self.set_current_target(victim.guid)
        self.combat_target = victim
        victim.attackers[self.guid] = self

        # Reset offhand weapon attack
        if self.has_offhand_weapon():
            self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

        if is_melee and self.is_within_interactable_distance(self.combat_target):
            self.send_melee_attack_start(self.combat_target.guid)

        return True

    def attack_stop(self, target_switch=False):
        if self.combat_target and self.guid in self.combat_target.attackers:
            self.combat_target.attackers.pop(self.guid, None)

        # Clear target
        self.set_current_target(self.guid)
        victim = self.combat_target
        self.combat_target = None

        self.send_melee_attack_stop(victim.guid if victim else self.guid)
        self.set_dirty()

    def send_melee_attack_start(self, victim_guid):
        data = pack('<2Q', self.guid, victim_guid)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTART, data), self)

    def send_melee_attack_stop(self, victim_guid):
        # Last uint32 is "deceased"; can be either 1 (self is dead), or 0, (self is alive).
        # Forces the unit to face the corpse and disables clientside
        # turning (UnitFlags.DisableMovement) CGUnit_C::OnAttackStop
        data = pack('<2QI', self.guid, victim_guid, 0 if self.is_alive else 1)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data), self)

    def attack_update(self, elapsed):
        if self.combat_target and not self.combat_target.is_alive:
            self.leave_combat()
            self.set_dirty()
            return

        self.update_attack_time(AttackTypes.BASE_ATTACK, elapsed * 1000.0)
        if self.has_offhand_weapon():
            self.update_attack_time(AttackTypes.OFFHAND_ATTACK, elapsed * 1000.0)

        self.update_melee_attacking_state()

    def update_melee_attacking_state(self):
        swing_error = AttackSwingError.NONE
        combat_angle = math.pi

        if not self.combat_target:
            if self.in_combat and len(self.attackers) == 0:
                self.leave_combat()
                self.set_dirty()
            return False

        if not self.is_attack_ready(AttackTypes.BASE_ATTACK) and not self.is_attack_ready(AttackTypes.OFFHAND_ATTACK):
            return False

        current_angle = self.location.angle(self.combat_target.location)
        # Out of reach
        if not self.is_within_interactable_distance(self.combat_target):
            swing_error = AttackSwingError.NOTINRANGE
        # Not proper angle
        elif current_angle > combat_angle or current_angle < -combat_angle:
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

        if self.object_type == ObjectTypes.TYPE_PLAYER:
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

                self.send_melee_attack_stop(self.combat_target.guid)

        self.swing_error = swing_error
        return swing_error == AttackSwingError.NONE

    def attacker_state_update(self, victim, attack_type, extra):
        if attack_type == AttackTypes.BASE_ATTACK:
            # TODO: Cast current melee spell

            # No recent extra attack only at any non extra attack
            if not extra and self.extra_attacks > 0:
                self.execute_extra_attacks()
                return

            if self.spell_manager.cast_queued_melee_ability(attack_type):
                return  # Melee ability replaces regular attack

        damage_info = self.calculate_melee_damage(victim, attack_type)
        if not damage_info:
            return

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
        damage_info.damage += self.calculate_damage(attack_type)
        # Not taking "subdamages" into account
        damage_info.total_damage = damage_info.damage

        # Generate rage (if needed)
        self.generate_rage(damage_info, is_player=self.get_type() == ObjectTypes.TYPE_PLAYER)

        if attack_type == AttackTypes.BASE_ATTACK:
            damage_info.proc_attacker = ProcFlags.DEAL_COMBAT_DMG | ProcFlags.SWING
            damage_info.proc_victim = ProcFlags.TAKE_COMBAT_DMG
            damage_info.hit_info = HitInfo.SUCCESS
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            damage_info.proc_attacker = ProcFlags.DEAL_COMBAT_DMG | ProcFlags.SWING
            damage_info.proc_victim = ProcFlags.TAKE_COMBAT_DMG
            damage_info.hit_info = HitInfo.SUCCESS | HitInfo.OFFHAND
        elif attack_type == AttackTypes.RANGED_ATTACK:
            damage_info.proc_attacker = ProcFlags.DEAL_COMBAT_DMG
            damage_info.proc_victim = ProcFlags.TAKE_COMBAT_DMG
            damage_info.hit_info = HitInfo.DAMAGE  # ?

        # Prior to version 1.8, dual wield's miss chance had a hard cap of 19%,
        # meaning that all dual-wield auto-attacks had a minimum 19% miss chance
        # regardless of how much +hit% gear was equipped.
        # TODO FINISH IMPLEMENTING
        damage_info.target_state = VictimStates.VS_WOUND  # test remove later

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
                                    include_self=self.get_type() == ObjectTypes.TYPE_PLAYER)

        # Damage effects
        self.deal_damage(damage_info.target, damage_info.total_damage)

    def calculate_damage(self, attack_type):
        min_damage, max_damage = self.calculate_min_max_damage(attack_type)

        if min_damage > max_damage:
            tmp_min = min_damage
            min_damage = max_damage
            max_damage = tmp_min

        return random.randint(min_damage, max_damage)

    # Implemented by PlayerManager
    def generate_rage(self, damage_info, is_player=False):
        return

    # Implemented by PlayerManager and CreatureManager
    def calculate_min_max_damage(self, attack_type=0):
        return 0, 0

    def deal_damage(self, target, damage):
        if not target or not target.is_alive or damage < 1:
            return

        if self.guid not in target.attackers:
            target.attackers[self.guid] = self

        if not self.in_combat:
            self.enter_combat()
            self.set_dirty()

        if not target.in_combat:
            target.enter_combat()
            target.set_dirty()

        target.receive_damage(damage, source=self)

    def receive_damage(self, amount, source=None):
        is_player = self.get_type() == ObjectTypes.TYPE_PLAYER

        new_health = self.health - amount
        if new_health <= 0:
            self.die(killer=source)
        else:
            self.set_health(new_health)

        # If unit is a creature and it's being attacked by another unit, automatically set combat target.
        if not self.combat_target and not is_player and source and source.get_type() != ObjectTypes.TYPE_GAMEOBJECT:
            self.attack(source)

        update_packet = self.generate_proper_update_packet(is_self=is_player)
        MapManager.send_surrounding(update_packet, self, include_self=is_player)

    def deal_spell_damage(self, target, damage, school, spell_id):  # TODO Spell hit damage visual?
        data = pack('<IQQIIfiii', 1, self.guid, target.guid, spell_id,
                    damage, damage, school, damage, 0)
        packet = PacketWriter.get_packet(OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL, data)
        MapManager.send_surrounding(packet, target, include_self=target.get_type() == ObjectTypes.TYPE_PLAYER)
        self.deal_damage(target, damage)

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

    def enter_combat(self):
        self.in_combat = True
        self.unit_flags |= UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def leave_combat(self, force=False):
        if not self.in_combat and not force:
            return

        # Remove self from attacker list of attackers
        for victim in list(self.attackers.values()):
            victim.attackers.pop(self.guid)
        self.attackers.clear()

        self.send_melee_attack_stop(self.combat_target.guid if self.combat_target else self.guid)
        self.swing_error = 0

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
        if mount_display_id > 0 and DbcDatabaseManager.creature_display_info_get_by_id(mount_display_id):
            self.mount_display_id = mount_display_id
            self.unit_flags |= UnitFlags.UNIT_MASK_MOUNTED
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def unmount(self):
        self.mount_display_id = 0
        self.unit_flags &= ~UnitFlags.UNIT_MASK_MOUNTED
        self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

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

    def set_armor(self, armor):
        self.resistance_0 = armor
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)

    def set_holy_res(self, holy_res):
        self.resistance_1 = holy_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)

    def set_fire_res(self, fire_res):
        self.resistance_2 = fire_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)

    def set_nature_res(self, nature_res):
        self.resistance_3 = nature_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)

    def set_frost_res(self, frost_res):
        self.resistance_4 = frost_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)

    def set_shadow_res(self, shadow_res):
        self.resistance_5 = shadow_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)

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

    # Implemented by PlayerManager
    def add_combo_points_on_target(self, target, combo_points):
        pass

    # Implemented by PlayerManager
    def remove_combo_points(self):
        pass

    def set_stand_state(self, stand_state):
        self.stand_state = stand_state

    # override
    def set_display_id(self, display_id):
        super().set_display_id(display_id)
        if display_id <= 0 or not \
                DbcDatabaseManager.creature_display_info_get_by_id(display_id):
            return

        self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.current_display_id)

    def generate_proper_update_packet(self, is_self=False, create=False):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            self.get_full_update_packet(is_self=is_self) if create else self.get_partial_update_packet()))
        return update_packet

    def die(self, killer=None):
        if not self.is_alive:
            return False
        self.is_alive = False

        # Stop movement on death
        if len(self.movement_manager.pending_waypoints) > 0:
            self.movement_manager.send_move_to([self.location], self.running_speed, SplineFlags.SPLINEFLAG_NONE)

        self.set_health(0)
        self.set_stand_state(StandState.UNIT_DEAD)

        self.unit_flags = UnitFlags.UNIT_MASK_DEAD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_DEAD
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        if killer and killer.get_type() == ObjectTypes.TYPE_PLAYER:
            if killer.current_selection == self.guid:
                killer.set_current_selection(killer.guid)
                killer.set_dirty()

            # Clear combo of killer if this unit was the target
            if killer.combo_target == self.guid:
                killer.remove_combo_points()
                killer.set_dirty()

        # Clear all pending waypoint movement
        self.movement_manager.reset()

        self.leave_combat()
        return True

    def respawn(self):
        # Force leave combat just in case.
        self.leave_combat(force=True)
        self.set_current_target(self.guid)
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
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    def _allegiance_status_checker(self, target, check_friendly=True):
        own_faction = DbcDatabaseManager.faction_template_get_by_id(self.faction)
        target_faction = DbcDatabaseManager.faction_template_get_by_id(target.faction)
        # Some units currently have a bugged faction, terminate the method if this is encountered
        if not target_faction:
            return False
        own_enemies = [own_faction.Enemies_1, own_faction.Enemies_2, own_faction.Enemies_3, own_faction.Enemies_4]
        own_friends = [own_faction.Friend_1, own_faction.Friend_2, own_faction.Friend_3, own_faction.Friend_4]
        if target_faction.Faction > 0:
            for enemy in own_enemies:
                if enemy == target_faction.Faction:
                    return not check_friendly
            for friend in own_friends:
                if friend == target_faction.Faction:
                    return check_friendly

        if check_friendly:
            return ((own_faction.FriendGroup & target_faction.FactionGroup) or (own_faction.FactionGroup & target_faction.FriendGroup)) != 0
        else:
            return ((own_faction.EnemyGroup & target_faction.FactionGroup) or (own_faction.FactionGroup & target_faction.EnemyGroup)) != 0

    def is_friendly_to(self, target):
        return self._allegiance_status_checker(target, True)

    def is_enemy_to(self, target):
        return self._allegiance_status_checker(target, False)
