import math

from dataclasses import dataclass
from typing import Union, Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.ExtendedSpellData import SummonedObjectPositions
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds
from utils.constants.SpellCodes import SpellImplicitTargets, SpellMissReason, SpellEffects, SpellTargetMask, \
    SpellHitFlags


@dataclass
class TargetMissInfo:
    target: ObjectManager
    result: SpellMissReason
    flags: SpellHitFlags


class EffectTargets:
    def __init__(self, casting_spell, spell_effect):
        self.initial_target = casting_spell.initial_target
        # The source this effect is applied from. Used for calculating impact delay.
        self.effect_source = casting_spell.spell_caster

        self.casting_spell = casting_spell

        self.simple_targets = []

        self.target_effect = spell_effect

        self.previous_targets_a = None
        self.previous_targets_b = None  # Used for non-persistent targets (aoe effects etc.)

        self.resolved_targets_a = []
        self.resolved_targets_b = []

        # Some area auras have self-target, but party target is required instead.
        if self.target_effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS and \
                self.target_effect.implicit_target_a == SpellImplicitTargets.TARGET_SELF:
            self.target_effect.implicit_target_a = SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY

    def resolve_simple_targets(self):
        self.simple_targets = self.get_simple_targets()

    def get_simple_targets(self) -> dict[SpellImplicitTargets, list[Union[ObjectManager, Vector]]]:
        caster = self.casting_spell.spell_caster
        caster_is_player = caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        caster_is_gameobject = caster.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT

        target_is_player = self.casting_spell.initial_target_is_player()
        target_is_gameobject = self.casting_spell.initial_target_is_gameobject()
        target_is_item = self.casting_spell.initial_target_is_item()

        target_is_friendly = not caster_is_gameobject \
            and self.casting_spell.initial_target_is_unit_or_player() and not \
            caster.can_attack_target(self.casting_spell.initial_target)

        targeted_unit_is_hostile = not caster_is_gameobject and \
            self.casting_spell.requires_implicit_initial_unit_target() and \
            caster.can_attack_target(self.casting_spell.targeted_unit_on_cast_start)

        return {
            SpellImplicitTargets.TARGET_INITIAL: self.initial_target,  # Only accept in A.
            SpellImplicitTargets.TARGET_SELF: caster,
            SpellImplicitTargets.TARGET_INNKEEPER_COORDINATES: caster.get_deathbind_coordinates() if target_is_player and caster_is_player else [],
            SpellImplicitTargets.TARGET_SELECTED_FRIEND: self.initial_target if target_is_friendly else [],
            SpellImplicitTargets.TARGET_SELECTED_GAMEOBJECT: self.initial_target if target_is_gameobject else [],
            SpellImplicitTargets.TARGET_GAMEOBJECT_AND_ITEM: self.initial_target if target_is_gameobject or target_is_item else [],
            SpellImplicitTargets.TARGET_HOSTILE_UNIT_SELECTION: self.casting_spell.targeted_unit_on_cast_start if targeted_unit_is_hostile else [],
            SpellImplicitTargets.TARGET_SELF_FISHING: self.initial_target,

            # Unused, use guesses for now to avoid crashes.
            # Assuming it teleported everyone near the caster to their respective binding locations (or maybe it
            # teleported everyone to the nearest Binder).
            SpellImplicitTargets.TARGET_10: caster.get_deathbind_coordinates() if target_is_player and caster_is_player else [],  # Divine Escape (NYI).
            # No idea about this spell, you can't even select anything in the terrain.
            SpellImplicitTargets.TARGET_11: caster.get_deathbind_coordinates() if target_is_player and caster_is_player else [],  # Word of Recall Other.
            # I assume Zone Recall (OLD) teleported you to the Binder of the zone you were at, but just teleporting to
            # binding location for now.
            SpellImplicitTargets.TARGET_19: caster.get_deathbind_coordinates() if target_is_player and caster_is_player else []  # Zone Recall (OLD).
        }

    def resolve_implicit_targets_reference(self, implicit_target) -> Optional[list[Union[ObjectManager, Vector]]]:
        target = self.simple_targets[implicit_target] if implicit_target in self.simple_targets else TARGET_RESOLVERS[implicit_target](self.casting_spell, self.target_effect)

        # TODO: Avoid crash on unfinished implementation while target resolving isn't finished
        # Implemented handlers should always return [] if no targets are found
        if target is None:
            Logger.warning(f'Implicit target {implicit_target} resolved to None. Falling back to initial target or self.')
            target = self.initial_target if self.casting_spell.initial_target_is_object() else self.casting_spell.spell_caster

        if type(target) is not list:
            return [target]
        return target

    def can_target_friendly(self, target=None) -> bool:
        implicit_targets = {self.target_effect.implicit_target_a, self.target_effect.implicit_target_b}

        if FRIENDLY_IMPLICIT_TARGETS.intersection(implicit_targets):
            return True

        # Neutral targets can target friendly. Use target context if given to resolve.
        if NEUTRAL_IMPLICIT_TARGETS.intersection(implicit_targets):
            return not target or not self.casting_spell.spell_caster.can_attack_target(target)

        # Spells with implicit target set to 0 can have both friendly and hostile targets.
        # These spells include passives, testing spells and npc spells.
        # However, in these cases the target mask seems to be enough to resolve target friendliness.
        if self.target_effect.implicit_target_a == SpellImplicitTargets.TARGET_INITIAL and not \
                self.casting_spell.spell_entry.Targets & SpellTargetMask.ENEMIES:
            return True

        return False

    def resolve_targets(self):
        if not self.simple_targets:
            self.resolve_simple_targets()

        self.previous_targets_a = self.resolved_targets_a
        self.previous_targets_b = self.resolved_targets_b
        self.resolved_targets_a = self.resolve_implicit_targets_reference(self.target_effect.implicit_target_a)
        self.resolved_targets_b = self.resolve_implicit_targets_reference(self.target_effect.implicit_target_b)

    def remove_object_from_targets(self, guid):
        if len(self.resolved_targets_a) > 0 and isinstance(self.resolved_targets_a[0], ObjectManager):
            self.previous_targets_a = self.resolved_targets_a
            self.resolved_targets_a = [target for target in self.resolved_targets_a if target.guid != guid]

        if len(self.resolved_targets_b) > 0 and isinstance(self.resolved_targets_b[0], ObjectManager):
            self.previous_targets_b = self.resolved_targets_b
            self.resolved_targets_b = [target for target in self.resolved_targets_b if target.guid != guid]

    # noinspection PyUnresolvedReferences
    def get_effect_target_miss_results(self) -> dict[int, TargetMissInfo]:
        targets = self.get_resolved_effect_targets_by_type(ObjectManager)
        target_info = {}
        for target in targets:
            if target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT and \
                    self.effect_source.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
                result = target.stat_manager.get_spell_miss_result_against_self(self.casting_spell)
                target_info[target.guid] = TargetMissInfo(target, *result)
            else:
                target_info[target.guid] = TargetMissInfo(target, SpellMissReason.MISS_REASON_NONE, SpellHitFlags.NONE)
        return target_info

    def get_resolved_effect_targets_by_type(self, _type) -> list[Union[ObjectManager, Vector]]:
        b_matches_type = False
        # If both A and B are the same type, we should prefer B as it can act as specifying

        # Accept B when it's the correct type and not 0.
        # Also check for SPECIFYING_IMPLICIT_TARGETS since in those cases empty targets should still be prioritized.
        if self.target_effect.implicit_target_b != SpellImplicitTargets.TARGET_INITIAL:
            has_valid_b_targets = len(self.resolved_targets_b) > 0
            if not has_valid_b_targets and self.target_effect.implicit_target_b in SPECIFYING_IMPLICIT_TARGETS or \
                    has_valid_b_targets and isinstance(self.resolved_targets_b[0], _type):
                b_matches_type = True

        if self.resolved_targets_a and len(self.resolved_targets_a) > 0 and isinstance(self.resolved_targets_a[0], _type):
            if not b_matches_type:
                return self.resolved_targets_a  # If B is not the correct type but A is, return A targets

        return self.resolved_targets_b if b_matches_type else []  # A is not the correct type - return B if that is

    @staticmethod
    def get_enemies_from_unit_list(units: list[ObjectManager], caster):
        return [unit for unit in units if caster.can_attack_target(unit)]

    @staticmethod
    def get_friends_from_unit_list(units: list[ObjectManager], caster):
        return [unit for unit in units if not caster.can_attack_target(unit)]

    @staticmethod
    def get_party_members_from_unit_list(units: list[ObjectManager], caster):
        if caster.get_type_id() != ObjectTypeIds.ID_PLAYER or not caster.group_manager:
            return []

        # Party members can be hostile while dueling
        friendly_units = EffectTargets.get_friends_from_unit_list(units, caster)
        return [unit for unit in friendly_units if caster.group_manager.is_party_member(unit.guid)]

    @staticmethod
    def resolve_random_enemy_chain_in_area(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_area_effect_custom(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_chain_damage(casting_spell, target_effect):
        target_is_friendly = casting_spell.initial_target_is_unit_or_player() and not \
            casting_spell.spell_caster.can_attack_target(casting_spell.initial_target)

        first_target = casting_spell.initial_target

        if target_is_friendly:
            targeted_on_cast = casting_spell.targeted_unit_on_cast_start
            if not casting_spell.spell_caster.can_attack_target(targeted_on_cast):
                return []
            first_target = targeted_on_cast

        if not target_effect.chain_targets:
            return first_target

        # TODO not sure what distance to use here; these spells don't provide radius info.
        # Should distance be higher for ranged spells?
        chain_distance = 5
        target_result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        final_targets = []

        units = list(target_result[0].values()) + list(target_result[1].values())
        units = EffectTargets.get_enemies_from_unit_list(units, casting_spell.spell_caster)
        for unit in units:
            distance = first_target.location.distance(unit.location)
            if distance > chain_distance:
                continue
            final_targets.append(unit)
            if len(final_targets) == target_effect.chain_targets:
                break

        return final_targets

    @staticmethod
    def resolve_master(casting_spell, target_effect):
        charmer_or_summoner = casting_spell.spell_caster.get_charmer_or_summoner()
        return charmer_or_summoner if charmer_or_summoner else []

    @staticmethod
    def resolve_pet(casting_spell, target_effect):
        if not casting_spell.spell_caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return []
        active_pet = casting_spell.spell_caster.pet_manager.get_active_controlled_pet()
        return active_pet.creature if active_pet else []

    @staticmethod
    def resolve_unit_near_caster(casting_spell, target_effect):
        result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        units = list(result[0].values()) + list(result[1].values())

        closest_info = -1, None
        caster = casting_spell.spell_caster
        for unit in units:
            if caster is unit:
                continue
            new_distance = caster.location.distance(unit.location)
            if closest_info[0] == -1 or new_distance < closest_info[0]:
                closest_info = new_distance, unit

        if closest_info[0] > casting_spell.range_entry.RangeMax:
            return []

        return closest_info[1]

    # Besides a couple test spells, this target seems to only be used in TargetB with TargetA
    # TargetA resolves the units in the area, and this seems to act as a filter for enemies
    # ie. war stomp - ImplicitTargetA_1 = TARGET_ALL_AROUND_CASTER, B_1 = TARGET_ALL_ENEMY_IN_AREA
    # For the sake of completeness (test spells), we'll fall back to around caster if this is used in A
    @staticmethod
    def resolve_all_enemy_in_area(casting_spell, target_effect):
        resolved_a = target_effect.targets.resolved_targets_a

        if not target_effect.implicit_target_a:  # see notes
            resolved_a = EffectTargets.resolve_all_around_caster(casting_spell, target_effect)

        return EffectTargets.get_enemies_from_unit_list(resolved_a, casting_spell.spell_caster)

    @staticmethod
    def resolve_all_enemy_in_area_instant(casting_spell, target_effect):
        caster = casting_spell.spell_caster
        map_id = casting_spell.spell_caster.map_id
        instance_id = casting_spell.spell_caster.instance_id
        radius = target_effect.get_radius()
        if casting_spell.initial_target_is_terrain():
            effect_source = casting_spell.initial_target
            result = MapManager.get_surrounding_units_by_location(effect_source, map_id, instance_id, radius, True)  # Ground-targeted AoE.
            merged = list(result[0].values()) + list(result[1].values())
        else:
            # TODO len(target_effect.targets.resolved_targets_a) == 1 incorrectly resolves to a single target of an AoE spell.
            effect_source = target_effect.targets.resolved_targets_a[0] if len(target_effect.targets.resolved_targets_a) == 1 else caster
            target_effect.targets.effect_source = effect_source

            result = MapManager.get_surrounding_units(effect_source, include_players=True)  # Unit-targeted AoE - explosive shot.
            merged = list(result[0].values()) + list(result[1].values())
            merged = [target for target in merged if target.location.distance(effect_source.location) <= radius]  # Select targets in range.

        enemies = EffectTargets.get_enemies_from_unit_list(merged, casting_spell.spell_caster)
        if isinstance(effect_source, ObjectManager) and effect_source in enemies:
            enemies.remove(effect_source)  # Effect source shouldn't be included in final targets.

        for enemy in enemies:
            # Write to impact timestamps to indicate that this target should be instant.
            # See SpellManager.calculate_impact_delays
            casting_spell.spell_impact_timestamps[enemy.guid] = -1

        if len(enemies) == 0 and len(target_effect.targets.resolved_targets_a) > 0:
            target_effect.targets.resolved_targets_a = []  # As this target specifies on A in some cases, clear out A if no targets exist.
        return enemies

    @staticmethod
    def resolve_table_coordinates(casting_spell, target_effect):
        target_position = WorldDatabaseManager.spell_target_position_get_by_spell(casting_spell.spell_entry.ID)
        if not target_position:
            Logger.warning(f'Unimplemented target spell position for spell {casting_spell.spell_entry.ID}.')
            return []

        return target_position.target_map, Vector(target_position.target_position_x,
                                                  target_position.target_position_y,
                                                  target_position.target_position_z,
                                                  target_position.target_orientation)

    @staticmethod
    def resolve_effect_select(casting_spell, target_effect):
        if target_effect.effect_type == SpellEffects.SPELL_EFFECT_SCHOOL_DAMAGE:  # Hellfire, aura of rot
            units = EffectTargets.resolve_all_around_caster(casting_spell, target_effect)
            return EffectTargets.get_enemies_from_unit_list(units, casting_spell.spell_caster)

        if target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_WILD or \
                target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON or \
                target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_OBJECT_WILD:
            return [casting_spell.spell_caster]

        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_party_around_caster(casting_spell, target_effect):
        result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        units = list(result[0].values()) + list(result[1].values())

        caster = casting_spell.spell_caster

        units_in_range = []

        caster_is_player = caster.get_type_id() == ObjectTypeIds.ID_PLAYER
        caster_is_unit = caster.get_type_mask() & ObjectTypeFlags.TYPE_UNIT
        caster_pet = caster.pet_manager.get_active_controlled_pet() if caster_is_unit else None
        if caster_pet:
            caster_pet = caster_pet.creature

        charmer_or_summoner = caster.get_charmer_or_summoner() if caster_is_unit else None
        party_group = None
        distance = target_effect.get_radius()

        # If caster has a player charmer/summoner, use his group manager.
        if charmer_or_summoner and charmer_or_summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            party_group = charmer_or_summoner.group_manager
        # No charmer/summoner and caster is a player, use his group manager.
        elif caster_is_player and caster.group_manager:
            party_group = caster.group_manager

        # These spells should most likely include self (battle shout, prayer of healing etc.)
        if caster_is_unit:
            # Totems should not target themselves.
            if not caster.is_totem():
                units_in_range.append(caster)

        # Has a charmer/summoner and is within radius.
        if charmer_or_summoner and caster.location.distance(charmer_or_summoner.location) < distance:
            units_in_range.append(charmer_or_summoner)

        # Has a pet and is within radius.
        if caster_pet and caster.location.distance(caster_pet.location) < distance:
            units_in_range.append(caster_pet)

        if not party_group:
            return units_in_range

        for unit in units:
            if caster is unit or unit is charmer_or_summoner or unit is caster_pet or \
                    not party_group.is_party_member(unit.guid) or \
                    caster.can_attack_target(unit):   # Dueling party members
                continue
            # Unit pets.
            unit_pet = unit.pet_manager.get_active_controlled_pet()
            if unit_pet and caster.location.distance(unit_pet.creature.location) < distance:
                units_in_range.append(unit_pet.creature)
            # Unit.
            if caster.location.distance(unit.location) <= distance:
                units_in_range.append(unit)

        return units_in_range

    # Never used in B
    @staticmethod
    def resolve_all_around_caster(casting_spell, target_effect):
        result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        units = list(result[0].values()) + list(result[1].values())

        caster = casting_spell.spell_caster
        units_in_range = []
        for unit in units:
            if caster is unit:
                continue
            distance = caster.location.distance(unit.location)
            if distance <= target_effect.get_radius():
                units_in_range.append(unit)

        return units_in_range

    @staticmethod
    def resolve_enemy_infront(casting_spell, target_effect):
        result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        units = list(result[0].values()) + list(result[1].values())

        caster = casting_spell.spell_caster
        units_in_range_front = []
        for unit in units:
            if not caster.can_attack_target(unit):
                continue

            distance = caster.location.distance(unit.location)
            if distance > target_effect.get_radius():
                continue
            if caster.location.has_in_arc(unit.location, math.pi / 2):
                units_in_range_front.append(unit)

        return units_in_range_front

    @staticmethod
    def resolve_unit(casting_spell, target_effect):
        # Some effects using this can resolve to any kind of unit target (npc-cast spells, mind vision etc.)
        # while some have special restrictions based on effect (DUEL, TAME_CREATURE etc.)
        # Implement effect-specific restrictions here or just return the original targets.
        # Effect IDs using this: {3, 5, 6, 38, 55, 82, 83}

        effect_type = target_effect.effect_type
        initial_target = casting_spell.initial_target
        caster = casting_spell.spell_caster

        if effect_type == SpellEffects.SPELL_EFFECT_TAME_CREATURE:
            # Only tameable, attackable targets.
            return [initial_target] if initial_target.is_tameable() and \
                                       caster.can_attack_target(initial_target) else []

        return [initial_target]

    # Only used with TARGET_ALL_AROUND_CASTER in A.
    @staticmethod
    def resolve_all_friendly_around_caster(casting_spell, target_effect):
        resolved_a = target_effect.targets.resolved_targets_a
        return EffectTargets.get_friends_from_unit_list(resolved_a, casting_spell.spell_caster)

    # Only 6758 (party grenade).
    @staticmethod
    def resolve_all_friendly_in_area(casting_spell, target_effect):
        target = casting_spell.initial_target
        if not casting_spell.initial_target_is_terrain():
            return []
        map_id = casting_spell.spell_caster.map_id
        instance_id = casting_spell.spell_caster.instance_id
        result = MapManager.get_surrounding_units_by_location(target, map_id, instance_id, target_effect.get_radius(), True)

        merged = list(result[0].values()) + list(result[1].values())
        return EffectTargets.get_friends_from_unit_list(merged, casting_spell.spell_caster)

    # Totems, duel flag etc.
    # Positioning depends on effect.
    @staticmethod
    def resolve_minion(casting_spell, target_effect):
        caster_location = casting_spell.spell_caster.location
        if target_effect.effect_type == SpellEffects.SPELL_EFFECT_DUEL:
            target_location = target_effect.targets.resolved_targets_a[0].location
            return [SummonedObjectPositions.get_position_for_duel_flag(caster_location, target_location)]

        elif target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_TOTEM:
            totem_id = casting_spell.get_required_tools()[0]
            return [SummonedObjectPositions.get_position_for_totem(totem_id, caster_location)]

        elif target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_OBJECT:
            return SummonedObjectPositions.get_position_for_object(target_effect.misc_value, caster_location)

        # Default to initial (self) target position.
        return [casting_spell.initial_target.location]

    # Only used with TARGET_ALL_AROUND_CASTER in A
    @staticmethod
    def resolve_all_party(casting_spell, target_effect):
        resolved_a = target_effect.targets.resolved_targets_a

        return EffectTargets.get_party_members_from_unit_list(resolved_a, casting_spell.spell_caster)

    @staticmethod
    def resolve_party_around_caster_2(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_single_party(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_aoe_party(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_script(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_gameobject_script_near_caster(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    # Used by is_area_of_effect_spell.
    AREA_TARGETS = {
        SpellImplicitTargets.TARGET_AREAEFFECT_CUSTOM,
        SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA,
        SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT,
        SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY,
        SpellImplicitTargets.TARGET_INFRONT,
        SpellImplicitTargets.TARGET_AREA_EFFECT_ENEMY_CHANNEL,
        SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER,
        SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA,
        SpellImplicitTargets.TARGET_ALL_PARTY,
        SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2,
        SpellImplicitTargets.TARGET_AREAEFFECT_PARTY,
    }


TARGET_RESOLVERS = {
    SpellImplicitTargets.TARGET_MASTER: EffectTargets.resolve_master,
    SpellImplicitTargets.TARGET_PET: EffectTargets.resolve_pet,
    SpellImplicitTargets.TARGET_RANDOM_ENEMY_CHAIN_IN_AREA: EffectTargets.resolve_random_enemy_chain_in_area,
    SpellImplicitTargets.TARGET_UNIT_NEAR_CASTER: EffectTargets.resolve_unit_near_caster,
    SpellImplicitTargets.TARGET_AREAEFFECT_CUSTOM: EffectTargets.resolve_area_effect_custom,
    SpellImplicitTargets.TARGET_ENEMY_UNIT: EffectTargets.resolve_chain_damage,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA: EffectTargets.resolve_all_enemy_in_area,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT: EffectTargets.resolve_all_enemy_in_area_instant,
    SpellImplicitTargets.TARGET_AREA_EFFECT_ENEMY_CHANNEL: EffectTargets.resolve_all_enemy_in_area_instant,
    SpellImplicitTargets.TARGET_TABLE_X_Y_Z_COORDINATES: EffectTargets.resolve_table_coordinates,
    SpellImplicitTargets.TARGET_EFFECT_SELECT: EffectTargets.resolve_effect_select,
    SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY: EffectTargets.resolve_party_around_caster,
    SpellImplicitTargets.TARGET_ALL_AROUND_CASTER: EffectTargets.resolve_all_around_caster,
    SpellImplicitTargets.TARGET_INFRONT: EffectTargets.resolve_enemy_infront,
    SpellImplicitTargets.TARGET_UNIT: EffectTargets.resolve_unit,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER: EffectTargets.resolve_all_friendly_around_caster,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA: EffectTargets.resolve_all_friendly_in_area,
    SpellImplicitTargets.TARGET_MINION: EffectTargets.resolve_minion,
    SpellImplicitTargets.TARGET_ALL_PARTY: EffectTargets.resolve_all_party,
    SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2: EffectTargets.resolve_party_around_caster_2,
    SpellImplicitTargets.TARGET_SINGLE_PARTY: EffectTargets.resolve_single_party,
    SpellImplicitTargets.TARGET_AREAEFFECT_PARTY: EffectTargets.resolve_aoe_party,
    SpellImplicitTargets.TARGET_SCRIPT: EffectTargets.resolve_script,
    SpellImplicitTargets.TARGET_GAMEOBJECT_SCRIPT_NEAR_CASTER: EffectTargets.resolve_gameobject_script_near_caster
}

# Targets that should gain priority over A when present in B instead of treating B as secondary targets for the spell.
SPECIFYING_IMPLICIT_TARGETS = {
    SpellImplicitTargets.TARGET_AREAEFFECT_CUSTOM,  # Used with 22 in A.
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA,  # Used with 18/22 in A.
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT,  # Used with 6/17/18/22 in A (note that 17 is a vector).
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER,  # Used with 22 in A.
    SpellImplicitTargets.TARGET_ALL_PARTY  # Used with 22 in A.
}

FRIENDLY_IMPLICIT_TARGETS = {
    SpellImplicitTargets.TARGET_SELF,
    SpellImplicitTargets.TARGET_PET,
    # SpellImplicitTargets.TARGET_EFFECT_SELECT  # All self casts except one hostile aoe
    SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY,
    SpellImplicitTargets.TARGET_SELECTED_FRIEND,
    # SpellImplicitTargets.TARGET_INFRONT,  # Only hostile
    # SpellImplicitTargets.TARGET_UNIT  # Can target both - resolved by checking target hostility
    SpellImplicitTargets.TARGET_MASTER,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA,
    SpellImplicitTargets.TARGET_MINION,
    SpellImplicitTargets.TARGET_ALL_PARTY,
    SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2,
    SpellImplicitTargets.TARGET_SINGLE_PARTY,
    SpellImplicitTargets.TARGET_AREAEFFECT_PARTY,  # Power infuses the target's party increasing their Shadow resistance by $s1 for $d.
    # SpellImplicitTargets.TARGET_SCRIPT  # Resolved separately
}

NEUTRAL_IMPLICIT_TARGETS = {
    SpellImplicitTargets.TARGET_EFFECT_SELECT,
    SpellImplicitTargets.TARGET_UNIT,
    SpellImplicitTargets.TARGET_SCRIPT
}
