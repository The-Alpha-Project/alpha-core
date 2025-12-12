import time
from struct import pack
from network.packet.update.UpdateData import UpdateData
from network.packet.update.UpdateMask import UpdateMask
from utils.Logger import Logger
from utils.constants.UpdateFields import EncapsulationType, ObjectFields

FIELDS_ENCAPSULATION = {}  # { field_type : { index : encapsulation} }
DEBUG_INFORMATION = {}  # Debug.


class UpdatePacketFactory:
    def __init__(self):
        self.owner_guid = 0
        self.fields_size = 0
        self.fields_type = None
        self.update_timestamps = []  # Timestamps for each field once it's touched.
        self.update_values_bytes = []  # Values bytes representation, used for update packets.
        self.update_values = []  # Raw values, used to compare current vs new without having to pack or unpack.
        self.update_mask = UpdateMask()

    def init_values(self, owner_guid, fields_type):
        self.owner_guid = owner_guid
        self.fields_type = fields_type
        self.fields_size = fields_type.END.value
        self.update_timestamps = [0] * self.fields_size
        self.update_values_bytes = [b'\x00\x00\x00\x00'] * self.fields_size
        self.update_values = [0] * self.fields_size
        self.update_mask.set_count(self.fields_size)
        self._load_encapsulation(fields_type)

    @staticmethod
    def _load_encapsulation(fields_type):
        # Cache encapsulation for each fields_type to avoid recomputation.
        if fields_type in FIELDS_ENCAPSULATION:
            return FIELDS_ENCAPSULATION[fields_type]

        # Initialize dictionaries for encapsulation and related info.
        FIELDS_ENCAPSULATION[fields_type] = {}
        DEBUG_INFORMATION[fields_type] = {}

        # Collect all involved update field types from the current type up to ObjectFields.
        update_field_types = []

        # Start from the provided fields_type.
        current_type = fields_type

        # Traverse parent fields until reaching ObjectFields.
        while True:
            update_field_types.insert(0, current_type)
            if current_type == ObjectFields:
                break
            current_type = current_type.parent_fields()

        # Process each update field type in order.
        for index, update_type in enumerate(update_field_types):
            for update_field in update_type:
                # For each component in the update field, store encapsulation info.
                for offset in range(update_field.size):
                    field_index = update_field.value + offset
                    field_str_value = f"[{field_index}] {update_field.name}_{offset} - [{update_field.flags.name}]"
                    # Store debugging info for each field.
                    DEBUG_INFORMATION[fields_type][field_index] = field_str_value
                    # Store the encapsulation flags for the field.
                    FIELDS_ENCAPSULATION[fields_type][field_index] = update_field.flags

        return FIELDS_ENCAPSULATION[fields_type]

    def is_dynamic_field(self, index):
        if not self._validate_field_existence(index):
            return False

        return FIELDS_ENCAPSULATION[self.fields_type][index] == EncapsulationType.DYNAMIC

    def has_read_rights_for_field(self, index, requester):
        if not self._validate_field_existence(index):
            return False

        if requester.guid != self.owner_guid and FIELDS_ENCAPSULATION[self.fields_type][index] == EncapsulationType.PRIVATE:
            # self._debug_field_acquisition(requester, index, was_protected=True)
            return False

        # self._debug_field_acquisition(requester, index, was_protected=False)
        return True

    def _validate_field_existence(self, index):
        if self.fields_type not in FIELDS_ENCAPSULATION:
            return False
        return index in FIELDS_ENCAPSULATION[self.fields_type]

    # Debug what UpdateFields players sees from self, other player, units, items, gameobjects, etc.
    def _debug_field_acquisition(self, requester, index, was_protected):
        update_field_info = DEBUG_INFORMATION[self.fields_type][index]
        result = {'[PROTECTED]' if was_protected else '[ACCESSED]'}
        Logger.debug(f"{requester.get_name()} - [{update_field_info}] - {result}, Value [{self.update_values[index]}]")

    # Makes sure every single player gets the same mask and values.
    def generate_update_data(self, flush_current=True):
        update_object = UpdateData(self.update_mask.copy(), self.update_values_bytes.copy())
        if flush_current:
            self.update_mask.clear()
        return update_object

    def reset(self):
        self.update_mask.clear()

    def has_pending_updates(self):
        return not self.update_mask.is_empty()

    def reset_older_than(self, timestamp_to_compare):
        all_clear = True
        for index, timestamp in enumerate(self.update_timestamps):
            if not timestamp:
                continue
            if timestamp <= timestamp_to_compare:
                self.update_mask.unset_bit(index)
            else:
                all_clear = False
        return all_clear

    # Check if the new value is different from the field known value.
    def should_update(self, index, value, is_int64):
        if not is_int64:
            return self.update_values[index] != value

        field_0 = int(value & 0xFFFFFFFF)
        field_1 = int((value >> 32) & 0xFFFFFFFF)  # Ensures only 32 bits are used after shifting.
        return self.update_values[index] != field_0 or self.update_values[index + 1] != field_1

    def update(self, index, value, value_type, is_int64):
        # Handle 64-bit 'q' type by splitting into two 32-bit updates.
        if is_int64:
            lower_value = int(value & 0xFFFFFFFF)
            upper_value = int((value >> 32) & 0xFFFFFFFF)  # Ensures only 32 bits are used after shifting.

            # Recursively update lower and upper parts.
            self.update(index, lower_value, 'I', False)
            self.update(index + 1, upper_value, 'I', False)
        else:
            self.update_timestamps[index] = time.time()
            self.update_values[index] = value
            self.update_values_bytes[index] = pack(f'<{value_type}', value)
            self.update_mask.set_bit(index)
