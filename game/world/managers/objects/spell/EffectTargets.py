from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.ObjectManager import ObjectManager
from utils.Logger import Logger
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import SpellImplicitTargets, SpellMissReason


class TargetMissInfo:
    def __init__(self, target, result):
        self.target = target
        self.result = result


class EffectTargets:
    def __init__(self, casting_spell, spell_effect):
        self.initial_target = casting_spell.initial_target_unit
        self.caster = casting_spell.spell_caster
        self.casting_spell = casting_spell

        self.simple_targets = self.get_simple_targets(casting_spell.spell_caster.get_type(),
                                                      self.caster.is_friendly_to(casting_spell.initial_target_unit))

        self.target_effect = spell_effect
        self.resolved_targets_a = None
        self.resolved_targets_b = None

    def get_simple_targets(self, target_object_type, is_friendly_target):
        is_player = target_object_type == ObjectTypes.TYPE_PLAYER
        is_gameobject = target_object_type == ObjectTypes.TYPE_GAMEOBJECT
        is_item = target_object_type == ObjectTypes.TYPE_ITEM
        return {
            SpellImplicitTargets.TARGET_NOTHING: 0,
            SpellImplicitTargets.TARGET_SELF: self.caster,
            SpellImplicitTargets.TARGET_PET: 0,  # TODO
            SpellImplicitTargets.TARGET_CHAIN_DAMAGE: self.initial_target,  # TODO - resolve chain targets
            SpellImplicitTargets.TARGET_INNKEEPER_COORDINATES: self.caster.get_deathbind_coordinates() if is_player else 0,
            SpellImplicitTargets.TARGET_SELECTED_FRIEND: self.initial_target if is_friendly_target else 0,
            SpellImplicitTargets.TARGET_SELECTED_GAMEOBJECT: self.initial_target if is_gameobject else 0,
            SpellImplicitTargets.TARGET_DUEL_VS_PLAYER: self.initial_target,  # Spells that can be cast on both hostile and friendly?
            SpellImplicitTargets.TARGET_GAMEOBJECT_AND_ITEM: self.initial_target if is_gameobject or is_item else 0,
            SpellImplicitTargets.TARGET_MASTER: None,  # TODO
            SpellImplicitTargets.TARGET_MINION: None,  # TODO
            SpellImplicitTargets.TARGET_SELF_FISHING: self.caster
        }

    def resolve_implicit_targets_reference(self, implicit_target):
        target = self.simple_targets[implicit_target] if implicit_target in self.simple_targets else self.TARGET_RESOLVERS[implicit_target](self.casting_spell)
        if type(target) is not list:
            return [target]
        return target

    def resolve_targets(self):
        self.resolved_targets_a = self.resolve_implicit_targets_reference(self.target_effect.implicit_target_a)
        self.resolved_targets_b = self.resolve_implicit_targets_reference(self.target_effect.implicit_target_b)

    def get_effect_target_results(self):
        targets = self.resolved_targets_a  # TODO B?
        target_info = {}
        for target in targets:
            if isinstance(target, ObjectManager):
                target_info[target.guid] = TargetMissInfo(target, SpellMissReason.MISS_REASON_NONE)  # TODO Misses etc.
        return target_info

    @staticmethod
    def resolve_random_enemy_chain_in_area(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_area_effect_custom(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_unit_near_caster(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_all_enemy_in_area(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_all_enemy_in_area_instant(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_table_coordinates(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_effect_select(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_party_around_caster(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_selected_friend(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_enemy_around_caster(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_infront(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_aoe_enemy_channel(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_all_friendly_around_caster(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_all_friendly_in_area(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_all_party(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_party_around_caster_2(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_single_party(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_aoe_party(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_script(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    @staticmethod
    def resolve_gameobject_script_near_caster(casting_spell):
        Logger.warning(f'Unimlemented implicit target called for spell {casting_spell.spell_entry.ID}')

    TARGET_RESOLVERS = {
        SpellImplicitTargets.TARGET_RANDOM_ENEMY_CHAIN_IN_AREA: resolve_random_enemy_chain_in_area,
        SpellImplicitTargets.TARGET_UNIT_NEAR_CASTER: resolve_unit_near_caster,
        SpellImplicitTargets.TARGET_AREAEFFECT_CUSTOM: resolve_area_effect_custom,
        SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA: resolve_all_enemy_in_area,
        SpellImplicitTargets.TARGET_ALL_ENEMY_IN_AREA_INSTANT: resolve_all_enemy_in_area_instant,
        SpellImplicitTargets.TARGET_TABLE_X_Y_Z_COORDINATES: resolve_table_coordinates,
        SpellImplicitTargets.TARGET_EFFECT_SELECT: resolve_effect_select,
        SpellImplicitTargets.TARGET_AROUND_CASTER_PARTY: resolve_party_around_caster,
        SpellImplicitTargets.TARGET_SELECTED_FRIEND: resolve_selected_friend,
        SpellImplicitTargets.TARGET_AROUND_CASTER_ENEMY: resolve_enemy_around_caster,
        SpellImplicitTargets.TARGET_INFRONT: resolve_infront,
        SpellImplicitTargets.TARGET_AREA_EFFECT_ENEMY_CHANNEL: resolve_aoe_enemy_channel,
        SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_AROUND_CASTER: resolve_all_friendly_around_caster,
        SpellImplicitTargets.TARGET_ALL_FRIENDLY_UNITS_IN_AREA: resolve_all_friendly_in_area,
        SpellImplicitTargets.TARGET_ALL_PARTY: resolve_all_party,
        SpellImplicitTargets.TARGET_ALL_PARTY_AROUND_CASTER_2: resolve_party_around_caster_2,
        SpellImplicitTargets.TARGET_SINGLE_PARTY: resolve_single_party,
        SpellImplicitTargets.TARGET_AREAEFFECT_PARTY: resolve_aoe_party,
        SpellImplicitTargets.TARGET_SCRIPT: resolve_script,
        SpellImplicitTargets.TARGET_GAMEOBJECT_SCRIPT_NEAR_CASTER: resolve_gameobject_script_near_caster
    }
