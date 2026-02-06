from enum import IntEnum
from struct import pack, pack_into
from threading import RLock

from database.world.WorldDatabaseManager import WorldDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.ObjectQueryUtils import ObjectQueryUtils
from utils.constants.MiscCodes import ObjectTypeIds, GameObjectStates
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import GameObjectFields


class UpdateBuilder:
    def __init__(self, player_mgr):
        self._player_mgr = player_mgr
        self._implements_known_players = {ObjectTypeIds.ID_UNIT, ObjectTypeIds.ID_GAMEOBJECT}
        self._implements_query_details = {ObjectTypeIds.ID_PLAYER, ObjectTypeIds.ID_UNIT, ObjectTypeIds.ID_GAMEOBJECT}
        self._create_guids = set()  # Objects guids with create update for this tick.
        self._create_linked_known_objects_updates = set()  # Objects know each other.
        self._create_owner_known_objects_updates = set()  # Only the player knows about the object.
        self._destroy_linked_known_objects_updates = set()  # Objects know each other.
        self._destroy_owner_known_objects_updates = set()  # Only the player knows about the object.
        self._destroy_known_items = set()  # Items from players no longer visible.
        self._active_objects = set()  # Objects which are active to the player (visible).
        self._packets = dict()
        self._lock = RLock()

    def has_active_guid(self, guid):
        with self._lock:
            return guid in self._active_objects

    def clear_active_objects(self):
        with self._lock:
            self._active_objects.clear()

    def add_active_object(self, world_object):
        with self._lock:
            self._active_objects.add(world_object.guid)

    def pop_active_object(self, world_object):
        with self._lock:
            self._active_objects.discard(world_object.guid)

    def process_update(self):
        with self._lock:
            # Query detail, destroy, movement and SMSG_UPDATE_OBJECT packets.
            if self._has_pending_update_packets():
                self._player_mgr.enqueue_packets(self._get_build_all_packets())

            # Relation between objects after creation.
            if self._has_create_known_objects_updates():
                self._process_known_objects_updates()

            # Relation between objects after destruction.
            if self._has_destroy_known_objects_updates():
                self._process_destroy_known_objects_updates()

            # Player known items after owner destruction.
            if self._has_destroy_known_items_updates():
                self._process_destroy_known_items_updates()

    def add_create_update_from_object(self, world_object):
        with self._lock:
            self._create_guids.add(world_object.guid)
            obj_type = world_object.get_type_id()

            # Specific query details given the object type.
            if obj_type in self._implements_query_details:
                self._add_world_object_detail_query_from_object(world_object)
                # Send units virtual items detail queries.
                if obj_type == ObjectTypeIds.ID_UNIT:
                    item_entries = world_object.get_virtual_equipment_entries(filtered=True)
                    for entry in item_entries:
                        self._add_virtual_item_detail_query_from_entry(world_object, entry)

            # Player inventory updates.
            if obj_type == ObjectTypeIds.ID_PLAYER:
                self._add_inventory_updates_from_player(world_object)

            update_data = None
            defer_bytes_1 = False
            defer_door_state = False
            door_deferred_state_update = None

            # Doors: send as ready on create, then send the real state.
            if world_object.is_gameobject():
                door_deferred_state_update = world_object.get_door_state_update_bytes()
                if door_deferred_state_update:
                    if not world_object.initialized:
                        world_object.initialize_field_values()
                    update_data = world_object.update_packet_factory.generate_update_data()
                    pack_into('<I', update_data.update_field_values,
                              GameObjectFields.GAMEOBJECT_STATE * 4,
                              GameObjectStates.GO_STATE_READY)
                    defer_door_state = True

            # Units: send a deferred bytes_1 update after create to refresh sheath state.
            if world_object.is_unit():
                if world_object.has_virtual_equipment():
                    defer_bytes_1 = True

            # Create packet bytes.
            self._add_packet(
                world_object.get_create_update_bytes(requester=self._player_mgr, update_data=update_data),
                PacketType.CREATE
            )

            # Movement packets.
            if world_object.is_unit(by_mask=True):
                self._add_movement_update_from_unit(world_object)

            # Handle special doors case in which the real state is sent after create packet in order to remove collision.
            if defer_door_state and door_deferred_state_update:
                self._add_packet(door_deferred_state_update, PacketType.PARTIAL_DEFERRED)

            # Handle special Units bytes_1 field in which the real sheath state is sent after create.
            if defer_bytes_1:
                bytes_1_deferred_state_update = world_object.get_bytes_1_state_update_bytes()
                self._add_packet(bytes_1_deferred_state_update, PacketType.PARTIAL_DEFERRED)

            # Player <-> Objects linked as known.
            if obj_type in self._implements_known_players:
                self._create_linked_known_objects_updates.add(world_object)
            # Only players need to know the object.
            else:
                self._create_owner_known_objects_updates.add(world_object)

    def add_partial_update_from_bytes(self, bytes_):
        with self._lock:
            self._add_packet(bytes_, packet_type=PacketType.PARTIAL)

    def add_partial_update_from_object(self, world_object, update_data=None):
        with self._lock:
            # If create packet already exists for the object, defer to next tick.
            packet_type = PacketType.PARTIAL if world_object.guid not in self._create_guids else PacketType.PARTIAL_DEFERRED
            self._add_packet(world_object.get_partial_update_bytes(requester=self._player_mgr,
                                                                   update_data=update_data), packet_type)

    def add_destroy_update_from_object(self, world_object):
        with self._lock:
            object_type = world_object.get_type_id()
            is_player = object_type == ObjectTypeIds.ID_PLAYER

            if object_type in self._implements_known_players:
                self._destroy_linked_known_objects_updates.add(world_object)
            else:
                self._destroy_owner_known_objects_updates.add(world_object)

            # Destroy other player items for self.
            if is_player:
                destroy_packets = world_object.get_inventory_destroy_packets(requester=self._player_mgr)
                for guid in destroy_packets.keys():
                    self._destroy_known_items.add(guid)
                self._add_packet(list(destroy_packets.values()), PacketType.DESTROY)

            # Destroy world object from self.
            self._add_packet(world_object.get_destroy_packet(), PacketType.DESTROY)

            # Destroyed a player which is in our party, update party stats.
            # We do this here because we need to make sure client no longer knows the player object if it went offline.
            if (is_player and self._player_mgr.group_manager
                    and self._player_mgr.group_manager.is_party_member(world_object.guid)):
                self._player_mgr.group_manager.send_update()

    def _add_virtual_item_detail_query_from_entry(self, unit, entry):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
        if not item_template:
            Logger.warning(f'Invalid virtual item {entry}, Unit: {unit.get_name()}, Spawn: {unit.spawn_id}')
            return
        query_data = ObjectQueryUtils.get_query_details_data(template=item_template)
        query_packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data)
        self._add_packet(query_packet, PacketType.QUERY)

    def _add_world_object_detail_query_from_object(self, world_object):
        self._add_packet(world_object.get_query_details_packet(), PacketType.QUERY)

    def _add_inventory_updates_from_player(self, player_mgr):
        item_queries, item_create_packets, item_partial_packets = (
            player_mgr.get_inventory_update_packets(requester=self._player_mgr))
        self._add_packet(item_queries, PacketType.QUERY)
        self._add_packet(item_create_packets, PacketType.CREATE)
        self._add_packet(item_partial_packets, PacketType.PARTIAL)

    def _add_movement_update_from_unit(self, unit):
        # Get partial movement packet if any.
        movement_packet = unit.movement_manager.try_build_movement_packet()
        if movement_packet:
            self._add_packet(movement_packet, PacketType.MOVEMENT)

    # Generates SMSG_UPDATE_OBJECT packets which includes all create and partial messages available at tick end.
    def _build_update_packets(self):
        update_type_create = self._packets.get(PacketType.CREATE, [])
        update_type_partial = self._packets.get(PacketType.PARTIAL, [])
        update_complete_bytes = update_type_create + update_type_partial

        if not update_complete_bytes:
            return []

        total_bytes = sum([len(b) for b in update_complete_bytes])
        packets = []
        transactions = 0
        data = bytearray()
        for update_bytes in update_complete_bytes:
            # If data exceeds uint16, split packets. (Account for opcode 4 bytes)
            if len(data) + len(update_bytes) > 65531:
                packet_bytes = bytearray(pack('<I', transactions)) + data
                packets.append(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, packet_bytes))
                transactions = 0
                data.clear()
            data.extend(update_bytes)
            transactions += 1

        if data:
            packet_bytes = bytearray(pack('<I', transactions)) + data
            packets.append(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, packet_bytes))

        data.clear()

        return packets

    def _get_build_all_packets(self):
        packets = self._get_query_detail_packets() + self._build_update_packets() + self._get_movement_packets() + self._get_destroy_packets()
        self._enqueue_deferred_and_flush()
        return packets

    def _process_destroy_known_items_updates(self):
        while self._destroy_known_items:
            guid = self._destroy_known_items.pop()
            if guid in self._player_mgr.known_items:
                del self._player_mgr.known_items[guid]

    def _process_destroy_known_objects_updates(self):
            while self._destroy_owner_known_objects_updates:
                world_object = self._destroy_owner_known_objects_updates.pop()
                self._player_mgr.known_objects.pop(world_object.guid, None)
                if world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
                    self._remove_threats(world_object)

            while self._destroy_linked_known_objects_updates:
                world_object = self._destroy_linked_known_objects_updates.pop()
                self._player_mgr.known_objects.pop(world_object.guid, None)
                world_object.known_players.pop(self._player_mgr.guid, None)
                if world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
                    self._remove_threats(world_object)

    def _remove_threats(self, world_object):
        # Helper method to remove threats.
        world_object.threat_manager.remove_unit_threat(self._player_mgr)
        self._player_mgr.threat_manager.remove_unit_threat(world_object)

    def _process_known_objects_updates(self):
        # Both objects know each other.
        while self._create_linked_known_objects_updates:
            world_object = self._create_linked_known_objects_updates.pop()
            self._player_mgr.known_objects[world_object.guid] = world_object
            world_object.known_players[self._player_mgr.guid] = self._player_mgr
        # Player knows the object.
        while self._create_owner_known_objects_updates:
            world_object = self._create_owner_known_objects_updates.pop()
            self._player_mgr.known_objects[world_object.guid] = world_object

    def _add_packet(self, data, packet_type):
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

    def _get_destroy_packets(self):
        destroy_packets = self._packets.get(PacketType.DESTROY, [])
        return destroy_packets

    def _has_pending_update_packets(self):
        return any(self._packets)

    def _has_destroy_known_items_updates(self):
        return any(self._destroy_known_items)

    def _has_destroy_known_objects_updates(self):
        return any(self._destroy_linked_known_objects_updates) or any(self._destroy_owner_known_objects_updates)

    def _has_create_known_objects_updates(self):
        return any(self._create_linked_known_objects_updates) or any(self._create_owner_known_objects_updates)

    def _enqueue_deferred_and_flush(self):
        partial_deferred = self._packets.get(PacketType.PARTIAL_DEFERRED, [])
        self._packets.clear()
        self._create_guids.clear()
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
    DESTROY = 6
