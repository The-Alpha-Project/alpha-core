from struct import pack
from math import pi
import zlib

from game.world.objects import UnitManager
from utils.constants.ObjectCodes import ObjectTypes
from utils.ConfigManager import config
from game.world.objects.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.UpdateFields \
    import ContainerFields, ItemFields, PlayerFields, UnitFields, ObjectFields, GameObjectFields


class ObjectManager(object):
    def __init__(self,
                 guid=0,
                 entry=0,
                 object_type=ObjectTypes.TYPE_OBJECT,
                 walk_speed=2.5,
                 running_speed=7.0,
                 swim_speed=4.72222223,
                 turn_rate=pi,
                 movement_flags=0,
                 unit_flags=0,
                 dynamic_flags=0,
                 shapeshift_form=0,
                 display_id=0,
                 scale=1,
                 bounding_radius=config.Unit.Defaults.bounding_radius,
                 location=Vector(),
                 transport_id=0,
                 transport=Vector(),
                 transport_orientation=0,
                 orientation=0,
                 pitch=0,
                 zone=0,
                 map_=0):
        self.guid = guid
        self.entry = entry
        self.object_type = object_type
        self.walk_speed = walk_speed
        self.running_speed = running_speed
        self.swim_speed = swim_speed
        self.turn_rate = turn_rate
        self.movement_flags = movement_flags
        self.unit_flags = unit_flags
        self.dynamic_flags = dynamic_flags
        self.shapeshift_form = shapeshift_form
        self.display_id = display_id
        self.scale = scale
        self.bounding_radius = bounding_radius
        self.location = location
        self.transport_id = transport_id
        self.transport = transport
        self.transport_orientation = transport_orientation
        self.orientation = orientation
        self.pitch = pitch
        self.zone = zone
        self.map_ = map_

    def get_update_mask(self):
        mask = 0
        if self.object_type == ObjectTypes.TYPE_CONTAINER.value:
            mask += ContainerFields.CONTAINER_END.value
        if self.object_type == ObjectTypes.TYPE_ITEM.value:
            mask += ItemFields.ITEM_END.value
        if self.object_type == ObjectTypes.TYPE_PLAYER.value:
            mask += PlayerFields.PLAYER_END.value
        if self.object_type == ObjectTypes.TYPE_UNIT.value:
            mask += UnitFields.UNIT_END.value
        if self.object_type == ObjectTypes.TYPE_OBJECT.value:
            mask += ObjectFields.OBJECT_END.value
        if self.object_type == ObjectTypes.TYPE_GAMEOBJECT.value:
            mask += GameObjectFields.GAMEOBJECT_END.value
        return (mask + 31) / 32

    def get_build_object_update_packet(self):
        update_mask = int(self.get_update_mask())
        data = pack(
            '!IBQBQfffffffffIIffffIIIQB',
            1,  # Number of transactions
            2,
            self.guid,
            self.object_type,
            self.transport_id,
            self.transport.x,
            self.transport.y,
            self.transport.z,
            self.transport_orientation,
            self.location.x,
            self.location.y,
            self.location.z,
            self.orientation,
            self.pitch,
            self.movement_flags,
            0,  # Fall Time?
            self.walk_speed,
            self.running_speed,
            self.swim_speed,
            self.turn_rate,
            1,  # Flags, 1 - Player, 0 - Bot
            1 if self.object_type >= ObjectTypes.TYPE_PLAYER.value else 0,  # AttackCycle
            0,  # TimerId
            self.combat_target if isinstance(self, UnitManager.UnitManager) else 0,  # Victim GUID
            update_mask
        )

        for x in range(0, update_mask):
            data += pack('!I', 4294967295)

        return data

    def _deflate(self, data):
        return zlib.compress(data)[2:-4]
