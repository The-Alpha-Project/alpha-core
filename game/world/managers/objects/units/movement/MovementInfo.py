from struct import pack, unpack

from game.world.managers.abstractions.Vector import Vector
from utils.constants.MiscCodes import MoveFlags
from utils.constants.OpCodes import OpCode


class MovementInfo:
    def __init__(self, world_object):
        self.owner = world_object
        # Internal
        self.transport = None
        self.distance_from_last = False
        self.moved = False
        self.turned = False
        self.jumped = False
        self.collided = False
        self.previous_position = Vector()

    def update(self, reader):
        from game.world.managers.objects.units.movement.helpers.Spline import Spline

        self.previous_position = self.owner.location.copy()

        self.owner.transport_id, self.owner.transport.x, self.owner.transport.y, self.owner.transport.z, \
            self.owner.transport.o, self.owner.location.x, self.owner.location.y, self.owner.location.z, \
            self.owner.location.o, self.owner.pitch, self.owner.movement_flags = unpack('<Q9fI', reader.data[:48])

        self.distance_from_last = self.owner.location.distance(self.previous_position)

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
            self.transport = self._get_transport()
            self.owner.transport_spawn_id = self.transport.owner.spawn_id
            self.transport.add_passenger(self.owner)
        # Leaving transport.
        elif not self.owner.transport_id and self.transport:
            self.owner.transport.flush()
            self.owner.transport_spawn_id = 0
            self.transport.remove_passenger(self.owner)
            self.transport = None

        return self

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
