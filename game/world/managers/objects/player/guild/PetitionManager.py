from struct import pack
from database.realm.RealmModels import Petition
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from network.packet.PacketWriter import PacketWriter, OpCode


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
            data += pack('<QI', signer.guid, 0)  # Unknown flag.
        packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOW_SIGNATURES, data)
        return packet
