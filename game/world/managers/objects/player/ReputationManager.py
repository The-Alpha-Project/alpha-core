from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from utils.constants.UnitCodes import UnitReaction
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import ReputationFlag
from utils.constants.OpCodes import OpCode

CLIENT_MAX = 64


class ReputationManager(object):
    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.reputations = {}

    def load_reputations(self):
        reputations = RealmDatabaseManager.character_get_reputations(self.player_mgr.player.guid)
        for reputation in reputations:
            self.reputations[reputation.index] = reputation

    def send_initialize_factions(self, set_visible=True):
        data = pack('<I', CLIENT_MAX)
        for x in range(0, CLIENT_MAX):
            if x in self.reputations:
                faction = DbcDatabaseManager.FactionHolder.faction_get_by_index(x)
                data += pack('<Bi', self.reputations[x].flags, self.reputations[x].standing - faction.ReputationBase_1)
            else:
                data += pack('<Bi', 0, 0)
        packet = PacketWriter.get_packet(OpCode.SMSG_INITIALIZE_FACTIONS, data)
        self.player_mgr.session.enqueue_packet(packet)

        if set_visible:
            for reputation in self.reputations.values():
                self.send_set_faction_visible(reputation)

    def send_set_faction_visible(self, faction):
        packet = PacketWriter.get_packet(OpCode.SMSG_SET_FACTION_VISIBLE, pack('<I', faction.index))
        self.player_mgr.session.enqueue_packet(packet)

    def modify_reputation(self, faction, amount):
        if faction.index not in self.reputations:
            return

        self.reputations[faction.index].standing += amount
        RealmDatabaseManager.character_update_reputation(self.reputations[faction.index])

        # Notify the client
        data = pack('<3i', 0x1, faction.index, self.reputations[faction.index].standing)
        packet = PacketWriter.get_packet(OpCode.SMSG_SET_FACTION_STANDING, data)
        self.player_mgr.session.enqueue_packet(packet)

    def get_reputation_flag(self, faction):
        standing = -1
        if faction.index in self.reputations:
            standing = self.reputations[faction.index].standing
        if standing > -1:
            reaction = ReputationManager.reaction_by_standing(standing)
            return ReputationManager.reputation_flag_by_reaction(reaction)
        return ReputationFlag.HIDDEN.value

    @staticmethod
    def reputation_flag_by_reaction(reaction):
        if reaction < UnitReaction.UNIT_REACTION_UNFRIENDLY:
            return ReputationFlag.ATWAR.value
        return ReputationFlag.HIDDEN.value

    @staticmethod
    def reaction_by_standing(standing):
        if standing >= 2100:
            return UnitReaction.UNIT_REACTION_REVERED
        elif standing >= 900:
            return UnitReaction.UNIT_REACTION_FRIENDLY
        elif standing >= 300:
            return UnitReaction.UNIT_REACTION_AMIABLE
        elif standing >= 0:
            return UnitReaction.UNIT_REACTION_NEUTRAL
        elif standing >= -300:
            return UnitReaction.UNIT_REACTION_UNFRIENDLY
        elif standing >= -600:
            return UnitReaction.UNIT_REACTION_HOSTILE
        return UnitReaction.UNIT_REACTION_HATED
