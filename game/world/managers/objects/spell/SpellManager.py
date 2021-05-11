import time
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterSpell
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.spell.CastingSpell import CastingSpell
from game.world.managers.objects.spell.SpellEffectHandler import SpellEffectHandler
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ItemCodes import InventoryError, InventoryTypes
from utils.constants.ObjectCodes import ObjectTypes
from utils.constants.SpellCodes import SpellCheckCastResult, SpellCastStatus, \
    SpellMissReason, SpellTargetMask, SpellState, SpellEffects, SpellAttributes, SpellCastFlags
from utils.constants.UnitCodes import PowerTypes


class SpellManager(object):
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.spells = {}
        self.cooldowns = {}
        self.casting_spells = []

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.unit_mgr.guid):
            self.spells[spell.spell] = spell

    def learn_spell(self, spell_id):
        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return False

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return False

        if spell_id in self.spells:
            return False

        db_spell = CharacterSpell()
        db_spell.guid = self.unit_mgr.guid
        db_spell.spell = spell_id
        RealmDatabaseManager.character_add_spell(db_spell)
        self.spells[spell_id] = db_spell

        data = pack('<H', spell_id)
        self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LEARNED_SPELL, data))
        # Teach skills required as well like in CharCreateHandler?
        return True

    def get_initial_spells(self):
        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            data += pack('<2H', spell.spell, 0)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def handle_cast_attempt(self, spell_id, caster, spell_target, target_mask):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell or not spell_target:
            return

        self.start_spell_cast(spell, caster, spell_target, target_mask)

    def start_spell_cast(self, spell, caster_obj, spell_target, target_mask):
        casting_spell = CastingSpell(spell, caster_obj, spell_target, target_mask)  # Initializes dbc references

        if not self.validate_cast(casting_spell):
            return

        if casting_spell.casts_on_swing():  # Handle swing ability queue and state
            queued_melee_ability = self.get_queued_melee_ability()
            if queued_melee_ability:
                self.remove_cast(queued_melee_ability, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)  # Only one melee ability can be queued

            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED  # Wait for next swing
            self.casting_spells.append(casting_spell)
            return

        self.casting_spells.append(casting_spell)
        casting_spell.cast_state = SpellState.SPELL_STATE_CASTING

        if not casting_spell.is_instant_cast():
            self.send_cast_start(casting_spell)
            return

        # Spell is instant, perform cast
        self.perform_spell_cast(casting_spell, False)

    def perform_spell_cast(self, casting_spell, validate=True):
        if validate and not self.validate_cast(casting_spell):
            self.remove_cast(casting_spell)
            return

        casting_spell.unit_target_results = self.resolve_target_info_for_spell_effects(casting_spell)

        if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_NO_ERROR)
            self.send_spell_go(casting_spell)
        else:
            return  # Spell is in delayed state, do nothing for now

        travel_time = self.calculate_time_to_impact(casting_spell)

        if travel_time != 0:
            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED
            casting_spell.spell_delay_end_timestamp = time.time() + travel_time
            self.consume_resources_for_cast(casting_spell)  # Remove resources
            return

        self.apply_spell_effects_and_remove(casting_spell)  # Apply effects

        if not casting_spell.trigger_cooldown_on_remove():
            self.set_on_cooldown(casting_spell.spell_entry)
        else:
            self.remove_cooldown(casting_spell.spell_entry)

        self.consume_resources_for_cast(casting_spell)  # Remove resources - order matters for combo points
        # self.send_channel_start(casting_spell.cast_time_entry.Base) TODO Channeled spells

    def apply_spell_effects_and_remove(self, casting_spell):
        for effect in casting_spell.effects:
            for target in effect.targets.resolved_targets_a:  # TODO B? targets.unit_targets?
                SpellEffectHandler.apply_effect(casting_spell, effect, target)
        self.remove_cast(casting_spell)

    def resolve_target_info_for_spell_effects(self, casting_spell):
        info = {}
        for effect in casting_spell.effects:
            effect.targets.resolve_targets()  # Inititalize references for implicit targets
            effect_info = effect.targets.get_effect_target_results()
            for target, result in effect_info.items():  # Resolve targets for all effects, keep unique ones (though not sure if uniqueness is an issue)
                if target in info:
                    continue
                info[target] = result
        return info

    def cast_queued_melee_ability(self, attack_type):
        melee_ability = self.get_queued_melee_ability()

        if not melee_ability or not self.validate_cast(melee_ability):
            self.remove_cast(melee_ability)
            return False

        melee_ability.spell_attack_type = attack_type

        melee_ability.cast_state = SpellState.SPELL_STATE_CASTING
        self.perform_spell_cast(melee_ability, False)
        return True

    def get_queued_melee_ability(self):
        for casting_spell in self.casting_spells:
            if not casting_spell.casts_on_swing() or \
                    casting_spell.cast_state != SpellState.SPELL_STATE_DELAYED:
                continue
            return casting_spell
        return None

    has_moved = False

    def flag_as_moved(self):
        # TODO temporary way of handling this until movement data can be passed to update()
        if len(self.casting_spells) == 0:
            return
        self.has_moved = True

    def update(self, timestamp):
        moved = self.has_moved
        self.has_moved = False  # Reset has_moved on every update
        for casting_spell in list(self.casting_spells):
            if casting_spell.casts_on_swing():  # spells cast on swing will be updated on call from attack handling
                continue
            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING:
                if casting_spell.cast_end_timestamp <= timestamp:
                    if not self.validate_cast(casting_spell):  # Spell finished casting, validate again
                        self.remove_cast(casting_spell)
                        return
                    self.perform_spell_cast(casting_spell)
                    if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED:  # Spell finished after perform (no impact delay)
                        self.remove_cast(casting_spell)
                elif moved:  # Spell has not finished casting, check movement
                    self.remove_cast(casting_spell, SpellCheckCastResult.SPELL_FAILED_MOVING)
                    self.has_moved = False
                    return

            elif casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED and \
                    casting_spell.spell_delay_end_timestamp <= timestamp:  # Spell was cast already and impact delay is done
                self.apply_spell_effects_and_remove(casting_spell)

    def remove_cast(self, casting_spell, cast_result=SpellCheckCastResult.SPELL_NO_ERROR):
        if casting_spell not in self.casting_spells:
            return
        self.casting_spells.remove(casting_spell)
        if cast_result != SpellCheckCastResult.SPELL_NO_ERROR:
            self.send_cast_result(casting_spell.spell_entry.ID, cast_result)

    def calculate_time_to_impact(self, casting_spell):
        if casting_spell.spell_entry.Speed == 0:
            return 0

        travel_distance = casting_spell.range_entry.RangeMax
        if casting_spell.initial_target_is_unit_or_player():
            target_unit_location = casting_spell.initial_target.location
            travel_distance = casting_spell.spell_caster.location.distance(target_unit_location)

        return travel_distance / casting_spell.spell_entry.Speed

    def send_cast_start(self, casting_spell):
        data = [self.unit_mgr.guid, self.unit_mgr.guid,  # TODO Source (1st arg) can also be item
                casting_spell.spell_entry.ID, casting_spell.cast_flags, casting_spell.get_base_cast_time(),
                casting_spell.spell_target_mask]

        signature = '<2QIHiH'  # source, caster, ID, flags, delay .. (targets, opt. ammo displayID/inventorytype)

        if casting_spell.initial_target and casting_spell.spell_target_mask != SpellTargetMask.SELF:  # Some self-cast spells crash client if target is written
            target_info = casting_spell.get_target_info()  # ([values], signature)
            data.extend(target_info[0])
            signature += target_info[1]

        if casting_spell.cast_flags & SpellCastFlags.CAST_FLAG_HAS_AMMO:
            signature += '2I'
            data.append(5996)  # TODO ammo display ID
            data.append(InventoryTypes.AMMO)  # TODO ammo inventorytype (thrown too)


        data = pack(signature, *data)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_SPELL_START, data), self.unit_mgr,
                                    include_self=self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER)

    def send_spell_go(self, casting_spell):
        data = [self.unit_mgr.guid, self.unit_mgr.guid,
                casting_spell.spell_entry.ID, casting_spell.cast_flags]


        signature = '<2QIH'  # source, caster, ID, flags .. (targets, ammo info)

        # Prepare target data
        results_by_type = {SpellMissReason.MISS_REASON_NONE: []}  # Hits need to be written first
        for target_guid, miss_info in casting_spell.unit_target_results.items():
            new_targets = results_by_type.get(miss_info.result, [])
            new_targets.append(target_guid)
            results_by_type[miss_info.result] = new_targets  # Sort targets by hit type for filling packet fields

        hit_count = len(results_by_type[SpellMissReason.MISS_REASON_NONE])
        miss_count = len(casting_spell.unit_target_results) - hit_count  # Subtract hits from all targets
        # Write targets, hits first
        for result, guids in results_by_type.items():
            if result == SpellMissReason.MISS_REASON_NONE:  # Hit count is written separately
                signature += 'B'
                data.append(hit_count)
                if len(guids) == 0:
                    continue

            if result != SpellMissReason.MISS_REASON_NONE:  # Write reason for miss
                signature += 'B'
                data.append(result)

            if len(guids) > 0:  # Write targets if there are any
                signature += f'{len(guids)}Q'
            for target_guid in guids:
                data.append(target_guid)

            if result == SpellMissReason.MISS_REASON_NONE:  # Write miss count at the end of hits since it needs to be written even if none happen
                signature += 'B'
                data.append(miss_count)

        signature += 'H'  # SpellTargetMask
        data.append(casting_spell.spell_target_mask)

        if casting_spell.spell_target_mask != SpellTargetMask.SELF:  # Write target info - same as cast start
            target_info = casting_spell.get_target_info()  # ([values], signature)
            data.extend(target_info[0])
            signature += target_info[1]

        packed = pack(signature, *data)
        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_SPELL_GO, packed), self.unit_mgr,
                                    include_self=self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER)

    def set_on_cooldown(self, spell):
        if spell.RecoveryTime == 0:
            return
        self.cooldowns[spell.ID] = spell.RecoveryTime + time.time()

        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        data = pack('<IQI', spell.ID, self.unit_mgr.guid, spell.RecoveryTime)
        self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def remove_cooldown(self, spell):
        self.cooldowns.pop(spell.ID, None)

        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        data = pack('<IQ', spell.ID, self.unit_mgr.guid)
        self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CLEAR_COOLDOWN, data))

    def is_on_cooldown(self, spell_id):
        return spell_id in self.cooldowns

    def validate_cast(self, casting_spell):
        if self.is_on_cooldown(casting_spell):
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOT_READY)
            return False

        if not casting_spell.spell_entry or casting_spell.spell_entry.ID not in self.spells:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NOT_KNOWN)
            return False

        if not self.unit_mgr.is_alive and \
                casting_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD != SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_CASTER_DEAD)
            return False

        if not casting_spell.initial_target:
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_BAD_TARGETS)
            return False

        if casting_spell.initial_target_is_unit_or_player() and not casting_spell.initial_target.is_alive:  # TODO dead targets (resurrect)
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_TARGETS_DEAD)
            return False

        if not self.meets_casting_requisites(casting_spell):
            return False

        return True

    def meets_casting_requisites(self, casting_spell):
        if casting_spell.spell_entry.PowerType != self.unit_mgr.power_type and casting_spell.spell_entry.ManaCost != 0:  # Doesn't have the correct power type
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
            return False

        if casting_spell.get_resource_cost() > self.unit_mgr.get_power_type_value():  # Doesn't have enough power
            self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_POWER)
            return False

        # Player only checks
        if self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER:
            # Check if player has required combo points
            if casting_spell.requires_combo_points() and \
                    (casting_spell.initial_target.guid != self.unit_mgr.combo_target or self.unit_mgr.combo_points == 0):  # Doesn't have required combo points
                self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_NO_COMBO_POINTS)
                return False

            # Check if player has required reagents
            for reagent_info, count in casting_spell.get_reagents():
                if reagent_info == 0:
                    break

                if self.unit_mgr.inventory.get_item_count(reagent_info) < count:
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_REAGENTS)
                    return False

            # Check if player inventory has space left
            for item, count in casting_spell.get_conjured_items():
                if item == 0:
                    break

                item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item)
                error = self.unit_mgr.inventory.can_store_item(item_template, count)
                if error != InventoryError.BAG_OK:
                    self.unit_mgr.inventory.send_equip_error(error)
                    self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_FAILED_DONT_REPORT)
                    return False

        return True

    def consume_resources_for_cast(self, casting_spell):  # This method assumes that the reagents exist (meets_casting_requisites was run)
        power_type = casting_spell.spell_entry.PowerType
        cost = casting_spell.spell_entry.ManaCost
        new_power = self.unit_mgr.get_power_type_value() - cost
        if power_type == PowerTypes.TYPE_MANA:
            self.unit_mgr.set_mana(new_power)
        elif power_type == PowerTypes.TYPE_RAGE:
            self.unit_mgr.set_rage(new_power)
        elif power_type == PowerTypes.TYPE_FOCUS:
            self.unit_mgr.set_focus(new_power)
        elif power_type == PowerTypes.TYPE_ENERGY:
            self.unit_mgr.set_energy(new_power)

        if self.unit_mgr.get_type() == ObjectTypes.TYPE_PLAYER and \
                casting_spell.requires_combo_points():
            self.unit_mgr.remove_combo_points()
            self.unit_mgr.set_dirty()

        for reagent_info in casting_spell.get_reagents():  # Reagents
            if reagent_info[0] == 0:
                break
            self.unit_mgr.inventory.remove_items(reagent_info[0], reagent_info[1])

        self.unit_mgr.set_dirty()

    def send_cast_result(self, spell_id, error):
        # cast_status = SpellCastStatus.CAST_SUCCESS if error == SpellCheckCastResult.SPELL_CAST_OK else SpellCastStatus.CAST_FAILED  # TODO CAST_SUCCESS_KEEP_TRACKING

        if self.unit_mgr.get_type() != ObjectTypes.TYPE_PLAYER:
            return

        if error == SpellCheckCastResult.SPELL_NO_ERROR:
            data = pack('<IB', spell_id, SpellCastStatus.CAST_SUCCESS)
        else:
            data = pack('<I2B', spell_id, SpellCastStatus.CAST_FAILED, error)

        self.unit_mgr.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CAST_RESULT, data))
