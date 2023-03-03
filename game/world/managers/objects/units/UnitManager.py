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
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.MovementManager import MovementManager
from game.world.managers.objects.units.player.StatManager import StatManager, UnitStats
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ByteUtils import ByteUtils
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.constants import CustomCodes
from utils.constants.DuelCodes import DuelState
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, AttackTypes, ProcFlags, \
    ProcFlagsExLegacy, HitInfo, AttackSwingError, MoveFlags, VictimStates, UnitDynamicTypes, HighGuid
from utils.constants.SpellCodes import SpellMissReason, SpellHitFlags, SpellSchools, ShapeshiftForms, SpellImmunity, \
    SpellSchoolMask
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
                 sheath_state=WeaponMode.SHEATHEDMODE,
                 shapeshift_form=0,
                 bytes_1=0,  # stand state, shapeshift form, sheathstate
                 dynamic_flags=0,
                 damage=0,  # current damage, max damage
                 bytes_2=0,  # combo points, 0, 0, 0
                 current_target=0,  # guid
                 combat_target=None,  # victim
                 summoner=None,
                 charmer=None,
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
        self.sheath_state = sheath_state
        self.shapeshift_form = shapeshift_form
        self.bytes_1 = bytes_1  # stand state, shapeshift form, sheathstate
        self.dynamic_flags = dynamic_flags
        self.damage = damage  # current damage, max damage
        self.bytes_2 = bytes_2  # combo points, 0, 0, 0
        self.current_target = current_target
        self.summoner = summoner
        self.charmer = charmer

        self.update_packet_factory.init_values(self.guid, UnitFields)

        self.is_alive = True
        self.in_combat = False
        self.is_evading = False
        self.swing_error = AttackSwingError.NONE
        self.extra_attacks = 0
        self.last_regen = 0
        self.mana_regen_timer = 0
        self.regen_flags = RegenStatsFlags.NO_REGENERATION

        self.attack_timers = {AttackTypes.BASE_ATTACK: 0,
                              AttackTypes.OFFHAND_ATTACK: 0,
                              AttackTypes.RANGED_ATTACK: 0}

        # Used to determine the current state of the unit (internal usage).
        self.unit_state = UnitStates.NONE
        # Used to handle sanctuary state.
        self.sanctuary_timer = 0

        # Defensive passive spells are not handled through the aura system.
        # The effects will instead flag the unit with these fields.
        self.has_block_passive = False
        self.has_parry_passive = False
        self.has_dodge_passive = False

        # Immunity.
        self._immunities = {}
        # School absorb.
        self._school_absorbs = {}
        # Effects modifying unit flags.
        self._flag_effects = dict(dict())  # Enum: (Flag: set())

        self.has_moved = False
        self.has_turned = False

        self.stat_manager = StatManager(self)
        self.aura_manager = AuraManager(self)
        self.movement_manager = MovementManager(self)
        from game.world.managers.objects.units.pet.PetManager import PetManager
        self.pet_manager = PetManager(self)
        # Players/Creatures.
        self.threat_manager = None

    def is_within_interactable_distance(self, victim):
        current_distance = self.location.distance(victim.location)
        return current_distance <= UnitFormulas.interactable_distance(self, victim)

    # override
    def is_hostile_to(self, target):
        if not target:
            return False

        # Always short circuit on charmer/summoner relationship.
        if self == target.get_charmer_or_summoner() or self.get_charmer_or_summoner() == target:
            return False

        return super().is_hostile_to(target)

    def can_perform_melee_attack(self):
        return self.combat_target and self.has_melee() and not self.is_casting() \
            and not self.unit_state & UnitStates.STUNNED and not self.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED \
            and not self.unit_flags & UnitFlags.UNIT_FLAG_FLEEING

    # override
    def can_attack_target(self, target):
        if not target or target is self:
            return False

        is_enemy = super().can_attack_target(target)
        if is_enemy:
            return True

        # Always short circuit on charmer/summoner relationship.
        charmer = self.get_charmer_or_summoner()
        if charmer is target or self is target.get_charmer_or_summoner():
            return False

        # Charmed unit whose charmer is dueling the target.
        if charmer and charmer.get_type_id() == ObjectTypeIds.ID_PLAYER and \
                charmer.duel_manager and charmer.duel_manager.is_unit_involved(target):
            return charmer.duel_manager.duel_state == DuelState.DUEL_STATE_STARTED

        # Might be neutral, but was attacked by target.
        return target and self.threat_manager.has_aggro_from(target)

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

        active_pet = self.pet_manager.get_active_controlled_pet()
        if active_pet:
            active_pet.creature.object_ai.owner_attacked(victim)

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
        # Don't update melee swing timers while casting, stunned, pacified or fleeing..
        if not self.can_perform_melee_attack():
            return False

        self.update_attack_time(AttackTypes.BASE_ATTACK, elapsed * 1000.0)
        if self.has_offhand_weapon():
            self.update_attack_time(AttackTypes.OFFHAND_ATTACK, elapsed * 1000.0)

        return self.update_melee_attacking_state()

    def update_melee_attacking_state(self):
        # Don't update melee swing timers while casting, stunned, pacified or fleeing..
        if not self.can_perform_melee_attack():
            return False

        swing_error = AttackSwingError.NONE
        combat_angle = math.pi

        # If neither main hand attack and off hand attack are ready, return.
        if not self.is_attack_ready(AttackTypes.BASE_ATTACK) and \
                (self.has_offhand_weapon() and not self.is_attack_ready(AttackTypes.OFFHAND_ATTACK)):
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

                self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK)
                self.set_attack_timer(AttackTypes.BASE_ATTACK, main_attack_delay)

            # Off hand attack.
            if self.has_offhand_weapon() and self.is_attack_ready(AttackTypes.OFFHAND_ATTACK):
                # Prevent both hand attacks at the same time.
                if self.attack_timers[AttackTypes.BASE_ATTACK] < 500:
                    self.set_attack_timer(AttackTypes.BASE_ATTACK, 500)

                self.attacker_state_update(self.combat_target, AttackTypes.OFFHAND_ATTACK)
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

    def attacker_state_update(self, victim, attack_type, extra=False):
        if not victim or not self.is_alive or not victim.is_alive or victim.unit_state & UnitStates.SANCTUARY:
            return

        self.aura_manager.check_aura_interrupts(attacked=True)
        if attack_type == AttackTypes.BASE_ATTACK:
            # No recent extra attack only at any non-extra attack.
            if not extra and self.extra_attacks > 0:
                self.execute_extra_attacks()

            melee_spell = self.spell_manager.get_queued_melee_ability()
            if melee_spell and self.spell_manager.cast_queued_melee_ability(attack_type):
                # Send attack update with deferred logging to display the cast in combat log/floating text.
                damage_info = DamageInfoHolder(attacker=self, target=victim,
                                               spell_id=melee_spell.spell_entry.ID, hit_info=HitInfo.DEFERRED_LOGGING)
                self.send_attack_state_update(damage_info)
                return

        damage_info = self.calculate_melee_damage(victim, attack_type)

        if damage_info.total_damage > 0:
            victim.spell_manager.check_spell_interrupts(received_auto_attack=True, hit_info=damage_info.hit_info)

        # Victim will not die with this hit.
        if not damage_info.hit_info & HitInfo.UNIT_DEAD:
            # The hit was successful, check melee attack procs.
            if damage_info.hit_info & HitInfo.SUCCESS:
                self.handle_melee_attack_procs(damage_info)
        else:  # Victim will die after this hit, reset extra attacks.
            self.extra_attacks = 0

        self.send_attack_state_update(damage_info)
        self.deal_damage(damage_info.target, damage_info)

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
        dual_wield_penalty = 0.19 if self.has_offhand_weapon() and attack_type != AttackTypes.RANGED_ATTACK else 0

        damage_info = DamageInfoHolder(attacker=self, target=victim,
                                       attack_type=attack_type,
                                       damage_school_mask=SpellSchoolMask.SPELL_SCHOOL_MASK_NORMAL)

        damage_info.hit_info = victim.stat_manager.get_attack_result_against_self(self, attack_type,
                                                                                  dual_wield_penalty=dual_wield_penalty)

        damage_info.base_damage = self.calculate_base_attack_damage(attack_type, SpellSchools.SPELL_SCHOOL_NORMAL, victim)
        damage_info.target_state = VictimStates.VS_WOUND  # Default state on successful attack.

        # Apply crit damage modifier first if necessary.
        if damage_info.hit_info & HitInfo.CRITICAL_HIT:
            damage_info.base_damage *= 2

        # Handle school absorb.
        damage_info.absorb = victim.get_school_absorb_for_damage(damage_info)
        if damage_info.absorb:
            damage_info.hit_info |= HitInfo.ABSORBED

        # Check evade, there is no HitInfo flag for this.
        if victim.is_evading:
            damage_info.target_state = VictimStates.VS_EVADE
        elif damage_info.hit_info & HitInfo.MISS:
            damage_info.base_damage = damage_info.total_damage = 0
        elif damage_info.hit_info & HitInfo.ABSORBED:
            # Immune.
            if not damage_info.absorb:
                damage_info.hit_info &= ~HitInfo.SUCCESS
                damage_info.base_damage = damage_info.total_damage = 0
                damage_info.target_state = VictimStates.VS_IMMUNE
            # Absorb.
            else:
                # Complete absorb.
                if damage_info.base_damage == damage_info.absorb:
                    damage_info.hit_info &= ~HitInfo.SUCCESS
                damage_info.total_damage = max(0, damage_info.base_damage - damage_info.absorb)
        elif damage_info.hit_info & HitInfo.DODGE:
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_DODGE
            damage_info.proc_victim |= ProcFlags.DODGE
        elif damage_info.hit_info & HitInfo.PARRY:
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_PARRY
            damage_info.proc_victim |= ProcFlags.PARRY
        elif damage_info.hit_info & HitInfo.BLOCK:
            # 0.6 patch notes: "Blocking an attack no longer avoids all of the damage of an attack."
            # Completely mitigate damage on block.
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_BLOCK
            damage_info.proc_victim |= ProcFlags.BLOCK
        else:  # Successful attack.
            if damage_info.hit_info & HitInfo.CRITICAL_HIT:
                damage_info.proc_ex = ProcFlagsExLegacy.CRITICAL_HIT
            damage_info.total_damage = damage_info.base_damage

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

        # If the victim is going to die due this attack.
        if victim.health - damage_info.total_damage <= 0:
            damage_info.hit_info |= HitInfo.UNIT_DEAD

        return damage_info

    def send_attack_state_update(self, damage_info):
        is_player = self.get_type_id() == ObjectTypeIds.ID_PLAYER
        attack_state_packet = damage_info.get_attacker_state_update_packet()
        MapManager.send_surrounding(attack_state_packet, self, include_self=is_player)

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
        if self.power_type == PowerTypes.TYPE_FOCUS and self.has_moved and self.get_power_value():
            # https://web.archive.org/web/20040420191923/http://www.worldofwar.net/articles/gencon2003_2.php
            # While a Hunter is standing still, Focus gradually increases. The moment a Hunter moves,
            # Focus drops to zero to prevent kiting. (Blizzard seems to be very anti-kiting;
            # several other features to minimize kiting are in place as well.)
            self.set_power_value(0)

        self.last_regen += elapsed
        self.mana_regen_timer = min(5, self.mana_regen_timer + elapsed)

        # Mana regen disruption.
        if self.spell_manager.get_casting_spell():
            self.mana_regen_timer = 0

        # Every 2 seconds.
        if self.last_regen < 2:
            return

        self.last_regen = 0
        self._power_regen_tick(PowerTypes.TYPE_HEALTH)
        self._power_regen_tick(self.power_type)

    def _power_regen_tick(self, power_type):
        # Compare regen flags to power type.
        regen_type_flag = RegenStatsFlags.REGEN_FLAG_HEALTH if power_type == PowerTypes.TYPE_HEALTH \
            else RegenStatsFlags.REGEN_FLAG_POWER

        if not self.regen_flags & regen_type_flag:
            return

        if power_type == PowerTypes.TYPE_FOCUS and self.has_moved:
            return  # Focus only generates when not moving.

        current_power = self.get_power_value(power_type)
        if power_type == PowerTypes.TYPE_RAGE:
            if current_power <= 0:
                return  # Rage only decays.
        elif current_power >= self.get_max_power_value(power_type):
            return  # Other powers only generate.

        regen_stat = UnitStats.POWER_REGEN_START << power_type if \
            power_type != PowerTypes.TYPE_HEALTH else UnitStats.HEALTH_REGENERATION_PER_5

        # TODO It's unclear how mana regeneration should behave and how it should be affected by casting.
        # 0.12: Life Tap no longer interrupts mana regeneration.
        # 1.4.0:
        #  Mana regeneration is now disrupted when a spell has completed casting rather than at the start of casting.
        #  It will resume normally five seconds after the last spell cast.
        #  This change increases the total time spent regenerating mana and
        #  therefore increases the total contribution from Spirit for mana-based classes.

        # Always regen 1% base mana per second.
        regen_per_5 = self.base_mana * 0.05 if power_type == PowerTypes.TYPE_MANA else 0

        # Apply regen bonuses from stats.
        # Apply mana regen bonus if the player hasn't cast for 5 seconds, and apply health regen bonus out of combat.
        # Note that mana regen auras are not affected by this restriction (only mp5 from spirit),
        # as they're implemented as periodic energize effects instead.
        if power_type not in {PowerTypes.TYPE_HEALTH, PowerTypes.TYPE_MANA} or \
            power_type == PowerTypes.TYPE_HEALTH and not self.in_combat or \
                (power_type == PowerTypes.TYPE_MANA and self.mana_regen_timer >= 5):
            regen_per_5 += self.stat_manager.get_total_stat(regen_stat, accept_negative=True)

        # Health regen from sitting.
        if power_type == PowerTypes.TYPE_HEALTH and not self.in_combat and self.is_sitting():
            regen_per_5 *= 4/3

        # Rage regen is set to the decay value in StatManager.
        # Set rage regen to 0 while in combat.
        if power_type == PowerTypes.TYPE_RAGE:
            if self.in_combat:
                regen_per_5 = 0
            elif self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE):
                # Defensive Stance (71) description says:
                #     "A defensive stance that reduces rage decay when out of combat. [...]."
                # There's no actual effect for this in the stance aura.
                # We assume the rage decay value is reduced by 50% when on Defensive Stance. We don't really
                # know how much it should be reduced, but 50% seemed reasonable (1 point instead of 2).
                regen_per_5 *= 0.5

        regen_per_tick = regen_per_5 * 0.4  # Regen per 5 -> regen per 2 (per tick).
        if 0 < regen_per_tick < 1:
            regen_per_tick = 1  # Round up to 1, but account for decay/zero regen.

        self.receive_power(int(regen_per_tick), power_type)

    # Warrior Stances and Bear Form.
    # Defensive Stance (71): "A defensive stance that reduces rage decay when out of combat.
    # Generate rage when you are hit."
    # Battle Stance (2457): "A balanced combat stance. Generate rage when hit and when you strike an opponent."
    # Berserker Stance (2458): "An aggressive stance. Generate rage when you strike an opponent."
    def generate_rage(self, damage_info, is_attacking=True):
        # Avoid regen if unit has no rage power type.
        if self.power_type != PowerTypes.TYPE_RAGE:
            return

        if not is_attacking and self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE) \
                or is_attacking and self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BERSERKERSTANCE) \
                or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BATTLESTANCE) \
                or self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_BEAR):
            self.receive_power(UnitFormulas.calculate_rage_regen(damage_info, is_attacking=is_attacking),
                               PowerTypes.TYPE_RAGE)

    # Implemented by PlayerManager
    def handle_combat_skill_gain(self, damage_info):
        return

    # Implemented by PlayerManager
    def handle_spell_cast_skill_gain(self, casting_spell):
        return False

    def calculate_min_max_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target):
        return self.stat_manager.get_base_attack_base_min_max_damage(AttackTypes(attack_type))

    def calculate_spell_damage(self, base_damage, miss_reason, hit_flags, spell_effect, target):
        spell = spell_effect.casting_spell

        damage_info = DamageInfoHolder(attacker=self, target=target, attack_type=spell.get_attack_type(),
                                       damage_school_mask=spell.get_school_mask(),
                                       spell_id=spell.spell_entry.ID,
                                       spell_school=spell.spell_entry.School,
                                       spell_miss_reason=miss_reason, hit_info=hit_flags)

        subclass = 0
        if self.get_type_id() == ObjectTypeIds.ID_PLAYER and damage_info.attack_type != -1:
            equipped_weapon = self.get_current_weapon_for_attack_type(damage_info.attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass

        spell_school = spell.spell_entry.School

        if spell_effect.is_periodic():
            # For periodic effects, add bonuses to the total damage, divide back into ticks and floor.
            effect_ticks = int(spell.get_duration() / spell_effect.aura_period)
            total_base_damage = base_damage * effect_ticks
            total_damage = self.stat_manager.apply_bonuses_for_damage(total_base_damage, spell_school,
                                                                      target, subclass)
            damage_info.base_damage = int(total_damage / effect_ticks)
        else:
            damage_info.base_damage = self.stat_manager.apply_bonuses_for_damage(base_damage, spell_school,
                                                                                 target, subclass)

        if spell.casts_on_swing():
            damage_info.hit_info |= HitInfo.DEFERRED_LOGGING

        if miss_reason in {SpellMissReason.MISS_REASON_EVADED, SpellMissReason.MISS_REASON_IMMUNE}:
            damage_info.target_state = VictimStates.VS_IMMUNE
            return damage_info

        # From 0.5.5 patch notes:
        #     "Critical hits with ranged weapons now do 100% extra damage."
        # We assume that ranged crits dealt 50% increased damage instead of 100%. The other option could be 200% but
        # 50% sounds more logical.
        if damage_info.hit_info & SpellHitFlags.CRIT and not spell_effect.is_periodic():
            is_ranged = damage_info.attack_type == AttackTypes.RANGED_ATTACK
            crit_multiplier = 1.50 if is_ranged else 2.0
            damage_info.proc_ex = ProcFlagsExLegacy.CRITICAL_HIT
            damage_info.base_damage = int(damage_info.base_damage * crit_multiplier)

        damage_info.absorb = target.get_school_absorb_for_damage(damage_info)
        damage_info.total_damage = max(0, damage_info.base_damage - damage_info.absorb)

        return damage_info

    def deal_damage(self, target, damage_info, casting_spell=None, is_periodic=False):
        if not target or not target.is_alive:
            return

        if target.is_evading:
            return

        target.receive_damage(damage_info, source=self, casting_spell=casting_spell, is_periodic=is_periodic)

    def receive_damage(self, damage_info, source=None, casting_spell=None, is_periodic=False):
        # This method will return whether or not the unit is suitable to keep receiving damage.
        if not self.is_alive:
            return False

        if source is not self and not is_periodic and damage_info.total_damage > 0:
            self.aura_manager.check_aura_interrupts(received_damage=True)
            self.spell_manager.check_spell_interrupts(received_damage=True)

        new_health = self.health - damage_info.total_damage
        if new_health <= 0:
            self.die(killer=source)
            return False
        else:
            self.set_health(new_health)
            self.generate_rage(damage_info, is_attacking=False)

        # TODO: Threat calculation.
        if casting_spell and damage_info.total_damage == 0:
            self.threat_manager.add_threat(source)
            return True
        # Spell and does not generate threat.
        elif casting_spell and not casting_spell.generates_threat():
            return True
        # Aura ticking dots should not generate threat if out of combat. (Threat applied upon aura application)
        elif is_periodic and not self.threat_manager.has_aggro_from(source):
            return True

        self.threat_manager.add_threat(source, damage_info.total_damage)
        return True

    def receive_healing(self, amount, source=None):
        if not self.is_alive or self.health == self.max_health:
            return False

        new_health = self.health + amount
        # Clamp to 0 - max health.
        self.set_health(max(0, min(new_health, self.max_health)))
        return True

    def receive_power(self, amount: int, power_type, source=None):
        if not self.is_alive:
            return False

        if power_type == PowerTypes.TYPE_HEALTH:
            return self.receive_healing(amount, source=source)

        if self.power_type != power_type:
            return False

        self.set_power_value(self.get_power_value() + amount)
        return True

    def apply_spell_damage(self, target, damage, spell_effect):
        # Skip if target is invalid or already dead.
        if not target or not target.is_alive:
            return False

        spell = spell_effect.casting_spell

        target_result = spell.object_target_results.get(target.guid, None)
        if target_result:
            miss_reason, hit_flags = target_result.result, target_result.flags
        elif target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            # Proc auras (PROC_TRIGGER_DAMAGE/DAMAGE_SHIELD) have no persistent target results.
            # Roll miss reason here if the target is missing.
            miss_reason, hit_flags = target.stat_manager.get_spell_miss_result_against_self(spell_effect.casting_spell)
        else:
            miss_reason, hit_flags = SpellMissReason.MISS_REASON_NONE, SpellHitFlags.NONE

        damage_info = self.calculate_spell_damage(damage, miss_reason, hit_flags, spell_effect, target)

        is_cast_on_swing = spell.casts_on_swing()
        # TODO Should other spells give skill too?
        if is_cast_on_swing or spell.is_ranged_weapon_attack():
            self.handle_combat_skill_gain(damage_info)
            target.handle_combat_skill_gain(damage_info)

        if damage_info.hit_info & HitInfo.DEFERRED_LOGGING:
            # Spells with deferred logging aren't logged until an attack state update is sent with this flag.
            self.send_attack_state_update(damage_info)

        self.send_spell_cast_debug_info(damage_info, spell)
        self.deal_damage(target, damage_info, is_periodic=spell_effect.is_periodic(), casting_spell=spell)
        return True

    def apply_spell_healing(self, target, value, casting_spell, is_periodic=False):
        # Target is already at full health.
        if not target.receive_healing(value, self):
            return False

        damage_info = casting_spell.get_cast_damage_info(self, target, value, absorb=0, healing=True)
        damage_info.spell_miss_reason = casting_spell.object_target_results[target.guid].result

        self.send_spell_cast_debug_info(damage_info, casting_spell)

        # From 0.5.4 Patch notes:
        #     "Healing over time generates hate."
        if casting_spell.generates_threat() and not is_periodic:
            self._threat_assist(target, value)
        return True

    def _threat_assist(self, target, source_threat: float):
        if target.in_combat:
            creature_observers = [attacker for attacker
                                  in target.threat_manager.get_threat_holder_units()
                                  if not attacker.get_type_mask() & ObjectTypeFlags.TYPE_PLAYER]
            observers_size = len(creature_observers)
            if observers_size > 0:
                threat = source_threat / observers_size
                for creature in creature_observers:
                    creature.threat_manager.add_threat(self, threat)

    def send_spell_cast_debug_info(self, damage_info, casting_spell):
        is_player = self.get_type_id() == ObjectTypeIds.ID_PLAYER
        spell_debug_packet = damage_info.get_attacker_state_update_spell_info_packet()
        target_is_player = damage_info.target.get_type_id() == ObjectTypeIds.ID_PLAYER
        if not damage_info.hit_info & SpellHitFlags.HEALED:
            MapManager.send_surrounding(spell_debug_packet, self, include_self=is_player)
            damage_done_packet = damage_info.get_damage_done_packet()
            MapManager.send_surrounding(damage_done_packet, self, include_self=is_player)
        # Healing effects are displayed to the affected player only.
        elif casting_spell.initial_target_is_player() and target_is_player:
            damage_info.target.enqueue_packet(spell_debug_packet)

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
        return self.has_block_passive and not self.spell_manager.is_casting() and \
               not self.unit_state & UnitStates.STUNNED

    def can_parry(self, attacker_location=None):
        return self.has_parry_passive and not self.spell_manager.is_casting() and \
               not self.unit_state & UnitStates.STUNNED

    def can_dodge(self, attacker_location=None):
        return self.has_dodge_passive and not self.spell_manager.is_casting() and \
               not self.unit_state & UnitStates.STUNNED

    def enter_combat(self, source=None):
        if self.in_combat:
            return False

        self.in_combat = True
        self.unit_flags |= UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
        # Handle enter combat interrupts.
        self.aura_manager.check_aura_interrupts(enter_combat=True)
        return True

    def leave_combat(self):
        if not self.in_combat:
            return

        self.send_attack_stop(self.combat_target.guid if self.combat_target else self.guid)
        self.swing_error = 0
        self.extra_attacks = 0

        # Reset threat table.
        self.threat_manager.reset()

        self.combat_target = None
        self.in_combat = False
        self.unit_flags &= ~UnitFlags.UNIT_FLAG_IN_COMBAT
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def is_attack_ready(self, attack_type):
        return self.attack_timers[attack_type] <= 0

    def update_attack_time(self, attack_type, value):
        if not self.is_attack_ready(attack_type):
            new_value = max(0, self.attack_timers[attack_type] - value)
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

    def set_sanctuary(self, active, time_secs=0):
        if active:
            self.unit_state |= UnitStates.SANCTUARY
            self.sanctuary_timer = time_secs
        else:
            self.unit_state &= ~UnitStates.SANCTUARY
            self.sanctuary_timer = 0

    def update_sanctuary(self, elapsed):
        if self.sanctuary_timer > 0:
            self.sanctuary_timer = max(0, self.sanctuary_timer - elapsed)
            if self.sanctuary_timer == 0:
                self.set_sanctuary(False)

    # Implemented by CreatureManager.
    def is_tameable(self):
        return False

    def get_possessed_unit(self):
        possessed_id = self.get_uint64(UnitFields.UNIT_FIELD_CHARM)
        if possessed_id:
            unit = MapManager.get_surrounding_unit_by_guid(self, possessed_id, include_players=True)
            return unit if unit and unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED else None
        return None

    # override
    def change_speed(self, speed=0):
        # Assign new base speed.
        self.stat_manager.base_stats[UnitStats.SPEED_RUNNING] = speed if speed > 0 else config.Unit.Defaults.run_speed
        # Get new total speed.
        speed = self.stat_manager.get_total_stat(UnitStats.SPEED_RUNNING)
        # Limit to 0-56 and assign object field.
        change_speed = super().change_speed(speed)
        # Speed was modified, update current spline if needed.
        if change_speed and self.is_moving():
            self.movement_manager.set_speed_dirty()
        return change_speed

    # override
    def can_detect_target(self, target, distance=0):
        if not target.unit_flags & UnitFlags.UNIT_FLAG_SNEAK:
            return True, False

        # No distance provided, calculate here.
        if not distance:
            distance = self.location.distance(target.location)

        if distance > 30.0:
            return False, False

        self_is_player = self.get_type_id() == ObjectTypeIds.ID_PLAYER
        target_is_player = target.get_type_id() == ObjectTypeIds.ID_PLAYER

        # Invisibility.

        invisibility_skill = target.stat_manager.get_total_stat(UnitStats.INVISIBILITY)
        invisibility_detect_skill = self.stat_manager.get_total_stat(UnitStats.INVISIBILITY_DETECTION)

        # Handle invisibility detection by raw skill comparison.
        if invisibility_detect_skill > invisibility_skill:
            return True, False
        # Unit has invisibility and was not detected by skill, not detectable.
        elif invisibility_skill:
            return False, False

        # Collision.
        if distance < 1.5:
            return True, False

        # Stealth.
        if self_is_player and target_is_player:
            visible_distance = 9.0
        elif self_is_player and not target_is_player:
            visible_distance = 21.0
        else:
            visible_distance = 5.0 / 6.0

        yards_per_level = 1.5 if self_is_player else 5.0 / 6.0

        # TODO: consider 'Stealth' player skill?.
        #  Vanilla handles invisibility using masks, mod invisibility misc values are always 0 for us.
        #  For now, merge stealth and invisibility handling, use greater skill.
        if target_is_player:
            stealth_skill = target.stat_manager.get_total_stat(UnitStats.STEALTH)
        else:
            stealth_skill = target.level * 5

        stealth_detect_skill = self.level * 5 + self.stat_manager.get_total_stat(UnitStats.STEALTH_DETECTION)

        level_diff = abs(target.level - self.level)
        if level_diff > 3:
            yards_per_level *= 2

        visible_distance += (stealth_detect_skill - stealth_skill) * yards_per_level / 5.0

        if visible_distance > 30.0:
            visible_distance = 30.0
        elif visible_distance < 0.0:
            visible_distance = 0.0

        # Sneaking unit is behind, reduce visible distance.
        if not self.location.has_in_arc(target.location, math.pi):
            visible_distance = max(0.0, visible_distance - 9.0)

        alert = False
        # Creature vs Player, alert handling.
        if self.get_type_id() == ObjectTypeIds.ID_UNIT and target_is_player:
            alert_range = visible_distance + 5.0
            alert = alert_range >= distance > visible_distance

        return distance <= visible_distance, alert

    def is_stealthed(self) -> bool:
        return self.unit_flags & UnitFlags.UNIT_FLAG_SNEAK == UnitFlags.UNIT_FLAG_SNEAK

    def set_stealthed(self, active, index=-1) -> bool:
        return self.set_unit_flag(UnitFlags.UNIT_FLAG_SNEAK, active, index)

    def set_rooted(self, active, index=-1) -> bool:
        is_rooted = self.set_move_flag(MoveFlags.MOVEFLAG_ROOTED, active, index)
        is_rooted |= self.set_unit_state(UnitStates.ROOTED, active, index)

        if is_rooted:
            # Stop movement if needed.
            self.stop_movement()

        return is_rooted

    def set_stunned(self, active, index=-1) -> bool:
        self.set_rooted(active, index)

        was_stunned = self.unit_state & UnitStates.STUNNED
        is_stunned = self.set_unit_state(UnitStates.STUNNED, active, index)
        self.set_unit_flag(UnitFlags.UNIT_FLAG_DISABLE_ROTATE, active, index)

        if not was_stunned and is_stunned:
            self.spell_manager.remove_casts(remove_active=False)
            self.set_current_target(0)
        elif was_stunned and not is_stunned:
            # Restore combat target on stun remove.
            if self.combat_target and self.combat_target.is_alive:
                self.set_current_target(self.combat_target.guid)

        return is_stunned

    def set_unit_state(self, unit_state, active, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitStates, unit_state, active, index)
        if is_active:
            self.unit_state |= unit_state
        else:
            self.unit_state &= ~unit_state

        return is_active

    def set_unit_flag(self, unit_flag, active, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitFlags, unit_flag, active, index)
        if is_active:
            self.unit_flags |= unit_flag
        else:
            self.unit_flags &= ~unit_flag

        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
        return is_active

    def set_move_flag(self, move_flag, active, index=-1) -> bool:
        is_active = self._set_effect_flag_state(MoveFlags, move_flag, active, index)
        if is_active:
            self.movement_flags |= move_flag
        else:
            self.movement_flags &= ~move_flag

        return is_active

    def set_dynamic_type_flag(self, type_flag, active, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitDynamicTypes, type_flag, active, index)
        if is_active:
            self.dynamic_flags |= type_flag
        else:
            self.dynamic_flags &= ~type_flag

        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        return is_active

    def _set_effect_flag_state(self, flag_type, flag, active, index=-1) -> bool:
        # Initialize required containers.
        if flag_type not in self._flag_effects:
            self._flag_effects[flag_type] = dict()
        if flag not in self._flag_effects[flag_type]:
            self._flag_effects[flag_type][flag] = set()

        # Add/remove flag.
        effects = self._flag_effects[flag_type][flag]
        if active:
            effects.add(index)
        else:
            effects.discard(index)

        # Clean up empty containers.
        if not effects:
            self._flag_effects[flag_type].pop(flag)
        if not self._flag_effects[flag_type]:
            self._flag_effects.pop(flag_type)

        return len(effects) > 0  # Return True if this flag should be set for the unit.

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
        return True

    def is_moving(self):
        return self.movement_manager.unit_is_moving()

    def stop_movement(self):
        # Stop only if unit has pending waypoints.
        if self.is_moving():
            self.movement_manager.stop()

    # Implemented by Creature/PlayerManager.
    def update_power_type(self):
        pass

    # Implemented by CreatureManager.
    def get_charmer_or_summoner(self, include_self=False):
        return self.charmer if self.charmer \
            else self if include_self else None

    # Implemented by CreatureManager.
    def set_charmed_by(self, charmer, spell_id=0, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC, remove=False):
        self.charmer = charmer if not remove else None
        self.set_uint64(UnitFields.UNIT_FIELD_CHARMEDBY, charmer.guid if not remove else 0)
        charmer.set_uint64(UnitFields.UNIT_FIELD_CHARM, self.guid if not remove else 0)
        # Set faction, either original or charmer. (Restored on CreatureManager/PlayerManager)
        self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)

    # Implemented by CreatureManager.
    def set_summoned_by(self, summoner, spell_id=0, subtype=CustomCodes.CreatureSubtype.SUBTYPE_GENERIC, remove=False):
        # Link self to summoner.
        summoner.set_uint64(UnitFields.UNIT_FIELD_SUMMON, self.guid if not remove else 0)
        # Set faction, either original or summoner. (Restored on CreatureManager/PlayerManager)
        self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)

    def set_can_abandon(self, state: bool):
        if state:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PET_CAN_ABANDON
        else:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_PET_CAN_ABANDON
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def set_can_rename(self, state: bool):
        if state:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PET_CAN_RENAME
        else:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_PET_CAN_RENAME
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def set_player_controlled(self, state):
        if state:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED
        else:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

    def get_power_value(self, power_type=-1):
        if power_type == -1:
            power_type = self.power_type

        if power_type == PowerTypes.TYPE_HEALTH:
            return self.health
        elif power_type == PowerTypes.TYPE_MANA:
            return self.power_1
        elif power_type == PowerTypes.TYPE_RAGE:
            return self.power_2
        elif power_type == PowerTypes.TYPE_FOCUS:
            return self.power_3
        elif power_type == PowerTypes.TYPE_ENERGY:
            return self.power_4
        return 0

    def set_power_value(self, value: int, power_type=-1):
        if power_type == -1:
            power_type = self.power_type

        value = max(0, min(value, self.get_max_power_value(power_type)))  # Clamp to 0 - max power.

        if power_type == PowerTypes.TYPE_MANA:
            self.power_1 = value
        elif power_type == PowerTypes.TYPE_RAGE:
            self.power_2 = value
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.power_3 = value
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.power_4 = value

        self.set_uint32(UnitFields.UNIT_FIELD_POWER1 + power_type, value)

    def get_max_power_value(self, power_type=-1):
        if power_type == -1:
            power_type = self.power_type

        if power_type == PowerTypes.TYPE_HEALTH:
            return self.max_health
        elif power_type == PowerTypes.TYPE_MANA:
            return self.max_power_1
        elif power_type == PowerTypes.TYPE_RAGE:
            return self.max_power_2
        elif power_type == PowerTypes.TYPE_FOCUS:
            return self.max_power_3
        elif power_type == PowerTypes.TYPE_ENERGY:
            return self.max_power_4
        return 0

    def set_max_power_value(self, value, power_type=-1):
        if power_type == -1:
            power_type = self.power_type

        if power_type == PowerTypes.TYPE_MANA:
            self.max_power_1 = value
        elif power_type == PowerTypes.TYPE_RAGE:
            self.max_power_2 = value
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.max_power_3 = value
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.max_power_4 = value

    def recharge_power(self):
        max_power = self.get_max_power_value()
        self.set_power_value(max_power)

    def replenish_powers(self):
        # Set health and mana/energy to max.
        health = self.max_health
        if self.power_type in {PowerTypes.TYPE_MANA, PowerTypes.TYPE_ENERGY}:
            self.recharge_power()
        self.set_health(health)

    def set_school_absorb(self, school_mask, aura_index, value, absorb=True):
        # Initialize if needed.
        if school_mask not in self._school_absorbs:
            self._school_absorbs[school_mask] = {}
        if aura_index not in self._school_absorbs[school_mask]:
            self._school_absorbs[school_mask][aura_index] = 0

        if absorb:
            self._school_absorbs[school_mask][aura_index] = value
        elif school_mask in self._school_absorbs and aura_index in self._school_absorbs[school_mask]:
            self._school_absorbs[school_mask][aura_index] = 0

    def can_absorb(self, spell_school_mask: SpellSchoolMask):
        return spell_school_mask in self._school_absorbs and any(self._school_absorbs[spell_school_mask].values()) > 0 \
               or any(spell_school_mask & mask for mask in self._school_absorbs.keys())

    def get_school_absorb_for_damage(self, damage_info):
        if not self.can_absorb(damage_info.damage_school_mask):
            return 0

        school_mask = [mask for mask in self._school_absorbs.keys() if damage_info.damage_school_mask & mask][0]
        absorb_capability = 0   # Merge available sources for this school mask.
        damage_to_mitigate = damage_info.base_damage
        for aura_index, remaining in list(self._school_absorbs[school_mask].items()):
            if remaining:
                absorb_capability += remaining
                absorb = absorb_capability - damage_to_mitigate
                self._school_absorbs[school_mask][aura_index] = max(0, absorb)
                # Complete absorb.
                if absorb >= 0:
                    damage_to_mitigate = 0
                # Source depleted.
                else:
                    damage_to_mitigate -= remaining

            # Cancel depleted aura.
            if not self._school_absorbs[school_mask][aura_index]:
                # Remove source school absorb.
                self._school_absorbs[school_mask].pop(aura_index, None)
                # No more sources available for this school, remove the entire school.
                if len(self._school_absorbs[school_mask]) == 0:
                    del self._school_absorbs[school_mask]
                aura = self.aura_manager.get_aura_by_index(aura_index)
                if aura:
                    self.aura_manager.remove_aura(aura)

        # Calculate absorb.
        absorb = absorb_capability - damage_info.base_damage
        damage = damage_info.base_damage
        return int(damage if absorb >= 0 else damage - abs(absorb))

    def set_immunity(self, immunity_type: SpellImmunity, source_id, immunity_arg: int = -1, immune=True):
        # Note: source ID can be an aura slot or -1 for an innate immunity.
        immunities = self._immunities.get(immunity_type, {})
        if immune:
            immunities[source_id] = immunity_arg
        elif source_id in immunities:
            immunities.pop(source_id)
        self._immunities[immunity_type] = immunities

        # Remove any auras that collide with an added immunity.
        if not immune:
            return

        for aura in list(self.aura_manager.active_auras.values()):
            if aura.spell_effect.is_target_immune(aura.target):
                self.aura_manager.remove_aura(aura)

    def has_immunity(self, immunity_type: SpellImmunity, immunity_arg: int, is_mask=False):
        type_immunities = self._immunities.get(immunity_type, {})

        if not is_mask and immunity_type in {SpellImmunity.IMMUNITY_DAMAGE, SpellImmunity.IMMUNITY_SCHOOL}:
            immunity_arg = 1 << immunity_arg
            is_mask = True

        return immunity_arg in type_immunities.values() or \
            (is_mask and any(immunity_arg & mask for mask in type_immunities.values()))

    def handle_immunity(self, source, immunity_type: SpellImmunity,
                        immunity_arg, casting_spell=None, is_mask=False) -> bool:
        # Also check school immunity on damage immunity.
        if self.has_immunity(immunity_type, immunity_arg, is_mask=is_mask) or \
            (immunity_type == SpellImmunity.IMMUNITY_DAMAGE and
                self.has_immunity(SpellImmunity.IMMUNITY_SCHOOL, immunity_arg, is_mask=is_mask)):
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
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    def set_shapeshift_form(self, shapeshift_form):
        self.shapeshift_form = shapeshift_form

    # Implemented by CreatureManager
    def has_melee(self):
        return True

    def has_form(self, shapeshift_form):
        return self.shapeshift_form == shapeshift_form

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

        if self.object_ai:
            self.object_ai.just_died()

        # Notify killer's pet AI about this kill.
        if killer and killer.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            killer_pet = killer.pet_manager.get_active_controlled_pet()
            if killer_pet:
                killer_pet.creature.object_ai.killed_unit(self)

        # Leave combat if needed.
        self.leave_combat()

        # Flush movement manager.
        self.movement_manager.flush()

        # Reset threat manager.
        self.threat_manager.reset()

        self.pet_manager.detach_active_pets()

        self.set_health(0)

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
            killer.aura_manager.check_aura_procs(killed_unit=True)

        self.spell_manager.remove_casts()
        self.aura_manager.handle_death()

        return True

    # override
    def destroy(self):
        # Make sure to remove casts from units that are destroyed but not necessarily killed. e.g. Totems.
        if self.spell_manager:
            self.spell_manager.remove_casts()
            self.aura_manager.remove_all_auras()

        charmer = self.get_charmer_or_summoner()
        # (Game objects can spawn creatures, but they don't have a PetManager).
        if charmer and charmer.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            active_pet = charmer.pet_manager.get_active_pet_by_guid(self.guid)
            if active_pet:
                summon_spell = active_pet.get_pet_data().summon_spell_id
                charmer.spell_manager.remove_cast_by_id(summon_spell)
                charmer.aura_manager.remove_auras_by_caster(self.guid)
                charmer.spell_manager.unlock_spell_cooldown(summon_spell)

        self.is_alive = False
        super().destroy()

    def is_swimming(self):
        return self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING

    def is_above_water(self):
        return not self.is_swimming()

    # override
    def respawn(self):
        # Force leave combat just in case.
        self.leave_combat()
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

    def set_has_moved(self, has_moved, has_turned, flush=False):
        # Only turn off once processed.
        if flush:
            self.has_moved = False
            self.has_turned = False
        else:  # Only turn ON.
            if not self.has_moved and has_moved:
                self.has_moved = has_moved
            if not self.has_turned and has_turned:
                self.has_turned = has_turned

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_UNIT

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    # override
    def generate_object_guid(self, low_guid):
        if self.is_pet():
            return low_guid | HighGuid.HIGHGUID_PET
        return low_guid | HighGuid.HIGHGUID_UNIT
