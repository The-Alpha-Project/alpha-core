from struct import pack
from math import pi

from network.packet.UpdatePacketFactory import UpdatePacketFactory
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
        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_OBJECT])

        self.current_grid = ''
        self.last_tick = 0

    def get_object_type_value(self):
        type_value = 0
        for type_ in self.object_type:
            type_value |= type_
        return type_value

    def get_update_mask(self):
        mask = 0
        if ObjectTypes.TYPE_CONTAINER in self.object_type:
            mask += ContainerFields.CONTAINER_END
        if ObjectTypes.TYPE_ITEM in self.object_type:
            mask += ItemFields.ITEM_END
        if ObjectTypes.TYPE_PLAYER in self.object_type:
            mask += PlayerFields.PLAYER_END
        if ObjectTypes.TYPE_UNIT in self.object_type:
            mask += UnitFields.UNIT_END
        if ObjectTypes.TYPE_OBJECT in self.object_type:
            mask += ObjectFields.OBJECT_END
        if ObjectTypes.TYPE_GAMEOBJECT in self.object_type:
            mask += GameObjectFields.GAMEOBJECT_END

        return (mask + 31) / 32

    def create_partial_update_packet(self, update_packet_factory):
        update_mask = self.get_update_mask()
        updated_fields_mask = update_packet_factory.get_updated_fields_mask()
        data = pack(
            '<IBQB%us' % len(updated_fields_mask),
            1,  # Number of transactions
            0,
            self.guid,
            int(update_mask),
            updated_fields_mask
        )
        return data

    def create_update_packet(self, update_packet_factory, is_self=True):
        from game.world.managers.objects import UnitManager
        merged_update_values = update_packet_factory.get_merged_update_values()
        update_mask = int(self.get_update_mask())
        data = pack(
            '<IBQBQfffffffffIIffffIIIQB',
            1,  # Number of transactions
            2,
            self.guid,
            self.get_type_id(),
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
            self.turn_rate,
            1 if is_self else 0,  # Flags, 1 - Current player, 0 - Other player
            1 if self.get_type_id() == ObjectTypeIds.ID_PLAYER else 0,  # AttackCycle
            0,  # TimerId
            self.combat_target if isinstance(self, UnitManager.UnitManager) else 0,  # Victim GUID
            update_mask
        )

        for x in range(0, update_mask):
            data += pack('<I', 0xFFFFFFFF)

        """for x in range(0, merged_update_fields.length()):
            if merged_update_fields[x] and x < len(merged_update_values):
                print('%u - %u' % (x, len(merged_update_values)))
                data += bytes(merged_update_values[x])"""
        data += merged_update_values

        self.update_packet_factory.init_lists()

        return data

    def set_obj_uint32(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.object_values,
                                          self.update_packet_factory.updated_object_fields, index, value, 'I')

    def set_obj_uint64(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.object_values,
                                          self.update_packet_factory.updated_object_fields, index, value, 'Q')

    def set_obj_float(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.object_values,
                                          self.update_packet_factory.updated_object_fields, index, value, 'f')

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
