from struct import pack, unpack, error, calcsize
from utils.constants.GroupCodes import PartyOperations, PartyResults
from game.world.managers.objects.player.GroupManager import GroupManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler

class GroupLootMethodHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty minimap ping packet
            loot_method, loot_master = unpack('<IQ', reader.data[:12])
            target_player_mgr=None

            if not world_session.player_mgr.group_manager:
                GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_LEAVE, '',
                                                         PartyResults.ERR_NOT_IN_GROUP)
            if world_session.player_mgr != world_session.player_mgr.group_manager.party_leader:
                    GroupManager.send_group_operation_result(world_session.player_mgr, PartyOperations.PARTY_OP_INVITE,
                                                             '', PartyResults.ERR_NOT_LEADER)

            if loot_master > 0:
                target_player_mgr = WorldSessionStateHandler.find_player_by_guid(loot_master)

            world_session.player_mgr.group_manager.set_loot_method(loot_method, master_looter=target_player_mgr)

        return 0
