from struct import pack, unpack
from utils.constants.MiscCodes import MoveFlags
from utils.constants.OpCodes import OpCode


class MovementInfo:
    def __init__(self, world_object):
        self.owner = world_object
        # Internal
        self.transport = None
        self.moved = False
        self.turned = False
        self.jumped = False
        self.collided = False

    def update(self, reader, unit_mover):
        from game.world.managers.objects.units.movement.helpers.Spline import Spline

        # t 'Transport' followed by unit fields.
        t_id, t_x, t_y, t_z, t_o, x, y, z, o, pitch, movement_flags = unpack('<Q9fI', reader.data[:48])

        distance = self.owner.location.distance(x=x, y=y, z=z)

        # Anti cheat / elevators bug.
        if unit_mover == self.owner and not self.owner.pending_taxi_destination and distance > 64:
            return None

        # Valid placement, set unit fields.
        unit_mover.transport_id = t_id
        unit_mover.transport.x = t_x
        unit_mover.transport.y = t_y
        unit_mover.transport.z = t_z
        unit_mover.transport.o = t_o
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

        self.collided = reader.opcode in {OpCode.MSG_MOVE_COLLIDE_REDIRECT, OpCode.MSG_MOVE_COLLIDE_STUCK}
        self.jumped = reader.opcode == OpCode.MSG_MOVE_JUMP
        self.moved = self.owner.movement_flags & (MoveFlags.MOVEFLAG_MOVE_MASK | MoveFlags.MOVEFLAG_STRAFE_MASK) != 0
        self.turned = self.owner.movement_flags & MoveFlags.MOVEFLAG_TURN_MASK != 0

        self.owner.set_has_moved(has_moved=self.moved or self.jumped, has_turned=self.turned)

        if self.collided:
            self.owner.movement_flags |= MoveFlags.MOVEFLAG_REDIRECTED
        else:
            self.owner.movement_flags &= ~MoveFlags.MOVEFLAG_REDIRECTED

        # Cache transport / add passenger.
        if self.owner.transport_id and not self.transport:
            self._add_transport()
        # Leaving transport, flush and remove passenger.
        elif not self.owner.transport_id and self.transport:
            self._remove_transport()

        return self

    def _add_transport(self):
        self.transport = self._get_transport()
        self.transport.add_passenger(self.owner)

    def _remove_transport(self):
        self.owner.transport.flush()
        self.transport.remove_passenger(self.owner)
        self.transport = None

    def _get_transport(self):
        from game.world.managers.maps.MapManager import MapManager
        return MapManager.get_surrounding_gameobject_by_guid(self.owner, self.owner.transport_id).transport_manager

    def get_bytes(self):
        data = pack('<2Q9fI', self.owner.guid, self.owner.transport_id, self.owner.transport.x, self.owner.transport.y,
                    self.owner.transport.z, self.owner.transport.o, self.owner.location.x, self.owner.location.y,
                    self.owner.location.z, self.owner.location.o, self.owner.pitch, self.owner.movement_flags)
        if self.owner.movement_spline:
            spline_bytes = self.owner.movement_spline.to_bytes()
            pack(f'<{len(spline_bytes)}s', spline_bytes)
        return data
