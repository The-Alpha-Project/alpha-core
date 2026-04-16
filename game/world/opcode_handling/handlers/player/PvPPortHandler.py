import random

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import PacketReader


class PvPPortHandler:

    @staticmethod
    def handle(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Only allow /pvp if not in combat.
        if player_mgr.in_combat:
            return 0

        current_map = player_mgr.get_map()

        # Already in a PvP map, teleport back.
        if current_map.is_pvp():
            if player_mgr.pvp_source_location:
                # Return to saved location.
                source_map, source_vector = player_mgr.pvp_source_location
                player_mgr.pvp_source_location = None
                player_mgr.teleport(source_map, source_vector)
            else:
                # No source saved (e.g. server restarted), fall back to deathbind.
                deathbind_map, deathbind_location = player_mgr.get_deathbind_coordinates()
                player_mgr.teleport(deathbind_map, deathbind_location)
            return 0

        # Only two maps flagged as PvP exist in 0.5.3: PvPZone01 and PvPZone02.
        pvp_map = random.randint(1, 2)
        location = WorldDatabaseManager.worldport_get_by_name(f'PvPZone0{pvp_map}')

        if location:
            # Save current location before porting.
            player_mgr.pvp_source_location = (player_mgr.map_id, player_mgr.location.copy())
            tel_location = Vector(location.x, location.y, location.z, location.o)
            player_mgr.teleport(location.map, tel_location)

        return 0
