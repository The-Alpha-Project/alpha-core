import time
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.dbc.DbcModels import Spell, SpellCastTimes
from database.realm.RealmDatabaseManager import RealmDatabaseManager, SessionHolder
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger
from utils.constants.SpellCodes import SpellState, SpellCheckCastResult, SpellCastStatus, \
    SpellMissReason, SpellTargetMask


class CastingSpell(object):
    spell_entry: Spell
    spell_targets: dict
    spell_target_mask: SpellTargetMask
    cast_time_entry: SpellCastTimes

    def __init__(self, spell, targets, target_mask):
        self.spell_entry = spell
        self.spell_targets = targets
        self.spell_target_mask = target_mask
        self.range_entry = DbcDatabaseManager.spell_range_get_by_id(spell.RangeIndex)
        self.cast_time_entry = DbcDatabaseManager.spell_cast_time_get_by_id(spell.RangeIndex)

    def is_instant_cast(self):
        return self.cast_time_entry.Base == 0

class SpellManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.spells = {}
        self.cooldowns = {}

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.player_mgr.guid):
            self.spells[spell.spell] = spell

    def get_initial_spells(self):
        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            data += pack('<2H', spell.spell, 0)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def handle_cast_attempt(self, spell_id, target_type, target):
        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        Logger.debug("cast attempt call")
        if not self.can_cast_spell(spell):
            return

        Logger.debug("cast spell call")
        self.cast_spell(spell, target, target_type)

    def cast_spell(self, spell, target_guid, target_mask):
        targets = self.build_targets_for_spell(spell, target_guid, target_mask)
        casting_spell = CastingSpell(spell, targets, target_mask)  # Initializes dbc references

        if not casting_spell.is_instant_cast():
            self.send_cast_start(casting_spell)
            Logger.debug("Cast start packet sent")
            return

        # Spell is instant, perform cast
        self.send_cast_result(spell.ID, SpellCheckCastResult.SPELL_CAST_OK)
        self.send_spell_GO(casting_spell)
        Logger.debug("Cast result and GO packets sent")
        #self.send_channel_start(casting_spell.cast_time_entry.Base) TODO Only channeled spells

    def build_targets_for_spell(self, spell, target_guid, target_mask):
        if target_mask == SpellTargetMask.SELF:
            return {}
        return {target_guid: SpellMissReason.MISS_REASON_NONE}

    def send_cast_start(self, casting_spell):
        data = [self.player_mgr.guid, self.player_mgr.guid,
                casting_spell.spell_entry.ID, 0, casting_spell.cast_time_entry.Base,
                casting_spell.spell_target_mask]

        signature = "<QQIHiH"  # TODO
        for target_guid in casting_spell.spell_targets.keys():
            data += target_guid
            signature += "Q"

        data = pack(signature, *data)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_START, data))

    def send_spell_GO(self, casting_spell):
        data = pack("QQIHBBH", self.player_mgr.guid, self.player_mgr.guid,
                    casting_spell.spell_entry.ID, 0,
                    0, 0,  # Hit targets count, miss targets count
                    0,   # SpellTargetMask - 0 for self
                    )
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_GO, data))

    def set_on_cooldown(self, spell):
        self.cooldowns[spell.ID] = spell.RecoveryTime + time.time()

        data = pack('<IQH', spell.ID, self.player_mgr.guid, spell.RecoveryTime)
        self.player_mgr.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SPELL_COOLDOWN, data))

    def is_on_cooldown(self, spell_id):
        return spell_id in self.cooldowns

    def get_cast_time(self, spell):
        return spell.Cast

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
