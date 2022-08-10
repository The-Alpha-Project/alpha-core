from struct import unpack
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.MiscCodes import HighGuid
from utils.Logger import Logger


class QuestGiverAcceptQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty quest giver accept quest packet.
            guid, quest_id = unpack('<QI', reader.data[:12])
            high_guid = ObjectManager.extract_high_guid(guid)
            is_item = False

            quest_giver = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                quest_giver = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                is_item = True
                quest_giver = world_session.player_mgr.inventory.get_item_by_guid(guid)

            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_ACCEPT_QUEST, could not find quest giver with guid of: {guid}')
                return 0
            elif not is_item and world_session.player_mgr.is_hostile_to(quest_giver):
                return 0
            elif world_session.player_mgr.quest_manager.is_quest_log_full():
                world_session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTLOG_FULL))
            else:
                world_session.player_mgr.quest_manager.handle_accept_quest(quest_id, guid, shared=False)
        return 0
