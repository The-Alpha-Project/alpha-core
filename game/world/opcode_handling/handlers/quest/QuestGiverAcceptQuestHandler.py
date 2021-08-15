from struct import unpack

from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.Logger import Logger


class QuestGiverAcceptQuestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 12:  # Avoid handling empty quest giver accept quest packet.
            quest_giver_guid, quest_id = unpack ('<QI', reader.data[:12])
            quest_giver = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, quest_giver_guid)
            if not quest_giver:
                Logger.error(f'Error in CMSG_QUESTGIVER_ACCEPT_QUEST, could not find quest giver with guid of: {quest_giver_guid}')
                return 0
            elif world_session.player_mgr.is_enemy_to(quest_giver):
                return 0
            elif world_session.player_mgr.quest_manager.is_quest_log_full():
                world_session.player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_QUESTLOG_FULL))
            else:
                world_session.player_mgr.quest_manager.handle_accept_quest(quest_id, quest_giver_guid, shared=False)
        return 0
