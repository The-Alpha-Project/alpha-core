from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverHelloHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty quest giver hello packet
            guid = unpack('<Q', reader.data[:8])[0]
            quest_giver = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            if not quest_giver:
                Logger.error("Error in CMSG_QUESTGIVER_HELLO, could not find quest giver with guid of: %u" % guid)
                return 0
            if world_session.player_mgr.is_enemy_to(quest_giver):
                return 0

            # TODO: Stop the npc if it's moving
            # TODO: Remove feign death from player (if it even exists in 0.5.3)
            # TODO: If the gossip menu is already open, do nothing
            world_session.player_mgr.quest_manager.prepare_quest_giver_gossip_menu(quest_giver, guid)

        return 0

