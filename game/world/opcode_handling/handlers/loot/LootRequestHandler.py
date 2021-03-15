from struct import unpack, pack
from utils.constants.UpdateFields import *
from utils.constants.UnitCodes import UnitFlags
from game.world.managers.GridManager import GridManager


class LootRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling null selection
            loot_target_guid = unpack('<Q', reader.data[:8])[0]

            player = world_session.player_mgr
            enemy = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, loot_target_guid,
                                                             include_players=True)

            if player and enemy:
                player.unit_flags |= UnitFlags.UNIT_FLAG_LOOTING
                player.set_uint32(UnitFields.UNIT_FIELD_FLAGS, player.unit_flags)
                player.send_loot(enemy)
                player.set_dirty()
                GridManager.send_surrounding(player.generate_proper_update_packet(create=True), player,
                                             include_self=True)

        return 0
