from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from network.packet.PacketReader import *
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupUnInviteGuidHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty group uninvite guid packet.
            guid = unpack('<Q', reader.data[:8])[0]
            target_player_mgr = RealmDatabaseManager.character_get_by_guid(guid)

            if not world_session.player_mgr.group_manager:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                         PartyResults.ERR_NOT_IN_GROUP)
            elif not target_player_mgr:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, 'Player',
                                                         PartyResults.ERR_BAD_PLAYER_NAME_S)
            elif not world_session.player_mgr.group_manager.is_party_member(target_player_mgr.guid):
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE,
                                                         target_player_mgr.name,
                                                         PartyResults.ERR_TARGET_NOT_IN_YOUR_GROUP_S)
            else:
                world_session.player_mgr.group_manager.un_invite_player(world_session.player_mgr.guid, target_player_mgr.guid)

        return 0
