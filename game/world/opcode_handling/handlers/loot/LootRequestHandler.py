from struct import unpack
from utils.constants.UnitCodes import UnitFlags


class LootRequestHandler:

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty loot packet.
            loot_target_guid = unpack('<Q', reader.data[:8])[0]
            player = world_session.player_mgr
            enemy = player.get_map().get_surrounding_unit_by_guid(world_session.player_mgr, loot_target_guid,
                                                                  include_players=False)

            if player and enemy:
                # Only set flag if player was able to loot, else the player would be kneeling forever.
                if player.send_loot(enemy.loot_manager):
                    player.set_unit_flag(UnitFlags.UNIT_FLAG_LOOTING, active=True)

        return 0
