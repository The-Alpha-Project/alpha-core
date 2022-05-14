import time
from struct import pack

from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdateMask import UpdateMask
from utils.constants.OpCodes import OpCode


class UpdatePacketFactory(object):
    def __init__(self):
        self.fields_size = 0
        self.update_timestamps = []  # Timestamps for each field once it's touched.
        self.update_values_bytes = []  # Values bytes representation, used for update packets.
        self.update_values = []  # Raw values, used to compare current vs new without having to pack or unpack.
        self.update_mask = UpdateMask()
        self.allow_override = False   # Allow players to override values when they need to receive a create packet.

    def init_values(self, fields_size):
        self.fields_size = fields_size
        self.update_timestamps = [0] * self.fields_size
        self.update_values_bytes = [b'\x00\x00\x00\x00'] * self.fields_size
        self.update_values = [0] * self.fields_size
        self.update_mask.set_count(self.fields_size)

    def reset(self):
        self.update_mask.clear()

    def has_pending_updates(self):
        return not self.update_mask.is_empty()

    def reset_older_than(self, timestamp_to_compare):
        all_clear = True
        for index, timestamp in enumerate(self.update_timestamps):
            if timestamp == 0:
                continue

            if timestamp <= timestamp_to_compare:
                self.update_mask.unset_bit(index)
            else:
                all_clear = False

        return all_clear

    def set_override_state(self, state):
        self.allow_override = state

    # Check if the new value is different from the field known value.
    def should_update(self, index, value, value_type):
        # Allow values to be written, even if they did not change.
        if self.allow_override and value != 0:
            return True

        if value_type.lower() == 'q':
            field_0 = int(value & 0xFFFFFFFF)
            field_1 = int(value >> 32)
            return self.update_values[index] != field_0 or self.update_values[index + 1] != field_1
        else:
            return self.update_values[index] != value

    def update(self, index, value, value_type):
        if value_type.lower() == 'q':
            self.update(index, int(value & 0xFFFFFFFF), 'I')
            self.update(index + 1, int(value >> 32), 'I')
        else:
            self.update_timestamps[index] = time.time()
            self.update_values[index] = value
            self.update_values_bytes[index] = pack(f'<{value_type}', value)
            self.update_mask.set_bit(index)

    @staticmethod
    def compress_if_needed(update_packet):
        if len(update_packet) > 100:
            compressed_packet_data = PacketWriter.deflate(update_packet[6:])
            compressed_data = pack('<I', len(update_packet) - 6)
            compressed_data += compressed_packet_data
            update_packet = PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, compressed_data)
        return update_packet
