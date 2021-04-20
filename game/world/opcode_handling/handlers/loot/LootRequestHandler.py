from struct import unpack, pack
from utils.constants.UpdateFields import *
from utils.constants.UnitCodes import UnitFlags
from game.world.managers.GridManager import GridManager


class LootRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling empty loot packet
            loot_target_guid = unpack('<Q', reader.data[:8])[0]

            # Circumvent CMSG_LOOT completly, client has a bug in which players gets stuck while trying to loot a corpse,
            # after this happens, clients will no longer trigger any subsequent CMSG_LOOT message, leaving us with no way
            # to know he got stuck. We can easily manage CMSG_LOOT in this handler, and it will always trigger.
            # Blizzard had this issue too back in the day and they solved it (most likely) by sending loot release
            # every 15 seconds:
            #     "loot bug" partially fixed (should only get stuck for 15 seconds max now, no more re-logging needed).
            #     https://wowpedia.fandom.com/wiki/Patch_0.5.3
            # TODO: Investigate if there's a better fix (or hackfix) for this issue.
            if world_session.player_mgr and world_session.player_mgr.current_selection != loot_target_guid:
                world_session.player_mgr.send_melee_attack_stop(loot_target_guid)
                world_session.player_mgr.set_current_selection(loot_target_guid)

            # Old working handler:
            # player = world_session.player_mgr
            # enemy = GridManager.get_surrounding_unit_by_guid(world_session.player_mgr, loot_target_guid,
            #                                                 include_players=False)
            # if player and enemy:
            #     # Only set flag if player was able to loot, else the player would be kneeling forever.
            #     if player.send_loot(enemy):
            #         player.unit_flags |= UnitFlags.UNIT_FLAG_LOOTING
            #         player.set_uint32(UnitFields.UNIT_FIELD_FLAGS, player.unit_flags)
            #         player.set_dirty()

        return 0
