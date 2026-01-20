from struct import  unpack_from, pack_into
from threading import RLock
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
        self.dynamic_fields = None
        self.private_fields = None
        self.update_values_bytes = bytearray()  # Values bytes representation, used for update packets.
        self.update_mask = UpdateMask()
        self.lock = RLock()

    def init_values(self, owner_guid, fields_type):
        self.owner_guid = owner_guid
        self.fields_type = fields_type
        self.fields_size = fields_type.END.value
        self.update_values_bytes = bytearray(self.fields_size * 4)
        self.update_mask.set_count(self.fields_size)

        # Cache dynamic and private fields for faster lookups.
        encapsulation = self._load_encapsulation(fields_type)
        self.dynamic_fields = {i for i, enc in encapsulation.items() if enc == EncapsulationType.DYNAMIC}
        self.private_fields = {i for i, enc in encapsulation.items() if enc == EncapsulationType.PRIVATE}

    @staticmethod
    def _load_encapsulation(fields_type):
        # Cache encapsulation for each fields_type to avoid recomputation.
        if fields_type in FIELDS_ENCAPSULATION:
            return FIELDS_ENCAPSULATION[fields_type]

        # Initialize dictionaries for encapsulation and related info.
        FIELDS_ENCAPSULATION[fields_type] = {}
        DEBUG_INFORMATION[fields_type] = {}

        # Traverse parent fields until reaching ObjectFields.
        current_type = fields_type
        update_field_types = []
        while True:
            update_field_types.insert(0, current_type)
            if current_type == ObjectFields:
                break
            current_type = current_type.parent_fields()

        # Process each update field type in order.
        for update_type in update_field_types:
            for update_field in update_type:
                # For each component in the update field, store encapsulation info.
                for offset in range(update_field.size):
                    field_index = update_field.value + offset
                    # Store debugging info for each field.
                    DEBUG_INFORMATION[fields_type][field_index] = (
                        f"[{field_index}] {update_field.name}_{offset} - [{update_field.flags.name}]"
                    )
                    # Store the encapsulation flags for the field.
                    FIELDS_ENCAPSULATION[fields_type][field_index] = update_field.flags

        return FIELDS_ENCAPSULATION[fields_type]

    def is_dynamic_field(self, index):
        return index in self.dynamic_fields

    def has_read_rights_for_field(self, index, requester):
        if requester.guid != self.owner_guid and index in self.private_fields:
            # self._debug_field_acquisition(requester, index, was_protected=True)
            return False

        # self._debug_field_acquisition(requester, index, was_protected=False)
        return True

    def _validate_field_existence(self, index):
        return self.fields_type in FIELDS_ENCAPSULATION and index in FIELDS_ENCAPSULATION[self.fields_type]

    # Debug what UpdateFields players sees from self, other player, units, items, gameobjects, etc.
    def _debug_field_acquisition(self, requester, index, was_protected):
        update_field_info = DEBUG_INFORMATION[self.fields_type][index]
        result = '[PROTECTED]' if was_protected else '[ACCESSED]'
        value = self.get_value(index, 'I', False)
        Logger.debug(f"{requester.get_name()} - [{update_field_info}] - {result}, Value [{value}]")

    # Makes sure every single player gets the same mask and values.
    def generate_update_data(self):
        with self.lock:
            return UpdateData(self.update_mask.copy(), self.update_values_bytes[:])

    def reset(self):
        with self.lock:
            self.update_mask.clear()

    def has_pending_updates(self):
        with self.lock:
            return not self.update_mask.is_empty()

    def get_value(self, index, value_type, is_int64):
        with self.lock:
            if not is_int64:
                return unpack_from(f'<{value_type}', self.update_values_bytes, index * 4)[0]

            # Unpack from two field bytes.
            return unpack_from(f'<{value_type}', self.update_values_bytes, index * 4)[0]

    # Check if the new value is different from the field known value.
    def should_update(self, index, value, is_int64):
        with self.lock:
            if not is_int64:
                return self.get_value(index, 'I', False) != value

            # Check both lower and upper parts for 64-bit values.
            return (self.get_value(index, 'I', False) != int(value & 0xFFFFFFFF) or
                    self.get_value(index + 1, 'I', False) != int((value >> 32) & 0xFFFFFFFF))

    def update(self, index, value, value_type, is_int64):
        with self.lock:
            # Handle 64-bit 'q' type by splitting into two 32-bit updates.
            if is_int64:
                lower_value = int(value & 0xFFFFFFFF)
                upper_value = int((value >> 32) & 0xFFFFFFFF)  # Ensures only 32 bits are used after shifting.

                # Inline update for both parts to avoid recursion overhead.
                self.set_value(index, lower_value, 'I')
                self.set_value(index + 1, upper_value, 'I')
            else:
                self.set_value(index, value, value_type)

    def set_value(self, index, value, value_type):
        with self.lock:
            pack_into(f'<{value_type}', self.update_values_bytes, index * 4, value)
            self.update_mask.set_bit(index)
