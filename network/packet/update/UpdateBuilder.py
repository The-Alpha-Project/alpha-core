from enum import IntEnum
from multiprocessing import RLock
from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds
from utils.constants.OpCodes import OpCode


class UpdateBuilder:
    def __init__(self, player_mgr):
        self._player_mgr = player_mgr
        self._implements_known_players = {ObjectTypeIds.ID_UNIT, ObjectTypeIds.ID_GAMEOBJECT}
        self._implements_query_details = {ObjectTypeIds.ID_PLAYER, ObjectTypeIds.ID_UNIT, ObjectTypeIds.ID_GAMEOBJECT}
        self._create_guids = set()  # Objects guids with create update for this tick.
        self._partial_guids = set()  # Objects guids with partial update for this tick.
        self._linked_known_objects_updates = set()  # Objects know each other.
        self._owner_known_objects_updates = set()  # Only the player knows about the object.
        self._destroy_objects_updates = set()  # Objects no longer active to the player.
        self._active_objects = set()  # Objects which are active to the player (visible).
        self._packets = dict()
        self.update_lock = RLock()

    def has_active_guid(self, guid):
        return guid in self._active_objects

    def clear_active_objects(self):
        self._active_objects.clear()

    def add_active_object(self, world_object):
        self._active_objects.add(world_object.guid)

    def pop_active_object(self, world_object):
        self._active_objects.discard(world_object.guid)

    def process_update(self):
        with self.update_lock:
            if self._has_update_fields_updates():
                self._player_mgr.enqueue_packets(self._get_build_all_packets())

            if self._has_known_objects_updates():
                self._process_known_objects_updates()

            if self._has_destroy_objects_updates():
                self._process_destroy_objects()

    def add_create_update_from_object(self, world_object):
        self._create_guids.add(world_object.guid)
        obj_type = world_object.get_type_id()

        # Specific query details given the object type.
        if obj_type not in self._implements_query_details:
            self._add_world_object_detail_query_from_object(world_object)

        # Player inventory updates.
        if obj_type == ObjectTypeIds.ID_PLAYER:
            self._add_inventory_updates_from_player(world_object)

        # Create packet bytes.
        self._add_packet(world_object.get_create_update_bytes(requester=self._player_mgr), PacketType.CREATE)

        # Movement packets.
        if world_object.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            self._add_movement_update_from_unit(world_object)

        # Handle special doors case in which the real state is sent after the create packet in order to remove
        # collision.
        if world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            door_deferred_state_update = world_object.get_door_state_update_bytes()
            if door_deferred_state_update:
                self._add_packet(door_deferred_state_update, PacketType.PARTIAL_DEFERRED)

        # Player <-> Objects linked as known.
        if world_object.get_type_id() in self._implements_known_players:
            self._linked_known_objects_updates.add(world_object)
        # Only players need to know the object.
        else:
            self._owner_known_objects_updates.add(world_object)

    def add_partial_update_from_object(self, world_object, update_data=None):
        # If a create/partial packet already exists for the object, defer to next tick.
        packet_type = PacketType.PARTIAL if (world_object.guid not in self._create_guids
                                             and world_object.guid not in self._partial_guids) \
            else PacketType.PARTIAL_DEFERRED

        self._add_packet(world_object.get_partial_update_bytes(requester=self._player_mgr,
                                                               update_data=update_data), packet_type)

    def add_destroy_object_update(self, guid):
        self._destroy_objects_updates.add(guid)

    def _add_world_object_detail_query_from_object(self, world_object):
        self._add_packet(world_object.get_query_details_packet(), PacketType.QUERY)

    def _add_inventory_updates_from_player(self, player_mgr):
        item__queries, create_packets, partial_packets = player_mgr.get_inventory_update_packets(requester=self._player_mgr)
        self._add_packet(item__queries, PacketType.QUERY)
        self._add_packet(create_packets, PacketType.CREATE)
        self._add_packet(partial_packets, PacketType.PARTIAL)

    def _add_movement_update_from_unit(self, unit):
        # Get partial movement packet if any.
        movement_packet = unit.movement_manager.try_build_movement_packet()
        if movement_packet:
            self._add_packet(movement_packet, PacketType.MOVEMENT)

    # Generates one SMSG_UPDATE_OBJECT which includes all create and partial messages available at tick end.
    def _build_update_packet(self):
        update_type_create = self._packets.get(PacketType.CREATE, [])
        update_type_partial = self._packets.get(PacketType.PARTIAL, [])
        update_complete_bytes = update_type_create + update_type_partial

        if not update_complete_bytes:
            return []

        data = bytearray(pack('<I', len(update_complete_bytes)))  # Transaction count.
        for update_bytes in update_complete_bytes:
            data.extend(update_bytes)

        packet = PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, bytes(data))
        data.clear()

        return [packet]

    def _get_build_all_packets(self):
        with self.update_lock:
            packets = self._get_query_detail_packets() + self._build_update_packet() + self._get_movement_packets()
            self._enqueue_deferred_and_flush()
            return packets

    def _process_destroy_objects(self):
        with self.update_lock:
            while self._destroy_objects_updates:
                guid = self._destroy_objects_updates.pop()
                self._player_mgr.destroy_near_object(guid)

    def _process_known_objects_updates(self):
        with self.update_lock:
            # Both objects know each other.
            while self._linked_known_objects_updates:
                world_object = self._linked_known_objects_updates.pop()
                self._player_mgr.known_objects[world_object.guid] = world_object
                world_object.known_players[self._player_mgr.guid] = self._player_mgr
            # Player knows the object.
            while self._owner_known_objects_updates:
                world_object = self._owner_known_objects_updates.pop()
                self._player_mgr.known_objects[world_object.guid] = world_object

    def _add_packet(self, data, packet_type):
        with self.update_lock:
            if packet_type not in self._packets:
                self._packets[packet_type] = list()
            if isinstance(data, list):
                for packet in data:
                    self._packets[packet_type].append(packet)
            else:
                self._packets[packet_type].append(data)

    def _get_query_detail_packets(self):
        query_packets = self._packets.get(PacketType.QUERY, [])
        return query_packets

    def _get_movement_packets(self):
        movement_packets = self._packets.get(PacketType.MOVEMENT, [])
        return movement_packets

    def _has_update_fields_updates(self):
        return any(self._packets)

    def _has_destroy_objects_updates(self):
        return any(self._destroy_objects_updates)

    def _has_known_objects_updates(self):
        return any(self._linked_known_objects_updates) or any(self._owner_known_objects_updates)

    def _enqueue_deferred_and_flush(self):
        partial_deferred = self._packets.get(PacketType.PARTIAL_DEFERRED, [])
        self._packets.clear()
        self._create_guids.clear()
        self._partial_guids.clear()
        # If we had partial deferred updates, move them now, so they get sent next tick.
        if partial_deferred:
            self._packets[PacketType.PARTIAL] = partial_deferred


class PacketType(IntEnum):
    QUERY = 0
    INVENTORY = 1
    CREATE = 2
    PARTIAL = 3
    PARTIAL_DEFERRED = 4
    MOVEMENT = 5
