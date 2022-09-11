from __future__ import annotations

import math
import random
from struct import pack
from typing import Optional

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.spell.aura.AuraManager import AuraManager
from game.world.managers.objects.spell.SpellManager import SpellManager
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.MovementManager import MovementManager
from game.world.managers.objects.units.player.StatManager import StatManager, UnitStats
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ByteUtils import ByteUtils
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, AttackTypes, ProcFlags, \
    ProcFlagsExLegacy, HitInfo, AttackSwingError, MoveFlags, VictimStates, UnitDynamicTypes, HighGuid
from utils.constants.SpellCodes import SpellMissReason, SpellHitFlags, SpellSchools, ShapeshiftForms, SpellImmunity
from utils.constants.UnitCodes import UnitFlags, StandState, WeaponMode, PowerTypes, UnitStates, RegenStatsFlags
from utils.constants.UpdateFields import UnitFields


class UnitManager(ObjectManager):
    def __init__(self,
                 channel_spell=0,
                 channel_object=0,
                 health=0,
                 power_type=0,
                 power_1=0,  # mana
                 power_2=0,  # rage
                 power_3=0,  # focus
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
                 base_hp=0,
                 base_mana=0,
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
                 summoner=None,
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
        self.race = 0
        self.class_ = 0
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
        self.base_hp = base_hp
        self.base_mana = base_mana
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
        self.summoner = summoner

        self.update_packet_factory.init_values(self.guid, UnitFields)

        self.is_alive = True
        self.in_combat = False
        self.is_evading = False
        self.evading_waypoints = []
        self.swing_error = AttackSwingError.NONE
        self.extra_attacks = 0
        self.last_regen = 0
        self.regen_flags = RegenStatsFlags.NO_REGENERATION
        self.attackers: dict[int, UnitManager] = {}
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

        # Immunity
        self._immunities = {}

        self.has_moved = False

        self.stat_manager = StatManager(self)
        self.aura_manager = AuraManager(self)
        self.movement_manager = MovementManager(self)
        # TODO: Support for CreatureManager is not added yet.
        from game.world.managers.objects.units.PetManager import PetManager
        self.pet_manager = PetManager(self)
        # Initialized by creatures only.
        self.threat_manager = None

    def is_within_interactable_distance(self, victim):
        current_distance = self.location.distance(victim.location)
        return current_distance <= UnitFormulas.interactable_distance(self, victim)

    # override
    def is_hostile_to(self, target):
        is_hostile = super().is_hostile_to(target)
        if is_hostile:
            return True

        # Might be neutral, but was attacked by target.
        return target and target.guid in self.attackers

    # override
    def can_attack_target(self, target):
        is_enemy = super().can_attack_target(target)
        if is_enemy:
            return True

        # Might be neutral, but was attacked by target.
        return target and target.guid in self.attackers

    def attack(self, victim: UnitManager):
        if not victim or victim == self:
            return False

        # Dead units can neither attack nor be attacked
        if not self.is_alive or not victim.is_alive:
            return False

        # Mounted players can't attack
        if self.get_type_id() == ObjectTypeIds.ID_PLAYER and self.mount_display_id > 0:
            return False

        # Invalid target.
        if not self.can_attack_target(victim):
            return False

        self.set_current_target(victim.guid)
        self.combat_target = victim

        victim.attackers[self.guid] = self
        self.attackers[victim.guid] = victim

        self.enter_combat()
        victim.enter_combat()

        # Reset offhand weapon attack
        if self.has_offhand_weapon():
            self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

        self.send_attack_start(self.combat_target.guid)

        return True

    def attack_stop(self):
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
        # Don't update melee swing timers while casting or stunned.
        if self.is_casting() or self.unit_state & UnitStates.STUNNED:
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

        # If no combat target exists but the unit is in combat with no attackers, leave combat return.
        if not self.combat_target:
            if self.in_combat and len(self.attackers) == 0:
                self.leave_combat()
            return False

        # If neither main hand attack and off hand attack are ready, return.
        if not self.is_attack_ready(AttackTypes.BASE_ATTACK) and \
                (self.has_offhand_weapon() and not self.is_attack_ready(AttackTypes.OFFHAND_ATTACK)):
            return False

        # If unit is casting, return.
        if self.spell_manager.is_casting():
            return False

        main_attack_delay = self.stat_manager.get_total_stat(UnitStats.MAIN_HAND_DELAY)
        off_attack_delay = self.stat_manager.get_total_stat(UnitStats.OFF_HAND_DELAY)

        # Out of reach.
        if not self.is_within_interactable_distance(self.combat_target):
            swing_error = AttackSwingError.NOTINRANGE
        # Not proper angle.
        elif not self.location.has_in_arc(self.combat_target.location, combat_angle):
            swing_error = AttackSwingError.BADFACING
        # Moving.
        elif self.movement_flags & MoveFlags.MOVEFLAG_MOTION_MASK:
            swing_error = AttackSwingError.MOVING
        # Not standing.
        elif self.stand_state != StandState.UNIT_STANDING:
            swing_error = AttackSwingError.NOTSTANDING
        # Dead target.
        elif not self.combat_target.is_alive:
            swing_error = AttackSwingError.DEADTARGET
        # Pacified.
        elif self.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED:
            swing_error = AttackSwingError.CANTATTACK
        else:
            # Main hand attack.
            if self.is_attack_ready(AttackTypes.BASE_ATTACK):
                # Prevent both hand attacks at the same time.
                if self.has_offhand_weapon():
                    if self.attack_timers[AttackTypes.OFFHAND_ATTACK] < 500:
                        self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, 500)

                self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK, False)
                self.set_attack_timer(AttackTypes.BASE_ATTACK, main_attack_delay)

            # Off hand attack.
            if self.has_offhand_weapon() and self.is_attack_ready(AttackTypes.OFFHAND_ATTACK):
                # Prevent both hand attacks at the same time.
                if self.attack_timers[AttackTypes.BASE_ATTACK] < 500:
                    self.set_attack_timer(AttackTypes.BASE_ATTACK, 500)

                self.attacker_state_update(self.combat_target, AttackTypes.OFFHAND_ATTACK, False)
                self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, off_attack_delay)

        if swing_error != AttackSwingError.NONE:
            self.set_attack_timer(AttackTypes.BASE_ATTACK, main_attack_delay)
            if self.has_offhand_weapon():
                self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, off_attack_delay)

            if self.get_type_id() == ObjectTypeIds.ID_PLAYER:
                if swing_error == AttackSwingError.NOTINRANGE:
                    self.send_attack_swing_not_in_range(self.combat_target)
                elif swing_error == AttackSwingError.BADFACING:
                    self.send_attack_swing_facing_wrong_way(self.combat_target)
                elif swing_error == AttackSwingError.DEADTARGET:
                    self.send_attack_swing_dead_target(self.combat_target)
                elif swing_error == AttackSwingError.NOTSTANDING:
                    self.send_attack_swing_not_standing(self.combat_target)

        self.swing_error = swing_error
        return swing_error == AttackSwingError.NONE

    def attacker_state_update(self, victim, attack_type, extra):
        if attack_type == AttackTypes.BASE_ATTACK:
            # No recent extra attack only at any non-extra attack.
            if not extra and self.extra_attacks > 0:
                self.execute_extra_attacks()
                return

            if self.spell_manager.cast_queued_melee_ability(attack_type):
                return  # Melee ability replaces regular attack.

        damage_info = self.calculate_melee_damage(victim, attack_type)
        if not damage_info:
            return

        if damage_info.total_damage > 0:
            victim.spell_manager.check_spell_interrupts(received_auto_attack=True, hit_info=damage_info.hit_info)

        self.handle_melee_attack_procs(damage_info)

        self.send_attack_state_update(damage_info)

        # Extra attack only at any non-extra attack.
        if not extra and self.extra_attacks > 0:
            self.execute_extra_attacks()

    def execute_extra_attacks(self):
        while self.extra_attacks > 0:
            self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK, True)
            self.extra_attacks -= 1

    def handle_melee_attack_procs(self, damage_info):
        damage_info.target.aura_manager.check_aura_procs(damage_info=damage_info, is_melee_swing=True)
        self.aura_manager.check_aura_procs(damage_info=damage_info, is_melee_swing=True)

        [unit.spell_manager.handle_damage_event_procs(damage_info=damage_info)
         for unit in [damage_info.attacker, damage_info.target]]

    def calculate_melee_damage(self, victim, attack_type):
        if not victim:
            return None

        if not self.is_alive or not victim.is_alive:
            return None

        damage_info = DamageInfoHolder()
        damage_info.attacker = self
        damage_info.target = victim
        damage_info.attack_type = attack_type

        dual_wield_penalty = 0.19 if self.has_offhand_weapon() else 0
        hit_info = victim.stat_manager.get_attack_result_against_self(self, attack_type, dual_wield_penalty)

        damage_info.damage = self.calculate_base_attack_damage(attack_type, SpellSchools.SPELL_SCHOOL_NORMAL, victim)
        damage_info.hit_info = hit_info
        damage_info.target_state = VictimStates.VS_WOUND  # Default state on successful attack.

        if hit_info & HitInfo.CRITICAL_HIT:
            damage_info.damage *= 2
            damage_info.proc_ex = ProcFlagsExLegacy.CRITICAL_HIT

        elif not hit_info & HitInfo.SUCCESS:
            damage_info.hit_info |= HitInfo.MISS
            damage_info.damage = 0
            # Check evade, there is no HitInfo flag for this.
            if victim.is_evading:
                damage_info.target_state = VictimStates.VS_EVADE
            elif hit_info & HitInfo.ABSORBED:
                damage_info.target_state = VictimStates.VS_IMMUNE
            elif hit_info & HitInfo.DODGE:
                damage_info.target_state = VictimStates.VS_DODGE
                damage_info.proc_victim |= ProcFlags.DODGE
            elif hit_info & HitInfo.PARRY:
                damage_info.target_state = VictimStates.VS_PARRY
                damage_info.proc_victim |= ProcFlags.PARRY
            elif hit_info & HitInfo.BLOCK:
                # 0.6 patch notes: "Blocking an attack no longer avoids all of the damage of an attack."
                # Completely mitigate damage on block.
                damage_info.target_state = VictimStates.VS_BLOCK
                damage_info.proc_victim |= ProcFlags.BLOCK

        damage_info.clean_damage = damage_info.total_damage = damage_info.damage

        # Generate rage (if needed).
        self.generate_rage(damage_info, is_attacking=True)

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

    def calculate_base_attack_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target,
                                     used_ammo: Optional[ItemManager] = None, apply_bonuses=True):
        min_damage, max_damage = self.calculate_min_max_damage(attack_type, attack_school, target)

        if min_damage > max_damage:
            tmp_min = min_damage
            min_damage = max_damage
            max_damage = tmp_min

        # Bullets/arrows can't be equipped in 0.5.3 and thus aren't included in item stats.
        # Add min/max ammo damage to base damage.
        if used_ammo:
            min_damage += used_ammo.item_template.dmg_min1
            max_damage += used_ammo.item_template.dmg_max1

        rolled_damage = random.randint(min_damage, max_damage)

        if apply_bonuses:
            subclass = -1
            equipped_weapon = self.get_current_weapon_for_attack_type(attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass
            rolled_damage = self.stat_manager.apply_bonuses_for_damage(rolled_damage, attack_school, target, subclass)

        return max(0, int(rolled_damage))

    def get_current_weapon_for_attack_type(self, attack_type: AttackTypes) -> Optional[ItemManager]:
        return None

    def regenerate(self, elapsed):
        if not self.is_alive or self.health == 0:
            return

        # The check to set Focus to 0 on movement needs to be outside of the 2 seconds timer to avoid being able to move
        # without losing Focus on that 2 seconds window.
        if self.power_type == PowerTypes.TYPE_FOCUS:
            # https://web.archive.org/web/20040420191923/http://www.worldofwar.net/articles/gencon2003_2.php
            # While a Hunter is standing still, Focus gradually increases. The moment a Hunter moves,
            # Focus drops to zero to prevent kiting. (Blizzard seems to be very anti-kiting;
            # several other features to minimize kiting are in place as well.)
            if self.has_moved:
                if self.power_3 > 0:
                    self.set_focus(0)

        self.last_regen += elapsed
        # Every 2 seconds.
        if self.last_regen >= 2:
            self.last_regen = 0

            # Healing aura increases regeneration "by 2 every second", and base points equal to 10.
            # Calculate 2/5 of hp5/mp5.
            health_regen = self.stat_manager.get_total_stat(UnitStats.HEALTH_REGENERATION_PER_5) * 0.4
            mana_regen = self.stat_manager.get_total_stat(UnitStats.POWER_REGENERATION_PER_5) * 0.4

            # Health
            if self.regen_flags & RegenStatsFlags.REGEN_FLAG_HEALTH:
                if self.health < self.max_health and not self.in_combat:
                    if health_regen < 1:
                        health_regen = 1

                    # Apply bonus if sitting.
                    if self.is_sitting():
                        health_regen += health_regen * 0.33

                    if self.health + health_regen >= self.max_health:
                        self.set_health(self.max_health)
                    elif self.health < self.max_health:
                        self.set_health(self.health + int(health_regen))

            # Powers
            # Check if this unit should regenerate its powers.
            if self.regen_flags & RegenStatsFlags.REGEN_FLAG_POWER:
                # Mana
                if self.power_type == PowerTypes.TYPE_MANA:
                    if self.power_1 < self.max_power_1:
                        if self.in_combat:
                            # 1% per second (5% per 5 seconds)
                            mana_regen = self.base_mana * 0.02

                        if mana_regen < 1:
                            mana_regen = 1

                        if self.power_1 + mana_regen >= self.max_power_1:
                            self.set_mana(self.max_power_1)
                        elif self.power_1 < self.max_power_1:
                            self.set_mana(self.power_1 + int(mana_regen))
                # Focus
                elif self.power_type == PowerTypes.TYPE_FOCUS:
                    # Don't do anything if the unit is moving.
                    if self.movement_flags & MoveFlags.MOVEFLAG_MOTION_MASK:
                        return

                    if self.power_3 < self.max_power_3:
                        # 1 Focus per second (2 every 2 seconds) is a guessed value based on the cost of spells.
                        if self.power_3 + 2 >= self.max_power_3:
                            self.set_focus(self.max_power_3)
                        elif self.power_3 < self.max_power_3:
                            self.set_focus(self.power_3 + 2)
                # Energy
                elif self.power_type == PowerTypes.TYPE_ENERGY:
                    if self.power_4 < self.max_power_4:
                        # Regenerating 5 Energy every 2 seconds instead of 20. This is a guess based on the cost of
                        # Sinister Strike in both 1.12 (45 Energy) and 0.5.3 (10 Energy). ((10 * 20) / 45 = 4.44)
                        if self.power_4 + 5 >= self.max_power_4:
                            self.set_energy(self.max_power_4)
                        elif self.power_4 < self.max_power_4:
                            self.set_energy(self.power_4 + 5)

            # Rage decay
            if self.power_type == PowerTypes.TYPE_RAGE:
                if self.power_2 > 0:
                    if not self.in_combat:
                        # Defensive Stance (71) description says:
                        #     "A defensive stance that reduces rage decay when out of combat. [...]."
                        # We assume the rage decay value is reduced by 50% when on Defensive Stance. We don't really
                        # know how much it should be reduced, but 50% seemed reasonable (1 point instead of 2).
                        rage_decay_value = 10 if self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE) else 20
                        self.set_rage(self.power_2 - rage_decay_value)

    # Warrior Stances and Bear Form.
    # Defensive Stance (71): "A defensive stance that reduces rage decay when out of combat.
    # Generate rage when you are hit."
    # Battle Stance (2457): "A balanced combat stance. Generate rage when hit and when you strike an opponent."
    # Berserker Stance (2458): "An aggressive stance. Generate rage when you strike an opponent."
    def generate_rage(self, damage_info, is_attacking=True):
        # Avoid regen if unit has no rage power type.
        if self.get_type_id() == ObjectTypeIds.ID_UNIT:
            if self.power_type != PowerTypes.TYPE_RAGE:
                return

        if not is_attacking and self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE) \
                or is_attacking and self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BERSERKERSTANCE) \
                or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BATTLESTANCE) \
                or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BEAR):
            self.set_rage(self.power_2 + UnitFormulas.calculate_rage_regen(damage_info, is_attacking=is_attacking))

    # Implemented by PlayerManager
    def handle_combat_skill_gain(self, damage_info):
        return

    # Implemented by PlayerManager
    def handle_spell_skill_gain(self, casting_spell):
        return False

    def calculate_min_max_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target):
        return self.stat_manager.get_base_attack_base_min_max_damage(AttackTypes(attack_type))

    def calculate_spell_damage(self, base_damage, spell_school: SpellSchools, target, spell_attack_type: AttackTypes = -1):
        if not target or not target.is_alive:
            return None

        damage_info = DamageInfoHolder()
        damage_info.attacker = self
        damage_info.target = target
        damage_info.attack_type = spell_attack_type if spell_attack_type != -1 else 0
        damage_info.damage_school_mask = spell_school
        
        subclass = 0
        if spell_attack_type != -1:
            equipped_weapon = self.get_current_weapon_for_attack_type(spell_attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass

        damage = self.stat_manager.apply_bonuses_for_damage(base_damage,
                                                            spell_school, target, subclass)

        damage_info.hit_info = target.stat_manager.get_spell_attack_result_against_self(self,
                                                                                        spell_attack_type, spell_school)
                                                             
        is_crit = damage_info.hit_info & SpellHitFlags.HIT_FLAG_CRIT
        # From 0.5.5 patch notes:
        #     "Critical hits with ranged weapons now do 100% extra damage."
        # We assume that ranged crits dealt 50% increased damage instead of 100%. The other option could be 200% but
        # 50% sounds more logical.
        crit_multiplier = 1.50 if spell_attack_type == AttackTypes.RANGED_ATTACK else 2.0
        if spell_school == SpellSchools.SPELL_SCHOOL_NORMAL:
            damage = int(damage * crit_multiplier if is_crit else damage)
            damage_info.damage = damage_info.clean_damage = damage_info.total_damage = damage
        else:
            damage_info.absorb = 0  # TODO: handle absorbs.
            damage_info.damage = int(damage * 1.5 if is_crit else damage)
            damage_info.total_damage = max(0, damage_info.damage - damage_info.absorb)

        return damage_info

    def deal_damage(self, target, damage, is_periodic=False, casting_spell=None):
        if not target or not target.is_alive:
            return

        if target.is_evading:
            return

        target.receive_damage(damage, source=self, is_periodic=is_periodic, casting_spell=casting_spell)

    def receive_damage(self, amount, source=None, is_periodic=False, casting_spell=None):
        # This method will return whether or not the unit is suitable to keep receiving damage.
        if not self.is_alive:
            return False

        if source is not self and not is_periodic and amount > 0:
            self.aura_manager.check_aura_interrupts(received_damage=True)
            self.spell_manager.check_spell_interrupts(received_damage=True)

        new_health = self.health - amount
        if new_health <= 0:
            self.die(killer=source)
            return False
        else:
            damage_info = DamageInfoHolder()
            damage_info.damage = amount
            damage_info.target = self
            self.set_health(new_health)
            self.generate_rage(damage_info, is_attacking=False)
        return True

    def receive_healing(self, amount, source=None):
        if not self.is_alive:
            return False

        new_health = self.health + amount
        if new_health > self.max_health:
            self.set_health(self.max_health)
        else:
            self.set_health(new_health)
        return True

    def receive_power(self, amount, power_type, source=None):
        if not self.is_alive:
            return False

        if self.power_type != power_type:
            return False

        new_power = self.get_power_type_value() + amount
        if power_type == PowerTypes.TYPE_MANA:
            self.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            self.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.set_energy(new_power)
        return True

    def apply_spell_damage(self, target, damage, casting_spell, is_periodic=False):
        if target.guid in casting_spell.object_target_results:
            miss_reason = casting_spell.object_target_results[target.guid].result
        else:  # TODO Proc damage effects (SPELL_AURA_PROC_TRIGGER_DAMAGE) can't fill target results - should they be able to miss?
            miss_reason = SpellMissReason.MISS_REASON_NONE

        # Overwrite if evading.
        if target.is_evading:
            miss_reason = SpellMissReason.MISS_REASON_EVADED

        # TODO This and evade should be written in spell target results instead.
        # Overwrite on immune.
        if target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            if target.handle_immunity(self, SpellImmunity.IMMUNITY_DAMAGE, casting_spell.spell_entry.School,
                                      spell_id=casting_spell.spell_entry.ID):
                miss_reason = SpellMissReason.MISS_REASON_IMMUNE

        damage_info = self.calculate_spell_damage(damage, casting_spell.spell_entry.School, target,
                                                  casting_spell.spell_attack_type)

        if miss_reason in {SpellMissReason.MISS_REASON_EVADED, SpellMissReason.MISS_REASON_IMMUNE}:
            damage_info.damage = damage_info.total_damage = 0
            damage_info.hit_info = HitInfo.MISS
            damage_info.proc_victim |= ProcFlags.NONE

        is_cast_on_swing = casting_spell.casts_on_swing()
        if is_cast_on_swing or casting_spell.is_ranged_weapon_attack():  # TODO Should other spells give skill too?
            self.handle_combat_skill_gain(damage_info)
            target.handle_combat_skill_gain(damage_info)

        # Handle spell required skill gain.
        self.handle_spell_skill_gain(casting_spell)

        self.send_spell_cast_debug_info(damage_info, miss_reason, casting_spell, is_periodic=is_periodic)
        self.deal_damage(target, damage_info.damage, is_periodic=is_periodic, casting_spell=casting_spell)

    def apply_spell_healing(self, target, healing, casting_spell, is_periodic=False):
        miss_info = casting_spell.object_target_results[target.guid].result
        damage_info = casting_spell.get_cast_damage_info(self, target, healing, 0)
        self.send_spell_cast_debug_info(damage_info, miss_info, casting_spell, is_periodic=is_periodic, healing=True)
        target.receive_healing(healing, self)
        # From 0.5.4 Patch notes:
        #     "Healing over time generates hate."
        if casting_spell.generates_threat() and not is_periodic:
            self._threat_assist(target, healing)
        # Handle spell required skill gain.
        self.handle_spell_skill_gain(casting_spell)

    def _threat_assist(self, target, source_threat: float):
        if target.in_combat:
            creature_observers = [attacker for attacker
                                  in target.attackers.values()
                                  if not attacker.get_type_mask() & ObjectTypeFlags.TYPE_PLAYER]
            observers_size = len(creature_observers)
            if observers_size > 0:
                threat = source_threat / observers_size
                for creature in creature_observers:
                    creature.threat_manager.add_threat(self, threat)

    def send_spell_cast_debug_info(self, damage_info, miss_reason, casting_spell, is_periodic=False, healing=False):
        # TODO: Below use of flags (first field of the packet) might not be correct, needs further investigation.
        spell_id = casting_spell.spell_entry.ID

        if miss_reason != SpellMissReason.MISS_REASON_NONE:
            combat_log_data = pack('<i2Q2i',
                                   damage_info.hit_info,
                                   damage_info.attacker.guid, damage_info.target.guid, spell_id, miss_reason)
            combat_log_opcode = OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELLMISS
        else:
            combat_log_data = pack('<I2Q2If3I',
                                   damage_info.hit_info,
                                   damage_info.attacker.guid, damage_info.target.guid, spell_id,
                                   damage_info.total_damage, damage_info.damage, damage_info.damage_school_mask,
                                   damage_info.damage, damage_info.absorb)
            combat_log_opcode = OpCode.SMSG_ATTACKERSTATEUPDATEDEBUGINFOSPELL

        if not healing:
            MapManager.send_surrounding(PacketWriter.get_packet(combat_log_opcode, combat_log_data), self,
                                        include_self=self.get_type_id() == ObjectTypeIds.ID_PLAYER)

            # TODO: Need better understanding of the how the client is handling this opcode in order to produce
            #  the right packet structure.
            damage_data = pack('<Q2IiIQ',
                               damage_info.target.guid,
                               damage_info.total_damage,
                               damage_info.damage,
                               damage_info.hit_info,
                               0,  # SpellID. (0 will allow client to display damage from dots and cast on swing spells).
                               damage_info.attacker.guid)

            MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_DAMAGE_DONE, damage_data), self,
                                        include_self=self.get_type_id() == ObjectTypeIds.ID_PLAYER)
        elif casting_spell.initial_target_is_player():  # Healing effects are displayed to the affected player only.
            damage_info.target.enqueue_packet(PacketWriter.get_packet(combat_log_opcode, combat_log_data))

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

        # Remove self from attacker list of attackers.
        for guid, attacker in list(self.attackers.items()):
            if self.guid in attacker.attackers:
                # Always pop self from attacker.
                del attacker.attackers[self.guid]
                # Remove self from attacker threat manager.
                if attacker.get_type_id() == ObjectTypeIds.ID_UNIT:
                    attacker.threat_manager.remove_unit_threat(self.guid)
                # If by now the attacker has no more attackers, leave combat as well.
                if len(attacker.attackers) == 0:
                    attacker.leave_combat(force=force)

        self.attackers.clear()

        self.send_attack_stop(self.combat_target.guid if self.combat_target else self.guid)
        self.swing_error = 0

        self.combat_target = None
        self.in_combat = False
        self.unit_flags &= ~UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

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
        if stand_state == self.stand_state:
            return

        self.stand_state = stand_state
        self.aura_manager.check_aura_interrupts(changed_stand_state=True)

    def is_stealthed(self):
        return self.unit_flags & UnitFlags.UNIT_FLAG_SNEAK == UnitFlags.UNIT_FLAG_SNEAK

    def set_stealthed(self, stealthed):
        if stealthed:
            self.unit_flags |= UnitFlags.UNIT_FLAG_SNEAK
        else:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_SNEAK
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    # Implemented by CreatureManager.
    def is_tameable(self):
        return False

    def get_pet(self):
        pet_id = self.get_uint64(UnitFields.UNIT_FIELD_SUMMON)
        if pet_id:
            pet = MapManager.get_surrounding_unit_by_guid(self, pet_id, include_players=True)
            return pet
        return None

    def get_summoner(self):
        summoner_id = self.get_uint64(UnitFields.UNIT_FIELD_SUMMONEDBY)
        if summoner_id:
            summoner = MapManager.get_surrounding_unit_by_guid(self, summoner_id, include_players=True)
            return summoner
        return None

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
            # Stop movement if needed.
            self.stop_movement()

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
        creature_template = WorldDatabaseManager.CreatureTemplateHolder.creature_get_by_entry(creature_entry)
        if not creature_template:
            return False

        self.mount(creature_template.display_id1)
        return True

    # TODO: this should be moved to specific creature and player implementations.
    def mount(self, mount_display_id):
        if mount_display_id > 0 and \
                DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(mount_display_id):
            self.mount_display_id = mount_display_id
            self.unit_flags |= UnitFlags.UNIT_MASK_MOUNTED
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            return True
        return False

    def unmount(self):
        self.mount_display_id = 0
        self.unit_flags &= ~UnitFlags.UNIT_MASK_MOUNTED
        self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def is_moving(self):
        return self.movement_manager.unit_is_moving()

    def is_casting(self):
        return self.spell_manager.is_casting()

    def stop_movement(self):
        # Stop only if unit has pending waypoints.
        if len(self.movement_manager.pending_waypoints) > 0:
            self.movement_manager.send_move_stop()

    # Implemented by Creature/PlayerManager.
    def update_power_type(self):
        pass

    def set_summoned_by(self, summoner: Optional[UnitManager]):
        self.summoner = summoner
        self.set_uint64(UnitFields.UNIT_FIELD_SUMMONEDBY, self.summoner.guid if self.summoner else 0)

    def get_power_type_value(self, power_type=-1):
        if power_type == -1:
            power_type = self.power_type

        if power_type == PowerTypes.TYPE_MANA:
            return self.power_1
        elif power_type == PowerTypes.TYPE_RAGE:
            return self.power_2
        elif power_type == PowerTypes.TYPE_FOCUS:
            return self.power_3
        elif power_type == PowerTypes.TYPE_ENERGY:
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

    def set_immunity(self, immunity_type: SpellImmunity, source_id, immunity_arg: int = -1, immune=True):
        # Note: source ID can be an aura slot or -1 for an innate immunity.
        immunities = self._immunities.get(immunity_type, {})
        if immune:
            immunities[source_id] = immunity_arg
        elif source_id in immunities:
            immunities.pop(source_id)
        self._immunities[immunity_type] = immunities

    def has_immunity(self, immunity_type: SpellImmunity, immunity_arg: int, is_mask=False):
        type_immunities = self._immunities.get(immunity_type, {})

        if not is_mask and immunity_type in {SpellImmunity.IMMUNITY_DAMAGE, SpellImmunity.IMMUNITY_SCHOOL}:
            immunity_arg = 1 << immunity_arg
            is_mask = True

        return immunity_arg in type_immunities.values() or \
            (is_mask and any(immunity_arg & mask for mask in type_immunities.values()))

    def handle_immunity(self, source, immunity_type: SpellImmunity,
                        immunity_arg, spell_id=0, is_mask=False) -> bool:
        # Also check school immunity on damage immunity.
        if self.has_immunity(immunity_type, immunity_arg, is_mask=is_mask) or \
            (immunity_type == SpellImmunity.IMMUNITY_DAMAGE and
                self.has_immunity(SpellImmunity.IMMUNITY_SCHOOL, immunity_arg, is_mask=is_mask)):
            self.spell_manager.send_cast_immune_result(source, spell_id)
            return True

        return False

    def set_health(self, health):
        if health < 0:
            health = 0
        self.health = min(health, self.max_health)
        self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)

    def set_max_health(self, health):
        self.max_health = health
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, health)

    def set_mana(self, mana):
        if mana < 0:
            mana = 0
        self.power_1 = min(mana, self.max_power_1)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)

    def set_rage(self, rage):
        if rage < 0:
            rage = 0
        self.power_2 = min(rage, self.max_power_2)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER2, self.power_2)

    def set_focus(self, focus):
        if focus < 0:
            focus = 0
        self.power_3 = min(focus, self.max_power_3)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER3, self.power_3)

    def set_energy(self, energy):
        if energy < 0:
            energy = 0
        self.power_4 = min(energy, self.max_power_4)
        self.set_uint32(UnitFields.UNIT_FIELD_POWER4, self.power_4)

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
        damages = ByteUtils.shorts_to_int(max_dmg, min_dmg)
        self.damage = damages
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, damages)

    def set_melee_attack_time(self, attack_time):
        self.base_attack_time = attack_time
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, attack_time)

    def set_offhand_attack_time(self, attack_time):
        self.offhand_attack_time = attack_time
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, attack_time)

    def set_weapon_reach(self, reach):
        self.weapon_reach = reach
        self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, reach)

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

    def form_matches_mask(self, shapeshift_mask):
        if not self.shapeshift_form:
            return False
        return (1 << (self.shapeshift_form - 1)) & shapeshift_mask

    def is_in_feral_form(self):
        return self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BEAR) or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_CAT)

    # Implemented by PlayerManager
    def add_combo_points_on_target(self, target, combo_points, hide=False):
        pass

    # Implemented by PlayerManager
    def remove_combo_points(self):
        pass

    def set_taxi_flying_state(self, is_flying, mount_display_id=0):
        if is_flying:
            self.mount(mount_display_id)
            self.unit_flags |= (UnitFlags.UNIT_FLAG_FROZEN | UnitFlags.UNIT_FLAG_TAXI_FLIGHT)
        else:
            if self.unit_flags & UnitFlags.UNIT_MASK_MOUNTED:
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

    def flush_channel_fields(self):
        self.set_channel_object(0)
        self.set_channel_spell(0)

    def set_channel_object(self, guid):
        self.channel_object = guid
        self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, guid)

    def set_channel_spell(self, spell_id):
        self.channel_spell = spell_id
        self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, spell_id)

    def die(self, killer=None):
        if not self.is_alive:
            return False
        self.is_alive = False

        # Reset movement and unit state flags.
        self.movement_flags = MoveFlags.MOVEFLAG_NONE
        self.unit_state = UnitStates.NONE

        # Stop movement on death.
        self.stop_movement()

        # Detach from controller if this unit is a pet.
        if self.summoner:
            self.summoner.pet_manager.detach_active_pet()

        self.leave_combat(force=True)
        self.evading_waypoints.clear()
        self.set_health(0)
        self.set_stand_state(StandState.UNIT_DEAD)

        self.unit_flags |= UnitFlags.UNIT_MASK_DEAD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_DEAD
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            if killer.current_selection == self.guid:
                killer.set_current_selection(killer.guid)

            # Clear combo of killer if this unit was the target
            if killer.combo_target == self.guid:
                killer.remove_combo_points()

        if killer and killer.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            killer.spell_manager.remove_unit_from_all_cast_targets(self.guid)  # Interrupt casting on target death
            killer.aura_manager.check_aura_procs(killed_unit=True)

        self.spell_manager.remove_casts()
        self.aura_manager.handle_death()

        return True

    # override
    def destroy(self):
        # Make sure to remove casts from units that are destroyed not necessarily killed. e.g. Totems.
        if self.spell_manager:
            self.spell_manager.remove_casts()
            self.aura_manager.remove_all_auras()
        self.is_alive = False
        super().destroy()

    # override
    def respawn(self):
        # Force leave combat just in case.
        self.leave_combat(force=True)
        self.set_current_target(0)
        self.is_alive = True

        self.unit_flags &= ~UnitFlags.UNIT_MASK_DEAD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags = UnitDynamicTypes.UNIT_DYNAMIC_NONE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        self.set_stand_state(StandState.UNIT_STANDING)

    # Implemented by CreatureManager and PlayerManager
    def get_bytes_0(self):
        pass

    # Implemented by CreatureManager and PlayerManager
    def get_bytes_1(self):
        pass

    # Implemented by CreatureManager and PlayerManager
    def get_bytes_2(self):
        pass

    # Implemented by CreatureManager and PlayerManager
    def get_damages(self):
        pass

    # override
    def on_cell_change(self):
        pass

    # override
    def notify_moved_in_line_of_sight(self, target):
        pass

    def set_has_moved(self, has_moved):
        self.has_moved = has_moved

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_UNIT
