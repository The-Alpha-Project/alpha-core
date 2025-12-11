from struct import unpack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.units.player.GroupManager import GroupManager
from utils.constants.GroupCodes import PartyOperations, PartyResults


class GroupLootMethodHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 12:  # Avoid handling empty group loot method packet.
            loot_method, loot_master = unpack('<IQ', reader.data[:12])
            target_player_mgr = None

            if not world_session.player_mgr.group_manager:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                         PartyResults.ERR_NOT_IN_GROUP)
            if world_session.player_mgr.guid != world_session.player_mgr.group_manager.group.leader_guid:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                         '', PartyResults.ERR_NOT_LEADER)

            if loot_master > 0:
                target_player_mgr = RealmDatabaseManager.character_get_by_guid(loot_master)

            if target_player_mgr:
                world_session.player_mgr.group_manager.set_loot_method(loot_method, master_looter_guid=target_player_mgr.guid)
            else:
                world_session.player_mgr.group_manager.set_loot_method(loot_method)

        return 0
