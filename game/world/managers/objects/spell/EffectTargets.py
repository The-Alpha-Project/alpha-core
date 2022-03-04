import math
from typing import Union, Optional

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.spell.ExtendedSpellData import SummonedObjectPositions
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypes
from utils.constants.SpellCodes import SpellImplicitTargets, SpellMissReason, SpellEffects


class TargetMissInfo:
    def __init__(self, target, result):
        self.target = target
        self.result = result


class EffectTargets:
    def __init__(self, casting_spell, spell_effect):
        self.initial_target = casting_spell.initial_target
        self.effect_source = casting_spell.spell_caster  # The source this effect is applied from. Used for calculating impact delay.

        self.casting_spell = casting_spell

        self.simple_targets = []

        self.target_effect = spell_effect

        self.previous_targets_a = None
        self.previous_targets_b = None  # Used for non-persistent targets (aoe effects etc.)

        self.resolved_targets_a = []
        self.resolved_targets_b = []

        if self.target_effect.effect_type in SpellEffectHandler.AREA_SPELL_EFFECTS and \
                self.target_effect.implicit_target_a == SpellImplicitTargets.TARGET_SELF:  # some area auras have self-target, but party target is required instead
            self.target_effect.implicit_target_a = SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY

    def resolve_simple_targets(self):
        self.simple_targets = self.get_simple_targets()

    def get_simple_targets(self) -> dict[SpellImplicitTargets, list[Union[ObjectManager, Vector]]]:
        caster = self.casting_spell.spell_caster
        caster_is_player = caster.get_type() == ObjectTypes.TYPE_PLAYER
        caster_is_gameobject = caster.get_type() == ObjectTypes.TYPE_GAMEOBJECT

        target_is_player = self.casting_spell.initial_target_is_player()
        target_is_gameobject = self.casting_spell.initial_target_is_gameobject()
        target_is_item = self.casting_spell.initial_target_is_item()

        target_is_friendly = not caster_is_gameobject and self.casting_spell.initial_target_is_unit_or_player() and not \
            caster.can_attack_target(self.casting_spell.initial_target)

        return {
            SpellImplicitTargets.TARGET_INITIAL: self.initial_target,  # Only accept in A.
            SpellImplicitTargets.TARGET_SELF: caster,
            SpellImplicitTargets.TARGET_PET: [],  # TODO
            SpellImplicitTargets.TARGET_INNKEEPER_COORDINATES: caster.get_deathbind_coordinates() if target_is_player and caster_is_player else [],
            SpellImplicitTargets.TARGET_11: [],  # Word of Recall Other - seems deprecated so return nothing
            SpellImplicitTargets.TARGET_SELECTED_FRIEND: self.initial_target if target_is_friendly else [],
            SpellImplicitTargets.TARGET_SELECTED_GAMEOBJECT: self.initial_target if target_is_gameobject else [],
            SpellImplicitTargets.TARGET_DUEL_VS_PLAYER: self.initial_target,  # Spells that can be cast on both hostile and friendly?
            SpellImplicitTargets.TARGET_GAMEOBJECT_AND_ITEM: self.initial_target if target_is_gameobject or target_is_item else [],
            SpellImplicitTargets.TARGET_MASTER: [],  # TODO
            SpellImplicitTargets.TARGET_SELF_FISHING: caster
        }

    def resolve_implicit_targets_reference(self, implicit_target) -> Optional[list[Union[ObjectManager, Vector]]]:
        target = self.simple_targets[implicit_target] if implicit_target in self.simple_targets else TARGET_RESOLVERS[implicit_target](self.casting_spell, self.target_effect)

        # Avoid crash on unfinished implementation while target resolving isn't finished TODO
        # Implemented handlers should always return [] if no targets are found
        if target is None:
            Logger.warning(f'Implicit target {implicit_target} resolved to None. Falling back to initial target or self.')
            target = self.initial_target if self.casting_spell.initial_target_is_object() else self.casting_spell.spell_caster

        if type(target) is not list:
            return [target]
        return target

    def can_target_friendly(self) -> bool:
        return self.target_effect.implicit_target_a in FRIENDLY_IMPLICIT_TARGETS or \
               self.target_effect.implicit_target_b in FRIENDLY_IMPLICIT_TARGETS

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

    def get_effect_target_miss_results(self) -> dict[int, TargetMissInfo]:
        targets = self.get_resolved_effect_targets_by_type(ObjectManager)
        target_info = {}
        for target in targets:
            if isinstance(target, ObjectManager):
                target_info[target.guid] = TargetMissInfo(target, SpellMissReason.MISS_REASON_NONE)  # TODO Misses etc.
        return target_info

    def get_resolved_effect_targets_by_type(self, _type) -> list[Union[ObjectManager, Vector]]:
        b_matches_type = False
        # If both A and B are the same type, we should prefer B as it can act as specifying
        # TODO if issues arise, add table for specifying ImplicitTargets

        # Accept B when it's the correct type and not 0.
        if self.resolved_targets_b and self.target_effect.implicit_target_b != SpellImplicitTargets.TARGET_INITIAL and \
                len(self.resolved_targets_b) > 0 and isinstance(self.resolved_targets_b[0], _type):
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
        if caster.get_type() != ObjectTypes.TYPE_PLAYER or not caster.group_manager:
            return []

        friendly_units = EffectTargets.get_friends_from_unit_list(units, caster)  # Party members can be hostile while dueling
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
        if not target_is_friendly:
            return [casting_spell.initial_target]

        target_on_cast = casting_spell.targeted_unit_on_cast_start
        return [target_on_cast] if target_on_cast and casting_spell.spell_caster.can_attack_target(target_on_cast) else []

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
        map_ = casting_spell.spell_caster.map_
        radius = target_effect.get_radius()
        if casting_spell.initial_target_is_terrain():
            effect_source = casting_spell.initial_target
            result = MapManager.get_surrounding_units_by_location(effect_source, map_, radius, True)  # Ground-targeted AoE.
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

        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_party_around_caster(casting_spell, target_effect):
        result = MapManager.get_surrounding_units(casting_spell.spell_caster, True)
        units = list(result[0].values()) + list(result[1].values())

        caster = casting_spell.spell_caster

        units_in_range = []

        # These spells should most likely include self (battle shout, prayer of healing etc.)
        if ObjectTypes.TYPE_UNIT in caster.object_type:
            units_in_range.append(caster)

        if caster.get_type() != ObjectTypes.TYPE_PLAYER or not caster.group_manager:
            return units_in_range  # TODO pets etc. should probably be targeted

        for unit in units:
            if caster is unit or not caster.group_manager.is_party_member(unit.guid) or \
                    caster.can_attack_target(unit):  # Dueling party members
                continue
            distance = caster.location.distance(unit.location)
            if distance <= target_effect.get_radius():
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
    def resolve_aoe_enemy_channel(casting_spell, target_effect):
        Logger.warning(f'Unimplemented implicit target called for spell {casting_spell.spell_entry.ID}')

    # Only used with TARGET_ALL_AROUND_CASTER in A
    @staticmethod
    def resolve_all_friendly_around_caster(casting_spell, target_effect):
        resolved_a = target_effect.targets.resolved_targets_a
        return EffectTargets.get_friends_from_unit_list(resolved_a, casting_spell.spell_caster)

    # Only 6758 (party grenade)
    @staticmethod
    def resolve_all_friendly_in_area(casting_spell, target_effect):
        target = casting_spell.initial_target
        if not casting_spell.initial_target_is_terrain():
            return []
        map_ = casting_spell.spell_caster.map_
        result = MapManager.get_surrounding_units_by_location(target, map_, target_effect.get_radius(), True)

        merged = list(result[0].values()) + list(result[1].values())
        return EffectTargets.get_friends_from_unit_list(merged, casting_spell.spell_caster)

    # Totems, duel flag etc.
    # Positioning depends on effect
    @staticmethod
    def resolve_minion(casting_spell, target_effect):
        caster_location = casting_spell.spell_caster.location
        if target_effect.effect_type == SpellEffects.SPELL_EFFECT_DUEL:
            target_location = target_effect.targets.resolved_targets_a[0].location
            # TODO flag is spawned by DuelManager for now
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
    def resolve_all_hostile_around_caster(casting_spell, target_effect):  # TODO Charge effects only?
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


TARGET_RESOLVERS = {
    SpellImplicitTargets.TARGET_RANDOM_ENEMY_CHAIN_IN_AREA: EffectTargets.resolve_random_enemy_chain_in_area,
    SpellImplicitTargets.TARGET_UNIT_NEAR_CASTER: EffectTargets.resolve_unit_near_caster,
    SpellImplicitTargets.TARGET_AREAEFFECT_CUSTOM: EffectTargets.resolve_area_effect_custom,
    SpellImplicitTargets.TARGET_CHAIN_DAMAGE: EffectTargets.resolve_chain_damage,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA: EffectTargets.resolve_all_enemy_in_area,
    SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT: EffectTargets.resolve_all_enemy_in_area_instant,
    SpellImplicitTargets.TARGET_TABLE_X_Y_Z_COORDINATES: EffectTargets.resolve_table_coordinates,
    SpellImplicitTargets.TARGET_EFFECT_SELECT: EffectTargets.resolve_effect_select,
    SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY: EffectTargets.resolve_party_around_caster,
    SpellImplicitTargets.TARGET_ALL_AROUND_CASTER: EffectTargets.resolve_all_around_caster,
    SpellImplicitTargets.TARGET_INFRONT: EffectTargets.resolve_enemy_infront,
    SpellImplicitTargets.TARGET_AREA_EFFECT_ENEMY_CHANNEL: EffectTargets.resolve_aoe_enemy_channel,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER: EffectTargets.resolve_all_friendly_around_caster,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA: EffectTargets.resolve_all_friendly_in_area,
    SpellImplicitTargets.TARGET_MINION: EffectTargets.resolve_minion,
    SpellImplicitTargets.TARGET_ALL_PARTY: EffectTargets.resolve_all_party,
    SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2: EffectTargets.resolve_party_around_caster_2,
    SpellImplicitTargets.TARGET_SINGLE_PARTY: EffectTargets.resolve_single_party,
    SpellImplicitTargets.TARGET_ALL_HOSTILE_UNITS_AROUND_CASTER: EffectTargets.resolve_all_hostile_around_caster,
    SpellImplicitTargets.TARGET_AREAEFFECT_PARTY: EffectTargets.resolve_aoe_party,
    SpellImplicitTargets.TARGET_SCRIPT: EffectTargets.resolve_script,
    SpellImplicitTargets.TARGET_GAMEOBJECT_SCRIPT_NEAR_CASTER: EffectTargets.resolve_gameobject_script_near_caster
}

FRIENDLY_IMPLICIT_TARGETS = [
    SpellImplicitTargets.TARGET_SELF,
    SpellImplicitTargets.TARGET_PET,
    # SpellImplicitTargets.TARGET_EFFECT_SELECT  # All self casts except one hostile aoe
    SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY,
    SpellImplicitTargets.TARGET_SELECTED_FRIEND,
    # SpellImplicitTargets.TARGET_INFRONT,  # Only hostile
    # SpellImplicitTargets.TARGET_DUEL_VS_PLAYER = 25  # Can target both - resolved by checking target hostility
    SpellImplicitTargets.TARGET_MASTER,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER,
    SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA,
    SpellImplicitTargets.TARGET_MINION,
    SpellImplicitTargets.TARGET_ALL_PARTY,
    SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2,
    SpellImplicitTargets.TARGET_SINGLE_PARTY,
    SpellImplicitTargets.TARGET_AREAEFFECT_PARTY,  # Power infuses the target's party increasing their Shadow resistance by $s1 for $d.
    # SpellImplicitTargets.TARGET_SCRIPT = 38  # Resolved separately
]
