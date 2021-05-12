from struct import pack
from database.realm.RealmModels import Petition
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ObjectCodes import PetitionError


# TODO: GuildMaster NPC won't accept the guild charter, even when signed full.
#  TabardVendor wont allow you to  purchase a new emblem.
class PetitionManager(object):

    @staticmethod
    def create_petition(owner_guid, guild_name, petition_guid):
        petition = Petition()
        petition.petition_guid = petition_guid
        petition.owner_guid = owner_guid
        petition.name = guild_name

        RealmDatabaseManager.guild_petition_create(petition)

    @staticmethod
    def get_petition(petition_guid):
        return RealmDatabaseManager.guild_petition_get(petition_guid)

    @staticmethod
    def build_signatures_packet(petition_guid, lo_petition_guid, petition):
        data = pack('<2QIB', petition_guid, petition.owner_guid, lo_petition_guid, len(petition.characters))
        for signer in petition.characters:
            data += pack('<QI', signer.guid, 0)
        packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOW_SIGNATURES, data)
        return packet

    @staticmethod
    def sign_petition(petition, signer_player, petition_owner_player):
        RealmDatabaseManager.sign_petition(petition, signer_player.player)
        PetitionManager.send_peition_sign_result(signer_player, PetitionError.PETITION_SUCCESS)
        PetitionManager.send_peition_sign_result(petition_owner_player, PetitionError.PETITION_SUCCESS)

    @staticmethod
    def send_peition_sign_result(player_mgr, result):
        data = pack('<I', result)
        packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SIGN_RESULTS, data)
        player_mgr.session.enqueue_packet(packet)

    @staticmethod
    def build_petition_query(lo_petition_guid, petition):
        guild_name_bytes = PacketWriter.string_to_bytes(petition.name)

        data = pack(f'<IQ{len(guild_name_bytes)}s',
                    lo_petition_guid,  # m_petitionID
                    petition.owner_guid,  # m_petitioner
                    guild_name_bytes,  # guild_name
                    )

        # m_bodyText?
        # m_flags?
        # m_minSignatures
        # m_maxSignatures
        # m_deadLine?
        # m_issueDate?
        # m_allowedGuildID?
        # m_allowedClasses?
        # m_allowedRaces?
        # m_allowedGender?
        # m_allowedMinLevel?
        # m_allowedMaxLevel?
        # m_choice?
        # m_numChoices?
        data += pack('<1B7I1B5I', 0, 1, 9, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

        return PacketWriter.get_packet(OpCode.SMSG_PETITION_QUERY_RESPONSE, data)
