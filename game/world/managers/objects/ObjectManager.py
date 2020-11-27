from struct import pack
from math import pi

from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, UpdateTypes
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
                 location=None,
                 transport_id=0,
                 transport=None,
                 pitch=0,
                 zone=0,
                 map_=0):
        self.guid = guid
        self.entry = entry
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
        self.location = Vector()
        self.transport_id = transport_id
        self.transport = Vector()
        self.pitch = pitch
        self.zone = zone
        self.map_ = map_

        self.object_type = [ObjectTypes.TYPE_OBJECT]
        self.update_packet_factory = UpdatePacketFactory()

        self.current_grid = ''
        self.last_tick = 0

    def get_object_type_value(self):
        type_value = 0
        for type_ in self.object_type:
            type_value |= type_
        return type_value

    def get_object_create_packet(self, is_self=True):
        from game.world.managers.objects import UnitManager

        # Base structure
        data = self._get_base_structure(UpdateTypes.CREATE_OBJECT)

        # Object type
        data += pack('<B', self.get_type_id())

        # Movement fields
        data += pack(
            '<QfffffffffIIffff',
            self.transport_id,
            self.transport.x,
            self.transport.y,
            self.transport.z,
            self.transport.o,
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
            self.turn_rate
        )

        # Misc fields
        data += pack(
            '<3IQ',
            1 if is_self else 0,  # Flags, 1 - Current player, 0 - Other player
            1 if self.get_type_id() == ObjectTypeIds.ID_PLAYER else 0,  # AttackCycle
            0,  # TimerId
            UnitManager.UnitManager(self).combat_target if isinstance(self, UnitManager.UnitManager) else 0, # Victim GUID
        )

        # Normal update fields
        data += self._get_fields_update()

        # Reset updated fields
        self.update_packet_factory.reset()

        return data

    def get_partial_update_packet(self):
        # Base structure
        data = self._get_base_structure(UpdateTypes.PARTIAL)

        # Normal update fields
        data += self._get_fields_update()

        # Reset updated fields
        self.update_packet_factory.reset()

        return data

    def _get_base_structure(self, update_type):
        return pack(
            '<IBQ',
            1,  # Number of transactions
            update_type,
            self.guid,
        )

    def _get_fields_update(self):
        data = pack('<B', self.update_packet_factory.update_mask.block_count)
        data += self.update_packet_factory.update_mask.to_bytes()

        for i in range(0, self.update_packet_factory.update_mask.field_count):
            if self.update_packet_factory.update_mask.is_set(i):
                data += self.update_packet_factory.update_values[i]

        return data

    def set_int32(self, index, value):
        self.update_packet_factory.update(index, value, 'i')

    def set_uint32(self, index, value):
        self.update_packet_factory.update(index, value, 'I')

    def set_int64(self, index, value):
        self.update_packet_factory.update(index, value, 'q')

    def set_uint64(self, index, value):
        self.update_packet_factory.update(index, value, 'Q')

    def set_float(self, index, value):
        self.update_packet_factory.update(index, value, 'f')

    # override
    def update(self):
        pass

    # override
    def get_full_update_packet(self, is_self=True):
        pass

    # override
    def get_type(self):
        return ObjectTypes.TYPE_OBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_OBJECT

    def get_destroy_packet(self):
        data = pack('<Q', self.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DESTROY_OBJECT, data)
