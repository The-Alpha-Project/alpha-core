from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack

from database.realm.RealmDatabaseManager import *
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.units.player.guild.GuildManager import GuildManager
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

        # Only from the character screen, a character in world would keep playing and saving after its deletion.
        if world_session.player_mgr:
            return 0

        # Character must exist and belong to this account.
        character = RealmDatabaseManager.character_get_by_guid(guid)
        if not character or character.account_id != world_session.account_mgr.account.id:
            Logger.anticheat(f'Account {world_session.account_mgr.account.id} tried to delete character with '
                             f'wrong guid ({guid}).')
            world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE,
                                                                 pack('<B', CharDelete.CHAR_DELETE_FAILED)))
            return 0

        res = CharDelete.CHAR_DELETE_SUCCESS
        # Prevent Guild Masters from deleting their character.
        if RealmDatabaseManager.character_is_guild_master(guid):
            res = CharDelete.CHAR_DELETE_FAILED

        # Read before the delete, the database cascade removes the group member rows.
        party_group = RealmDatabaseManager.group_get_by_character_guid(guid)
        party_members = RealmDatabaseManager.group_get_members(party_group) if party_group else []

        # Try to delete the character.
        if res != CharDelete.CHAR_DELETE_FAILED and (guid == 0 or RealmDatabaseManager.character_delete(guid) != 0):
            res = CharDelete.CHAR_DELETE_FAILED
            Logger.error(f'Error deleting character with guid {guid}.')

        # Only once the character is gone, a failed delete must keep its party and guild.
        # If this character has a party, and it has online members, handle removing/disbanding.
        online_party_members = None
        disbanded = False
        if res != CharDelete.CHAR_DELETE_FAILED:
            for group_member in party_members:
                if group_member.guid == guid:
                    continue
                player_mgr = WorldSessionStateHandler.find_player_by_guid(group_member.guid)
                if not player_mgr or not player_mgr.group_manager:
                    continue
                online_party_members = player_mgr
                disbanded = online_party_members.group_manager.leave_party(guid)
                break

            # The cascade removed the guild member row, the loaded guild must drop the member too.
            for guild_manager in list(GuildManager.GUILDS.values()):
                if guild_manager.has_member(guid):
                    guild_manager.leave(guid)
                    break

        # Check if the whole group needs to be erased while all members were offline.
        if res != CharDelete.CHAR_DELETE_FAILED:
            if not disbanded and party_group and not online_party_members:
                # Group might've been destroyed on cascade event by now, try to retrieve again.
                group = RealmDatabaseManager.group_by_id(party_group.group_id)
                if group and len(RealmDatabaseManager.group_get_members(group)) <= 1:
                    RealmDatabaseManager.group_destroy(party_group)

        world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_CHAR_DELETE, pack('<B', res)))

        return 0
