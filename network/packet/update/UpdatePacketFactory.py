import time
from struct import pack

from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdateMask import UpdateMask
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import GameObjectFields, UnitFields


# noinspection PyMethodMayBeStatic
class UpdatePacketFactory(object):
    def __init__(self):
        self.fields_size = 0
        self.update_timestamps = []
        self.update_values = []
        self.update_mask = UpdateMask()

    def init_values(self, fields_size):
        self.fields_size = fields_size
        self.update_timestamps = [0] * self.fields_size
        self.update_values = [b'\x00\x00\x00\x00'] * self.fields_size
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

    def update(self, index, value, value_type):
        if value_type.lower() == 'q':
            self.update(index, int(value & 0xFFFFFFFF), 'I')
            self.update(index + 1, int(value >> 32), 'I')
        else:
            self.update_timestamps[index] = time.time()
            self.update_values[index] = pack(f'<{value_type}', value)
            self.update_mask.set_bit(index)

    def is_dynamic_field(self, index):
        # TODO: Check more cases?
        return index == GameObjectFields.GAMEOBJECT_DYN_FLAGS

    def is_aura_field(self, index):
        return UnitFields.UNIT_FIELD_AURA <= index <= UnitFields.UNIT_FIELD_AURA + 55

    @staticmethod
    def compress_if_needed(update_packet):
        if len(update_packet) > 100:
            compressed_packet_data = PacketWriter.deflate(update_packet[6:])
            compressed_data = pack('<I', len(update_packet) - 6)
            compressed_data += compressed_packet_data
            update_packet = PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, compressed_data)
        return update_packet
