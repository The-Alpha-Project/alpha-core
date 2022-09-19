from struct import error

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units import MovementManager
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

                # Hacky way to prevent random teleports when colliding with elevators
                # Also acts as a rudimentary teleport cheat detection
                if not player_mgr.pending_taxi_destination and player_mgr.location.distance(x=x, y=y, z=z) > 64:
                    Logger.anticheat(f'Preventing desync from player {player_mgr.player.name} ({player_mgr.guid}).')
                    player_mgr.teleport(player_mgr.map_, player_mgr.location, is_instant=True)
                    return 0

                player_jumped = reader.opcode == OpCode.MSG_MOVE_JUMP
                player_moved = flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK)
                player_turned = flags & MoveFlags.MOVEFLAG_TURN_MASK

                # Movement actions.
                if player_moved or player_jumped or player_turned:
                    # Flag player as moved only if x,y changed.
                    if not player_jumped and not player_turned:
                        player_mgr.set_has_moved(True)

                    # Cancel looting if x,y,z changed.
                    if not player_turned:
                        player_mgr.interrupt_looting()

                    # Check spell and aura interrupts.
                    player_mgr.spell_manager.check_spell_interrupts(moved=player_moved or player_jumped,
                                                                    turned=player_turned)
                    player_mgr.aura_manager.check_aura_interrupts(moved=player_moved or player_jumped,
                                                                  turned=player_turned)
                # Update transport information.
                player_mgr.transport_id = transport_guid
                player_mgr.transport.x = transport_x
                player_mgr.transport.y = transport_y
                player_mgr.transport.z = transport_z
                player_mgr.transport.o = transport_o

                # Update player location, pitch and movement flags.
                player_mgr.location.x = x
                player_mgr.location.y = y
                player_mgr.location.z = z
                player_mgr.location.o = o
                player_mgr.pitch = pitch
                player_mgr.movement_flags = flags

                # Unpack spline mover if needed.
                if flags & MoveFlags.MOVEFLAG_SPLINE_MOVER:
                    player_mgr.movement_spline = MovementManager.MovementSpline.from_bytes(reader.data[48:])

                # Broadcast player movement to surroundings.
                movement_data = pack(f'<Q{len(reader.data)}s', player_mgr.guid, reader.data)
                movement_packet = PacketWriter.get_packet(OpCode(reader.opcode), movement_data)
                MapManager.send_surrounding(movement_packet, player_mgr, include_self=False)

                # Stand up if player jumps while not standing.
                if player_jumped and player_mgr.stand_state != StandState.UNIT_DEAD and \
                        player_mgr.stand_state != StandState.UNIT_STANDING:
                    player_mgr.set_stand_state(StandState.UNIT_STANDING)

            except (AttributeError, error):
                Logger.error(f'Error while handling {reader.opcode_str()}, skipping. Data: {reader.data}')

        return 0
