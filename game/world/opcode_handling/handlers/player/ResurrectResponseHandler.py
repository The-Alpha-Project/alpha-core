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

            caster = None
            high_guid: HighGuid = ObjectManager.extract_high_guid(guid)
            if high_guid == HighGuid.HIGHGUID_PLAYER:
                caster = WorldSessionStateHandler.find_player_by_guid(guid)
            elif high_guid == HighGuid.HIGHGUID_UNIT:
                caster = MapManager.get_surrounding_unit_by_guid(world_session.player_mgr, guid)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                caster = MapManager.get_surrounding_gameobject_by_guid(world_session.player_mgr, guid)

            # TODO: Use real spell effect data in order to apply the correct health/power percentage.
            world_session.player_mgr.respawn(recovery_percentage=0.5)
            world_session.player_mgr.spirit_release_timer = 0
            if caster:
                world_session.player_mgr.teleport(caster.map_, caster.location)

        return 0
