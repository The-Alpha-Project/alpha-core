from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from database.realm.RealmDatabaseManager import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.CharCodes import *
from utils.constants.OpCodes import OpCode


class CharDeleteHandler:

    @staticmethod
    def handle(world_session, reader):
        guid = 0
        # Avoid handling an empty area char delete packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        guid = unpack('<Q', reader.data[:8])[0]

        res = CharDelete.CHAR_DELETE_SUCCESS
        # Prevent Guild Masters from deleting their character.
        if RealmDatabaseManager.character_is_guild_master(guid):
            res = CharDelete.CHAR_DELETE_FAILED

        # If this character has a party, and it has online members, handle removing/disbanding.
        party_group = RealmDatabaseManager.group_get_by_character_guid(guid)
        online_party_members = None
        disbanded = False
        if party_group:
            for group_member in RealmDatabaseManager.group_get_members(party_group):
                if group_member.guid == guid:
                    continue
                player_mgr = WorldSessionStateHandler.find_player_by_guid(group_member.guid)
                if not player_mgr or not player_mgr.group_manager:
                    continue
                online_party_members = player_mgr
                disbanded = online_party_members.group_manager.leave_party(guid)
                break

        # Try to delete the character.
        if res != CharDelete.CHAR_DELETE_FAILED and (guid == 0 or RealmDatabaseManager.character_delete(guid) != 0):
            res = CharDelete.CHAR_DELETE_FAILED
            Logger.error(f'Error deleting character with guid {guid}.')

        # Check if the whole group needs to be erased while all members were offline.
        if res != CharDelete.CHAR_DELETE_FAILED:
            if not disbanded and party_group and not online_party_members:
                # Group might've been destroyed on cascade event by now, try to retrieve again.
                group = RealmDatabaseManager.group_by_id(party_group.group_id)
                if group and len(RealmDatabaseManager.group_get_members(group)) <= 1:
                    RealmDatabaseManager.group_destroy(party_group)

        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE, pack('<B', res)))

        return 0
