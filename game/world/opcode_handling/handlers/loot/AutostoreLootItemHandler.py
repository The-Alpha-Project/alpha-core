from struct import unpack
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import HighGuid


class AutostoreLootItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 1:  # Avoid handling empty autostore loot item packet.
            slot = unpack('<B', reader.data[:1])[0]
            AutostoreLootItemHandler._loot_item(world_session.player_mgr, slot)

        return 0

    @staticmethod
    def _loot_item(player_mgr, slot):
        if player_mgr.loot_selection:
            high_guid: HighGuid = GuidUtils.extract_high_guid(player_mgr.loot_selection.object_guid)
            world_obj_target = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                world_obj_target = player_mgr.get_map().get_surrounding_unit_by_guid(
                    player_mgr, player_mgr.loot_selection.object_guid, include_players=False)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                world_obj_target = player_mgr.get_map().get_surrounding_gameobject_by_guid(
                    player_mgr, player_mgr.loot_selection.object_guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                world_obj_target = player_mgr.inventory.get_item_by_guid(player_mgr.loot_selection.object_guid)

            if world_obj_target:
                loot_manager = player_mgr.loot_selection.get_loot_manager(world_obj_target)
                if loot_manager:
                    loot_manager.loot_item_in_slot(slot, requester=player_mgr)
            else:
                Logger.error(f'Unable to loot item for object {high_guid} at slot {slot}, object not found.')
