from __future__ import annotations

import random
from struct import pack
from typing import Optional, Any

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.helpers.CellUtils import VIEW_DISTANCE
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.spell.aura.AuraManager import AuraManager
from game.world.managers.objects.units.AttackRollInfo import AttackRollInfo
from game.world.managers.objects.units.AttackRoundAdvancedLogging import AttackRoundAdvancedLogging
from game.world.managers.objects.units.SpellAdvancedLogging import SpellAdvancedLogging
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.movement.MovementInfo import MovementInfo
from game.world.managers.objects.units.movement.MovementManager import MovementManager
from game.world.managers.objects.units.player.StatManager import StatManager, UnitStats
from network.packet.PacketWriter import PacketWriter
from utils.ByteUtils import ByteUtils
from utils.ConfigManager import config
from utils.Formulas import UnitFormulas
from utils.constants import CustomCodes
from utils.constants.DuelCodes import DuelState
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, AttackTypes, ProcFlags, \
    ProcFlagsExLegacy, HitInfo, AttackSwingError, MoveFlags, VictimStates, UnitDynamicTypes, HighGuid, EmoteUnitState, \
    SpeedType
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellMissReason, SpellHitFlags, SpellSchools, ShapeshiftForms, SpellImmunity, \
    SpellSchoolMask, SpellTargetMask, SpellAttributesEx, AuraState, AuraTypes
from utils.constants.UnitCodes import UnitFlags, StandState, WeaponMode, PowerTypes, UnitStates, RegenStatsFlags, \
    AIReactionStates
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
        self.resistance_buff_mods_positive = [resistance_buff_mods_positive_0, resistance_buff_mods_positive_1, 
                                              resistance_buff_mods_positive_2, resistance_buff_mods_positive_3, 
                                              resistance_buff_mods_positive_4, resistance_buff_mods_positive_5]
        self.resistance_buff_mods_negative = [resistance_buff_mods_negative_0, resistance_buff_mods_negative_1, 
                                              resistance_buff_mods_negative_2, resistance_buff_mods_negative_3, 
                                              resistance_buff_mods_negative_4, resistance_buff_mods_negative_5]
        self.base_attack_time = base_attack_time
        self.offhand_attack_time = offhand_attack_time
        # # Armor, holy, fire, nature, frost, shadow.
        self.resistances = [resistance_0, resistance_1, resistance_2, resistance_3, resistance_4, resistance_5]
        self.stand_state = stand_state
        self.sheath_state = sheath_state
        self.emote_unit_state = EmoteUnitState.NONE
        self.shapeshift_form = shapeshift_form
        self.bytes_1 = bytes_1  # stand state, shapeshift form, sheathstate
        self.dynamic_flags = dynamic_flags
        self.damage = damage  # current damage, max damage
        self.bytes_2 = bytes_2  # combo points, 0, 0, 0
        self.current_target = current_target
        self.summoner = summoner
        self.charmer = charmer
        self._is_guardian = False

        self.update_packet_factory.init_values(self.guid, UnitFields)

        self.is_alive = True
        self.in_combat = False
        self.is_evading = False
        self.swing_error = AttackSwingError.NONE
        self.extra_attacks = 0
        self.hp_percent = 100
        self.power_percent = 100
        self.last_regen = 0
        self.mana_regen_timer = 0
        self.regen_flags = RegenStatsFlags.NO_REGENERATION
        self._power_regen_remainder = {}
        self._power_regen_negative_logged = set()

        self.attack_timers = {AttackTypes.BASE_ATTACK: 0,
                              AttackTypes.OFFHAND_ATTACK: 0,
                              AttackTypes.RANGED_ATTACK: 0}
        # Milliseconds since last swing per attack type (used for attack round advanced logging).
        self.attack_swing_elapsed = {AttackTypes.BASE_ATTACK: 0,
                                     AttackTypes.OFFHAND_ATTACK: 0,
                                     AttackTypes.RANGED_ATTACK: 0}

        # Used to determine the current state of the unit (internal usage).
        self.unit_state = UnitStates.NONE
        # Used to handle sanctuary state.
        self.sanctuary_timer = 0
        # Cheat flags, used by Players.
        self.beast_master = False

        # Call for help and swim updates (Creatures).
        self.call_for_help_timer = 0
        self.swim_checks_enabled = False

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
        self._flag_effects = dict(dict())  # Enum: (Flag: set(source id))
        # Language override, used by spells like Curse of Tongues.
        self.language_mod = -1

        self.movement_info = MovementInfo(self)
        self.has_moved = False
        self.has_turned = False
        # The QuadTreeNode in which this unit stands, if any.
        self.quadtree_node = None

        self.invincibility_hp_level = 0
        self.melee_disabled = False

        self.stat_manager = StatManager(self)
        self.aura_manager = AuraManager(self)
        self.movement_manager = MovementManager(self)
        from game.world.managers.objects.units.pet.PetManager import PetManager
        self.pet_manager = PetManager(self)
        # Players/Creatures.
        self.threat_manager = None

    def __hash__(self):
        return self.guid

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

    def has_aggro(self):
        return self.threat_manager.has_aggro()

    def can_perform_melee_attack(self):
        return self.combat_target and self.has_melee() and not self.is_casting() \
            and not self.unit_state & UnitStates.STUNNED and not self.unit_flags & UnitFlags.UNIT_FLAG_PACIFIED \
            and not self.unit_flags & UnitFlags.UNIT_FLAG_FLEEING and not self.unit_state & UnitStates.CONFUSED

    def has_aura_pet_should_avoid_breaking(self, exclude_caster_channel=None) -> bool:
        return self.aura_manager.has_breakable_by_damage_crowd_control_aura(exclude_caster_channel)

    # override
    def can_attack_target(self, target):
        if not target or target is self:
            return False

        if not target.initialized or not self.initialized:
            return False

        if target.is_gameobject(by_mask=True):
            return False

        if not target.is_alive:
            return False

        # Sanctuary.
        if target.unit_state & UnitStates.SANCTUARY:
            return False

        # Fleeing.
        if self.unit_flags & UnitFlags.UNIT_FLAG_FLEEING:
            return False

        # Beastmaster.
        has_aggro_from_target = self.threat_manager.has_aggro_from(target)
        if not has_aggro_from_target and target.beast_master:
            return False

        # Flight.
        if target.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            return False

        # Player only checks.
        if self.is_player() or self.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED:
            if target.unit_flags & UnitFlags.UNIT_FLAG_IMMUNE_TO_PLAYER:
                return False
        # Creature only checks.
        elif target.is_unit():
            if not target.is_spawned:
                return False
            if target.unit_flags & UnitFlags.UNIT_FLAG_IMMUNE_TO_NPC:
                return False
            if self.is_unit():
                if self.unit_flags & UnitFlags.UNIT_FLAG_IMMUNE_TO_NPC:
                    return False

        # Always short circuit on charmer/summoner relationship.
        charmer = self.get_charmer_or_summoner()
        if charmer is target or self is target.get_charmer_or_summoner():
            return False

        # Charmed unit whose charmer is dueling the target.
        if charmer and charmer.is_player():
            duel_arbiter = charmer.get_duel_arbiter()
            from game.world.managers.objects.gameobjects.managers.DuelArbiterManager import DuelArbiterManager
            if isinstance(duel_arbiter, DuelArbiterManager) and duel_arbiter.is_unit_involved(target):
                return duel_arbiter.duel_state == DuelState.DUEL_STATE_STARTED

        is_enemy = super().can_attack_target(target)
        if is_enemy:
            return True

        # Might be neutral, but was attacked by target.
        return target and has_aggro_from_target

    def attack(self, victim: UnitManager, from_script=False):
        if not victim or victim == self:
            return False

        # Dead units can neither attack nor be attacked
        if not self.is_alive or not victim.is_alive:
            return False

        # Mounted players can't attack
        if self.is_player() and self.mount_display_id > 0:
            return False

        # Invalid target.
        if not from_script and not self.can_attack_target(victim):
            return False

        self.set_current_target(victim.guid)
        self.combat_target = victim

        for pet_or_guardian in self.pet_manager.get_pet_and_guardians():
            pet_or_guardian.object_ai.owner_attacked(victim)

        # Reset offhand weapon attack
        if self.has_offhand_weapon():
            self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, self.offhand_attack_time)

        if victim.is_player() or victim.is_player_controlled_pet():
            if self.object_ai: # Send AI reaction.
                self.object_ai.send_ai_reaction(victim, AIReactionStates.AI_REACT_HOSTILE)
            # Force players or player pets in-combat.
            victim.threat_manager.add_threat(source=self)

        self.send_attack_start(self.combat_target.guid)

        return True

    def attack_stop(self):
        # Clear target
        self.set_current_target(0)
        victim = self.combat_target
        self.combat_target = None

        self.send_attack_stop(victim.guid if victim else self.guid if self.is_alive else 0)

    def send_attack_start(self, victim_guid):
        data = pack('<2Q', self.guid, victim_guid)
        self.get_map().send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTART, data), self)

    def send_attack_stop(self, victim_guid):
        # Last uint32 is "deceased"; can be either 1 (self is dead), or 0, (self is alive).
        # Forces the unit to face the corpse and disables clientside
        # turning (UnitFlags.DisableMovement) CGUnit_C::OnAttackStop
        data = pack('<2QI', self.guid, victim_guid, 0 if self.is_alive else 1)
        self.get_map().send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data), self)

    def attack_update(self, elapsed):
        self.update_attack_timers(elapsed)
        return self.update_melee_attacking_state()

    def update_attack_timers(self, elapsed):
        elapsed_ms = elapsed * 1000.0
        self.update_attack_time(AttackTypes.BASE_ATTACK, elapsed_ms)
        self.attack_swing_elapsed[AttackTypes.BASE_ATTACK] += elapsed_ms
        if self.has_offhand_weapon():
            self.update_attack_time(AttackTypes.OFFHAND_ATTACK, elapsed_ms)
            self.attack_swing_elapsed[AttackTypes.OFFHAND_ATTACK] += elapsed_ms

    def update_melee_attacking_state(self):
        main_attack_ready = self.is_attack_ready(AttackTypes.BASE_ATTACK)
        off_hand_attack_ready = self.is_attack_ready(AttackTypes.OFFHAND_ATTACK) and self.has_offhand_weapon()

        # If neither main hand attack and offhand attack are ready, return.
        if not main_attack_ready and not off_hand_attack_ready:
            return False

        # Don't update melee attacking state while casting, stunned, pacified, fleeing or confused.
        if not self.can_perform_melee_attack():
            return False

        swing_error = AttackSwingError.NONE

        # Out of reach.
        if not self.is_within_interactable_distance(self.combat_target):
            swing_error = AttackSwingError.NOTINRANGE
        # Not proper angle.
        elif not self.location.has_in_arc(self.combat_target.location):
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
            if main_attack_ready:
                # Prevent both hand attacks at the same time.
                if self.has_offhand_weapon():
                    if self.attack_timers[AttackTypes.OFFHAND_ATTACK] < 500:
                        self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, 500)

                main_attack_delay = self.stat_manager.get_total_stat(UnitStats.MAIN_HAND_DELAY)
                self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK)
                self.set_attack_timer(AttackTypes.BASE_ATTACK, main_attack_delay)
                self.attack_swing_elapsed[AttackTypes.BASE_ATTACK] = 0

            # Offhand attack.
            if off_hand_attack_ready:
                # Prevent both hand attacks at the same time.
                if self.attack_timers[AttackTypes.BASE_ATTACK] < 500:
                    self.set_attack_timer(AttackTypes.BASE_ATTACK, 500)

                off_attack_delay = self.stat_manager.get_total_stat(UnitStats.OFF_HAND_DELAY)
                self.attacker_state_update(self.combat_target, AttackTypes.OFFHAND_ATTACK)
                self.set_attack_timer(AttackTypes.OFFHAND_ATTACK, off_attack_delay)
                self.attack_swing_elapsed[AttackTypes.OFFHAND_ATTACK] = 0

        if swing_error != AttackSwingError.NONE:
            if self.is_player():
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

        if attack_type == AttackTypes.BASE_ATTACK:
            # No recent extra attack only at any non-extra attack.
            if not extra and self.extra_attacks > 0:
                self.execute_extra_attacks()

            melee_spell = self.spell_manager.get_queued_melee_ability()
            if melee_spell and self.spell_manager.cast_queued_melee_ability(attack_type):
                # Send attack update with deferred logging to display the cast in combat log/floating text.
                damage_info = DamageInfoHolder(attacker=self, target=victim,
                                               spell_id=melee_spell.spell_entry.ID,
                                               attack_round_hit_info=HitInfo.DEFERRED_LOGGING)
                self.send_attack_state_update(damage_info)
                return

        damage_info = self.calculate_melee_damage(victim, attack_type)

        if damage_info.total_damage > 0:
            interrupted = victim.spell_manager.check_spell_interrupts(
                received_auto_attack=True,
                hit_info=damage_info.attack_round_hit_info,
            )
            if interrupted and damage_info.target_state == VictimStates.VS_WOUND:
                damage_info.target_state = VictimStates.VS_INTERRUPT

        self.handle_melee_attack_procs(damage_info)

        if damage_info.attack_round_hit_info & HitInfo.UNIT_DEAD:
            self.extra_attacks = 0

        self.send_attack_state_update(damage_info)
        self.deal_damage(damage_info.target, damage_info)
        self.aura_manager.check_aura_interrupts(attacked=True)

    def execute_extra_attacks(self):
        while self.extra_attacks > 0:
            self.attacker_state_update(self.combat_target, AttackTypes.BASE_ATTACK, True)
            self.extra_attacks -= 1

    def handle_melee_daze_chance(self, attacker):
        if attacker.is_player(by_mask=True):
            return

        owner = attacker.get_charmer_or_summoner()
        if owner and owner.is_player(by_mask=True):
            return

        # Not attack from behind, ignore.
        if self.location.has_in_arc(attacker.location):
            return

        # Check if already dazed.
        if self.aura_manager.has_aura_by_spell_id(1604):
            return

        if random.random() > self.stat_manager.get_daze_chance_against_self(attacker):
            return

        spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(1604)
        spell = attacker.spell_manager.try_initialize_spell(spell_entry, self, SpellTargetMask.UNIT,
                                                            triggered=True, validate=False)
        attacker.spell_manager.start_spell_cast(initialized_spell=spell)

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

        roll_info = AttackRollInfo()
        damage_info.attack_round_hit_info = victim.stat_manager.get_attack_result_against_self(self, attack_type,
                                                                                  dual_wield_penalty=dual_wield_penalty,
                                                                                  roll_info=roll_info)
        damage_info.advanced_logging = AttackRoundAdvancedLogging(roll_info=roll_info)
        if attack_type == AttackTypes.OFFHAND_ATTACK:
            damage_info.dual_wield_hit_roll = roll_info.miss_roll
            damage_info.dual_wield_hit_roll_needed = roll_info.miss_roll_needed

        min_damage, max_damage = self.calculate_min_max_damage(attack_type, SpellSchools.SPELL_SCHOOL_NORMAL, victim)
        if min_damage > max_damage:
            min_damage, max_damage = max_damage, min_damage

        rolled_damage = random.randint(min_damage, max_damage)
        damage_info.raw_damage = rolled_damage

        equipped_weapon = self.get_current_weapon_for_attack_type(attack_type)
        subclass = equipped_weapon.item_template.subclass if equipped_weapon else -1
        weapon_type = 1 << subclass if subclass != -1 else 0
        attack_school = SpellSchools.SPELL_SCHOOL_NORMAL
        spell_school_mask = 1 << attack_school
        target_creature_type = victim.creature_type

        flat_done = (
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, False, spell_school_mask, True) +
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, False, weapon_type, True) +
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_CREATURE_TYPE, False, target_creature_type)
        )

        pct_done = (
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_SCHOOL, True, spell_school_mask, True) *
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_WEAPON, True, weapon_type, True) *
            self.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_DONE_CREATURE_TYPE, True, target_creature_type)
        )

        flat_taken = victim.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_TAKEN_SCHOOL, False, spell_school_mask, True)
        pct_taken = victim.stat_manager.get_aura_stat_bonus(UnitStats.DAMAGE_TAKEN_SCHOOL, True, spell_school_mask, True)

        damage_after_done = (rolled_damage + flat_done) * pct_done
        damage_after_taken = (damage_after_done + flat_taken) * pct_taken

        min_after_done = (min_damage + flat_done) * pct_done
        min_after_taken = (min_after_done + flat_taken) * pct_taken
        max_after_done = (max_damage + flat_done) * pct_done
        max_after_taken = (max_after_done + flat_taken) * pct_taken

        reduction = 0.0
        if attack_school == SpellSchools.SPELL_SCHOOL_NORMAL:
            total_armor = victim.stat_manager.get_total_stat(UnitStats.RESISTANCE_PHYSICAL)
            reduction = (0.3 * (total_armor - 1)) / (10 * self.level + 89)
            reduction = max(0.0, min(0.75, reduction))

        armor_reduction = max(0.0, damage_after_taken * reduction)
        max_damage_reduction = max(0.0, max_after_taken * reduction)
        damage_after_armor = max(0.0, damage_after_taken * (1 - reduction))

        damage_info.base_damage = max(1, int(damage_after_armor))
        damage_info.advanced_logging.min_damage = max(0, int(min_after_taken))
        damage_info.advanced_logging.max_damage = max(0, int(max_after_taken))
        damage_info.advanced_logging.armor_reduction = int(round(armor_reduction))
        damage_info.advanced_logging.scaled_damage = max(0.0, float(damage_after_taken))
        damage_info.advanced_logging.scaled_armor_reduction = max(0.0, float(armor_reduction))
        damage_info.advanced_logging.max_damage_reduction = max(0.0, float(max_damage_reduction))
        damage_info.advanced_logging.net_damage_multiplier = pct_done * pct_taken
        damage_info.advanced_logging.mod_damage_done = pct_done
        damage_info.advanced_logging.mod_damage_taken = pct_taken

        if attack_type == AttackTypes.OFFHAND_ATTACK:
            delay_time = self.stat_manager.get_total_stat(UnitStats.OFF_HAND_DELAY)
        elif attack_type == AttackTypes.RANGED_ATTACK:
            delay_time = self.stat_manager.get_total_stat(UnitStats.RANGED_DELAY)
        else:
            delay_time = self.stat_manager.get_total_stat(UnitStats.MAIN_HAND_DELAY)
        damage_info.advanced_logging.delay_time = int(delay_time)
        damage_info.advanced_logging.since_last_swing = int(self.attack_swing_elapsed.get(attack_type, 0))
        damage_info.target_state = VictimStates.VS_WOUND  # Default state on successful attack.

        # Apply crit damage modifier if necessary.
        if damage_info.attack_round_hit_info & HitInfo.CRITICAL_HIT:
            damage_info.base_damage *= 2
            damage_info.advanced_logging.scaled_damage *= 2.0
            damage_info.advanced_logging.min_damage = int(damage_info.advanced_logging.min_damage * 2.0)
            damage_info.advanced_logging.max_damage = int(damage_info.advanced_logging.max_damage * 2.0)
            damage_info.advanced_logging.armor_reduction = int(round(damage_info.advanced_logging.armor_reduction * 2.0))
            damage_info.advanced_logging.scaled_armor_reduction *= 2.0
            damage_info.advanced_logging.max_damage_reduction *= 2.0

        # Apply crushing blow damage modifier if necessary.
        if damage_info.attack_round_hit_info & HitInfo.CRUSHING:
            damage_info.base_damage += int(damage_info.base_damage / 2)
            damage_info.advanced_logging.scaled_damage *= 1.5
            damage_info.advanced_logging.min_damage = int(damage_info.advanced_logging.min_damage * 1.5)
            damage_info.advanced_logging.max_damage = int(damage_info.advanced_logging.max_damage * 1.5)
            damage_info.advanced_logging.armor_reduction = int(round(damage_info.advanced_logging.armor_reduction * 1.5))
            damage_info.advanced_logging.scaled_armor_reduction *= 1.5
            damage_info.advanced_logging.max_damage_reduction *= 1.5

        # Handle school absorb.
        damage_info.absorb = victim.get_school_absorb_for_damage(damage_info)
        if damage_info.absorb:
            damage_info.attack_round_hit_info |= HitInfo.ABSORBED

        # Handle the case in which we did not really miss but damage was 0, which should display as miss.
        if (not damage_info.base_damage and damage_info.attack_round_hit_info & HitInfo.SUCCESS and
                not damage_info.attack_round_hit_info & (HitInfo.DODGE | HitInfo.PARRY | HitInfo.BLOCK | HitInfo.ABSORBED)):
            damage_info.attack_round_hit_info = HitInfo.MISS

        # Check evade, there is no HitInfo flag for this.
        if victim.is_evading:
            damage_info.target_state = VictimStates.VS_EVADE
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.proc_ex |= ProcFlagsExLegacy.EVADE
        elif damage_info.attack_round_hit_info & HitInfo.MISS:
            damage_info.attack_round_hit_info &= ~HitInfo.SUCCESS
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_NONE
            damage_info.proc_ex |= ProcFlagsExLegacy.MISS
        elif damage_info.attack_round_hit_info & HitInfo.ABSORBED:
            # Immune.
            if not damage_info.absorb:
                damage_info.attack_round_hit_info &= ~HitInfo.SUCCESS
                damage_info.base_damage = damage_info.total_damage = 0
                damage_info.target_state = VictimStates.VS_IMMUNE
                damage_info.proc_ex |= ProcFlagsExLegacy.IMMUNE
            # Absorb.
            else:
                damage_info.proc_ex |= ProcFlagsExLegacy.ABSORB
                # Complete absorb.
                if damage_info.base_damage == damage_info.absorb:
                    damage_info.attack_round_hit_info &= ~HitInfo.SUCCESS
                damage_info.total_damage = max(0, damage_info.base_damage - damage_info.absorb)
        elif damage_info.attack_round_hit_info & HitInfo.DODGE:
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_DODGE
            damage_info.proc_victim |= ProcFlags.DODGE
            damage_info.proc_ex |= ProcFlagsExLegacy.DODGE
        elif damage_info.attack_round_hit_info & HitInfo.PARRY:
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_PARRY
            damage_info.proc_victim |= ProcFlags.PARRY
            damage_info.proc_ex |= ProcFlagsExLegacy.PARRY
        elif damage_info.attack_round_hit_info & HitInfo.BLOCK:
            # 0.6 patch notes: "Blocking an attack no longer avoids all of the damage of an attack."
            # Completely mitigate damage on block.
            damage_info.base_damage = damage_info.total_damage = 0
            damage_info.target_state = VictimStates.VS_BLOCK
            damage_info.proc_victim |= ProcFlags.BLOCK
            damage_info.proc_ex |= ProcFlagsExLegacy.BLOCK | ProcFlagsExLegacy.FULL_BLOCK
        else:  # Successful attack.
            if damage_info.attack_round_hit_info & HitInfo.CRITICAL_HIT:
                damage_info.proc_ex |= ProcFlagsExLegacy.CRITICAL_HIT

            damage_info.proc_ex |= ProcFlagsExLegacy.NORMAL_HIT
            damage_info.target_state = VictimStates.VS_WOUND  # Normal hit.
            damage_info.total_damage = damage_info.base_damage

        # Invincibility.
        invincibility_hp_level = victim.invincibility_hp_level
        if invincibility_hp_level and victim.health < invincibility_hp_level + damage_info.total_damage:
            if victim.health <= invincibility_hp_level:
                damage_info.total_damage = 0
            else:
                damage_info.total_damage = int(victim.health - invincibility_hp_level)

        # Check if the target is unkillable and cap damage.
        damage_info.cap_unkillable_damage(victim)

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
            damage_info.attack_round_hit_info |= HitInfo.OFFHAND

        # If the victim is going to die due this attack.
        if victim.health - damage_info.total_damage <= 0:
            damage_info.attack_round_hit_info |= HitInfo.UNIT_DEAD
            damage_info.proc_attacker |= ProcFlags.KILL

        return damage_info

    def is_combat_log_debug_enabled(self) -> bool:
        return self.is_player() and (self.unit_flags & UnitFlags.UNIT_FLAG_DEBUG_COMBAT_LOGGING) != 0

    def _get_debug_combat_log_players(self, include_self=True):
        debug_players = []
        map_ = self.get_map()
        if map_:
            for player in map_.get_surrounding_players(self).values():
                if not player.online:
                    continue
                if not include_self and player.guid == self.guid:
                    continue
                if not player.is_combat_log_debug_enabled():
                    continue
                if player.guid != self.guid and self.guid not in player.known_objects:
                    continue
                debug_players.append(player)

        if include_self and self.is_combat_log_debug_enabled() and self.guid not in {p.guid for p in debug_players}:
            debug_players.append(self)

        return debug_players

    def send_attack_state_update(self, damage_info):
        is_player = self.is_player()
        debug_players = self._get_debug_combat_log_players(include_self=is_player)
        debug_guids = {player.guid for player in debug_players}
        if debug_players:
            debug_packet = damage_info.get_attacker_state_update_packet(include_advanced_logging=True)
            for player in debug_players:
                player.enqueue_packet(debug_packet)
        attack_state_packet = damage_info.get_attacker_state_update_packet(include_advanced_logging=False)
        self.get_map().send_surrounding(attack_state_packet, self, include_self=is_player, exclude=debug_guids or None)

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
            min_damage = int(used_ammo.item_template.dmg_min1 + min_damage)
            max_damage = int(used_ammo.item_template.dmg_max1 + max_damage)

        rolled_damage = random.randint(min_damage, max_damage)

        if apply_bonuses:
            subclass = -1
            equipped_weapon = self.get_current_weapon_for_attack_type(attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass
            rolled_damage = self.stat_manager.apply_bonuses_for_damage(rolled_damage, attack_school, target, subclass)

        return max(1, int(rolled_damage))

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
        casting_spell = self.spell_manager.get_casting_spell(ignore_melee=True)
        if casting_spell and not casting_spell.is_ability() and not casting_spell.is_tradeskill():
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
            self._power_regen_remainder[power_type] = 0.0
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
        regen_per_5 = self.stat_manager.get_base_stat(UnitStats.MANA) * 0.05 if \
            power_type == PowerTypes.TYPE_MANA else 0

        # Apply regen bonuses from stats.
        # Apply mana regen bonus if the player hasn't cast for 5 seconds, and apply health regen bonus out of combat.
        # Note that mana regen auras are not affected by this restriction (only mp5 from spirit),
        # as they're implemented as periodic energize effects instead.
        if power_type not in {PowerTypes.TYPE_HEALTH, PowerTypes.TYPE_MANA} or \
            power_type == PowerTypes.TYPE_HEALTH and not self.in_combat or \
                (power_type == PowerTypes.TYPE_MANA and self.mana_regen_timer >= 5):
            regen_per_5 += self.stat_manager.get_total_stat(regen_stat, accept_negative=True, accept_float=True)

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

        non_decaying_power_types = {
            PowerTypes.TYPE_HEALTH,
            PowerTypes.TYPE_MANA,
            PowerTypes.TYPE_FOCUS,
            PowerTypes.TYPE_ENERGY,
        }
        if power_type in non_decaying_power_types and regen_per_tick < 0:
            if power_type not in self._power_regen_negative_logged:
                self._power_regen_negative_logged.add(power_type)
            regen_per_tick = 0
        else:
            self._power_regen_negative_logged.discard(power_type)

        # Don't bank fractional regen while combat rules suppress it.
        reset_remainder = power_type in {PowerTypes.TYPE_HEALTH, PowerTypes.TYPE_RAGE} and self.in_combat
        remainder = 0.0 if reset_remainder else self._power_regen_remainder.get(power_type, 0.0)
        if power_type in non_decaying_power_types and remainder < 0:
            remainder = 0.0

        # Carry fractional regen between ticks so low rates don't round up to 1 every tick.
        total_regen = regen_per_tick + remainder
        if total_regen >= 1 or total_regen <= -1:
            regen_amount = int(total_regen)
            remainder = total_regen - regen_amount
        else:
            regen_amount = 0
            remainder = total_regen

        self._power_regen_remainder[power_type] = remainder
        if regen_amount:
            self.receive_power(regen_amount, power_type)

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

    def calculate_spell_damage(self, base_damage, miss_reason, hit_flags, spell_effect, target,
                               spell_logging: SpellAdvancedLogging = None):
        spell = spell_effect.casting_spell
        base_damage_input = base_damage
        damage_info = DamageInfoHolder(attacker=self, target=target,
                                       damage_school_mask=spell.get_damage_school_mask(),
                                       spell_id=spell.spell_entry.ID,
                                       spell_school=spell.get_damage_school(),
                                       spell_miss_reason=miss_reason, spell_hit_flags=hit_flags)
        logging = spell_logging or SpellAdvancedLogging()
        damage_info.spell_advanced_logging = logging
        # Track periodic ticks so floating text doesn't get deferred as a melee swing.
        damage_info.is_periodic = spell_effect.is_periodic()

        cast_on_swing = spell.casts_on_swing() and not spell_effect.is_periodic()
        is_weapon_attack = spell.is_weapon_attack()

        if is_weapon_attack:
            damage_info.attack_type = spell.get_attack_type()
            if damage_info.attack_type == AttackTypes.OFFHAND_ATTACK:
                damage_info.attack_round_hit_info |= HitInfo.OFFHAND

        if cast_on_swing:
            damage_info.attack_round_hit_info |= HitInfo.DEFERRED_LOGGING

        if miss_reason == SpellMissReason.MISS_REASON_RESIST:
            damage_info.proc_ex |= ProcFlagsExLegacy.RESIST
            damage_info.base_damage = base_damage
            damage_info.resist = base_damage

        if miss_reason != SpellMissReason.MISS_REASON_NONE:
            if miss_reason == SpellMissReason.MISS_REASON_PHYSICAL:
                damage_info.attack_round_hit_info |= HitInfo.MISS
                damage_info.proc_ex |= ProcFlagsExLegacy.MISS
                damage_info.target_state = VictimStates.VS_NONE
            elif miss_reason == SpellMissReason.MISS_REASON_EVADED:
                damage_info.attack_round_hit_info |= HitInfo.SUCCESS
                damage_info.target_state = VictimStates.VS_EVADE
                damage_info.proc_ex |= ProcFlagsExLegacy.EVADE
            elif miss_reason in {SpellMissReason.MISS_REASON_IMMUNE, SpellMissReason.MISS_REASON_TEMPIMMUNE}:
                damage_info.target_state = VictimStates.VS_IMMUNE
                damage_info.proc_ex |= ProcFlagsExLegacy.IMMUNE
            elif miss_reason == SpellMissReason.MISS_REASON_DEFLECTED:
                damage_info.attack_round_hit_info |= HitInfo.DEFLECT | HitInfo.SUCCESS
                damage_info.target_state = VictimStates.VS_DEFLECT
                damage_info.proc_ex |= ProcFlagsExLegacy.DEFLECT
            elif miss_reason == SpellMissReason.MISS_REASON_DODGED:
                damage_info.attack_round_hit_info |= HitInfo.DODGE | HitInfo.SUCCESS
                damage_info.target_state = VictimStates.VS_DODGE
                damage_info.proc_victim |= ProcFlags.DODGE
                damage_info.proc_ex |= ProcFlagsExLegacy.DODGE
            elif miss_reason == SpellMissReason.MISS_REASON_PARRIED:
                damage_info.attack_round_hit_info |= HitInfo.PARRY | HitInfo.SUCCESS
                damage_info.target_state = VictimStates.VS_PARRY
                damage_info.proc_victim |= ProcFlags.PARRY
                damage_info.proc_ex |= ProcFlagsExLegacy.PARRY
            elif miss_reason == SpellMissReason.MISS_REASON_BLOCKED:
                damage_info.attack_round_hit_info |= HitInfo.BLOCK | HitInfo.SUCCESS
                damage_info.target_state = VictimStates.VS_BLOCK
                damage_info.proc_victim |= ProcFlags.BLOCK
                damage_info.proc_ex |= ProcFlagsExLegacy.BLOCK | ProcFlagsExLegacy.FULL_BLOCK
            return damage_info

        subclass = -1
        if self.is_player() and spell.is_weapon_attack():
            equipped_weapon = self.get_current_weapon_for_attack_type(damage_info.attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass

        spell_school = spell.get_damage_school()

        if spell_effect.is_periodic():
            # For periodic effects, add bonuses to the total damage, divide back into ticks and floor.
            effect_ticks = max(1, int(spell.get_duration() / spell_effect.aura_period))
            total_base_damage = base_damage * effect_ticks
            total_damage = self.stat_manager.apply_bonuses_for_damage(total_base_damage, spell_school,
                                                                      target, subclass)
            damage_info.base_damage = int(total_damage / effect_ticks)
        else:
            damage_info.base_damage = self.stat_manager.apply_bonuses_for_damage(base_damage, spell_school,
                                                                                 target, subclass)

        logging.min_damage = int(damage_info.base_damage)
        logging.max_damage = int(damage_info.base_damage)
        logging.scaled_damage = float(damage_info.base_damage)
        logging.damage_type = int(damage_info.spell_school)
        logging.aura_effect_id = int(getattr(spell_effect, 'aura_type', 0))
        if base_damage_input:
            logging.net_damage_multiplier = float(damage_info.base_damage) / float(base_damage_input)

        # From 0.5.5 patch notes:
        #     "Critical hits with ranged weapons now do 100% extra damage."
        # We assume that ranged crits dealt 50% increased damage instead of 100%. The other option could be 200% but
        # 50% sounds more logical.
        if damage_info.spell_hit_flags & SpellHitFlags.CRIT and not spell_effect.is_periodic():
            is_ranged = damage_info.attack_type == AttackTypes.RANGED_ATTACK
            crit_multiplier = 1.50 if is_ranged else 2.0
            damage_info.proc_ex |= ProcFlagsExLegacy.CRITICAL_HIT
            if cast_on_swing or is_weapon_attack:
                damage_info.attack_round_hit_info |= HitInfo.CRITICAL_HIT
            damage_info.base_damage = int(damage_info.base_damage * crit_multiplier)

        damage_info.absorb = target.get_school_absorb_for_damage(damage_info)
        if damage_info.absorb:
            damage_info.attack_round_hit_info |= HitInfo.ABSORBED
            damage_info.proc_ex |= ProcFlagsExLegacy.ABSORB
        damage_info.total_damage = max(0, damage_info.base_damage - damage_info.absorb)

        # Reflected hits should set the reflect proc flag for combat log handling.
        if damage_info.spell_hit_flags & SpellHitFlags.REFLECTED:
            damage_info.proc_ex |= ProcFlagsExLegacy.REFLECT

        if cast_on_swing or is_weapon_attack:
            damage_info.proc_ex |= ProcFlagsExLegacy.NORMAL_HIT
            damage_info.attack_round_hit_info |= HitInfo.SUCCESS

        damage_info.cap_unkillable_damage(target)

        # Target will die because of this attack.
        if target.health - damage_info.total_damage <= 0:
            damage_info.attack_round_hit_info |= HitInfo.UNIT_DEAD

        return damage_info

    def deal_damage(self, target, damage_info, casting_spell=None, is_periodic=False):
        if not target or not target.is_alive:
            return

        if target.is_evading:
            return

        if (casting_spell and target.object_ai and damage_info.spell_miss_reason == SpellMissReason.MISS_REASON_NONE
                and damage_info.total_damage):
            target.object_ai.spell_hit(caster=self, casting_spell=casting_spell)

        # Notify caster AI about successful spell hits on targets.
        if (casting_spell and self.object_ai and damage_info.spell_miss_reason == SpellMissReason.MISS_REASON_NONE):
            self.object_ai.spell_hit_target(target, casting_spell.spell_entry)

        target.receive_damage(damage_info, source=self, casting_spell=casting_spell, is_periodic=is_periodic)

    def receive_damage(self, damage_info, source=None, casting_spell=None, is_periodic=False):
        # This method will return whether the unit is suitable to keep receiving damage.
        if not self.is_alive:
            return False

        if source is not self and damage_info.total_damage > 0:
            self.aura_manager.check_aura_interrupts(received_damage=True)
            if not is_periodic:
                interrupted = self.spell_manager.check_spell_interrupts(received_damage=True)
                if interrupted and damage_info.target_state == VictimStates.VS_WOUND:
                    damage_info.target_state = VictimStates.VS_INTERRUPT

        damage_info.cap_unkillable_damage(self)

        new_health = self.health - damage_info.total_damage
        if new_health <= 0:
            self.die(killer=source)
            return False
        else:
            self.set_health(new_health)
            self.generate_rage(damage_info, is_attacking=False)

        if casting_spell and damage_info.total_damage == 0:
            self.threat_manager.add_threat(source)
            return True
        # Spell and does not generate threat.
        elif casting_spell and not casting_spell.generates_threat():
            return True
        # Aura ticking dots should not generate threat if out of combat. (Threat applied upon aura application)
        elif is_periodic and not self.threat_manager.has_aggro_from(source):
            return True

        # Add threat according to damage.
        if damage_info.total_damage:
            self.threat_manager.add_threat(source, damage_info.total_damage)
        else:
            # No damage dealt - add minimal threat.
            self.threat_manager.add_threat(source)
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
            spell_logging = target_result.advanced_logging
        elif target.is_unit(by_mask=True):
            # Proc auras (PROC_TRIGGER_DAMAGE/DAMAGE_SHIELD) have no persistent target results.
            # Roll miss reason here if the target is missing.
            spell_logging = SpellAdvancedLogging()
            miss_reason, hit_flags = target.stat_manager.get_spell_miss_result_against_self(
                spell_effect.casting_spell, spell_logging)
        else:
            miss_reason, hit_flags = SpellMissReason.MISS_REASON_NONE, SpellHitFlags.NONE
            spell_logging = None

        damage_info = self.calculate_spell_damage(damage, miss_reason, hit_flags, spell_effect, target,
                                                  spell_logging=spell_logging)

        cast_on_swing = spell.casts_on_swing() and not spell_effect.aura_type

        if cast_on_swing:
            self.handle_melee_attack_procs(damage_info)

        # TODO Should other spells give skill too?
        if cast_on_swing or spell.is_ranged_weapon_attack():
            self.handle_combat_skill_gain(damage_info)
            target.handle_combat_skill_gain(damage_info)

        if damage_info.attack_round_hit_info & HitInfo.DEFERRED_LOGGING and self.is_alive:
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
        if not target.in_combat:
            return
        creature_observers = [attacker for attacker
                              in target.threat_manager.get_threat_holder_units()
                              if not attacker.is_player(by_mask=True)]
        if not creature_observers:
            return
        threat = source_threat / len(creature_observers)
        [creature.threat_manager.add_threat(self, threat) for creature in creature_observers]

    def send_spell_cast_debug_info(self, damage_info, casting_spell):
        is_player = self.is_player()
        is_miss = damage_info.spell_miss_reason > SpellMissReason.MISS_REASON_NONE
        if is_miss:
            spell_debug_packet = damage_info.get_attacker_state_update_spell_miss_packet()
            debug_packet = None
        else:
            spell_debug_packet = damage_info.get_attacker_state_update_spell_hit_packet(include_advanced_logging=False)
            debug_packet = damage_info.get_attacker_state_update_spell_hit_packet(include_advanced_logging=True)
        target_is_player = damage_info.target.is_player()
        if not damage_info.spell_hit_flags & SpellHitFlags.HEALED:
            debug_players = self._get_debug_combat_log_players(include_self=is_player)
            debug_guids = {player.guid for player in debug_players} if debug_packet and debug_players else set()
            if debug_packet and debug_players:
                for player in debug_players:
                    player.enqueue_packet(debug_packet)
            self.get_map().send_surrounding(spell_debug_packet, self, include_self=is_player, exclude=debug_guids or None)
            damage_done_packet = damage_info.get_damage_done_packet()
            self.get_map().send_surrounding(damage_done_packet, self, include_self=is_player)
        # Healing effects are displayed to the affected player only.
        elif casting_spell.initial_target_is_player() and target_is_player:
            target = damage_info.target
            if debug_packet and target.is_combat_log_debug_enabled():
                target.enqueue_packet(debug_packet)
            else:
                target.enqueue_packet(spell_debug_packet)

        if damage_info.resist:
            self.spell_manager.send_spell_resist_result(casting_spell, damage_info)

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
    def can_block(self, attacker_location=None, in_combat=False):
        if not in_combat:
            return self.has_block_passive

        return self.has_block_passive and not self.spell_manager.is_casting() and \
            not self.unit_state & UnitStates.STUNNED

    def has_shield(self):
        return False

    def has_buckler(self):
        return False

    def can_parry(self, attacker_location=None, in_combat=False):
        if not in_combat:
            return self.has_parry_passive

        return self.has_parry_passive and not self.spell_manager.is_casting() and \
            not self.unit_state & UnitStates.STUNNED

    def can_dodge(self, attacker_location=None, in_combat=False):
        if not in_combat:
            return self.has_dodge_passive

        return self.has_dodge_passive and not self.spell_manager.is_casting() and \
            not self.unit_state & UnitStates.STUNNED

    def can_crush(self):
        return False

    def should_always_crush(self):
        return False

    def enter_combat(self, source=None):
        if self.in_combat:
            return False

        # Make sure pet or guardians enter combat as well.
        for pet_or_guardian in self.pet_manager.get_pet_and_guardians():
            if not pet_or_guardian.in_combat:
                pet_or_guardian.enter_combat()

        self.in_combat = True
        self.set_unit_flag(UnitFlags.UNIT_FLAG_IN_COMBAT, active=True)
        # Handle enter combat interrupts.
        self.aura_manager.check_aura_interrupts(enter_combat=True)
        return True

    def leave_combat(self):
        if not self.in_combat:
            return False

        self.attack_stop()
        self.remove_combo_points()
        self.swing_error = 0
        self.extra_attacks = 0

        # Reset aura states.
        self.aura_manager.reset_aura_states()

        # Remove casts, active for dead units, not active for alive units.
        self.spell_manager.remove_casts(remove_active=not self.is_alive)

        # Reset threat table.
        self.threat_manager.reset()

        self.combat_target = None
        self.in_combat = False

        # Make sure pet/guardians leave combat if they have no aggro or no longer able to attack current target.
        for pet_or_guardian in self.pet_manager.get_pet_and_guardians():
            combat_target = pet_or_guardian.combat_target
            can_attack = combat_target and pet_or_guardian.can_attack_target(combat_target)
            if not pet_or_guardian.has_aggro() or not can_attack:
                pet_or_guardian.spell_manager.remove_casts()
                pet_or_guardian.leave_combat()

        self.set_unit_flag(UnitFlags.UNIT_FLAG_IN_COMBAT, active=False)
        return True

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

    def is_standing(self):
        return self.stand_state == StandState.UNIT_STANDING

    def set_stand_state(self, stand_state):
        if stand_state == self.stand_state:
            return

        self.stand_state = stand_state
        self.aura_manager.check_aura_interrupts(changed_stand_state=True)

    def set_sanctuary(self, active=True, time_secs=0):
        if active:
            self.set_unit_state(UnitStates.SANCTUARY, active=True)
            self.sanctuary_timer = time_secs
        else:
            self.set_unit_state(UnitStates.SANCTUARY, active=False)
            self.sanctuary_timer = 0

    def set_beast_master(self, active=True):
        self.beast_master = active
        for pet_or_guardian in self.pet_manager.get_pet_and_guardians():
            pet_or_guardian.beast_master = active

    def update_sanctuary(self, elapsed):
        if not self.sanctuary_timer:
            return
        self.sanctuary_timer = max(0, self.sanctuary_timer - elapsed)
        if not self.sanctuary_timer:
            self.set_sanctuary(False)

    # Implemented by CreatureManager.
    def is_tameable(self):
        return False

    # Implemented by CreatureManager.
    def is_sessile(self):
        return False

    def get_possessed_unit(self):
        possessed_id = self.get_uint64(UnitFields.UNIT_FIELD_CHARM)
        if possessed_id:
            unit = self.get_map().get_surrounding_unit_by_guid(self, possessed_id, include_players=True)
            return unit if unit and (unit.unit_flags & UnitFlags.UNIT_FLAG_POSSESSED) != 0 else None
        return None

    # override
    def change_speed(self, speed_type: SpeedType = SpeedType.RUN, speed: float = 0.0):
        stat_type = UnitStats.SPEED_RUNNING
        default_speed = config.Unit.Defaults.run_speed

        if speed_type == SpeedType.WALK:
            stat_type = None
            default_speed = config.Unit.Defaults.walk_speed
        elif speed_type == SpeedType.SWIM:
            stat_type = UnitStats.SPEED_SWIMMING
            default_speed = config.Unit.Defaults.swim_speed
        elif speed_type == SpeedType.TURN:
            stat_type = None
            default_speed = config.Unit.Player.Defaults.turn_speed

        if stat_type:
            # Assign new base speed.
            self.stat_manager.base_stats[stat_type] = speed if speed > 0 else default_speed
            # Get new total speed.
            speed = self.stat_manager.get_total_stat(stat_type, accept_float=True)
        elif speed <= 0:
            speed = default_speed

        if speed_type == SpeedType.RUN and self.is_mounted():
            # Apply mounted speed bonuses without affecting walk/swim/turn speeds.
            from game.world.managers.objects.units.player.PlayerManager import PlayerManager
            speed *= self.stat_manager.get_aura_stat_bonus(UnitStats.SPEED_MOUNTED, percentual=True)
            if isinstance(self, PlayerManager) and self.skill_manager:
                riding_bonus = self.skill_manager.get_riding_speed_bonus_percent()
                if riding_bonus:
                    speed *= riding_bonus / 100 + 1

        # Limit to 0-56.
        if speed > 56:
            speed = 56

        if speed_type == SpeedType.RUN:
            change_speed = super().change_speed(speed_type, speed)
        elif speed_type == SpeedType.WALK:
            if self.walk_speed == speed:
                return False
            self.walk_speed = speed
            change_speed = True
        elif speed_type == SpeedType.SWIM:
            if self.swim_speed == speed:
                return False
            self.swim_speed = speed
            change_speed = True
        elif speed_type == SpeedType.TURN:
            if self.turn_rate == speed:
                return False
            self.turn_rate = speed
            change_speed = True
        else:
            return False

        # Speed was modified, update current spline if needed.
        if change_speed:
            # Speed change is made noticeable through the new spline generated by the current movement behavior.
            self.movement_manager.set_speed_dirty()

        return change_speed

    # override
    def can_detect_target(self, target, distance=-1):
        if not target.unit_flags & UnitFlags.UNIT_FLAG_SNEAK:
            return True, False

        # No distance provided, calculate here.
        if distance < 0:
            distance = self.location.distance(target.location)

        if distance > 30.0:
            return False, False

        self_is_player = self.is_player()
        target_is_player = target.is_player()

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
        if not self.location.has_in_arc(target.location):
            visible_distance = max(0.0, visible_distance - 9.0)

        alert = False
        # Creature vs Player, alert handling.
        if self.is_unit() and target_is_player:
            alert_range = visible_distance + 5.0
            alert = alert_range >= distance > visible_distance

        return distance <= visible_distance, alert

    def is_stealthed(self) -> bool:
        return self.unit_flags & UnitFlags.UNIT_FLAG_SNEAK == UnitFlags.UNIT_FLAG_SNEAK

    def set_stealthed(self, active=True, index=-1) -> bool:
        return self.set_unit_flag(UnitFlags.UNIT_FLAG_SNEAK, active, index)

    def set_rooted(self, active=True, index=-1) -> bool:
        is_rooted = self.set_move_flag(MoveFlags.MOVEFLAG_ROOTED, active, index)
        is_rooted |= self.set_unit_state(UnitStates.ROOTED, active, index)
        return is_rooted

    def set_stunned(self, active=True, index=-1, allow_interrupt=True) -> bool:
        self.set_rooted(active, index)

        was_stunned = bool(self.unit_state & UnitStates.STUNNED)
        is_stunned = bool(self.set_unit_state(UnitStates.STUNNED, active, index))

        if not was_stunned and is_stunned:
            # Force move behavior stop.
            self.movement_manager.stop(force=True)
            if allow_interrupt:
                self.spell_manager.remove_casts(remove_active=False)
            self.set_current_target(0)
        elif was_stunned and not is_stunned:
            # Restore combat target on stun remove.
            if self.combat_target and self.combat_target.is_alive:
                self.set_current_target(self.combat_target.guid)

        self.set_unit_flag(UnitFlags.UNIT_FLAG_DISABLE_ROTATE, active, index)

        return is_stunned

    def remove_all_unit_flags(self, clear_effects=True):
        if clear_effects:
            self._flag_effects.clear()

        for unit_flag in UnitFlags:
            if self.unit_flags & unit_flag:
                self.set_unit_flag(unit_flag, active=False)

    def remove_all_dynamic_flags(self, clear_effects=True):
        if clear_effects:
            self._flag_effects.clear()

        for dyn_flag in UnitDynamicTypes:
            if self.dynamic_flags & dyn_flag:
                self.set_dynamic_type_flag(dyn_flag, active=False)

    def remove_all_movement_flags(self, clear_effects=True):
        if clear_effects:
            self._flag_effects.clear()

        for move_flag in MoveFlags:
            if self.movement_flags & move_flag:
                self.set_move_flag(move_flag, active=False)

    def set_unit_state(self, unit_state, active=True, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitStates, unit_state, active, index)
        if is_active:
            self.unit_state |= unit_state
        else:
            self.unit_state &= ~unit_state

        return is_active

    def set_unit_flags(self, unit_flags, active=True, index=-1):
        for unit_flag in unit_flags:
            self.set_unit_flag(unit_flag, active=active, index=index)

    def set_unit_flag(self, unit_flag, active=True, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitFlags, unit_flag, active, index)
        if is_active:
            self.unit_flags |= unit_flag
        else:
            self.unit_flags &= ~unit_flag

        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        # Modify UnitStates accordingly.
        if unit_flag == UnitFlags.UNIT_FLAG_FLEEING:
            self.set_unit_state(UnitStates.FLEEING, active=active, index=index)
        elif unit_flag == UnitFlags.UNIT_FLAG_POSSESSED:
            self.set_unit_state(UnitStates.POSSESSED, active=active, index=index)
        elif unit_flag == UnitFlags.UNIT_FLAG_CONFUSED:
            self.set_unit_state(UnitStates.CONFUSED, active=active, index=index)

        return is_active

    def set_move_flag(self, move_flag, active=True, index=-1) -> bool:
        is_active = self._set_effect_flag_state(MoveFlags, move_flag, active, index)

        flag_changed = (is_active and not self.movement_flags & move_flag) or \
                       (not is_active and self.movement_flags & move_flag)

        if is_active:
            self.movement_flags |= move_flag
        else:
            self.movement_flags &= ~move_flag

        # Force movement stop if rooted or immobilized.
        if flag_changed and is_active and move_flag in {MoveFlags.MOVEFLAG_ROOTED, MoveFlags.MOVEFLAG_IMMOBILIZED}:
            self.movement_manager.stop(force=True)

        # Only broadcast swimming, rooted, walking or immobilized.
        if flag_changed and move_flag in {MoveFlags.MOVEFLAG_SWIMMING, MoveFlags.MOVEFLAG_ROOTED,
                                          MoveFlags.MOVEFLAG_IMMOBILIZED, MoveFlags.MOVEFLAG_WALK}:
            self.get_map().send_surrounding(self.get_heartbeat_packet(), self)

        return is_active

    def set_dynamic_type_flag(self, type_flag, active=True, index=-1) -> bool:
        is_active = self._set_effect_flag_state(UnitDynamicTypes, type_flag, active, index)
        if is_active:
            self.dynamic_flags |= type_flag
        else:
            self.dynamic_flags &= ~type_flag

        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        return is_active

    def _set_effect_flag_state(self, flag_type, flag, active=True, index=-1) -> bool:
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
        if not emote:
            return
        range_ = config.World.Chat.ChatRange.emote_range
        data = pack('<IQ', emote, self.guid)
        packet = PacketWriter.get_packet(OpCode.SMSG_EMOTE, data)
        self.get_map().send_surrounding_in_range(packet, self, range_)

    def say_emote_text(self, emote_id, target=None):
        emote = DbcDatabaseManager.emote_text_get_by_id(emote_id)
        if not emote:
            return

        data = pack('<QI', self.guid, emote.ID)
        if not target:
            data += pack('<B', 0)
        elif target.is_player():
            player_name_bytes = PacketWriter.string_to_bytes(target.get_name())
            data += pack(f'<{len(player_name_bytes)}s', player_name_bytes)
        elif target.is_unit() and target.creature_template:
            unit_name_bytes = PacketWriter.string_to_bytes(target.get_name())
            data += pack(f'<{len(unit_name_bytes)}s', unit_name_bytes)
            target.object_ai.receive_emote(self, emote.ID)  # Notify CreatureAI about emote sent to this creature.
        else:
            data += pack('<B', 0)

        range_ = config.World.Chat.ChatRange.emote_range
        packet = PacketWriter.get_packet(OpCode.SMSG_TEXT_EMOTE, data)
        self.get_map().send_surrounding_in_range(packet, self, range_)

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
            self.pet_manager.detach_active_pets()
            self.mount_display_id = mount_display_id
            self.set_unit_flag(UnitFlags.UNIT_MASK_MOUNTED, active=True)
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            # Recalculate run speed to include mounted bonuses.
            self.change_speed(SpeedType.RUN, self.stat_manager.get_base_stat(UnitStats.SPEED_RUNNING))
            return True
        return False

    def unmount(self):
        self.mount_display_id = 0
        packet = PacketWriter.get_packet(OpCode.SMSG_PUREMOUNT_CANCELLED, data=pack(f'<Q', self.guid))
        self.get_map().send_surrounding(packet, self, include_self=self.is_player())
        self.set_unit_flag(UnitFlags.UNIT_MASK_MOUNTED, active=False)
        self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
        # Recalculate run speed to remove mounted bonuses.
        self.change_speed(SpeedType.RUN, self.stat_manager.get_base_stat(UnitStats.SPEED_RUNNING))
        return True

    def is_moving(self):
        return self.movement_manager.unit_is_moving()

    # Implemented by Creature/PlayerManager.
    def update_power_type(self):
        pass

    # Implemented by CreatureManager.
    def is_guardian(self):
        return False

    # Implemented by CreatureManager.
    def is_critter(self):
        return False

    # Implemented by CreatureManager.
    def is_immune_to_aoe(self):
        return False

    # Implemented by CreatureManager.
    def is_temp_summon_or_pet_or_guardian(self):
        return False

    # Implemented by PlayerManager.
    def get_duel_arbiter(self) -> Any:
        return None

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
        # Totems/Guardians are not linked to players (no portrait will appear).
        if not self.is_totem() and not self.is_guardian():
            summoner.set_uint64(UnitFields.UNIT_FIELD_SUMMON, self.guid if not remove else 0)
        # Set faction, either original or summoner. (Restored on CreatureManager/PlayerManager)
        self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)

    def set_can_abandon(self, state: bool):
        self.set_unit_flag(UnitFlags.UNIT_FLAG_PET_CAN_ABANDON, active=state)

    # Emote state is set given the EmoteID over dbc.
    def set_emote_unit_state(self, emote_state, is_temporary=False):
        if not is_temporary:
            self.emote_unit_state = emote_state

        if is_temporary and not emote_state:
            # Restore original.
            self.set_uint32(UnitFields.UNIT_EMOTE_STATE, self.emote_unit_state)
            return

        self.set_uint32(UnitFields.UNIT_EMOTE_STATE, emote_state)

    def set_can_rename(self, state: bool):
        self.set_unit_flag(UnitFlags.UNIT_FLAG_PET_CAN_RENAME, active=state)

    def set_player_controlled(self, state):
        self.set_unit_flag(UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED, active=state)

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

        max_power = self.get_max_power_value(power_type)
        value = max(0, min(value, max_power))  # Clamp to 0 - max power.

        if power_type == PowerTypes.TYPE_MANA:
            self.power_1 = value
        elif power_type == PowerTypes.TYPE_RAGE:
            self.power_2 = value
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.power_3 = value
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.power_4 = value

        self.power_percent = 0 if not max_power else (value / max_power) * 100
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

    def set_immunity(self, immunity_type: SpellImmunity, immunity_mask: int, source_id = -1):
        # Note: source ID can be an aura slot or -1 for an innate immunity.
        immunities = self._immunities.get(immunity_type, {})
        immunities[source_id] = immunity_mask
        self._immunities[immunity_type] = immunities

        if source_id == -1:
            return

        # Remove auras that collide with this immunity if needed.
        source_aura = self.aura_manager.get_aura_by_index(source_id)
        if not source_aura.source_spell.spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_DISPEL_AURAS_ON_IMMUNITY:
            return

        source_index = source_aura.index if not source_aura.passive else source_aura.active_aura_index
        for aura in list(self.aura_manager.active_auras.values()):
            # Skip canceling aura if it's purely passive or the source of the immunity.
            if aura.passive and aura.active_aura_index == -1:
                continue

            applied_main_index = aura.index if not aura.passive else aura.active_aura_index
            if applied_main_index == source_index:
                continue

            if aura.spell_effect.is_target_immune(aura.target):
                self.aura_manager.remove_aura(aura)

    def remove_immunity(self, immunity_type: SpellImmunity, source_id: int):
        immunities = self._immunities.get(immunity_type, {})
        immunities.pop(source_id, None)
        self._immunities[immunity_type] = immunities

    def has_immunity(self, immunity_type: SpellImmunity, immunity_arg: int, is_mask=False,
                     source=None, is_friendly=False):
        type_immunities = self._immunities.get(immunity_type, {})

        if not is_mask:
            immunity_arg = 1 << immunity_arg

        immunity_sources = [source_id for source_id, mask in type_immunities.items() if
                            immunity_arg & mask]
        if not immunity_sources:
            return False  # No immunity.

        if not is_friendly and (not source or source.can_attack_target(self)):
            return True  # Hostile/neutral source.

        # Friendly source. Check if immunity applies for helpful spells.
        for source_id in immunity_sources:
            source_aura = self.aura_manager.get_aura_by_index(source_id)
            if source_aura and source_aura.source_spell.grants_positive_immunity():
                return True

        return False

    def has_damage_immunity(self, school, casting_spell=None, is_mask=False) -> bool:
        if casting_spell and casting_spell.ignores_immunity():
            return False

        # Also check school immunity on damage immunity.
        return self.has_immunity(SpellImmunity.IMMUNITY_DAMAGE, school, is_mask=is_mask) or \
            self.has_immunity(SpellImmunity.IMMUNITY_SCHOOL, school, is_mask=is_mask)

    def set_health(self, health):
        if health < 0:
            health = 0

        self.health = min(health, self.max_health)
        self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
        self.hp_percent = (self.health / self.max_health) * 100 if self.max_health else 0

        # Aura state health <= 20%.
        if self.health:
            self.aura_manager.modify_aura_state(AuraState.AURA_STATE_HEALTH_20_PERCENT, apply=self.hp_percent <= 20)

    def set_max_health(self, health):
        self.max_health = health
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, health)

    def set_max_mana(self, mana):
        self.max_power_1 = mana
        self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_base_str(self, str_):
        self.base_str = str_
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT0, str_)

    def set_base_agi(self, agi):
        self.base_agi = agi
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT1, agi)

    def set_base_sta(self, sta):
        self.base_sta = sta
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT2, sta)

    def set_base_int(self, int_):
        self.base_int = int_
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT3, int_)

    def set_base_spi(self, spi):
        self.base_spi = spi
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT4, spi)

    def set_str(self, str_):
        self.str = str_
        self.set_int32(UnitFields.UNIT_FIELD_STAT0, str_)

    def set_agi(self, agi):
        self.agi = agi
        self.set_int32(UnitFields.UNIT_FIELD_STAT1, agi)

    def set_sta(self, sta):
        self.sta = sta
        self.set_int32(UnitFields.UNIT_FIELD_STAT2, sta)

    def set_int(self, int_):
        self.int = int_
        self.set_int32(UnitFields.UNIT_FIELD_STAT3, int_)

    def set_spi(self, spi):
        self.spi = spi
        self.set_int32(UnitFields.UNIT_FIELD_STAT4, spi)

    def set_resistance(self, resistance_type, total_resistance, item_bonus):
        # Armor, holy, fire, nature, frost, shadow.
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + resistance_type, total_resistance)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEITEMMODS + resistance_type, item_bonus)
        self.resistances[resistance_type] = total_resistance

    def set_resistance_mods(self, resistance_type, negative_mods, positive_mods):
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + resistance_type, negative_mods)
        self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + resistance_type, positive_mods)
        self.resistance_buff_mods_negative[resistance_type] = negative_mods
        self.resistance_buff_mods_positive[resistance_type] = positive_mods

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

    def set_weapon_mode(self, weapon_mode, force=False):
        self.sheath_state = weapon_mode
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1, force=force)

    def set_shapeshift_form(self, shapeshift_form):
        self.shapeshift_form = shapeshift_form
        self.aura_manager.reset_aura_states()

    def set_combat_reach(self, combat_reach):
        self.combat_reach = combat_reach
        self.set_float(UnitFields.UNIT_FIELD_COMBATREACH, combat_reach)

    def set_bounding_radius(self, bounding_radius):
        self.bounding_radius = bounding_radius
        self.set_float(UnitFields.UNIT_FIELD_BOUNDINGRADIUS, self.bounding_radius)

    # Implemented by CreatureManager
    def has_melee(self):
        return not self.melee_disabled

    # Implemented by CreatureManager
    def is_unkillable_target(self) -> bool:
        return False

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
        self.set_unit_flags([UnitFlags.UNIT_FLAG_FROZEN, UnitFlags.UNIT_FLAG_TAXI_FLIGHT], active=is_flying)
        if is_flying:
            self.mount(mount_display_id)
        elif self.is_mounted():
            self.unmount()

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

        self.set_has_moved(False, False, True)
        self.call_for_help_timer = 0
        self.swim_checks_enabled = False

        if self.object_ai:
            self.object_ai.just_died(killer)

        # Notify killer's pet AI about this kill.
        if killer and killer.is_unit(by_mask=True):
            killer_pet = killer.pet_manager.get_active_controlled_pet()
            if killer_pet:
                killer_pet.creature.object_ai.killed_unit(self)

        # Leave combat if needed.
        self.leave_combat()

        # Flush movement manager.
        self.movement_manager.flush()
        self.remove_all_movement_flags()

        # Reset threat manager.
        self.threat_manager.reset()

        self.pet_manager.detach_active_pets()
        charmer = self.get_charmer_or_summoner()
        if charmer:
            charmer.pet_manager.handle_pet_death(self)

        if killer and killer.is_player():
            if killer.current_selection == self.guid:
                killer.set_current_selection(killer.guid)

            # Clear combo of killer if this unit was the target
            if killer.combo_target == self.guid:
                killer.remove_combo_points()

        if killer and killer.is_unit(by_mask=True):
            killer.aura_manager.check_aura_procs(killed_unit=True)

        self.spell_manager.remove_casts()
        self.aura_manager.handle_death()

        # Reset unit state flags.
        self.unit_state = UnitStates.NONE

        self.set_unit_flag(UnitFlags.UNIT_MASK_DEAD, active=True)
        self.set_dynamic_type_flag(UnitDynamicTypes.UNIT_DYNAMIC_DEAD, active=True)
        self.set_health(0)

        return True

    # override
    def despawn(self, ttl=0, respawn_delay=0):
        # Make sure to remove casts from units that are destroyed but not necessarily killed. e.g. Totems.
        if self.spell_manager:
            self.spell_manager.remove_casts()
            self.aura_manager.remove_all_auras()

        charmer = self.get_charmer_or_summoner()
        # (Game objects can spawn creatures, but they don't have a PetManager).
        if charmer and charmer.is_unit(by_mask=True):
            active_pet = charmer.pet_manager.get_active_pet_by_guid(self.guid)
            if active_pet:
                summon_spell = active_pet.get_pet_data().summon_spell_id
                charmer.spell_manager.remove_cast_by_id(summon_spell)

                # Don't remove buffs from permanent pets on despawn (e.g. Sacrificial Shield).
                if not active_pet.is_permanent():
                    charmer.aura_manager.remove_auras_by_caster(self.guid)

        self.is_alive = False
        super().despawn(ttl, respawn_delay)

        charmer_or_summoner = self.get_charmer_or_summoner()
        # Detach from controller if this unit is an active pet and the summoner is a unit
        # (game objects can spawn creatures, but they don't have a PetManager).
        if charmer_or_summoner and charmer_or_summoner.is_unit(by_mask=True):
            charmer_or_summoner.pet_manager.detach_pet_by_guid(self.guid)

    def is_swimming(self):
        return (self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING) != 0

    def is_above_water(self):
        return not self.is_swimming()

    def is_mounted(self):
        return (self.unit_flags & UnitFlags.UNIT_MASK_MOUNTED) != 0

    # override
    def respawn(self):
        # Force leave combat just in case.
        self.leave_combat()
        self.set_current_target(0)
        self.is_alive = True

        self.set_unit_flag(UnitFlags.UNIT_MASK_DEAD, active=False)
        self.remove_all_dynamic_flags()
        self.set_stand_state(StandState.UNIT_STANDING)

    def get_ai_name(self):
        if not self.object_ai:
            return 'None'
        return type(self.object_ai).__name__

    def is_in_world(self):
        pass

    # Implemented by CreatureManager
    def has_ooc_events(self):
        pass

    # Implemented by CreatureManager
    def get_npc_flags(self):
        return 0

    # Implemented by CreatureManager
    def get_unit_class(self):
        return self.class_

    # Implemented by PlayerManager
    def get_combo_points(self):
        return 0

    def get_bytes_0(self):
        return ByteUtils.bytes_to_int(
            self.power_type,  # Power type.
            self.gender,  # Gender.
            self.get_unit_class(),  # Unit class.
            self.race  # Unit race.
        )

    # Implemented by CorpseManager
    def get_bytes_1(self, is_create=False):
        return ByteUtils.bytes_to_int(
            self.sheath_state if not is_create else WeaponMode.SHEATHEDMODE,  # Sheath state.
            self.shapeshift_form,  # Shapeshift form.
            self.get_npc_flags(),  # NPC flags (0 for players).
            self.stand_state  # Stand state.
        )

    # Implemented by CorpseManager.
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # Unused.
            0,  # Unused.
            0,  # Unused.
            self.get_combo_points()  # Combo points.
        )

    """
        The client does not correctly update the sheath state for units following destroy/create operations. 
        As a workaround, we first send the bytes_1 field bytes with all values zeroed out, 
        and then send the actual state data afterward.
    """
    def get_bytes_1_state_update_bytes(self):
        return self.get_single_field_update_bytes(UnitFields.UNIT_FIELD_BYTES_1, self.get_bytes_1())

    # Implemented by CreatureManager and PlayerManager
    def get_damages(self):
        pass

    # override
    def on_cell_change(self):
        pass

    # Used by creatures.
    def get_detection_range(self, unit):
        return 0

    def update_visibility_bounds(self, visibility_bounds):
        view_factor = VIEW_DISTANCE if not self.has_ooc_events() else 45  # Max detection range cap.
        visibility_bounds.width = view_factor * 2
        visibility_bounds.height = view_factor * 2
        visibility_bounds.x = self.location.x - view_factor
        visibility_bounds.y = self.location.y - view_factor

    def has_moved_significantly(self, visibility_bounds):
        if not self.quadtree_node:
            return True
        self.update_visibility_bounds(visibility_bounds)
        node_bounds = self.quadtree_node.bounds
        return not node_bounds.contains_box(visibility_bounds)

    def notify_move_in_line_of_sight(self, map_, unit, ooc_event=False, in_range=False, distance=None):
        los_check = None

        # Check ooc events for self (Which can have greater range than detection range).
        if ooc_event:
            los_check = map_.los_check(self.get_ray_position(), unit.get_ray_position())
            if los_check:
                self.object_ai.move_in_line_of_sight(unit, ai_event=True)

        if not self.threat_manager.can_resolve_target():
            return

        if not in_range or not self.is_hostile_to(unit) or not self.can_attack_target(unit):
            return

        # Check for stealth/invisibility.
        if distance is None:
            distance = self.location.distance(unit.location)
        can_detect_unit, alert = self.can_detect_target(unit, distance)
        if alert and unit.is_player() and not self.is_player():
            self.object_ai.send_ai_reaction(self, AIReactionStates.AI_REACT_ALERT)

        if not can_detect_unit or self.is_player():
            return

        los_check = los_check if los_check is not None else map_.los_check(unit.get_ray_position(),
                                                                               self.get_ray_position())
        if not los_check:
            return

        self.object_ai.move_in_line_of_sight(unit)

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

    # noinspection PyMethodMayBeStatic
    def get_creature_family(self):
        return 0

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_UNIT

    # override
    def get_low_guid(self):
        if self.is_pet():
            return self.guid & ~HighGuid.HIGHGUID_PET
        return self.guid & ~HighGuid.HIGHGUID_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT

    # override
    def generate_object_guid(self, low_guid):
        if self.is_pet():
            return low_guid | HighGuid.HIGHGUID_PET
        return low_guid | HighGuid.HIGHGUID_UNIT
