from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import Petition
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
from network.packet.PacketWriter import PacketWriter
from utils.ConfigManager import config
from utils.constants.ItemCodes import PetitionError
from utils.constants.MiscCodes import HighGuid
from utils.constants.OpCodes import OpCode


class PetitionManager:
    CHARTER_ENTRY = 5863
    CHARTER_DISPLAY_ID = 9199
    CHARTER_COST = 1000

    @staticmethod
    def create_petition(owner_guid, guild_name, item_guid):
        petition = Petition()
        petition.realm_id = config.Server.Connection.Realm.local_realm_id
        petition.item_guid = item_guid & ~HighGuid.HIGHGUID_ITEM
        petition.owner_guid = owner_guid
        petition.name = guild_name

        RealmDatabaseManager.guild_petition_create(petition)
        return petition

    @staticmethod
    def get_petition(petition_item_guid):
        return RealmDatabaseManager.guild_petition_get(petition_item_guid)

    @staticmethod
    def build_signatures_packet(petition):
        data = pack('<2QIB', petition.item_guid, petition.owner_guid, petition.petition_id, len(petition.characters))
        for signer in petition.characters:
            data += pack('<QI', signer.guid, 0)
        packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SHOW_SIGNATURES, data)
        return packet

    @staticmethod
    def sign_petition(petition, signer_player, petition_owner_player=None):
        if not petition or not signer_player:
            return

        if petition.owner_guid == signer_player.guid:
            PetitionManager.send_petition_sign_result(signer_player, PetitionError.PETITION_CHARTER_CREATOR)
            return

        if signer_player.guild_manager:
            PetitionManager.send_petition_sign_result(signer_player, PetitionError.PETITION_ALREADY_IN_GUILD)
            return

        if any(signer.guid == signer_player.guid for signer in petition.characters):
            PetitionManager.send_petition_sign_result(signer_player, PetitionError.PETITION_ALREADY_SIGNED)
            return

        if len(petition.characters) >= 9:
            return

        petition.characters.append(signer_player.player)
        RealmDatabaseManager.guild_petition_update(petition)
        PetitionManager.send_petition_sign_result(signer_player, PetitionError.PETITION_SUCCESS)
        if petition_owner_player:
            PetitionManager.send_petition_sign_result(petition_owner_player, PetitionError.PETITION_SUCCESS)

    @staticmethod
    def turn_in_petition(player_mgr, petition_owner, petition):
        if not petition or not petition_owner:
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_UNKNOWN_ERROR)
            return

        if player_mgr.guild_manager:
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_ALREADY_IN_GUILD)
            return

        if petition_owner != player_mgr.guid:
            return

        if len(petition.characters) < 9:
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_NOT_ENOUGH_SIGNATURES)
            return

        # If not able to create a guild, GuildManager will report the error.
        if GuildManager.create_guild(player_mgr, petition.name, petition=petition):
            PetitionManager.send_petition_turn_in_result(player_mgr, PetitionError.PETITION_SUCCESS)
            RealmDatabaseManager.guild_petition_destroy(petition)
            player_mgr.inventory.remove_items(PetitionManager.CHARTER_ENTRY, 1)

    @staticmethod
    def send_petition_sign_result(player_mgr, result):
        data = pack('<I', result)
        packet = PacketWriter.get_packet(OpCode.SMSG_PETITION_SIGN_RESULTS, data)
        player_mgr.enqueue_packet(packet)

    @staticmethod
    def send_petition_turn_in_result(player_mgr, result):
        data = pack('<I', result)
        packet = PacketWriter.get_packet(OpCode.SMSG_TURN_IN_PETITION_RESULTS, data)
        player_mgr.enqueue_packet(packet)

    @staticmethod
    def build_petition_query(petition):
        guild_name_bytes = PacketWriter.string_to_bytes(petition.name)

        data = pack(
            f'<IQ{len(guild_name_bytes)}sB8I1H4I',
            petition.petition_id,  # int m_petitionID;
            petition.owner_guid,  # unsigned __int64 m_petitioner;
            guild_name_bytes,  # char m_title[256];
            0,  # char m_bodyText[4096];
            1,  # int m_flags;
            9,  # int m_minSignatures;
            9,  # int m_maxSignatures;
            0,  # int m_deadLine;
            0,  # int m_issueDate;
            0,  # int m_allowedGuildID;
            0,  # int m_allowedClasses;
            0,  # int m_allowedRaces;
            0,  # __int16 m_allowedGender;
            0,  # int m_allowedMinLevel;
            0,  # int m_allowedMaxLevel;
            0,  # char m_choicetext[10][64];
            0  # int m_numChoices;
        )

        return PacketWriter.get_packet(OpCode.SMSG_PETITION_QUERY_RESPONSE, data)
