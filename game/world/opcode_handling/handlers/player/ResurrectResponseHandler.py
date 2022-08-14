from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketReader import *
from utils.constants.MiscCodes import HighGuid


class ResurrectResponseHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.is_alive:
            return 0

        if len(reader.data) >= 9:  # Avoid handling empty resurrect response packet.
            guid, status = unpack('<QB', reader.data[:9])

            # Resurrection request declined.
            if status == 0:
                return 0

            # Resurrection request data not available.
            if not world_session.player_mgr.resurrect_data:
                return 0

            # Original resuscitator doesn't match with the received one.
            if world_session.player_mgr.resurrect_data.resuscitator_guid != guid:
                return 0

            world_session.player_mgr.resurrect()

        return 0
