from enum import IntEnum
from multiprocessing import RLock
from struct import pack

from game.world.managers.objects.gameobjects.utils.GoQueryUtils import GoQueryUtils
from game.world.managers.objects.units.creature.utils.UnitQueryUtils import UnitQueryUtils
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import PacketWriter
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds
from utils.constants.OpCodes import OpCode


class UpdateBuilder:
    def __init__(self, owner):
        self.owner = owner
        self.active_objects = dict()
        self.packets = dict()
        self.lock = RLock()

    def has_active_guid(self, guid):
        return guid in self.active_objects

    def add_active_object(self, world_object):
        self.active_objects[world_object.guid] = world_object

    def pop_active_object(self, world_object):
        if world_object.guid in self.active_objects:
            del self.active_objects[world_object.guid]

    def add(self, data, packet_type):
        with self.lock:
            if packet_type not in self.packets:
                self.packets[packet_type] = list()
            if isinstance(data, list):
                for packet in data:
                    self.packets[packet_type].append(packet)
            else:
                self.packets[packet_type].append(data)

    def _get_name_query_packets(self):
        query_packets = self.packets.get(PacketType.QUERY, [])
        print(f'Sending {len(query_packets)} query packets')
        return query_packets

    def _get_movement_packets(self):
        movement_packets = self.packets.get(PacketType.MOVEMENT, [])
        print(f'Sending {len(movement_packets)} movement packets')
        return movement_packets

    def add_partial_update_from_object(self, world_object, update_data=None):
        self.add(world_object.get_partial_update_bytes(requester=self.owner, update_data=update_data),
                 PacketType.PARTIAL)

    def add_create_update_from_object(self, world_object):
        if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Retrieve their name detail query.
            self.add_player_name_query_from_player(world_object)
            # Retrieve their inventory updates.
            self.add_inventory_updates_from_player(world_object)

        # Create packet.
        self.add(world_object.get_create_update_bytes(requester=self.owner), PacketType.CREATE)

        # Movement packets.
        if world_object.get_type_mask() & ObjectTypeFlags.TYPE_UNIT:
            self.add_movement_update_from_unit(world_object)

        # Deferred updates are only needed for doors collision bug, we cannot send both create and partial updates
        # with different state flag on the same SMSG_UPDATE_OBJECT packet, we need to first create, and then
        # notify the real door state upon next tick.
        if world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            door_deferred_state_update = world_object.get_door_state_update_bytes()
            if door_deferred_state_update:
                self.add(door_deferred_state_update, PacketType.PARTIAL_DEFERRED)

    def add_player_name_query_from_player(self, player_mgr):
        self.add(NameQueryHandler.get_query_details(player_mgr.player), PacketType.QUERY)

    def add_inventory_updates_from_player(self, player_mgr):
        item__queries, create_packets, partial_packets = player_mgr.get_inventory_update_packets(requester=self.owner)
        self.add(item__queries, PacketType.QUERY)
        self.add(create_packets, PacketType.CREATE)
        self.add(partial_packets, PacketType.PARTIAL)

    def add_movement_update_from_unit(self, unit):
        # Get partial movement packet if any.
        movement_packet = unit.movement_manager.try_build_movement_packet()
        if movement_packet:
            self.add(movement_packet, PacketType.MOVEMENT)

    def add_detail_query_from_gobject(self, gobject):
        self.add(GoQueryUtils.query_details(gameobject_mgr=gobject), PacketType.QUERY)

    def add_detail_query_from_creature(self, creature):
        self.add(UnitQueryUtils.query_details(creature_mgr=creature), PacketType.QUERY)

    def has_updates(self):
        return any(self.packets)

    # Generates SMSG_UPDATE_OBJECT including all create and partial messages available.
    def _build_update_packet(self):
        update_type_create = self.packets.get(PacketType.CREATE, [])
        print(f'Sending {len(update_type_create)} create packets')
        update_type_partial = self.packets.get(PacketType.PARTIAL, [])
        print(f'Sending {len(update_type_partial)} partial packets')

        update_complete_bytes = update_type_create + update_type_partial

        if not update_complete_bytes:
            return []

        data = bytearray(pack('<I', len(update_complete_bytes)))  # Transaction count.
        for update_packet in update_complete_bytes:
            data.extend(update_packet)  # Update packet.

        packet = PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, data)
        data.clear()

        return [packet]

    def get_build_all_packets(self, flush=True):
        with self.lock:
            packets = self._get_name_query_packets() + self._build_update_packet() + self._get_movement_packets()
            if flush:
                self.flush()
            return packets

    def flush(self):
        partial_deferred = self.packets.get(PacketType.PARTIAL_DEFERRED, [])
        self.packets.clear()
        # If we had partial deferred updates, move them now, so they get sent next tick.
        if partial_deferred:
            self.packets[PacketType.PARTIAL] = partial_deferred


class PacketType(IntEnum):
    QUERY = 0
    INVENTORY = 1
    CREATE = 2
    PARTIAL = 3
    PARTIAL_DEFERRED = 4
    MOVEMENT = 5
