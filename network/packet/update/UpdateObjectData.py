from enum import IntEnum
from struct import pack

from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.MiscCodes import UpdateTypes
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

    def push_packets(self, packets, packet_type):
        for packet in packets:
            self.push_packet(packet, packet_type)

    def push_packet(self, packet, packet_type):
        if packet_type not in self.packets:
            self.packets[packet_type] = list()
        self.packets[packet_type].append(packet)

    def get_inventory_update_packets(self):
        return self.packets.get(PacketType.INVENTORY, [])

    def get_name_query_packets(self):
        return self.packets.get(PacketType.QUERY, [])

    def get_movement_packets(self):
        return self.packets.get(PacketType.MOVEMENT, [])

    # Generates SMSG_UPDATE_OBJECT including all create and partial messages available.
    def build_create_packet(self):
        update_type_create = self.packets.get(PacketType.CREATE, [])
        update_type_partial = self.packets.get(PacketType.PARTIAL, [])

        print(f'Create packets {len(update_type_create)}')
        print(f'Partial packets {len(update_type_partial)}')

        update_complete_bytes = update_type_create + update_type_partial

        if not update_complete_bytes:
            return None

        # How many objects are being created.
        transaction_count = len(update_complete_bytes)
        print(transaction_count)

        # Header.
        data = bytearray(pack('<I', len(update_complete_bytes)))
        for creature_packet_bytes in update_complete_bytes:
            data.extend(creature_packet_bytes)

        packet = PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, data)
        print(len(packet))
        print('--')
        data.clear()

        return packet


class PacketType(IntEnum):
    QUERY = 0
    INVENTORY = 1
    CREATE = 2
    PARTIAL = 3
    MOVEMENT = 4
