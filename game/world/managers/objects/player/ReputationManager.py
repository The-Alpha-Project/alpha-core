from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.constants.ObjectCodes import ReputationReacion
from utils.constants.OpCodes import OpCode


class ReputationManager(object):

    @staticmethod
    def send_player_reputations(player_mgr):
        reputations = RealmDatabaseManager.charater_get_reputations(player_mgr.player)
        rep_dict = {}
        for reputation in reputations:
            print(reputation.index)
            rep_dict[reputation.index] = reputation

        data = pack('<I', 64)  # Client always except 64 factions.
        for rep_index in range(0, 64):
            if rep_index in rep_dict:
                data += pack('<Bi', rep_dict[rep_index].flags, rep_dict[rep_index].standing)
            else:
                data += pack('<Bi', 0, 0)

        packet = PacketWriter.get_packet(OpCode.SMSG_INITIALIZE_FACTIONS, data)
        player_mgr.session.enqueue_packet(packet)

    @staticmethod
    def get_reaction(standing):
        if standing >= 2100:
            return ReputationReacion.REVERED
        elif standing >= 900:
            return ReputationReacion.FRIENDLY
        elif standing >= 300:
            return ReputationReacion.AMIABLE
        elif standing >= 0:
            return ReputationReacion.NEUTRAL
        elif standing >= -300:
            return ReputationReacion.UNFRIENDLY
        elif standing >- -600:
            return ReputationReacion.HOSTILE
        else:
            return ReputationReacion.HATED