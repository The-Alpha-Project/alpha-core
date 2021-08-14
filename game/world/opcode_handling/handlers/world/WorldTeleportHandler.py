from struct import unpack

from game.world.managers.abstractions.Vector import Vector
from utils.Logger import Logger
from utils.constants.UnitCodes import SplineFlags


class WorldTeleportHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        # Don't teleport if player is in the middle of a flight.
        if world_session.player_mgr.movement_spline and world_session.player_mgr.movement_spline.flags == SplineFlags.SPLINEFLAG_FLYING:
            return 0

        if len(reader.data) >= 21:  # Avoid handling malformed world port packet.
            return 0
        
        if world_session.player_mgr.is_gm:
            pack_guid, map_, x, y, z, o = unpack('<IB4f', reader.data)
            world_session.player_mgr.teleport(map_, Vector(x, y, z, o))
        else:
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to teleport himself.')

        return 0

    @staticmethod
    def handle_ack(world_session, socket, reader):
        if world_session.player_mgr:
            world_session.player_mgr.spawn_player_from_teleport()
        return 0
