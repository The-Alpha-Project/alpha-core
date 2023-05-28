from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid, ObjectTypeIds
from utils.constants.OpCodes import OpCode


class LootMoneyHandler(object):

    @staticmethod
    def handle(world_session, reader):
        LootMoneyHandler._loot_money(world_session.player_mgr)
        return 0

    @staticmethod
    def _loot_money(player_mgr):
        if player_mgr.loot_selection:
            high_guid = GuidUtils.extract_high_guid(player_mgr.loot_selection.object_guid)
            if high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                world_object = MapManager.get_surrounding_gameobject_by_guid(player_mgr,
                                                                             player_mgr.loot_selection.object_guid)
            elif high_guid == HighGuid.HIGHGUID_UNIT:
                world_object = MapManager.get_surrounding_unit_by_guid(player_mgr,
                                                                       player_mgr.loot_selection.object_guid)
            else:
                Logger.error(f'Tried to loot money from an unknown object type: ({high_guid}).')
                return

            if not world_object:
                Logger.error(f'Unable to loot money for object {high_guid}, object not found.')
                return

            loot_manager = player_mgr.loot_selection.get_loot_manager(world_object)
            if loot_manager.has_money():
                # If party is formed, try to split money.
                # TODO: Currently not splitting money when looting a chest, investigate if this is the correct
                #  behavior or not.
                if world_object.get_type_id() == ObjectTypeIds.ID_UNIT and player_mgr.group_manager and \
                        player_mgr.group_manager.is_party_formed():
                    # Try to split money and finish on success.
                    if player_mgr.group_manager.reward_group_money(player_mgr, world_object):
                        return

                # Not able to split money or no group, loot money to self only.
                player_mgr.mod_money(loot_manager.current_money)
                loot_manager.clear_money()
                packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_CLEAR_MONEY)
                for looter in loot_manager.get_active_looters():
                    looter.enqueue_packet(packet)
