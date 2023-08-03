from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.ConfigManager import config
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, UpdateTypes, LiquidTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UnitCodes import UnitReaction, UnitFlags, UnitStates
from utils.constants.UpdateFields \
    import ObjectFields, UnitFields


class ObjectManager:
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
                 map_id=0):
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
        self.transport_location = Vector()
        self.pitch = pitch
        self.zone = zone
        self.map_id = map_id
        self.instance_id = 0
        self.update_packet_factory = UpdatePacketFactory()

        self.initialized = False
        self.is_spawned = True
        self.is_default = True
        self.summoner = None
        self.charmer = None
        self.current_cell = ''
        self.last_tick = 0
        self.movement_spline = None
        self.object_ai = None

        # Units and gameobjects have SpellManager.
        from game.world.managers.objects.spell.SpellManager import SpellManager
        self.spell_manager = None
        if self.get_type_mask() & ObjectTypeFlags.TYPE_UNIT or self.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            self.spell_manager = SpellManager(self)

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return self.guid == other.guid
        return NotImplemented

    def __ne__(self, other):
        return not self == other

    def get_ray_position(self):
        return self.location.get_ray_vector(world_object=self)

    def has_pending_updates(self):
        return self.update_packet_factory.has_pending_updates()

    def generate_create_packet(self, requester):
        return UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            self.get_object_create_bytes(requester)))

    def generate_partial_packet(self, requester):
        if not self.initialized:
            self.initialize_field_values()

        return UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            self.get_partial_update_bytes(requester)))

    def generate_movement_packet(self):
        return PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, self.get_movement_update_bytes())

    def get_object_create_bytes(self, requester):
        from game.world.managers.objects.units import UnitManager

        is_self = requester.guid == self.guid

        if not self.initialized:
            self.initialize_field_values()

        # Initialize bytearray.
        data = bytearray()

        # Base structure.
        data.extend(self._get_base_structure(UpdateTypes.CREATE_OBJECT))

        # Object type.
        data.extend(pack('<B', self.get_type_id()))

        # Movement fields.
        data.extend(self._get_movement_fields())

        # Misc fields.
        combat_unit = UnitManager.UnitManager(self).combat_target if self.get_type_mask() & ObjectTypeFlags.TYPE_UNIT \
            else None
        data.extend(pack(
            '<3IQ',
            1 if is_self else 0,  # Flags, 1 - Current player, 0 - Other player
            1 if self.get_type_id() == ObjectTypeIds.ID_PLAYER else 0,  # AttackCycle
            0,  # TimerId
            combat_unit.guid if combat_unit else 0,  # Victim GUID
        ))

        # Normal update fields.
        data.extend(self._get_fields_update(True, requester))

        return data

    def get_partial_update_bytes(self, requester):
        data = bytearray()

        # Base structure.
        data.extend(self._get_base_structure(UpdateTypes.PARTIAL))

        # Normal update fields.
        data.extend(self._get_fields_update(False, requester))

        return data

    def get_heartbeat_packet(self):
        data = pack(
            '<2Q9fI',
            self.guid,
            self.transport_id,
            self.transport_location.x,
            self.transport_location.y,
            self.transport_location.z,
            self.transport_location.o,
            self.location.x,
            self.location.y,
            self.location.z,
            self.location.o,
            self.pitch,
            self.movement_flags,
        )
        return PacketWriter.get_packet(OpCode.MSG_MOVE_HEARTBEAT, data)

    def get_movement_update_bytes(self):
        # Base structure.
        data = self._get_base_structure(UpdateTypes.MOVEMENT)

        # Movement update fields.
        data += self._get_movement_fields()

        return data

    def is_active_object(self):
        return False

    def get_name(self):
        return ''

    def get_display_id(self):
        return self.current_display_id

    def set_display_id(self, display_id):
        self.current_display_id = display_id
        return True

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
        # Reset updated fields.
        self.update_packet_factory.reset()

    def reset_fields_older_than(self, timestamp):
        # Reset updated fields older than the specified timestamp.
        return self.update_packet_factory.reset_older_than(timestamp)

    def force_fields_update(self):
        # TODO - This method is a hackfix for force-updating single fields.
        #  Implement something like the following instead:
        # self.set_uint32(field_index, 0, force=true)
        self.get_map().update_object(self, has_changes=True)

    def _get_base_structure(self, update_type):
        return pack(
            '<IBQ',
            1,  # Number of transactions
            update_type,
            self.guid,
        )

    # Fall Time (Not implemented for units, anim progress for transports).
    # noinspection PyMethodMayBeStatic
    def get_fall_time(self):
        return 0

    def _get_movement_fields(self):
        data = pack(
            '<Q9fI',
            self.transport_id,
            self.transport_location.x,
            self.transport_location.y,
            self.transport_location.z,
            self.transport_location.o,
            self.location.x,
            self.location.y,
            self.location.z,
            self.location.o,
            self.pitch,
            self.movement_flags
        )

        is_unit = self.get_type_mask() & ObjectTypeFlags.TYPE_UNIT
        data += pack(
            '<I4f',
            self.get_fall_time(),
            self.walk_speed if is_unit else 1.0,
            self.running_speed if is_unit else 1.0,
            self.swim_speed if is_unit else 1.0,
            self.turn_rate if is_unit else 1.0,
         )

        # TODO: Not working.
        # if self.movement_flags & MoveFlags.MOVEFLAG_SPLINE_MOVER:
        #     data += self.movement_spline.to_bytes()

        return data

    def _get_fields_update(self, is_create, requester):
        data = bytearray()
        mask = self.update_packet_factory.update_mask.copy()
        for field_index in range(self.update_packet_factory.update_mask.field_count):
            # Partial packets only care for fields that had changes.
            if not is_create and mask[field_index] == 0:
                continue
            # Check for encapsulation, turn off the bit if requester has no read access.
            if not self.update_packet_factory.has_read_rights_for_field(field_index, requester):
                mask[field_index] = 0
                continue
            # Append field value and turn on bit on mask.
            data.extend(self.update_packet_factory.update_values_bytes[field_index])
            mask[field_index] = 1
        return pack('<B', self.update_packet_factory.update_mask.block_count) + mask.tobytes() + data

    # noinspection PyMethodMayBeStatic
    def is_aura_field(self, index):
        return UnitFields.UNIT_FIELD_AURA <= index <= UnitFields.UNIT_FIELD_AURA + 55

    def set_int32(self, index, value, force=False):
        if force or self.update_packet_factory.should_update(index, value, 'i'):
            self.update_packet_factory.update(index, value, 'i')

    def get_int32(self, index):
        return self._get_value_by_type_at('i', index)

    def set_uint32(self, index, value, force=False):
        if force or self.update_packet_factory.should_update(index, value, 'I'):
            self.update_packet_factory.update(index, value, 'I')

    def get_uint32(self, index):
        return self._get_value_by_type_at('I', index)

    def set_int64(self, index, value, force=False):
        if force or self.update_packet_factory.should_update(index, value, 'q'):
            self.update_packet_factory.update(index, value, 'q')

    def get_int64(self, index):
        return self._get_value_by_type_at('q', index)

    def set_uint64(self, index, value, force=False):
        if force or self.update_packet_factory.should_update(index, value, 'Q'):
            self.update_packet_factory.update(index, value, 'Q')

    def get_uint64(self, index):
        return self._get_value_by_type_at('Q', index)

    def set_float(self, index, value, force=False):
        if force or self.update_packet_factory.should_update(index, value, 'f'):
            self.update_packet_factory.update(index, value, 'f')

    def get_float(self, index):
        return self._get_value_by_type_at('f', index)

    def _get_value_by_type_at(self, value_type, index):
        if not self.update_packet_factory.update_values[index]:
            return 0

        # Return the raw value directly if not 64 bits.
        if value_type.lower() != 'q':
            return self.update_packet_factory.update_values[index]

        # Unpack from two field bytes.
        value = self.update_packet_factory.update_values_bytes[index]
        if value_type.lower() == 'q':
            value += self.update_packet_factory.update_values_bytes[index + 1]

        return unpack(f'<{value_type}', value)[0]

    # override
    def update(self, now):
        pass

    # override
    def initialize_field_values(self):
        pass

    # override
    def on_cell_change(self):
        pass

    def get_low_guid(self):
        return self.guid & ~GuidUtils.extract_high_guid(self.guid)

    # override
    def get_type_mask(self):
        return ObjectTypeFlags.TYPE_OBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_OBJECT

    # override
    def get_debug_messages(self, requester=None):
        return [
            f'Guid: {self.get_low_guid()}, Entry: {self.entry}, Display ID: {self.current_display_id}',
            f'X: {self.location.x:.3f}, Y: {self.location.y:.3f}, Z: {self.location.z:.3f}, O: {self.location.o:.3f}',
            f'Distance: {self.location.distance(requester.location) if requester else 0} yd'
        ]

    # override
    def generate_object_guid(self, low_guid):
        pass

    # override
    def despawn(self, ttl=0):
        self.is_spawned = False
        if self.spell_manager:
            self.spell_manager.remove_casts()
        if self.object_ai:
            self.object_ai.just_despawned()
        # Destroy completely.
        if self.is_default and not ttl:
            self.get_map().remove_object(self)
            return
        # Despawn (De-activate)
        self.get_map().update_object(self, has_changes=True)

    # override
    def respawn(self):
        self.is_spawned = True
        self.get_map().update_object(world_object=self, has_changes=True)

    def get_map(self):
        from game.world.managers.maps.MapManager import MapManager
        return MapManager.get_map(self.map_id, self.instance_id)

    # override
    def is_above_water(self):
        return False

    # override
    def is_under_water(self):
        liquid_information = self.get_map().get_liquid_information(self.location.x, self.location.y, self.location.z)
        return liquid_information and self.location.z + (self.current_scale * 1.8) < liquid_information.height

    # override
    def is_in_deep_water(self):
        liquid_information = self.get_map().get_liquid_information(self.location.x, self.location.y, self.location.z)
        return liquid_information and liquid_information.liquid_type == LiquidTypes.DEEP

    def is_casting(self):
        return self.spell_manager.is_casting()

    # override
    def is_totem(self):
        return False

    # override
    def is_pet(self):
        return False

    # override
    def is_temp_summon(self):
        return False

    # override
    def is_unit_pet(self, unit):
        return False

    def can_attack_target(self, target):
        if not target:
            return False

        if target is self:
            return False

        # You can only attack units, not gameobjects.
        if not target.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            return False

        # Sanctuary.
        if target.unit_state & UnitStates.SANCTUARY:
            return False

        # Flight.
        if target.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            return False

        if self.unit_flags & UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED and \
                target.unit_flags & UnitFlags.UNIT_FLAG_NOT_ATTACKABLE_OCC:
            return False

        # Creature only checks.
        elif target.get_type_id() == ObjectTypeIds.ID_UNIT and not target.is_spawned:
            return False

        if not target.is_alive:
            return False

        return self._allegiance_status_checker(target) < UnitReaction.UNIT_REACTION_AMIABLE

    # Implemented by UnitManager.
    # Returns 1. if the target can be detected and 2. if alert should happen (AI reaction).
    def can_detect_target(self, target, distance):
        return True, False

    # Implemented by UnitManager.
    def get_charmer_or_summoner(self, include_self=False):
        return self if include_self else None

    def _allegiance_status_checker(self, target) -> UnitReaction:
        own_faction = DbcDatabaseManager.FactionTemplateHolder.faction_template_get_by_id(self.faction)
        target_faction = DbcDatabaseManager.FactionTemplateHolder.faction_template_get_by_id(target.faction)

        if not own_faction:
            Logger.warning(f'Invalid faction template: {self.faction}.')
            return UnitReaction.UNIT_REACTION_NEUTRAL

        if not target_faction:
            Logger.warning(f'Invalid faction template: {target.faction}.')
            return UnitReaction.UNIT_REACTION_NEUTRAL

        # TODO: Reputation standing checks first.

        if target_faction.FactionGroup & own_faction.EnemyGroup != 0:
            return UnitReaction.UNIT_REACTION_HOSTILE

        own_enemies = {own_faction.Enemies_1, own_faction.Enemies_2, own_faction.Enemies_3, own_faction.Enemies_4}
        if target_faction.Faction > 0 and target_faction.Faction in own_enemies:
            return UnitReaction.UNIT_REACTION_HOSTILE

        if target_faction.FactionGroup & own_faction.FriendGroup != 0:
            return UnitReaction.UNIT_REACTION_FRIENDLY

        own_friends = {own_faction.Friend_1, own_faction.Friend_2, own_faction.Friend_3, own_faction.Friend_4}
        if target_faction.Faction > 0 and target_faction.Faction in own_friends:
            return UnitReaction.UNIT_REACTION_FRIENDLY

        if target_faction.FriendGroup & own_faction.FactionGroup != 0:
            return UnitReaction.UNIT_REACTION_FRIENDLY

        other_friends = {target_faction.Friend_1, target_faction.Friend_2, target_faction.Friend_3, target_faction.Friend_4}
        if own_faction.Faction > 0 and own_faction.Faction in other_friends:
            return UnitReaction.UNIT_REACTION_FRIENDLY

        return UnitReaction.UNIT_REACTION_NEUTRAL

    def is_friendly_to(self, target):
        return self._allegiance_status_checker(target) >= UnitReaction.UNIT_REACTION_NEUTRAL

    def is_hostile_to(self, target):
        return self._allegiance_status_checker(target) < UnitReaction.UNIT_REACTION_NEUTRAL

    def get_destroy_packet(self):
        data = pack('<Q', self.guid)
        return PacketWriter.get_packet(OpCode.SMSG_DESTROY_OBJECT, data)
