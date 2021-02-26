from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode


class SpellManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.spells = {}

    def load_spells(self):
        for spell in RealmDatabaseManager.character_get_spells(self.player_mgr.guid):
            self.spells[spell.spell] = spell

    def get_initial_spells(self):
        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            data += pack('<2H', spell.spell, 0)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)
