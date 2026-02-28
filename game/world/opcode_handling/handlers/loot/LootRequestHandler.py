from game.world.opcode_handling.HandlerValidator import HandlerValidator
from struct import unpack
from utils.Formulas import Distances
from utils.constants.MiscCodes import LootErrors
from utils.constants.UnitCodes import UnitFlags, UnitStates


class LootRequestHandler:
    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode)
        if not player_mgr:
            return res

        # Avoid handling an empty loot packet.
        if not HandlerValidator.validate_packet_length(reader, min_length=8):
            return 0
        loot_target_guid = unpack('<Q', reader.data[:8])[0]

        if not player_mgr.is_standing():
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_NOT_STANDING)
            return 0

        if player_mgr.unit_state & UnitStates.STUNNED:
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_STUNNED)
            return 0

        enemy = player_mgr.get_map().get_surrounding_unit_by_guid(player_mgr, loot_target_guid, include_players=False)

        if not enemy:
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_DIDNT_KILL)
            return 0

        # Another player is currently looting this target.
        active_looters = enemy.loot_manager.get_active_looters() if enemy.loot_manager else []
        if active_looters and player_mgr not in active_looters:
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_LOCKED)
            return 0

        if not Distances.is_within_loot_distance(player_mgr, enemy):
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_TOO_FAR)
            return 0

        if not player_mgr.location.has_in_arc(enemy.location):
            player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_BAD_FACING)
            return 0

        # Only set flag if player was able to loot, else the player would be kneeling forever.
        if player_mgr.send_loot(enemy.loot_manager):
            player_mgr.set_unit_flag(UnitFlags.UNIT_FLAG_LOOTING, active=True)
            return 0

        player_mgr.send_loot_error(loot_target_guid, LootErrors.LOOT_ERROR_DIDNT_KILL)

        return 0
