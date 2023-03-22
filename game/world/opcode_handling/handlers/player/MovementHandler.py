from struct import error

from game.world.managers.maps.MapManager import MapManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState


class MovementHandler:

    @staticmethod
    def handle_movement_status(world_session, socket, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Avoid handling malformed movement packets.
        if len(reader.data) >= 48:
            try:
                # Get either the player or its possessed unit.
                unit_mover = player_mgr if not player_mgr.possessed_unit else player_mgr.possessed_unit
                move_info = unit_mover.movement_info.update(reader)

                # Hacky way to prevent random teleports when colliding with elevators.
                # Also acts as a rudimentary teleport cheat detection.
                if (not player_mgr.possessed_unit and not player_mgr.pending_taxi_destination
                        and move_info.distance_from_last > 64):
                    Logger.anticheat(f'Preventing desync from player {player_mgr.get_name()} ({player_mgr.guid}).')
                    player_mgr.teleport(player_mgr.map_id, move_info.previous_position, is_instant=True)
                    return 0

                # If the player is not controlling another unit.
                if not player_mgr.possessed_unit:
                    # Cancel looting if x,y,z changed.
                    if move_info.jumped or move_info.moved:
                        player_mgr.interrupt_looting()

                    # Stand up if player jumps while not standing.
                    if move_info.jumped and player_mgr.stand_state != StandState.UNIT_DEAD and \
                            player_mgr.stand_state != StandState.UNIT_STANDING:
                        player_mgr.set_stand_state(StandState.UNIT_STANDING)

                # Broadcast player/possessed unit movement to surroundings.
                movement_packet = PacketWriter.get_packet(OpCode(reader.opcode), move_info.get_bytes())
                MapManager.send_surrounding(movement_packet, unit_mover, include_self=False)

            except (AttributeError, error):
                Logger.error(f'Error while handling {reader.opcode_str()}, skipping. Data: {reader.data}')

        return 0
