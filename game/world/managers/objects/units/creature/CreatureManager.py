import math
import time
from random import randint

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ai.AIFactory import AIFactory
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.creature.CreatureLootManager import CreatureLootManager
from game.world.managers.objects.units.creature.CreaturePickPocketLootManager import CreaturePickPocketLootManager
from game.world.managers.objects.units.creature.ThreatManager import ThreatManager
from game.world.managers.objects.units.creature.items.VirtualItemsUtils import VirtualItemsUtils
from game.world.managers.objects.units.creature.utils.CreatureUtils import CreatureUtils
from utils import Formulas
from utils.ByteUtils import ByteUtils
from utils.Formulas import UnitFormulas, Distances
from utils.constants import CustomCodes
from utils.constants.MiscCodes import NpcFlags, ObjectTypeIds, UnitDynamicTypes, ObjectTypeFlags
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags, WeaponMode, CreatureTypes, MovementTypes, SplineFlags, \
    CreatureStaticFlags, PowerTypes, CreatureFlagsExtra, CreatureReactStates, AIReactionStates
from utils.constants.UpdateFields import ObjectFields, UnitFields


# noinspection PyCallByClass
class CreatureManager(UnitManager):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.entry = 0
        self.guid = 0
        self.creature_template = None
        self.location = None
        self.spawn_position = None
        self.map_ = 0
        self.health_percent = 100
        self.mana_percent = 100
        self.summoner = None
        self.addon = None
        self.spell_id = 0
        self.time_to_live_timer = 0
        self.faction = 0
        self.subtype = CustomCodes.CreatureSubtype.SUBTYPE_GENERIC
        self.react_state = CreatureReactStates.REACT_PASSIVE
        self.npc_flags = 0
        self.static_flags = 0
        self.emote_state = 0
        self.spell_list_id = 0
        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False
        self.ranged_attack_time = 0
        self.ranged_dmg_min = 0
        self.ranged_dmg_max = 0
        self.destroy_time = 0
        self.destroy_timer = 420  # Standalone instances, destroyed after 7 minutes.
        self.last_random_movement = 0
        self.random_movement_wait_time = randint(1, 12)
        self.virtual_item_info = {}

        self.wander_distance = 0
        self.movement_type = MovementTypes.IDLE
        self.fully_loaded = False
        self.killed_by = None
        self.known_players = {}

        # # Managers, will be load upon lazy loading trigger.
        self.loot_manager = None
        self.pickpocket_loot_manager = None

        # # All creatures can block, parry and dodge by default.
        # # TODO: Checks for CREATURE_FLAG_EXTRA_NO_BLOCK and CREATURE_FLAG_EXTRA_NO_PARRY, for hit results.
        self.has_block_passive = True
        self.has_dodge_passive = True
        self.has_parry_passive = True

    # This can also be used to 'morph' the creature.
    def initialize_from_creature_template(self, creature_template):
        if not creature_template:
            return

        self.entry = creature_template.entry
        self.creature_template = creature_template
        self.entry = self.creature_template.entry
        self.class_ = self.creature_template.unit_class
        self.resistance_0 = self.creature_template.armor
        self.resistance_1 = self.creature_template.holy_res
        self.resistance_2 = self.creature_template.fire_res
        self.resistance_3 = self.creature_template.nature_res
        self.resistance_4 = self.creature_template.frost_res
        self.resistance_5 = self.creature_template.shadow_res
        self.npc_flags = self.creature_template.npc_flags
        self.static_flags = self.creature_template.static_flags
        self.regen_flags = self.creature_template.regeneration
        self.virtual_item_info = {}  # Slot: VirtualItemInfoHolder
        self.base_attack_time = self.creature_template.base_attack_time
        self.ranged_attack_time = self.creature_template.ranged_attack_time
        self.ranged_dmg_min = self.creature_template.ranged_dmg_min
        self.ranged_dmg_max = self.creature_template.ranged_dmg_max
        self.unit_flags = self.creature_template.unit_flags
        self.emote_state = 0
        self.faction = self.creature_template.faction
        self.creature_type = self.creature_template.type
        self.spell_list_id = self.creature_template.spell_list_id
        self.sheath_state = WeaponMode.NORMALMODE

        if 0 < self.creature_template.rank < 4:
            self.unit_flags |= UnitFlags.UNIT_FLAG_PLUS_MOB

        if self.is_totem() or self.is_critter() or not self.can_have_target():
            self.react_state = CreatureReactStates.REACT_PASSIVE
        elif self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_AGGRO:
            self.react_state = CreatureReactStates.REACT_DEFENSIVE
        else:
            self.react_state = CreatureReactStates.REACT_AGGRESSIVE

        self.set_melee_damage(int(self.creature_template.dmg_min), int(self.creature_template.dmg_max))

        self.mod_cast_speed = 1
        self.wearing_mainhand_weapon = False
        self.wearing_offhand_weapon = False
        self.wearing_ranged_weapon = False

        self.fully_loaded = False

        self.initialized = False
        self.killed_by = None
        self.known_players = {}

        self.native_display_id = CreatureUtils.generate_creature_display_id(self.creature_template)
        self.current_display_id = self.native_display_id
        self.level = randint(self.creature_template.level_min, self.creature_template.level_max)

        self.max_health, self.max_power_1 = UnitFormulas.calculate_max_health_and_max_power(self, self.level)
        self.health = int((self.health_percent / 100) * self.max_health)
        self.power_1 = int((self.mana_percent / 100) * self.max_power_1)

        self.last_random_movement = 0
        self.threat_manager = ThreatManager(self, self.creature_template.call_for_help_range)

        # Reset pickpocket state.
        if self.pickpocket_loot_manager:
            self.pickpocket_loot_manager.already_pickpocketed = False

        # Creature AI.
        self.object_ai = AIFactory.build_ai(self)

    # override
    def initialize_field_values(self):
        # Lazy loading first.
        if not self.fully_loaded:
            self.finish_loading()

        # Initialize values.
        # After this, fields must be modified by setters or directly writing values to them.
        if not self.initialized:
            self.bytes_1 = self.get_bytes_1()
            self.bytes_2 = self.get_bytes_2()
            self.damage = self.get_damages()

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

            # Unit fields.
            self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
            self.set_uint32(UnitFields.UNIT_CREATED_BY_SPELL, self.spell_id)
            self.set_uint64(UnitFields.UNIT_FIELD_CREATEDBY, self.summoner.guid if self.summoner else 0)
            self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
            self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, self.max_power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
            self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, self.base_attack_time)
            self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)
            self.set_float(UnitFields.UNIT_FIELD_BOUNDINGRADIUS, self.bounding_radius)
            self.set_float(UnitFields.UNIT_FIELD_COMBATREACH, self.combat_reach)
            self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, self.weapon_reach)
            self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.current_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_EMOTE_STATE, self.emote_state)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)
            self.set_uint32(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
            self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

            # Pet related
            # TODO pet naming/pet number?
            if self.is_pet():
                self.set_uint32(UnitFields.UNIT_FIELD_PET_NAME_TIMESTAMP, int(time.time()))
                self.set_uint32(UnitFields.UNIT_FIELD_PETNUMBER, 1)

            for slot, virtual_item in self.virtual_item_info.items():
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_SLOT_DISPLAY + slot, virtual_item.display_id)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 0, virtual_item.info_packed)
                self.set_uint32(UnitFields.UNIT_VIRTUAL_ITEM_INFO + (slot * 2) + 1, virtual_item.info_packed_2)

            self.initialized = True

    def finish_loading(self):
        if not self.fully_loaded:
            # Load loot manager.
            self.loot_manager = CreatureLootManager(self)
            # Load pickpocket loot manager if required.
            if self.creature_template.pickpocket_loot_id:
                self.pickpocket_loot_manager = CreaturePickPocketLootManager(self)

            display_id = self.current_display_id
            creature_model_info = WorldDatabaseManager.CreatureModelInfoHolder.creature_get_model_info(display_id)
            if creature_model_info:
                self.bounding_radius = creature_model_info.bounding_radius
                self.combat_reach = creature_model_info.combat_reach
                self.gender = creature_model_info.gender

            if self.creature_template.scale == 0:
                display_scale = DbcDatabaseManager.CreatureDisplayInfoHolder.creature_display_info_get_by_id(display_id)
                if display_scale and display_scale.CreatureModelScale > 0:
                    self.native_scale = display_scale.CreatureModelScale
                else:
                    self.native_scale = 1
            else:
                self.native_scale = self.creature_template.scale
            self.current_scale = self.native_scale

            if self.creature_template.equipment_id > 0:
                creature_equip_template = WorldDatabaseManager.CreatureEquipmentHolder.creature_get_equipment_by_id(
                    self.creature_template.equipment_id
                )
                if creature_equip_template:
                    VirtualItemsUtils.set_virtual_item(self, 0, creature_equip_template.equipentry1)
                    VirtualItemsUtils.set_virtual_item(self, 1, creature_equip_template.equipentry2)
                    VirtualItemsUtils.set_virtual_item(self, 2, creature_equip_template.equipentry3)

            # Mount this creature, will be overriden if defined too in creature_addon.
            if self.creature_template.mount_display_id > 0:
                self.mount(self.creature_template.mount_display_id)

            auras = set()
            # Template auras.
            if self.creature_template.auras:
                auras = {int(aura) for aura in str(self.creature_template.auras).split()}

            addon = self.addon
            if addon:
                self.set_stand_state(addon.stand_state)
                self.set_weapon_mode(addon.sheath_state)

                # Set emote state if available.
                if addon.emote_state:
                    self.set_emote_state(addon.emote_state)

                # Check spawn auras.
                if addon.auras:
                    auras.update({int(aura) for aura in str(addon.auras).split()})

                # Update display id if available.
                if addon.display_id:
                    self.set_display_id(addon.display_id)

                # Mount this creature if defined (will override template mount).
                if addon.mount_display_id > 0:
                    self.mount(addon.mount_display_id)

            # Cast active auras for this NPC.
            for aura in auras:
                self.spell_manager.handle_cast_attempt(aura, self, SpellTargetMask.SELF, validate=False)

            # Stats.
            self.stat_manager.init_stats()
            self.stat_manager.apply_bonuses(replenish=True)

            self.fully_loaded = True

    def is_guard(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_GUARD

    def can_summon_guards(self):
        return self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_SUMMON_GUARD

    def can_assist_help_calls(self):
        return not self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_ASSIST

    def is_critter(self):
        return self.creature_template.type == CreatureTypes.AMBIENT

    def is_pet(self):
        return self.summoner and self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_PET

    def is_player_controlled_pet(self):
        return self.is_pet() and self.summoner.get_type_id() == ObjectTypeIds.ID_PLAYER

    def is_totem(self):
        return self.summoner and self.subtype == CustomCodes.CreatureSubtype.SUBTYPE_TOTEM

    def can_have_target(self):
        return not self.creature_template.flags_extra & CreatureFlagsExtra.CREATURE_FLAG_EXTRA_NO_TARGET

    def is_quest_giver(self):
        return self.npc_flags & NpcFlags.NPC_FLAG_QUESTGIVER

    def is_trainer(self):
        return self.npc_flags & NpcFlags.NPC_FLAG_TRAINER

    # override
    def is_tameable(self):
        return self.static_flags & CreatureStaticFlags.TAMEABLE

    def can_swim(self):
        return (self.static_flags & CreatureStaticFlags.AMPHIBIOUS) or (self.static_flags & CreatureStaticFlags.AQUATIC)

    def can_exit_water(self):
        return self.static_flags & CreatureStaticFlags.AQUATIC == 0

    # override
    def leave_combat(self, force=False):
        super().leave_combat(force=force)
        # Reset threat table.
        self.threat_manager.reset()
        if not self.is_player_controlled_pet():
            self.evade()

    # TODO: Finish implementing evade mechanic.
    def evade(self):
        # Already evading or dead, ignore.
        if self.is_evading or not self.is_alive:
            return

        # Flag creature as currently evading.
        self.is_evading = True

        # Remove all auras on evade.
        self.aura_manager.remove_all_auras()

        if not self.static_flags & CreatureStaticFlags.NO_AUTO_REGEN:
            self.set_health(self.max_health)
            self.recharge_power()

        # Pets should return to owner on evading, not to spawn position. This case at this moment only affects
        # creature summoned pets since player summoned pets will never enter this method.
        if self.is_pet():
            return

        # Get the path we are using to get back to spawn location.
        waypoints_to_spawn, z_locked = self._get_return_to_spawn_points()
        self.evading_waypoints.clear()

        # Despawn this creature if the last evade point is too far away from its current position.
        if self.location.distance(waypoints_to_spawn[-1]) > Distances.CREATURE_EVADE_DISTANCE * 2:
            self.despawn()
        else:
            # TODO: Find a proper move type that accepts multiple waypoints, RUNMODE and others halt the unit movement.
            spline_flag = SplineFlags.SPLINEFLAG_RUNMODE if not z_locked else SplineFlags.SPLINEFLAG_FLYING
            self.movement_manager.send_move_normal(waypoints_to_spawn, self.running_speed, spline_flag)

    # TODO: Below return to spawn point logic should be removed once a navmesh is available.
    def _get_return_to_spawn_points(self) -> tuple:  # [waypoints], z_locked bool
        # No points, return just spawn point.
        if len(self.evading_waypoints) == 0:
            return [self.spawn_position], False

        # Reverse the combat waypoints, so they point back to spawn location.
        waypoints = [wp for wp in reversed(self.evading_waypoints)]
        # Set self location to the latest known point.
        self.location = waypoints[0].copy()
        last_waypoint = self.location
        # Distance we want between each waypoint.
        d_factor = 3
        # Try to use waypoints only for units that have invalid z calculations.
        z_locked = False
        distance_sum = 0
        # Filter the waypoints by distance, remove those that are too close to each other.
        for waypoint in list(waypoints):
            # Check for protected z.
            if not z_locked:
                z, z_locked = MapManager.calculate_z(self.map_, waypoint.x, waypoint.y, waypoint.z)
            distance_sum += last_waypoint.distance(waypoint)
            if distance_sum < d_factor:
                waypoints.remove(waypoint)
            else:
                distance_sum = 0
            last_waypoint = waypoint

        if z_locked:
            # Make sure the last waypoints its self spawn position.
            waypoints.append(self.spawn_position.copy())
        else:
            # This unit is probably outside a cave, do not use waypoints.
            waypoints.clear()
            waypoints.append(self.spawn_position)
        return waypoints, z_locked

    def has_observers(self):
        return len(self.known_players) > 0

    def has_wander_type(self):
        return self.movement_type == MovementTypes.WANDER

    def _perform_random_movement(self, now):
        # Do not wander if dead, in combat, while evading or without wander flag.
        if self.is_alive and not self.in_combat and not self.is_evading and self.has_wander_type():
            if len(self.movement_manager.pending_waypoints) == 0:
                if now > self.last_random_movement + self.random_movement_wait_time:
                    self.movement_manager.move_random(self.spawn_position, self.wander_distance)
                    self.random_movement_wait_time = randint(1, 12)
                    self.last_random_movement = now

    # TODO: All the evade calls should be probably handled by aggro manager, it should be able to decide if unit can
    #  switch to another target from the Threat list or evade, or some other action.
    def _perform_combat_movement(self):
        # Avoid moving while casting, no combat target, evading or target already dead.
        if self.is_casting() or not self.combat_target or self.is_evading or not self.combat_target.is_alive:
            return

        # Check if target is player and is online.
        target_is_player = self.combat_target.get_type_id() == ObjectTypeIds.ID_PLAYER
        if target_is_player and not self.combat_target.online:
            self.leave_combat(True)
            return

        spawn_distance = self.location.distance(self.spawn_position)
        target_distance = self.location.distance(self.combat_target.location)
        combat_position_distance = UnitFormulas.combat_distance(self, self.combat_target)

        if not self.is_pet():
            # In 0.5.3, evade mechanic was only based on distance, the correct distance remains unknown.
            # From 0.5.4 patch notes:
            #     "Creature pursuit is now timer based rather than distance based."
            if spawn_distance > Distances.CREATURE_EVADE_DISTANCE  \
                    or target_distance > Distances.CREATURE_EVADE_DISTANCE:
                self.leave_combat(True)
                return

            # TODO: There are some creatures like crabs or murlocs that apparently couldn't swim in earlier versions
            #  but are spawned inside the water at this moment since most spawns come from Vanilla data. These mobs
            #  will currently bug out when you try to engage in combat with them. Also seems like a lot of humanoids
            #  couldn't swim before patch 1.3.0:
            #  World of Warcraft Client Patch 1.3.0 (2005-03-22)
            #   - Most humanoids NPCs have gained the ability to swim.
            if self.is_on_water():
                if not self.can_swim():
                    self.leave_combat(True)
                    return
            else:
                if not self.can_exit_water():
                    self.leave_combat(True)
                    return

        # If this creature is not facing the attacker, update its orientation (server-side).
        if not self.location.has_in_arc(self.combat_target.location, math.pi):
            self.location.face_point(self.combat_target.location)

        combat_location = self.combat_target.location.get_point_in_between(combat_position_distance,
                                                                           vector=self.location)
        if not combat_location:
            return

        # If target is within combat distance or already in combat location, don't move.
        if target_distance <= combat_position_distance and self.location == combat_location:
            return

        # If already going to the correct spot, don't do anything.
        if len(self.movement_manager.pending_waypoints) > 0 \
                and self.movement_manager.pending_waypoints[0].location == combat_location:
            return

        if self.is_on_water():
            # Force destination Z to target Z.
            combat_location.z = self.combat_target.location.z
            # TODO: Find how to actually trigger swim animation and which spline flag to use.
            #  VMaNGOS uses UNIT_FLAG_USE_SWIM_ANIMATION, we don't have that.
            self.movement_manager.send_move_normal([combat_location], self.swim_speed, SplineFlags.SPLINEFLAG_FLYING)
        else:
            self.movement_manager.send_move_normal([combat_location], self.running_speed,
                                                   SplineFlags.SPLINEFLAG_RUNMODE)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_alive and self.is_spawned and self.initialized:

                # Time to live checks for standalone instances.
                if not self._check_time_to_live(elapsed):
                    return  # Creature destroyed.

                # Regeneration.
                self.regenerate(elapsed)
                # Spell/Aura Update.
                self.spell_manager.update(now)
                self.aura_manager.update(now)
                # Movement Updates.
                self.movement_manager.update_pending_waypoints(elapsed)
                if self.has_moved:
                    self._on_relocation()
                    self.set_has_moved(False)
                # Random Movement, if visible to players.
                if self.has_observers():
                    self._perform_random_movement(now)
                # Combat Movement.
                self._perform_combat_movement()
                # AI.
                if self.object_ai:
                    self.object_ai.update_ai(elapsed)
                # Attack Update.
                if self.combat_target:
                    self.attack_update(elapsed)
                # Not in combat, check if threat manager can resolve a target or if unit should switch target.
                elif self.threat_manager:
                    target = self.threat_manager.resolve_target()
                    if target and target != self.combat_target:
                        self.attack(target)
            # Dead creature with no creature spawn parent, handle destroy.
            elif not self._check_despawn(elapsed):
                return  # Creature destroyed.

            # Check if this creature object should be updated yet or not.
            if self.has_pending_updates():
                MapManager.update_object(self, has_changes=True)
                self.reset_fields_older_than(now)

        self.last_tick = now

    def _check_despawn(self, elapsed):
        if self.summoner and not self.is_alive and self.is_spawned and self.initialized:
            self.destroy_timer += elapsed
            if self.destroy_timer >= self.destroy_time:
                self.despawn()
                return False
        return True

    def _check_time_to_live(self, elapsed):
        if self.time_to_live_timer > 0:
            self.time_to_live_timer -= elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer <= 0:
                self.despawn()
                return False
        return True

    # override
    def attack(self, victim: UnitManager):
        if victim.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.object_ai.send_ai_reaction(victim, AIReactionStates.AI_REACT_HOSTILE)
        super().attack(victim)

    # override
    def attack_update(self, elapsed):
        target = self.threat_manager.get_hostile_target()
        # Has a target, check if we need to attack or switch target.
        if target and self.combat_target != target:
            self.attack(target)
        # No target at all, leave combat, reset aggro.
        elif not target and self.combat_target:
            self.leave_combat(force=True)
            return

        super().attack_update(elapsed)

    # override
    def receive_damage(self, amount, source=None, is_periodic=False, casting_spell=None):
        if not self.is_spawned:
            return False

        if not super().receive_damage(amount, source, is_periodic):
            return False

        # If creature's being attacked by another unit, automatically set combat target.
        not_attacked_by_gameobject = source and source.get_type_id() != ObjectTypeIds.ID_GAMEOBJECT
        if not_attacked_by_gameobject:
            if not self.combat_target:
                # Make sure to first stop any movement right away.
                self.stop_movement()

            threat = amount
            # TODO: Threat calculation.
            # No threat but source spell generates threat on miss.
            if casting_spell and threat == 0 and casting_spell.generates_threat_on_miss():
                threat = ThreatManager.THREAT_NOT_TO_LEAVE_COMBAT

            self.threat_manager.add_threat(source, threat)
        return True

    # override
    def receive_healing(self, amount, source=None):
        if not self.is_spawned:
            return False

        return super().receive_healing(amount, source)

    # override
    def receive_power(self, amount, power_type, source=None):
        if not self.is_spawned:
            return False

        return super().receive_power(amount, power_type, source)

    # override
    def die(self, killer=None):
        if not self.is_alive:
            return False

        if killer.get_type_id() != ObjectTypeIds.ID_PLAYER:
            # Attribute non-player kills to the creature's summoner.
            # TODO Does this also apply for player mind control?
            killer = killer.summoner if killer.summoner else killer

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self.loot_manager.generate_loot(killer)

            self.reward_kill_xp(killer)
            self.killed_by = killer
            # Handle required creature or go for quests and reputation.
            if self.killed_by.group_manager:
                self.killed_by.group_manager.reward_group_reputation(self.killed_by, self)
                self.killed_by.group_manager.reward_group_creature_or_go(self.killed_by, self)
            else:
                # Reward required creature or go and reputation to the player with the killing blow.
                self.killed_by.reward_reputation_on_kill(self)
                self.killed_by.quest_manager.reward_creature_or_go(self)

            # If the player is in a group, set the group as allowed looters if needed.
            if self.killed_by.group_manager and self.loot_manager.has_loot():
                self.killed_by.group_manager.set_allowed_looters(self)

        if self.loot_manager.has_loot():
            self.set_lootable(True)

        self.unit_flags = UnitFlags.UNIT_FLAG_STANDARD
        return super().die(killer)

    def reward_kill_xp(self, player):
        if self.static_flags & CreatureStaticFlags.NO_XP:
            return

        is_elite = 0 < self.creature_template.rank < 4
        if player.group_manager:
            player.group_manager.reward_group_xp(player, self, is_elite)
        else:
            player.give_xp([Formulas.CreatureFormulas.xp_reward(self.level, player.level, is_elite)], self)

    # override
    def set_max_mana(self, mana):
        if self.max_power_1 > 0:
            self.max_power_1 = mana
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_emote_state(self, emote_state):
        self.emote_state = emote_state
        self.set_uint32(UnitFields.UNIT_EMOTE_STATE, self.emote_state)

    def set_lootable(self, flag=True):
        if flag:
            self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        else:
            self.dynamic_flags &= ~UnitDynamicTypes.UNIT_DYNAMIC_LOOTABLE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

    # override
    def get_bytes_0(self):
        return ByteUtils.bytes_to_int(
            self.power_type,  # power type
            self.gender,  # gender
            self.creature_template.unit_class,  # class
            self.race  # race (0 for creatures)
        )

    # override
    def get_bytes_1(self):
        return ByteUtils.bytes_to_int(
            0,  # visibility flags
            self.shapeshift_form,  # shapeshift form
            self.npc_flags,  # npc flags
            self.stand_state  # stand state
        )

    # override
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # unknown
            0,  # pet flags
            0,  # misc flags
            self.sheath_state  # sheath state
        )

    # override
    def get_damages(self):
        return ByteUtils.shorts_to_int(
            int(self.creature_template.dmg_max),
            int(self.creature_template.dmg_min)
        )

    def _on_relocation(self):
        self.object_ai.movement_inform()

    # override
    def notify_moved_in_line_of_sight(self, target):
        self.object_ai.move_in_line_of_sight(target)

    # override
    def has_mainhand_weapon(self):
        return self.wearing_mainhand_weapon

    # override
    def has_offhand_weapon(self):
        return self.wearing_offhand_weapon

    # override
    def has_ranged_weapon(self):
        return self.wearing_ranged_weapon

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_2 = self.get_bytes_2()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def set_shapeshift_form(self, shapeshift_form):
        super().set_shapeshift_form(shapeshift_form)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def update_power_type(self):
        if not self.shapeshift_form:
            self.power_type = PowerTypes.TYPE_MANA
        else:
            self.power_type = ShapeshiftInfo.get_power_for_form(self.shapeshift_form)

        self.bytes_0 = self.get_bytes_0()

    # override
    def get_type_mask(self):
        return ObjectTypeFlags.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
