from struct import error

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units.movement import MovementManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveFlags
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
                transport_guid, transport_x, transport_y, transport_z, transport_o, x, y, z, o, pitch, flags = \
                    unpack('<Q9fI', reader.data[:48])

                # Hacky way to prevent random teleports when colliding with elevators.
                # Also acts as a rudimentary teleport cheat detection.
                if (not player_mgr.possessed_unit and not player_mgr.pending_taxi_destination
                        and player_mgr.location.distance(x=x, y=y, z=z) > 64):
                    Logger.anticheat(f'Preventing desync from player {player_mgr.get_name()} ({player_mgr.guid}).')
                    player_mgr.teleport(player_mgr.map_id, player_mgr.location, is_instant=True)
                    return 0

                unit_collide = reader.opcode in {OpCode.MSG_MOVE_COLLIDE_REDIRECT, OpCode.MSG_MOVE_COLLIDE_STUCK}
                unit_jumped = reader.opcode == OpCode.MSG_MOVE_JUMP
                unit_moved = flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK) != 0
                unit_turned = flags & MoveFlags.MOVEFLAG_TURN_MASK != 0

                # If the player is not controlling another unit.
                if not player_mgr.possessed_unit:
                    # Cancel looting if x,y,z changed.
                    if unit_jumped or unit_moved:
                        player_mgr.interrupt_looting()

                    # Unpack spline mover if needed.
                    if flags & MoveFlags.MOVEFLAG_SPLINE_MOVER:
                        player_mgr.movement_spline = MovementManager.Spline.from_bytes(player_mgr, reader.data[48:])

                    # Stand up if player jumps while not standing.
                    if unit_jumped and player_mgr.stand_state != StandState.UNIT_DEAD and \
                            player_mgr.stand_state != StandState.UNIT_STANDING:
                        player_mgr.set_stand_state(StandState.UNIT_STANDING)

                # Get either the player or its possessed unit.
                unit_mover = player_mgr if not player_mgr.possessed_unit else player_mgr.possessed_unit

                # Update transport information.
                unit_mover.transport_id = transport_guid
                unit_mover.transport.x = transport_x
                unit_mover.transport.y = transport_y
                unit_mover.transport.z = transport_z
                unit_mover.transport.o = transport_o

                # Update unit mover location, pitch and movement flags.
                unit_mover.location.x = x
                unit_mover.location.y = y
                unit_mover.location.z = z
                unit_mover.location.o = o
                unit_mover.pitch = pitch
                unit_mover.movement_flags = flags

                if unit_collide:
                    unit_mover.movement_flags |= MoveFlags.MOVEFLAG_REDIRECTED
                else:
                    unit_mover.movement_flags &= ~MoveFlags.MOVEFLAG_REDIRECTED

                unit_mover.set_has_moved(has_moved=unit_moved or unit_jumped, has_turned=unit_turned)

                # Broadcast player/possessed unit movement to surroundings.
                movement_data = pack(f'<Q{len(reader.data)}s', unit_mover.guid, reader.data)
                movement_packet = PacketWriter.get_packet(OpCode(reader.opcode), movement_data)
                MapManager.send_surrounding(movement_packet, unit_mover, include_self=False)

            except (AttributeError, error):
                Logger.error(f'Error while handling {reader.opcode_str()}, skipping. Data: {reader.data}')

        return 0
