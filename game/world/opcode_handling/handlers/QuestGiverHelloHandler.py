from struct import unpack, pack

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from utils.Logger import Logger
from utils.constants import ObjectCodes

from network.packet.PacketWriter import PacketWriter, OpCode


class QuestGiverHelloHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Cancel feign death, if it even exists at this point
        # Stop the npc if they are moving
        if len(reader.data) >= 8:
            guid = unpack('<Q', reader.data[:8])[0]
            # questgiver_npc = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)

            # Logger.debug( "guid: %s"%(guid) )
            # Logger.debug( "questgiver_npc.entry: %s"%(questgiver_npc.entry) )


        return 0

