import time
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell, SpellCastTimes, SpellRange
from database.realm.RealmDatabaseManager import RealmDatabaseManager, CharacterSpell
from game.world.managers.GridManager import GridManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellCheckCastResult, SpellCastStatus, \
    SpellMissReason, SpellTargetMask, SpellState


class CastingSpell(object):
    spell_entry: Spell
    cast_state: SpellState
    spell_caster = None
    initial_target_unit = None
    target_results: dict
    spell_target_mask: SpellTargetMask
    range_entry: SpellRange
    cast_time_entry: SpellCastTimes
    cast_end_timestamp: float
    spell_delay_end_timestamp: float

    def __init__(self, spell, caster_obj, initial_target_unit, target_results, target_mask):
        self.spell_entry = spell
        self.spell_caster = caster_obj
        self.initial_target_unit = initial_target_unit
        self.target_results = target_results
        self.spell_target_mask = target_mask
        self.range_entry = DbcDatabaseManager.spell_range_get_by_id(spell.RangeIndex)
        self.cast_time_entry = DbcDatabaseManager.spell_cast_time_get_by_id(spell.CastingTimeIndex)
        self.cast_end_timestamp = self.get_base_cast_time()/1000 + time.time()

        self.cast_state = SpellState.SPELL_STATE_PREPARING

    def is_instant_cast(self):
        return self.cast_time_entry.Base == 0

    def get_base_cast_time(self):
        skill = self.spell_caster.skill_manager.get_skill_for_spell_id(self.spell_entry.ID)
        if not skill:
            return self.cast_time_entry.Minimum

        return int(max(self.cast_time_entry.Minimum, self.cast_time_entry.Base + self.cast_time_entry.PerLevel * skill.value))


class SpellManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.spells = {}
        self.cooldowns = {}
        self.casting_spells = []

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.player_mgr.guid):
            self.spells[spell.spell] = spell

    def learn_spell(self, spell_id):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not spell:
            return

        db_spell = CharacterSpell()
        db_spell.guid = self.player_mgr.guid
        db_spell.spell = spell_id
        RealmDatabaseManager.character_add_spell(db_spell)
        self.spells[spell_id] = db_spell

        data = pack('<H', spell_id)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_LEARNED_SPELL, data))
        # Teach skills required as well like in CharCreateHandler?

    def get_initial_spells(self):
        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            data += pack('<2H', spell.spell, 0)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def handle_cast_attempt(self, spell_id, caster, target_guid, target_mask):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if not self.can_cast_spell(spell):
            return
        spell_target = GridManager.get_surrounding_unit_by_guid(caster, target_guid) if target_guid else caster
        self.start_spell_cast(spell, caster, spell_target, target_mask)

    def start_spell_cast(self, spell, caster_obj, spell_target, target_mask):
        targets = self.build_targets_for_spell(spell, spell_target, target_mask)
        casting_spell = CastingSpell(spell, caster_obj, spell_target, targets, target_mask)  # Initializes dbc references

        if not casting_spell.is_instant_cast():
            self.send_cast_start(casting_spell)
            casting_spell.cast_state = SpellState.SPELL_STATE_CASTING
            self.casting_spells.append(casting_spell)
            return

        # Spell is instant, perform cast
        self.perform_spell_cast(casting_spell)

    def perform_spell_cast(self, casting_spell):
        self.send_cast_result(casting_spell.spell_entry.ID, SpellCheckCastResult.SPELL_CAST_OK)
        self.send_spell_GO(casting_spell)

        travel_time = self.calculate_time_to_impact(casting_spell)
        if travel_time != 0:
            casting_spell.cast_state = SpellState.SPELL_STATE_DELAYED
            casting_spell.spell_delay_end_timestamp = time.time() + travel_time
            return
        casting_spell.cast_state = SpellState.SPELL_STATE_FINISHED

    # self.send_channel_start(casting_spell.cast_time_entry.Base) TODO Only channeled spells

    def update(self, timestamp):
        for casting_spell in list(self.casting_spells):
            if casting_spell.cast_state == SpellState.SPELL_STATE_CASTING:
                if casting_spell.cast_end_timestamp <= timestamp:
                    self.perform_spell_cast(casting_spell)
                    if casting_spell.cast_state == SpellState.SPELL_STATE_FINISHED:  # Spell finished after perform (no impact delay)
                        self.casting_spells.remove(casting_spell)
#                else:  # Spell has not finished casting, just do movement check


            elif casting_spell.cast_state == SpellState.SPELL_STATE_DELAYED and \
                    casting_spell.spell_delay_end_timestamp <= timestamp:  # Spell was cast already and impact delay is done
                print("Spell impact")  # TODO
                casting_spell.spell_caster.deal_damage(casting_spell.initial_target_unit, 10)
                self.casting_spells.remove(casting_spell)



    def calculate_time_to_impact(self, casting_spell):
        if casting_spell.spell_entry.Speed == 0:
            return 0

        travel_distance = casting_spell.range_entry.RangeMax
        if casting_spell.spell_target_mask & SpellTargetMask.UNIT == SpellTargetMask.UNIT:
            target_unit_location = casting_spell.initial_target_unit.location
            travel_distance = casting_spell.spell_caster.location.distance(target_unit_location)

        return travel_distance / casting_spell.spell_entry.Speed

    def build_targets_for_spell(self, spell, target, target_mask):
        if target_mask == SpellTargetMask.SELF or target is None:
            return {}
        return {target.guid: SpellMissReason.MISS_REASON_NONE}

    def send_cast_start(self, casting_spell):
        data = [self.player_mgr.guid, self.player_mgr.guid,
                casting_spell.spell_entry.ID, 0, casting_spell.get_base_cast_time(),
                casting_spell.spell_target_mask]

        signature = "<QQIHiH"  # TODO
        if casting_spell.initial_target_unit:
            data.append(casting_spell.initial_target_unit.guid)
            signature += "Q"

        data = pack(signature, *data)
        Logger.debug("sending cast start of spell " + casting_spell.spell_entry.Name_enUS + " with cast time " + str(casting_spell.get_base_cast_time()))

        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_START, data))

    def send_spell_GO(self, casting_spell):
        data = [self.player_mgr.guid, self.player_mgr.guid,
                casting_spell.spell_entry.ID, 0]  # TODO Flags

        sign = "<QQIH"

        hit_count = 0
        if len(casting_spell.target_results.keys()) > 0:
            hit_count += 1
        sign += 'B'
        data.append(hit_count)

        for target, reason in casting_spell.target_results.items():
            if reason == SpellMissReason.MISS_REASON_NONE:
                data.append(target)
                sign += 'Q'

        data.append(0)  # miss count
        sign += 'B'

        sign += 'H'  # SpellTargetMask
        data.append(casting_spell.spell_target_mask)

        # write initial target
        if casting_spell.spell_target_mask & SpellTargetMask.UNIT == SpellTargetMask.UNIT:
            sign += 'Q'
            data.append(casting_spell.initial_target_unit.guid)

        #data = pack("QQIHBBH", self.player_mgr.guid, self.player_mgr.guid,
        #            casting_spell.spell_entry.ID, 0,
        #            0, 0,  # Hit targets count, miss targets count
        #            0,   # SpellTargetMask - 0 for self
        #            )

        packed = pack(sign, *data)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_GO, packed))

    def set_on_cooldown(self, spell):
        self.cooldowns[spell.ID] = spell.RecoveryTime + time.time()

        data = pack('<IQH', spell.ID, self.player_mgr.guid, spell.RecoveryTime)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def is_on_cooldown(self, spell_id):
        return spell_id in self.cooldowns

    def can_cast_spell(self, spell):
        if not spell or spell.ID not in self.spells:
            self.send_cast_result(spell.ID, SpellCheckCastResult.SPELL_FAILED_NOT_KNOWN)
            return False
        return True

    def send_cast_result(self, spell_id, error):
        # cast_status = SpellCastStatus.CAST_SUCCESS if error == SpellCheckCastResult.SPELL_CAST_OK else SpellCastStatus.CAST_FAILED  # TODO CAST_SUCCESS_KEEP_TRACKING
        if error == SpellCheckCastResult.SPELL_CAST_OK:
            data = pack('<IB', spell_id, SpellCastStatus.CAST_SUCCESS)
        else:
            data = pack('<IBB', spell_id, SpellCastStatus.CAST_FAILED, error)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_CAST_RESULT, data))
