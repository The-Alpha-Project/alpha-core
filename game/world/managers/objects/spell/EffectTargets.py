import math

from dataclasses import dataclass
from typing import Union, Optional, Tuple

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.ExtendedSpellData import SummonedObjectPositions
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from utils.Logger import Logger
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
        caster_is_player = caster.is_player()
        caster_is_gameobject = caster.is_gameobject()

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

    def get_target_hostility_info(self, unit_target=None) -> Tuple[bool, bool]:  # Can target friendly, can target hostile.
        implicit_targets = {self.target_effect.implicit_target_a}

        if self.target_effect.implicit_target_b != SpellImplicitTargets.TARGET_INITIAL:
            implicit_targets.add(self.target_effect.implicit_target_b)

        has_friendly = FRIENDLY_IMPLICIT_TARGETS.intersection(implicit_targets)
        has_hostile = HOSTILE_IMPLICIT_TARGETS.intersection(implicit_targets)

        if has_friendly != has_hostile:
            return bool(has_friendly), bool(has_hostile)

        # Spells with implicit target set to 0 can have both friendly and hostile targets.
        # These spells include passives, testing spells and npc spells.
        # However, in these cases the target mask seems to be enough to resolve target friendliness.
        if self.target_effect.implicit_target_a == SpellImplicitTargets.TARGET_INITIAL and not \
                self.casting_spell.spell_entry.Targets & SpellTargetMask.ENEMIES:
            return True, False

        # Neutral targets can target any unit. Use target context if given to resolve.
        if NEUTRAL_IMPLICIT_TARGETS.intersection(implicit_targets):
            can_attack = self.casting_spell.spell_caster.can_attack_target(unit_target) if unit_target else None
            return (not can_attack, can_attack) if unit_target is not None else (True, True)

        return True, True

    def resolve_targets(self):
        if not self.simple_targets:
            self.resolve_simple_targets()

        self.previous_targets_a = self.resolved_targets_a
        self.previous_targets_b = self.resolved_targets_b
        self.resolved_targets_a = self.resolve_implicit_targets_reference(self.target_effect.implicit_target_a)
        if self.target_effect.implicit_target_b != SpellImplicitTargets.TARGET_INITIAL:
            # Don't consider INITIAL in B as set.
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
            if target.is_unit(by_mask=True) and self.effect_source.is_unit(by_mask=True):
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
    def get_surrounding_unit_targets(target_effect, source_unit=None, source_location=None,
                                     enemies_only=False, friends_only=False,
                                     distance_loc=None, radius=-1):
        casting_spell = target_effect.casting_spell
        caster = casting_spell.spell_caster
        source = source_unit or source_location
        if not source:
            source = caster

        if isinstance(source, Vector):
            radius = target_effect.get_radius() if radius == -1 else radius
            result = caster.get_map().get_surrounding_units_by_location(source,
                                                                        caster.map_id, caster.instance_id,
                                                                        radius, include_players=True)
            units = sorted(list(result[0].values()) + list(result[1].values()), key=lambda u: source.distance(u.location))
        else:
            units = source.get_map().get_surrounding_units(source, include_players=True)
            units = list(units[0].values()) + list(units[1].values())

        scripted_targets = WorldDatabaseManager.SpellScriptTargetHolder.\
            spell_script_targets_get_by_spell(target_effect.casting_spell.spell_entry.ID)

        if not enemies_only and not friends_only and not distance_loc and not \
                casting_spell.spell_entry.TargetCreatureType and not scripted_targets:
            return units  # No filters provided.

        return EffectTargets._filter_unit_targets(units, casting_spell,
                                                  enemies_only=enemies_only, friends_only=friends_only,
                                                  distance_loc=distance_loc, radius=radius,
                                                  target_entries=[t.target_entry for t in scripted_targets])

    @staticmethod
    def _filter_unit_targets(units, casting_spell, enemies_only=False, friends_only=False,
                             distance_loc=None, radius=-1, target_entries=None):
        filtered_units = []
        unit_type_restriction = casting_spell.spell_entry.TargetCreatureType

        radius_sqrd = radius ** 2
        for unit in units:
            # Unit type.
            if unit_type_restriction and not unit_type_restriction & (1 << unit.creature_type - 1):
                continue

            if target_entries and (not unit.is_unit() or unit.entry not in target_entries):
                continue

            # Friendliness.
            if enemies_only or friends_only:
                can_attack = casting_spell.spell_caster.can_attack_target(unit)
                if enemies_only and not can_attack or friends_only and can_attack:
                    continue

            # Distance.
            if distance_loc and radius != -1:
                if unit.location.distance_sqrd(distance_loc) > radius_sqrd:
                    continue

            filtered_units.append(unit)

        return filtered_units

    @staticmethod
    def get_enemies_from_unit_list(units: list[ObjectManager], caster):
        return [unit for unit in units if caster.can_attack_target(unit)]

    @staticmethod
    def get_friends_from_unit_list(units: list[ObjectManager], caster):
        return [unit for unit in units if not caster.can_attack_target(unit)]

    @staticmethod
    def get_party_members_from_unit_list(units: list[ObjectManager], caster):
        if not caster.is_player() or not caster.group_manager:
            return []

        # Party members can be hostile while dueling
        friendly_units = EffectTargets.get_friends_from_unit_list(units, caster)
        return [unit for unit in friendly_units if caster.group_manager.is_party_member(unit.guid)]

    @staticmethod
    def resolve_random_enemy_chain_in_area(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_area_effect_custom(casting_spell, target_effect):
        # Always paired with TARGET_ALL_AROUND_CASTER,
        # which applies unit entry restrictions via filtering in get_surrounding_unit_targets.

        if casting_spell.spell_entry.ID in [7353, 7358]:  # Cozy Fire - only apply on friendly targets without the aura.
            return [target for target in target_effect.targets.resolved_targets_a if
                    not casting_spell.spell_caster.can_attack_target(target) and
                    not target.aura_manager.get_similar_applied_auras_by_effect(target_effect)]

        return target_effect.targets.resolved_targets_a

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
        chain_distance = target_effect.chain_targets * 2.78  # spellchaineffects AvgSegmentLength
        final_targets = []
        # Use the initial target as start point.
        units = EffectTargets.get_surrounding_unit_targets(target_effect,
                                                           source_location=first_target.location,
                                                           enemies_only=True,
                                                           radius=chain_distance)
        for unit in units:
            if not unit.is_alive:
                continue
            unit_distance = first_target.location.distance(unit.location)
            if unit_distance > chain_distance:
                continue
            final_targets.append(unit)
            if len(final_targets) == target_effect.chain_targets:
                break
            first_target = unit

        return final_targets

    @staticmethod
    def resolve_master(casting_spell, target_effect):
        charmer_or_summoner = casting_spell.spell_caster.get_charmer_or_summoner()
        return charmer_or_summoner if charmer_or_summoner else []

    @staticmethod
    def resolve_pet(casting_spell, target_effect):
        if not casting_spell.spell_caster.is_unit(by_mask=True):
            return []
        active_pet = casting_spell.spell_caster.pet_manager.get_active_controlled_pet()
        return active_pet.creature if active_pet else []

    @staticmethod
    def resolve_unit_near_caster(casting_spell, target_effect):
        units = EffectTargets.get_surrounding_unit_targets(target_effect,
                                                           source_unit=casting_spell.spell_caster)
        closest_info = -1, None
        caster = casting_spell.spell_caster
        for unit in units:
            if caster is unit:
                continue
            new_distance_sqrd = caster.location.distance_sqrd(unit.location)
            if closest_info[0] == -1 or new_distance_sqrd < closest_info[0]:
                closest_info = new_distance_sqrd, unit

        if closest_info[0] > casting_spell.range_entry.RangeMax ** 2:
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
        radius = target_effect.get_radius()
        effect_source = casting_spell.initial_target

        if casting_spell.initial_target_is_terrain():
            # Ground-targeted AoE. Radius will be applied by get_surrounding_unit_targets.
            enemies = EffectTargets.get_surrounding_unit_targets(target_effect, source_location=effect_source,
                                                                 enemies_only=True)
        else:
            # Unit-targeted AoE - explosive shot.
            enemies = EffectTargets.get_surrounding_unit_targets(target_effect, source_unit=effect_source,
                                                                 enemies_only=True,
                                                                 distance_loc=effect_source.location,
                                                                 radius=radius)

            if effect_source in enemies:
                enemies.remove(effect_source)  # Effect source shouldn't be included in final targets.

        for enemy in enemies:
            # Write to impact timestamps to indicate that this target should be instant.
            # See SpellManager.calculate_impact_delays
            casting_spell.spell_impact_timestamps[enemy.guid] = -1

        if len(enemies) == 0 and len(target_effect.targets.resolved_targets_a) > 0:
            # As this target specifies on A in some cases, clear out A if no targets exist.
            target_effect.targets.resolved_targets_a = []
        return enemies

    @staticmethod
    def resolve_table_coordinates(casting_spell, target_effect):
        target_position = WorldDatabaseManager.spell_target_position_get_by_spell(casting_spell.spell_entry.ID)
        if not target_position:
            Logger.warning(f'Unimplemented target spell position for spell {casting_spell.spell_entry.ID}.')
            #  Not available in db tables, return initial target if available.
            if casting_spell.initial_target and casting_spell.initial_target_is_terrain():
                return [casting_spell.initial_target]
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
                target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_OBJECT_WILD or \
                target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_GUARDIAN or \
                target_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_OBJECT:
            return [casting_spell.spell_caster.location]

        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_party_around_caster(casting_spell, target_effect):
        caster = casting_spell.spell_caster

        caster_is_player = caster.is_player()
        caster_is_unit = caster.is_unit(by_mask=True)
        caster_pet_guardian = caster.pet_manager.get_active_controlled_pet_or_guardian() if caster_is_unit else None
        if caster_pet_guardian:
            caster_pet_guardian = caster_pet_guardian.creature

        charmer_or_summoner = caster.get_charmer_or_summoner() if caster_is_unit else None
        party_group = None
        distance_sqrd = target_effect.get_radius() ** 2

        # If caster has a player charmer/summoner, use his group manager.
        if charmer_or_summoner and charmer_or_summoner.is_player():
            party_group = charmer_or_summoner.group_manager
        # No charmer/summoner and caster is a player, use his group manager.
        elif caster_is_player and caster.group_manager:
            party_group = caster.group_manager

        units_in_range = []

        # These spells should include self (battle shout, prayer of healing etc.) unless the caster is a totem.
        if caster_is_unit and not caster.is_totem():
            units_in_range.append(caster)

        # Has a charmer/summoner and is within radius.
        if charmer_or_summoner and caster.location.distance_sqrd(charmer_or_summoner.location) < distance_sqrd:
            units_in_range.append(charmer_or_summoner)

        # Has a pet and is within radius.
        if caster_pet_guardian and caster.location.distance_sqrd(caster_pet_guardian.location) < distance_sqrd:
            units_in_range.append(caster_pet_guardian)

        if not party_group:
            return units_in_range

        units = EffectTargets.get_surrounding_unit_targets(target_effect, source_unit=caster)
        for unit in units:
            if caster in [unit, charmer_or_summoner, caster_pet_guardian] or \
                    not party_group.is_party_member(unit.guid) or \
                    caster.can_attack_target(unit):   # Dueling party members
                continue
            # Unit pets.
            unit_pet_guardian = unit.pet_manager.get_active_controlled_pet_or_guardian()
            if unit_pet_guardian and caster.location.distance_sqrd(unit_pet_guardian.creature.location) < distance_sqrd:
                units_in_range.append(unit_pet_guardian.creature)
            # Unit.
            if caster.location.distance_sqrd(unit.location) <= distance_sqrd:
                units_in_range.append(unit)

        return units_in_range

    # Never used in B
    @staticmethod
    def resolve_all_around_caster(casting_spell, target_effect):
        caster = casting_spell.spell_caster
        units = EffectTargets.get_surrounding_unit_targets(target_effect, source_unit=caster,
                                                           distance_loc=caster.location,
                                                           radius=target_effect.get_radius())
        return units

    @staticmethod
    def resolve_enemy_infront(casting_spell, target_effect):
        caster = casting_spell.spell_caster
        units = EffectTargets.get_surrounding_unit_targets(target_effect, source_unit=caster, enemies_only=True,
                                                           distance_loc=caster.location,
                                                           radius=target_effect.get_radius())

        return [unit for unit in units if caster.location.has_in_arc(unit.location, math.pi / 2)]

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

        return EffectTargets.get_surrounding_unit_targets(target_effect, source_location=target, friends_only=True)

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
        caster = casting_spell.spell_caster
        surrounding_units = [u for u in caster.get_map().get_surrounding_units(caster, include_players=False).values()]
        script_targets = WorldDatabaseManager.SpellScriptTargetHolder. \
            spell_script_targets_get_by_spell(target_effect.casting_spell.spell_entry.ID)
        target_entries = [t.target_entry for t in script_targets]
        return [u for u in surrounding_units if u.entry in target_entries]

    # Only used by warlock class quest summoning spells (7728, 7729).
    @staticmethod
    def resolve_gameobject_script_near_caster(casting_spell, target_effect):
        caster = casting_spell.spell_caster
        surrounding_gos = [go for go in caster.get_map().get_surrounding_gameobjects(caster).values()]
        script_targets = WorldDatabaseManager.SpellScriptTargetHolder.\
            spell_script_targets_get_by_spell(target_effect.casting_spell.spell_entry.ID)
        target_entries = [t.target_entry for t in script_targets]
        return [go for go in surrounding_gos if go.entry in target_entries]

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

HOSTILE_IMPLICIT_TARGETS = {
    SpellImplicitTargets.TARGET_RANDOM_ENEMY_CHAIN_IN_AREA,
    SpellImplicitTargets.TARGET_ENEMY_UNIT,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT,
    SpellImplicitTargets.TARGET_AREA_EFFECT_ENEMY_CHANNEL,
    SpellImplicitTargets.TARGET_HOSTILE_UNIT_SELECTION
}

NEUTRAL_IMPLICIT_TARGETS = {
    SpellImplicitTargets.TARGET_INITIAL,
    SpellImplicitTargets.TARGET_EFFECT_SELECT,
    SpellImplicitTargets.TARGET_UNIT,
    SpellImplicitTargets.TARGET_SCRIPT
}
