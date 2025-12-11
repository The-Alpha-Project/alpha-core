from struct import pack, unpack

from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import MoveFlags
from utils.constants.OpCodes import OpCode

COLLISION_DETECTION = {OpCode.MSG_MOVE_COLLIDE_REDIRECT, OpCode.MSG_MOVE_COLLIDE_STUCK}


class MovementInfo:
    def __init__(self, world_object):
        self.owner = world_object
        # Internal
        self._transport = None
        self._moved = False
        self._turned = False
        self._jumped = False

    def update(self, reader, unit_mover):
        prev_transport = unit_mover.transport_id
        from game.world.managers.objects.units.movement.helpers.Spline import Spline
        collided = reader.opcode in COLLISION_DETECTION

        # t 'Transport' followed by unit fields.
        t_id, t_x, t_y, t_z, t_o, x, y, z, o, pitch, movement_flags = unpack('<Q9fI', reader.data[:48])

        distance = self.owner.location.distance(x=x, y=y, z=z)
        # Anti cheat / elevators bug.
        if (unit_mover == self.owner and self.owner.is_player()
                and not self.owner.pending_taxi_destination and distance > 64):
            return None, None

        # Valid placement, set unit fields.
        unit_mover.transport_id = t_id
        unit_mover.transport_location.x = t_x
        unit_mover.transport_location.y = t_y
        unit_mover.transport_location.z = t_z
        unit_mover.transport_location.o = t_o
        unit_mover.location.x = x
        unit_mover.location.y = y
        unit_mover.location.z = z
        unit_mover.location.o = o
        unit_mover.pitch = pitch
        unit_mover.movement_flags = movement_flags

        if self.owner.movement_flags & MoveFlags.MOVEFLAG_SPLINE_MOVER:
            self.owner.movement_spline = Spline.from_bytes(self.owner, reader.data[48:])
        else:
            self.owner.movement_spline = None

        self._jumped = reader.opcode == OpCode.MSG_MOVE_JUMP
        self._moved = self.owner.movement_flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK) != 0
        self._turned = self.owner.movement_flags & MoveFlags.MOVEFLAG_TURN_MASK != 0

        self.owner.set_has_moved(has_moved=self._moved or self._jumped, has_turned=self._turned)

        if collided:
            self.owner.movement_flags |= MoveFlags.MOVEFLAG_REDIRECTED
        else:
            self.owner.movement_flags &= ~MoveFlags.MOVEFLAG_REDIRECTED

        # Cache transport / add passenger.
        if self.owner.transport_id and not self._transport:
            self._add_transport()
        # Leaving transport, flush and remove passenger.
        elif not self.owner.transport_id and self._transport:
            self._remove_transport()

        if self._transport:
            self._transport.calculate_passenger_position(self.owner)

        # Don't send movement update for transport changes and synchronize updates with transport update.
        # This is a hacky way to prevent players disappearing for each other when interacting with transports.
        ignore_update = (prev_transport != unit_mover.transport_id
                         or self._transport and self._transport.is_new_passenger(self.owner.guio))

        return self, ignore_update

    def remove_from_transport(self):
        if not self._transport:
            return False
        self._remove_transport()
        return True

    def unit_jumped(self):
        return self._jumped

    def unit_moved(self):
        return self._moved

    def _add_transport(self):
        self._transport = self._get_transport()
        self._transport.add_passenger(self.owner)

    def _remove_transport(self):
        self.owner.transport_id = 0
        self.owner.transport_location.flush()
        self._transport.remove_passenger(self.owner)
        self._transport = None

    def _get_transport(self):
        map_ = self.owner.get_map()
        return map_.get_surrounding_gameobject_by_guid(self.owner, self.owner.transport_id)

    def _get_bytes(self):
        # Client seems to expect local coordinates in place of world coordinates for players on transports.
        location = self.owner.transport_location if self._transport else self.owner.location

        data = pack('<2Q9fI', self.owner.guid, self.owner.transport_id, self.owner.transport_location.x,
                    self.owner.transport_location.y, self.owner.transport_location.z, self.owner.transport_location.o,
                    location.x, location.y, location.z, location.o,
                    self.owner.pitch, self.owner.movement_flags)

        if self.owner.movement_spline:
            spline_bytes = self.owner.movement_spline.to_bytes()
            pack(f'<{len(spline_bytes)}s', spline_bytes)
        return data

    def send_surrounding_update(self, opcode=OpCode.MSG_MOVE_HEARTBEAT):
        movement_packet = PacketWriter.get_packet(opcode, self._get_bytes())
        self.owner.get_map().send_surrounding(movement_packet, self.owner, include_self=False)
