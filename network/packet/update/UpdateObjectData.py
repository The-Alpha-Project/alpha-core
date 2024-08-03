from enum import IntEnum
from struct import pack

from network.packet.PacketWriter import PacketWriter
from utils.constants.OpCodes import OpCode


class UpdateObjectData:
    def __init__(self):
        self.active_objects = dict()
        self.packets = dict()

    def has_active_guid(self, guid):
        return guid in self.active_objects

    def add_active_object(self, world_object):
        self.active_objects[world_object.guid] = world_object

    def pop_active_object(self, world_object):
        if world_object.guid in self.active_objects:
            del self.active_objects[world_object.guid]

    def add(self, data, packet_type):
        if packet_type not in self.packets:
            self.packets[packet_type] = list()
        if isinstance(data, list):
            for packet in data:
                self.packets[packet_type].append(packet)
        else:
            self.packets[packet_type].append(data)

    def _get_name_query_packets(self):
        return self.packets.get(PacketType.QUERY, [])

    def _get_movement_packets(self):
        return self.packets.get(PacketType.MOVEMENT, [])

    def has_updates(self):
        return any(self.packets)

    # Generates SMSG_UPDATE_OBJECT including all create and partial messages available.
    def _build_update_packet(self):
        update_type_create = self.packets.get(PacketType.CREATE, [])
        update_type_partial = self.packets.get(PacketType.PARTIAL, [])
        update_complete_bytes = update_type_create + update_type_partial

        if not update_complete_bytes:
            return None

        data = bytearray(pack('<I', len(update_complete_bytes)))  # Transaction count.
        for update_packet in update_complete_bytes:
            data.extend(update_packet)  # Update packet.

        packet = PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, data)
        data.clear()

        return packet

    def build_all_packets(self):
        return self._get_name_query_packets() + self._build_update_packet() + self._get_movement_packets()

    # Deferred updates are only needed for doors collision bug, we cannot send both create and partial updates
    # with different state flag on the same SMSG_UPDATE_OBJECT packet, we need to first create, and then
    # notify the real door state upon next tick.
    def flush(self):
        partial_deferred = self.packets.get(PacketType.PARTIAL_DEFERRED, [])
        self.packets.clear()
        # If we had partial deferred updates, move now, so they get sent next tick.
        if partial_deferred:
            self.packets[PacketType.PARTIAL] = partial_deferred


class PacketType(IntEnum):
    QUERY = 0
    INVENTORY = 1
    CREATE = 2
    PARTIAL = 3
    PARTIAL_DEFERRED = 4
    MOVEMENT = 5
