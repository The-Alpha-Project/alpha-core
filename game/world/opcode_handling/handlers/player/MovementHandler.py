from struct import error
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState


class MovementHandler:

    @staticmethod
    def handle_movement_status(world_session, reader: PacketReader) -> int:
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        # Ignore while teleporting.
        if player_mgr.update_lock or not player_mgr.is_alive:
            return 0

        # Avoid handling malformed movement packets.
        if len(reader.data) >= 48:
            try:
                # Get the player or its possessed unit.
                unit_mover = player_mgr if not player_mgr.possessed_unit else player_mgr.possessed_unit
                move_info = unit_mover.movement_info.update(reader, unit_mover)

                # Hacky way to prevent random teleports when colliding with elevators.
                # Also acts as a rudimentary teleport cheat detection.
                if not move_info:
                    # Already teleporting.
                    if world_session.player_mgr.update_lock:
                        return 0
                    Logger.anticheat(f'Preventing desync from player {unit_mover.get_name()} ({unit_mover.guid}).')
                    unit_mover.teleport(unit_mover.map_id, unit_mover.location)
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

                # Broadcast unit mover movement to surroundings.
                move_info.send_surrounding_update(opcode=OpCode(reader.opcode))

            except (AttributeError, error):
                Logger.error(f'Error while handling {reader.opcode_str()}, skipping. Data: {reader.data}')

        return 0
