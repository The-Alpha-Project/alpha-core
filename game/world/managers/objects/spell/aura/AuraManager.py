from struct import pack
from typing import Optional, Dict, List

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.spell.ExtendedSpellData import AuraTargetRestrictions, AuraSourceRestrictions
from game.world.managers.objects.spell.aura.AppliedAura import AppliedAura
from game.world.managers.objects.spell.aura.AuraEffectHandler import AuraEffectHandler
from game.world.managers.objects.spell.CastingSpell import CastingSpell
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ProcFlags
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import AuraTypes, AuraSlots, SpellAuraInterruptFlags, SpellAttributes, \
    SpellAttributesEx, SpellEffects, AuraState, AuraFlags
from utils.constants.UnitCodes import UnitFlags, StandState, UnitStates
from utils.constants.UpdateFields import UnitFields


class AuraManager:
    # All applied single-target auras (sleep) by player guid.
    SINGLE_TARGET_AURAS: Dict[int, List[AppliedAura]] = {}

    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.active_auras = {}  # (int: Aura) to have persistent indices.

    def apply_spell_effect_aura(self, caster, casting_spell, spell_effect):
        aura = AppliedAura(caster, casting_spell, spell_effect, self.unit_mgr)
        self.add_aura(aura)

    def add_aura(self, aura):
        # Mount spells act as a toggle. If already mounted, dismount and skip applying a new mount aura.
        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOUNTED and aura.target.is_mounted():
            aura.target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOUNTED)
            aura.target.aura_manager.remove_auras_by_type(AuraTypes.SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED)
            AuraEffectHandler.handle_mounted(aura, aura.target, remove=True)
            return -1

        if not self.can_apply_aura(aura):
            return -1

        # Application threat and negative aura application interrupts.
        if aura.harmful and self.unit_mgr != aura.caster and self.unit_mgr.can_attack_target(aura.caster):
            # Add threat for non-player targets against unit casters if the caster and target are not the same.
            if aura.caster.is_unit(by_mask=True) and aura.source_spell.generates_threat():
                self.unit_mgr.threat_manager.add_threat(aura.caster, abs(aura.get_effect_points()))

            self.check_aura_interrupts(negative_aura_applied=True)

        applied_similar_auras = self.get_similar_applied_auras(aura, accept_all_ranks=False, accept_all_sources=False)
        is_refresh = len(applied_similar_auras) > 0
        if is_refresh:
            # Only one similar aura from the same source can be applied.
            # Lower ranks are removed by remove_colliding_effects.
            similar_aura = applied_similar_auras[0]

            if aura.can_stack and similar_aura.applied_stacks < similar_aura.max_stacks:
                similar_aura.applied_stacks += 1  # Add a stack if the aura isn't at max already

            similar_aura.spell_effect.start_aura_duration(overwrite=True)  # Refresh duration

            # Note that this aura will not be actually applied.
            # Index and stacks are copied for sending information and updating effect points.
            aura.applied_stacks = similar_aura.applied_stacks
            aura.index = similar_aura.index
        else:
            self.remove_colliding_effects(aura)
            aura.index = self.get_next_aura_index(aura)
            self.active_auras[aura.index] = aura

        # Handle effects after possible stack increase/refresh to update stats properly.
        AuraEffectHandler.handle_aura_effect_change(aura, aura.target)

        if not is_refresh and AuraTargetRestrictions.is_single_target_aura(aura.spell_id):
            # Find existing single target aura to remove.
            existing_auras = AuraManager.SINGLE_TARGET_AURAS.get(aura.caster.guid, [])
            colliding = [ex_aura for ex_aura in existing_auras if
                         AuraTargetRestrictions.are_colliding_auras(aura.spell_id, ex_aura.spell_id)]

            # Remove colliding aura if one exists.
            [coll_aura.target.aura_manager.remove_aura(coll_aura) for coll_aura in colliding]
            AuraManager.SINGLE_TARGET_AURAS[aura.caster.guid] = [aura]

        self.write_aura_to_unit(aura, is_refresh=is_refresh)
        return aura.index

    def update(self, timestamp):
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.area_aura_holder:
                continue  # Area auras are updated by AreaAuraHolder.

            aura.update(timestamp)  # Update duration and handle periodic effects.
            if aura.has_duration() and aura.get_duration() <= 0 or aura.get_heartbeat_resist_result(timestamp):
                self.remove_aura(aura)

    def can_apply_aura(self, aura) -> bool:
        # TODO Similar (stat mod?) harmful auras (2x. slows etc.) should not stack.
        if aura.harmful:
            return True

        if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT and \
                len(self.get_auras_by_spell_id(aura.spell_id)) > 0:
            return False  # Don't apply same shapeshift effect if it already exists.

        # Don't allow overwriting higher rank buffs.
        similar_applied_auras = self.get_similar_applied_auras(aura, accept_all_ranks=True, accept_all_sources=True)
        if len(similar_applied_auras) > 0:
            similar_applied = similar_applied_auras[0]  # Only one similar buff can be applied.
            applied_rank = DbcDatabaseManager.SpellHolder.spell_get_rank_by_spell(similar_applied.source_spell.spell_entry)
            new_rank = DbcDatabaseManager.SpellHolder.spell_get_rank_by_spell(aura.source_spell.spell_entry)
            if applied_rank > new_rank:
                return False

        return True

    def are_spell_effects_applicable(self, casting_spell):
        for spell_effect in casting_spell.get_effects():
            if spell_effect.effect_type == SpellEffects.SPELL_EFFECT_SUMMON_MOUNT and \
                    self.has_aura_by_type(AuraTypes.SPELL_AURA_MOUNTED):
                # Special case of mounting via spell effect when the player already has a mount aura applied.
                # This interaction does not currently work,
                # as the mount aura is removed via aura interrupts on cast (fixable?).
                # This results in the spell effect's mount applying instead of dismounting the player,
                # visually leaving the player on the aura-applied mount.

                return False

            if spell_effect.effect_type not in {SpellEffects.SPELL_EFFECT_APPLY_AURA,
                                                SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA}:
                continue

            aura = AppliedAura(casting_spell.spell_caster, casting_spell, spell_effect, self.unit_mgr)
            if not self.can_apply_aura(aura):
                return False
        return True

    def check_aura_interrupts(self, moved=False, turned=False, changed_stand_state=False, negative_aura_applied=False,
                              received_damage=False, enter_combat=False, attacked=False,
                              cast_spell: Optional[CastingSpell] = None):
        if not self.active_auras:
            return

        flag_cases = {
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_ENTER_COMBAT: enter_combat,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_NOT_MOUNTED: self.unit_mgr.is_mounted(),
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_MOVE: moved,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_TURNING: turned,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_ACTION: cast_spell is not None or attacked,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_NEGATIVE_SPELL: negative_aura_applied,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_DAMAGE: received_damage,
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_NOT_ABOVEWATER: self.unit_mgr.is_swimming(),
            SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_NOT_UNDERWATER: not self.unit_mgr.is_swimming(),
        }

        for aura in list(self.active_auras.values()):
            if aura.passive:
                continue  # Skip secondary components of active auras. No passive spells have aura interrupts.

            # An interrupt for sitting does not exist.
            # Food/drink spells do claim that the player must remain seated.
            # In later versions an aura interrupt exists for this purpose.
            if aura.source_spell.is_refreshment_spell() and changed_stand_state and \
                    self.unit_mgr.stand_state != StandState.UNIT_SITTING:
                self.remove_aura(aura)
                continue

            # Some stealth auras don't have correct interrupt flags set (5916, 6408), but should be removed on attack.
            if aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_STEALTH and attacked:
                self.remove_aura(aura)
                continue

            # Outdoors-only auras should be treated as movement-interruptible when mounted indoors or swimming.
            if moved and aura.source_spell.is_outdoors_spell() and self.unit_mgr.is_mounted():
                if self.unit_mgr.is_swimming() or self.unit_mgr.get_map().is_wmo_interior(self.unit_mgr.location.x,
                                                                                          self.unit_mgr.location.y,
                                                                                          self.unit_mgr.location.z):
                    self.remove_aura(aura)
                    continue

            for flag, condition in flag_cases.items():
                if flag == SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_ACTION and \
                     aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_STEALTH and \
                        cast_spell and not cast_spell.cast_breaks_stealth():
                    continue  # Skip cast interrupt for stealth spells for flagged spells.

                # Mount casts must not interrupt existing mount auras; otherwise the aura is removed before
                # mount-toggle logic runs, which re-applies the mount and stacks speed on repeated item use.
                if flag == SpellAuraInterruptFlags.AURA_INTERRUPT_FLAG_ACTION and \
                        aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOUNTED and cast_spell:
                    has_mount_effect = cast_spell.has_effect_of_type(SpellEffects.SPELL_EFFECT_SUMMON_MOUNT)
                    has_mount_aura = any(effect and effect.aura_type == AuraTypes.SPELL_AURA_MOUNTED
                                         for effect in cast_spell.get_effects())
                    if has_mount_effect or has_mount_aura:
                        # Let mount toggle logic handle dismount/remount without a premature interrupt.
                        # Mount toggle happens in `AuraManager.add_aura` and `SpellEffectHandler.handle_summon_mount`.
                        continue

                if aura.interrupt_flags & flag and condition:
                    self.remove_aura(aura)
                    continue

    # Involved unit is the secondary unit in the proc event.
    # is_receiver is set to false if the player is causing damage and set to true if the player is taking damage.
    def check_aura_procs(self, involved_cast=None, killed_unit=False, damage_info=None, is_melee_swing=False):
        is_receiver = (damage_info and damage_info.target is self.unit_mgr) or \
                      (involved_cast and involved_cast.spell_caster is not self.unit_mgr)

        # Always pass the second unit as the effect target. The handler will choose the target based on the spell.
        if damage_info:
            effect_target = damage_info.attacker if is_receiver else damage_info.target
        elif involved_cast:
            # All targets for the spell could be passed, but this would only matter for ProcFlags.SPELL_CAST
            # SPELL_CAST is only used by one deprecated spell which will have the correct target in initial_target.
            effect_target = involved_cast.spell_caster if is_receiver else involved_cast.initial_target
        else:
            effect_target = self.unit_mgr

        flag_cases = {
            ProcFlags.DEAL_COMBAT_DMG: not is_receiver and damage_info and damage_info.total_damage > 0,  # -> cast on target.
            ProcFlags.TAKE_COMBAT_DMG: is_receiver and damage_info and damage_info.total_damage > 0,
            ProcFlags.KILL: killed_unit,
            ProcFlags.HEARTBEAT: False,  # Heartbeat effects are handled in their respective places on update - ignore the flag here.
            ProcFlags.DODGE: is_receiver and damage_info and damage_info.proc_victim & ProcFlags.DODGE,
            ProcFlags.PARRY: is_receiver and damage_info and damage_info.proc_victim & ProcFlags.PARRY,
            ProcFlags.BLOCK: is_receiver and damage_info and damage_info.proc_victim & ProcFlags.BLOCK,
            ProcFlags.SWING: not is_receiver and is_melee_swing,
            ProcFlags.SPELL_CAST: not is_receiver and involved_cast,  # Only used by zzOLDMind Bomb.
            ProcFlags.SPELL_HIT: is_receiver and involved_cast,
        }
        for aura in list(self.active_auras.values()):
            flags = aura.proc_flags
            if not flags:
                continue

            for proc_flag, condition in flag_cases.items():
                if proc_flag & flags and condition and aura.proc_charges != 0:  # Proc charges are set to -1 for auras with no charges so check for 0.
                    # Remove charge before trigger to avoid infinite loops with procs.
                    aura.proc_charges -= 1
                    AuraEffectHandler.handle_aura_effect_change(aura, effect_target, is_proc=True)

                    if aura.proc_charges == 0:
                        self.remove_aura(aura)

    def remove_colliding_effects(self, aura):
        # TODO Exclusivity by aura effect type.
        #  Some spells with similar effects shouldn't be stackable.

        aura_spell_template = aura.source_spell.spell_entry

        new_aura_name = aura_spell_template.Name_enUS
        caster_guid = aura.caster.guid

        for applied_aura in list(self.active_auras.values()):
            if applied_aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT and \
                    aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_MOD_SHAPESHIFT:
                self.remove_aura(applied_aura)  # Player can only be in one shapeshift form.
                continue

            # Skip auras from the same spell cast (i.e. passive aura components).
            if aura.source_spell is applied_aura.source_spell:
                continue

            applied_spell_entry = applied_aura.source_spell.spell_entry
            applied_aura_name = applied_spell_entry.Name_enUS

            # Paladin seals, warlock curses etc.
            has_group_restriction = AuraSourceRestrictions.are_colliding_auras(aura.spell_id,
                                                                               applied_aura.spell_id)
            is_similar = applied_aura.spell_id == aura.spell_id or new_aura_name == applied_aura_name
            is_same_source = applied_aura.caster.guid == caster_guid
            is_dummy = aura.spell_effect.aura_type == AuraTypes.SPELL_AURA_DUMMY

            if not is_similar and not (has_group_restriction and is_same_source):
                continue  # TODO Same effects but different spells (exclusivity groups)?

            is_unique = applied_spell_entry.AttributesEx & SpellAttributesEx.SPELL_ATTR_EX_AURA_UNIQUE
            is_stacking = applied_aura.can_stack

            if (is_unique or is_same_source or not aura.harmful) and not (is_similar and is_stacking) and not is_dummy:
                # Remove similar applied aura if it's unique, a buff or from the same caster.
                # Ignore if this is a stacking buff; add_aura will just add a dose in that case.
                # We can also ignore ranks here, as attempting to cast a lower rank buff will fail in validation.
                self.remove_aura(applied_aura, canceled=True)
        return True

    def reset_aura_states(self):
        for flag in AuraState:
            self.modify_aura_state(flag, apply=False)

    def modify_aura_state(self, flag: AuraState, apply):
        flag_value = 1 << (flag.value - 1)
        flags = self.unit_mgr.get_uint32(UnitFields.UNIT_FIELD_AURASTATE)
        if not apply and flags & flag_value != 0:
            flags &= ~flag.value
        elif apply and flags & flag_value == 0:
            flags |= flag.value
        self.unit_mgr.set_uint32(UnitFields.UNIT_FIELD_AURASTATE, flags)

    def has_aura_by_spell_id(self, spell_id):
        for aura in list(self.active_auras.values()):
            if aura.spell_id == spell_id:
                return True
        return False

    def get_auras_by_spell_id(self, spell_id) -> list[AppliedAura]:
        auras = []
        for aura in list(self.active_auras.values()):
            if aura.spell_id != spell_id:
                continue
            auras.append(aura)
        return auras

    def get_aura_by_index(self, aura_index) -> Optional[AppliedAura]:
        if aura_index not in self.active_auras:
            return None
        return self.active_auras[aura_index]

    def get_main_aura_slot_for_spell(self, casting_spell) -> int:
        for aura in list(self.active_auras.values()):
            if not aura.passive and aura.source_spell is casting_spell:
                return aura.index
        return -1

    def get_auras_by_type(self, aura_type) -> list[AppliedAura]:
        auras = []
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type != aura_type:
                continue
            auras.append(aura)
        return auras

    def get_auras_by_shapeshift_mask(self, shapeshift_mask, self_targeted_only=False, exclude_aura: Optional[AppliedAura] = None) -> list[AppliedAura]:
        if shapeshift_mask <= 0:
            return []

        auras = []
        for aura in list(self.active_auras.values()):
            if exclude_aura and aura is exclude_aura:
                continue

            aura_mask = aura.source_spell.spell_entry.ShapeshiftMask
            if aura_mask <= 0:
                continue

            if aura_mask & shapeshift_mask == 0:
                continue

            if self_targeted_only and not aura.source_spell.is_self_targeted():
                continue

            auras.append(aura)

        return auras

    def has_aura_by_type(self, aura_type) -> bool:
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type == aura_type:
                return True
        return False

    def get_active_auras(self):
        return [self.active_auras[i] for i in
                range(0, AuraSlots.AURA_SLOT_PASSIVE_AURA_START)
                if i in self.active_auras]

    def get_beneficial_auras(self):
        return [self.active_auras[i] for i in
                range(0, AuraSlots.AURA_SLOT_HARMFUL_AURA_START)
                if i in self.active_auras]

    def get_harmful_auras(self):
        return [self.active_auras[i] for i in
                range(AuraSlots.AURA_SLOT_HARMFUL_AURA_START, AuraSlots.AURA_SLOT_PASSIVE_AURA_START)
                if i in self.active_auras]

    def get_similar_applied_auras(self, aura, accept_all_ranks=True, accept_all_sources=True) -> list[AppliedAura]:
        return self.get_similar_applied_auras_by_effect(aura.spell_effect,
                                                        accept_all_ranks=accept_all_ranks,
                                                        accept_all_sources=accept_all_sources)

    def get_similar_applied_auras_by_effect(self, spell_effect, accept_all_ranks=True, accept_all_sources=True) -> list[AppliedAura]:
        aura_spell_template = spell_effect.casting_spell.spell_entry
        caster = spell_effect.casting_spell.spell_caster

        new_aura_name = aura_spell_template.Name_enUS
        new_aura_rank = DbcDatabaseManager.SpellHolder.spell_get_rank_by_spell(aura_spell_template)

        similar_auras = []

        for applied_aura in list(self.active_auras.values()):
            if applied_aura.spell_effect.effect_index != spell_effect.effect_index:
                continue

            if not accept_all_sources and caster != applied_aura.caster:
                continue

            applied_spell_entry = applied_aura.source_spell.spell_entry

            if applied_spell_entry.ID != aura_spell_template.ID:
                applied_aura_name = applied_spell_entry.Name_enUS
                applied_aura_rank = DbcDatabaseManager.SpellHolder.spell_get_rank_by_spell(applied_spell_entry)

                if applied_aura_name != new_aura_name or \
                        (applied_aura_rank != new_aura_rank and not accept_all_ranks):
                    continue

            similar_auras.append(applied_aura)

        return similar_auras

    def remove_auras_by_type(self, aura_type):
        for aura in list(self.active_auras.values()):
            if aura.spell_effect.aura_type != aura_type:
                continue
            self.remove_aura(aura)

    def handle_death(self):
        persistent_flags = SpellAttributes.SPELL_ATTR_ALLOW_CAST_WHILE_DEAD | SpellAttributes.SPELL_ATTR_PASSIVE
        for aura in list(self.active_auras.values()):
            if aura.source_spell.spell_entry.Attributes & persistent_flags:
                continue
            self.remove_aura(aura)

    def remove_harmful_auras_by_caster(self, caster_guid):
        for aura in list(self.active_auras.values()):
            if aura.harmful and aura.caster.guid == caster_guid:
                self.remove_aura(aura)

    def remove_auras_by_caster(self, caster_guid):
        for aura in list(self.active_auras.values()):
            if aura.caster.guid == caster_guid:
                self.remove_aura(aura)

    def remove_aura(self, aura, canceled=False):
        if aura.index not in self.active_auras:
            return

        AuraEffectHandler.handle_aura_effect_change(aura, aura.target, remove=True)
        if not self.active_auras.pop(aura.index, None):
            return

        # Cancel other effects of this aura.
        self.remove_auras_from_spell(aura.source_spell)

        # Auras can be tied to spell casts (area auras, targeted channels etc.)
        # Cancel spell casts and resulting auras from this aura.
        is_area_aura = aura.spell_effect.effect_type in {SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA,
                                                         SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA}
        if not is_area_aura:
            aura.caster.spell_manager.remove_cast(aura.source_spell, cancel_auras=True)
        elif aura.caster is self.unit_mgr:
            self.unit_mgr.spell_manager.remove_cast(aura.source_spell, cancel_auras=True)

        # Some spells start cooldown on aura remove, handle that case here.
        if aura.source_spell.unlock_cooldown_on_trigger():
            self.unit_mgr.spell_manager.unlock_spell_cooldown(aura.spell_id)

        # Remove tracked single-target aura.
        if AuraTargetRestrictions.is_single_target_aura(aura.spell_id):
            source_auras = AuraManager.SINGLE_TARGET_AURAS.get(aura.caster.guid, [])
            source_auras = [a for a in source_auras if a != aura]
            if not source_auras:
                AuraManager.SINGLE_TARGET_AURAS.pop(aura.caster.guid, None)
            else:
                AuraManager.SINGLE_TARGET_AURAS[aura.caster.guid] = source_auras

        self.write_aura_to_unit(aura, clear=True)

    def remove_all_auras(self):
        for aura in list(self.active_auras.values()):
            self.remove_aura(aura)

    def remove_hostile_auras(self):
        for aura in list(self.active_auras.values()):
            if aura.caster.can_attack_target(self.unit_mgr):
                self.remove_aura(aura)

    def cancel_auras_by_spell_id(self, spell_id, source_restriction=None):
        auras = self.get_auras_by_spell_id(spell_id)

        for aura in auras:
            if source_restriction and aura.caster is not source_restriction:
                continue
            self.remove_aura(aura, canceled=True)

    def cancel_auras_by_shapeshift_mask(self, shapeshift_mask, self_targeted_only=False, exclude_aura: Optional[AppliedAura] = None):
        auras = self.get_auras_by_shapeshift_mask(
            shapeshift_mask,
            self_targeted_only=self_targeted_only,
            exclude_aura=exclude_aura
        )

        for aura in auras:
            self.remove_aura(aura, canceled=True)

    def remove_auras_from_spell(self, casting_spell):
        for aura in list(self.active_auras.values()):
            if aura.source_spell is casting_spell:
                self.remove_aura(aura)

    def build_update(self):
        [self.write_aura_to_unit(aura, send_duration=False) for aura in list(self.active_auras.values())]

    def handle_player_cancel_aura_request(self, spell_id):
        auras = self.get_auras_by_spell_id(spell_id)
        can_remove = True
        is_passive = True  # Player shouldn't be able to remove auras with only a passive part.
        for aura in auras:
            if not aura.passive:
                is_passive = False
            is_area_aura = aura.spell_effect.effect_type in {SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA,
                                                             SpellEffects.SPELL_EFFECT_PERSISTENT_AREA_AURA}
            if aura.harmful or \
                    aura.source_spell.spell_entry.Attributes & SpellAttributes.SPELL_ATTR_CANT_CANCEL or \
                    (is_area_aura and aura.caster != self.unit_mgr):
                can_remove = False
                break

        if is_passive or not can_remove:
            return

        self.cancel_auras_by_spell_id(spell_id)

    def send_aura_duration(self, aura):
        if not self.unit_mgr.is_player():
            return

        data = pack('<Bi', aura.index, int(aura.get_duration()))
        self.unit_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_UPDATE_AURA_DURATION, data))

    def write_aura_to_unit(self, aura, clear=False, is_refresh=False, send_duration=True):
        if aura.passive:
            return  # Passive auras are server-side only.

        if send_duration:
            self.send_aura_duration(aura)

        field_index = UnitFields.UNIT_FIELD_AURA + aura.index

        # Clear field on refresh to trigger aura application visual.
        if is_refresh:
            self.unit_mgr.set_uint32(field_index, 0, force=True)

        self.unit_mgr.set_uint32(field_index, aura.spell_id if not clear else 0)
        self._write_aura_flag_to_unit(aura, clear=clear)

    def _write_aura_flag_to_unit(self, aura, clear=False):
        if not aura:
            return

        aura_index = aura.active_aura_index if aura.passive else aura.index
        offset = int(aura_index / 8)  # 4 bits for each aura slot, writing in 32 bit fields.
        flags = self.unit_mgr.get_uint32(UnitFields.UNIT_FIELD_AURAFLAGS + offset)

        half_byte_index = aura_index & 7
        flag_offset = 4 * half_byte_index

        if not clear:
            # Cancelable flag.
            aura_attributes = aura.source_spell.spell_entry.Attributes
            if not aura_attributes & SpellAttributes.SPELL_ATTR_CANT_CANCEL and not aura.harmful:
                flags |= AuraFlags.AURA_FLAG_CANCELABLE << flag_offset

            # Active effect flags.
            for effect in aura.source_spell.get_effects():
                if effect.effect_type in {SpellEffects.SPELL_EFFECT_APPLY_AURA,
                                          SpellEffects.SPELL_EFFECT_APPLY_AREA_AURA}:
                    effect_flag = AuraFlags.AURA_FLAG_EFF_INDEX_0 >> effect.effect_index
                    flags |= effect_flag << flag_offset
        else:
            flags &= ~(AuraFlags.AURA_FLAG_ALL << flag_offset)

        self.unit_mgr.set_uint32(UnitFields.UNIT_FIELD_AURAFLAGS + offset, flags)

    def get_next_aura_index(self, aura) -> int:
        if aura.passive:
            min_index = AuraSlots.AURA_SLOT_PASSIVE_AURA_START
            max_index = AuraSlots.AURA_SLOT_END
        elif aura.harmful:
            min_index = AuraSlots.AURA_SLOT_HARMFUL_AURA_START
            max_index = AuraSlots.AURA_SLOT_PASSIVE_AURA_START
        else:
            min_index = AuraSlots.AURA_SLOT_POSITIVE_AURA_START
            max_index = AuraSlots.AURA_SLOT_HARMFUL_AURA_START

        for i in range(min_index, max_index):
            if i not in self.active_auras:
                return i
        return min_index  # No aura slots free, return first possible. TODO Some kind of priority system?
