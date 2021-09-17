from struct import pack, unpack

from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.ConfigManager import config
from utils.constants.MiscCodes import ObjectTypes, ObjectTypeIds, UpdateTypes, HighGuid, LiquidTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields \
    import ObjectFields


class ObjectManager(object):
    def __init__(self,
                 guid=0,
                 entry=0,
                 object_type=None,
                 walk_speed=config.Unit.Defaults.walk_speed,
                 running_speed=config.Unit.Defaults.run_speed,
                 swim_speed=config.Unit.Defaults.swim_speed,
                 turn_rate=config.Unit.Player.Defaults.turn_speed,
                 movement_flags=0,
                 unit_flags=0,
                 dynamic_flags=0,
                 native_scale=1,
                 native_display_id=0,
                 faction=0,
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
        self.native_scale = native_scale
        self.current_scale = native_scale
        self.native_display_id = native_display_id  # Native display ID
        self.current_display_id = native_display_id
        self.faction = faction
        self.bounding_radius = bounding_radius
        self.location = Vector()
        self.transport_id = transport_id
        self.transport = Vector()
        self.pitch = pitch
        self.zone = zone
        self.map_ = map_

        self.object_type = [ObjectTypes.TYPE_OBJECT]
        self.update_packet_factory = UpdatePacketFactory()

        self.is_spawned = True
        self.is_summon = False
        self.dirty = False
        self.current_cell = ''
        self.last_tick = 0
        self.movement_spline = None

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.guid == other.guid
        return NotImplemented

    def __ne__(self, other):
        return not self == other

    def get_object_type_value(self):
        type_value = 0
        for type_ in self.object_type:
            type_value |= type_
        return type_value

    def generate_proper_update_packet(self, is_self=False, create=False):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            self.get_full_update_packet(is_self=is_self) if create else self.get_partial_update_packet()))
        return update_packet

    def send_create_packet_surroundings(self, **kwargs):
        update_packet = self.generate_proper_update_packet(False, True)
        MapManager.send_surrounding(update_packet, self, include_self=False)

    def get_object_create_packet(self, is_self=True):
        from game.world.managers.objects.units import UnitManager

        # Base structure.
        data = self._get_base_structure(UpdateTypes.CREATE_OBJECT)

        # Object type.
        data += pack('<B', self.get_type_id())

        # Movement fields.
        data += self._get_movement_fields()

        # Misc fields.
        combat_unit = UnitManager.UnitManager(self).combat_target if ObjectTypes.TYPE_UNIT in self.object_type else None
        data += pack(
            '<3IQ',
            1 if is_self else 0,  # Flags, 1 - Current player, 0 - Other player
            1 if self.get_type_id() == ObjectTypeIds.ID_PLAYER else 0,  # AttackCycle
            0,  # TimerId
            combat_unit.guid if combat_unit else 0,  # Victim GUID
        )

        # Normal update fields.
        data += self._get_fields_update()

        return data

    def get_partial_update_packet(self):
        # Base structure.
        data = self._get_base_structure(UpdateTypes.PARTIAL)

        # Normal update fields.
        data += self._get_fields_update()

        return data

    def get_movement_update_packet(self):
        # Base structure.
        data = self._get_base_structure(UpdateTypes.MOVEMENT)

        # Movement update fields.
        data += self._get_movement_fields()

        return data

    def set_dirty(self, is_dirty=True):
        self.dirty = is_dirty

    def get_display_id(self):
        return self.current_display_id

    def set_display_id(self, display_id):
        self.current_display_id = display_id

    def reset_display_id(self):
        self.set_display_id(self.native_display_id)

    def set_scale(self, scale):
        self.current_scale = scale
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

    def change_speed(self, speed=0):
        if speed <= 0:
            speed = config.Unit.Defaults.run_speed
        elif speed >= 56:
            speed = 56  # Max speed without glitches

        if self.running_speed == speed:
            return False

        self.running_speed = speed
        return True

    def reset_scale(self):
        self.set_scale(self.native_scale)

    def reset_fields(self):
        # Reset updated fields
        self.update_packet_factory.reset()

    def reset_fields_older_than(self, timestamp):
        # Reset updated fields older than the specified timestamp
        return self.update_packet_factory.reset_older_than(timestamp)

    def _get_base_structure(self, update_type):
        return pack(
            '<IBQ',
            1,  # Number of transactions
            update_type,
            self.guid,
        )

    def _get_movement_fields(self):
        data = pack(
            '<Q9fI',
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
            self.movement_flags
        )

        # TODO: NOT WORKING!
        # if self.movement_spline:
        #    data += self.movement_spline.to_bytes()

        data += pack(
            '<I4f',
            0,  # Fall Time
            self.walk_speed,
            self.running_speed,
            self.swim_speed,
            self.turn_rate
         )

        return data

    def _get_fields_update(self):
        data = pack('<B', self.update_packet_factory.update_mask.block_count)
        data += self.update_packet_factory.update_mask.to_bytes()

        for i in range(0, self.update_packet_factory.update_mask.field_count):
            if self.update_packet_factory.update_mask.is_set(i):
                data += self.update_packet_factory.update_values[i]

        return data

    def set_int32(self, index, value):
        self.update_packet_factory.update(index, value, 'i')

    def get_int32(self, index):
        return unpack('<i', self.update_packet_factory.update_values[index])[0]

    def set_uint32(self, index, value):
        self.update_packet_factory.update(index, value, 'I')

    def get_uint32(self, index):
        return unpack('<I', self.update_packet_factory.update_values[index])[0]

    def set_int64(self, index, value):
        self.update_packet_factory.update(index, value, 'q')

    def get_int64(self, index):
        return unpack('<q', self.update_packet_factory.update_values[index] +
                      self.update_packet_factory.update_values[index + 1])[0]

    def set_uint64(self, index, value):
        self.update_packet_factory.update(index, value, 'Q')

    def get_uint64(self, index):
        return unpack('<Q', self.update_packet_factory.update_values[index] +
                      self.update_packet_factory.update_values[index + 1])[0]

    def set_float(self, index, value):
        self.update_packet_factory.update(index, value, 'f')

    def get_float(self, index):
        return unpack('<f', self.update_packet_factory.update_values[index])[0]

    # override
    def update(self):
        pass

    # override
    def get_full_update_packet(self, is_self=True):
        pass

    # override
    def on_cell_change(self):
        pass

    # override
    def get_type(self):
        return ObjectTypes.TYPE_OBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_OBJECT

    # override
    def get_debug_messages(self):
        low_guid = self.guid & ~ObjectManager.extract_high_guid(self.guid)
        return [
            f'Guid: {low_guid}, Entry: {self.entry}, Display ID: {self.current_display_id}',
            f'X: {self.location.x}, Y: {self.location.y}, Z: {self.location.z}, O: {self.location.o}'
        ]

    # override
    def generate_object_guid(self, low_guid):
        pass

    # override
    def despawn(self):
        MapManager.despawn_object(self)

    # override
    def respawn(self):
        pass

    # override
    def is_on_water(self):
        liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y,
                                                               self.location.z)
        map_z = MapManager.calculate_z_for_object(self)
        return liquid_information and map_z < liquid_information.height

    # override
    def is_under_water(self):
        liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y,
                                                               self.location.z)
        return liquid_information and self.location.z + (self.current_scale * 2) < liquid_information.height

    # override
    def is_in_deep_water(self):
        liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y,
                                                               self.location.z)
        return liquid_information and liquid_information.liquid_type == LiquidTypes.DEEP

    def get_destroy_packet(self):
        data = pack('<Q', self.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DESTROY_OBJECT, data)

    @staticmethod
    def extract_high_guid(guid):
        return HighGuid(guid & (0xFFFF << 48))
