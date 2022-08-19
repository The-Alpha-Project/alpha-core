import random

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketReader import PacketReader


class PvPPortHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        # Only two maps flagged as PvP exist in 0.5.3: PvPZone01 and PvPZone02.
        pvp_map = random.randint(1, 2)
        location = WorldDatabaseManager.worldport_get_by_name(f'PvPZone0{pvp_map}')

        if location:
            tel_location = Vector(location.x, location.y, location.z, location.o)
            world_session.player_mgr.teleport(location.map, tel_location)
        return 0
