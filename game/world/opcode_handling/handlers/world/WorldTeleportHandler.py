from struct import unpack

from game.world.managers.abstractions.Vector import Vector
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.Logger import Logger
from utils.constants.UnitCodes import UnitFlags


class WorldTeleportHandler:

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Don't teleport if player is in the middle of a flight.
        if player_mgr.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            return 0

        if world_session.account_mgr.is_gm():
            if len(reader.data) >= 21:  # Avoid handling empty world teleport packet.
                pack_guid, map_, x, y, z, o = unpack('<IB4f', reader.data[:21])
                world_session.player_mgr.teleport(map_, Vector(x, y, z, o))
        else:
            Logger.anticheat(f'Player {world_session.player_mgr.get_name()} ({world_session.player_mgr.guid}) tried to teleport himself.')

        return 0

    @staticmethod
    def handle_ack(world_session, reader):
        if world_session.player_mgr:
            world_session.player_mgr.spawn_player_from_teleport()
        return 0
