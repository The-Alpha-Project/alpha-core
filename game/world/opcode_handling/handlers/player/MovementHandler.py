from struct import error

from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.units import MovementManager
from network.packet.PacketReader import *
from network.packet.PacketWriter import *
from utils.Logger import Logger
from utils.constants.MiscCodes import MoveFlags
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import StandState


class MovementHandler:

    @staticmethod
    def handle_movement_status(world_session, socket, reader: PacketReader) -> int:
        # Avoid handling malformed movement packets, or handling them while no player or player teleporting.
        if world_session.player_mgr and len(reader.data) >= 48:
            try:
                transport_guid, transport_x, transport_y, transport_z, transport_o, x, y, z, o, pitch, flags = \
                    unpack('<Q9fI', reader.data[:48])

                # Hacky way to prevent random teleports when colliding with elevators
                # Also acts as a rudimentary teleport cheat detection
                if not world_session.player_mgr.pending_taxi_destination and \
                        world_session.player_mgr.location.distance(x=x, y=y, z=z) > 64:
                    Logger.anticheat(f'Preventing coordinate desync from player {world_session.player_mgr.player.name} '
                                     f'({world_session.player_mgr.guid}).')
                    world_session.player_mgr.teleport(world_session.player_mgr.map_,
                                                      world_session.player_mgr.location, is_instant=True)

                    return 0

                jumped = reader.opcode == OpCode.MSG_MOVE_JUMP

                if flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK) or jumped:
                    world_session.player_mgr.spell_manager.check_spell_interrupts(moved=True)
                    world_session.player_mgr.aura_manager.check_aura_interrupts(moved=True)

                if flags & MoveFlags.MOVEFLAG_TURN_MASK:
                    world_session.player_mgr.spell_manager.check_spell_interrupts(turned=True)

                world_session.player_mgr.transport_id = transport_guid

                world_session.player_mgr.transport.x = transport_x
                world_session.player_mgr.transport.y = transport_y
                world_session.player_mgr.transport.z = transport_z
                world_session.player_mgr.transport.o = transport_o

                world_session.player_mgr.location.x = x
                world_session.player_mgr.location.y = y
                world_session.player_mgr.location.z = z
                world_session.player_mgr.location.o = o

                if flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK):
                    world_session.player_mgr.set_has_moved(True)

                world_session.player_mgr.pitch = pitch
                world_session.player_mgr.movement_flags = flags

                if flags & MoveFlags.MOVEFLAG_SPLINE_MOVER:
                    world_session.player_mgr.movement_spline = MovementManager.MovementSpline.from_bytes(
                        reader.data[48:])

                # Broadcast player movement to surroundings.
                movement_data = pack(f'<Q{len(reader.data)}s', world_session.player_mgr.guid, reader.data)
                movement_packet = PacketWriter.get_packet(OpCode(reader.opcode), movement_data)
                MapManager.send_surrounding(movement_packet, world_session.player_mgr, include_self=False)

                # Get up if you jump while not standing.
                if jumped and world_session.player_mgr.stand_state != StandState.UNIT_DEAD and \
                        world_session.player_mgr.stand_state != StandState.UNIT_STANDING:
                    world_session.player_mgr.set_stand_state(StandState.UNIT_STANDING)

            except (AttributeError, error):
                Logger.error(f'Error while handling {OpCode(reader.opcode).name}, skipping. Data: {reader.data}')

        return 0
