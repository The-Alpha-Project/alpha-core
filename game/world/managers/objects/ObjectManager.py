from struct import pack
from math import pi

from game.world.managers.objects import UnitManager
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds
from utils.ConfigManager import config
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields \
    import ContainerFields, ItemFields, PlayerFields, UnitFields, ObjectFields, GameObjectFields


class ObjectManager(object):
    def __init__(self,
                 guid=0,
                 entry=0,
                 object_type=None,
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
                 pitch=0,
                 zone=0,
                 map_=0):
        self.guid = guid
        self.entry = entry
        self.object_type = [ObjectTypes.TYPE_OBJECT]
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
        self.pitch = pitch
        self.zone = zone
        self.map_ = map_

        self.current_grid = ''

    def get_object_type_value(self):
        type_value = 0
        for type_ in self.object_type:
            type_value |= type_.value
        return type_value

    def get_update_mask(self):
        mask = 0
        if ObjectTypes.TYPE_CONTAINER in self.object_type:
            mask += ContainerFields.CONTAINER_END.value
        if ObjectTypes.TYPE_ITEM in self.object_type:
            mask += ItemFields.ITEM_END.value
        if ObjectTypes.TYPE_PLAYER in self.object_type:
            mask += PlayerFields.PLAYER_END.value
        if ObjectTypes.TYPE_UNIT in self.object_type:
            mask += UnitFields.UNIT_END.value
        if ObjectTypes.TYPE_OBJECT in self.object_type:
            mask += ObjectFields.OBJECT_END.value
        if ObjectTypes.TYPE_GAMEOBJECT in self.object_type:
            mask += GameObjectFields.GAMEOBJECT_END.value

        return (mask + 31) / 32

    def create_partial_update_packet(self):
        update_mask = self.get_update_mask()
        data = pack(
            '<IBQBI',
            1,  # Number of transactions
            0,
            self.guid,
            int(update_mask)
        )
        return data

    def create_update_packet(self, is_self=True):
        update_mask = self.get_update_mask()
        data = pack(
            '<IBQBQfffffffffIIffffIIIQB',
            1,  # Number of transactions
            2,
            self.guid,
            self.get_type_id().value,
            self.transport_id,
            self.transport.x,
            self.transport.y,
            self.transport.z,
            self.transport_orientation,
            self.location.x,
            self.location.y,
            self.location.z,
            self.location.o,
            self.pitch,
            self.movement_flags,
            0,  # Fall Time?
            self.walk_speed,
            self.running_speed,
            self.swim_speed,
            self.turn_rate,
            1 if is_self else 0,  # Flags, 1 - Current player, 0 - Other player
            1 if self.get_type_id() == ObjectTypeIds.TYPEID_PLAYER else 0,  # AttackCycle
            0,  # TimerId
            self.combat_target if isinstance(self, UnitManager.UnitManager) else 0,  # Victim GUID
            int(update_mask)
        )

        for x in range(0, int(update_mask)):
            data += pack('<I', 0xFFFFFFFF)

        return data

    def get_type(self):
        return ObjectTypes.TYPE_OBJECT

    def get_type_id(self):
        return ObjectTypeIds.TYPEID_OBJECT

    def get_destroy_packet(self):
        data = pack('<Q', self.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DESTROY_OBJECT, data)
