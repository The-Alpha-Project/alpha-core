import time
from struct import pack
from typing import Optional

from bitarray import bitarray

from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdateData import UpdateData
from network.packet.update.UpdateMask import UpdateMask
from utils.Logger import Logger
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import EncapsulationType, ObjectFields

FIELDS_ENCAPSULATION = {}  # { field_type : { index : encapsulation} }
ENCAPSULATION_INFORMATION = {}  # Debug.


class UpdatePacketFactory(object):
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
        # We just build encapsulation once per update field type, then share the same dictionary reference for all
        # other update fields of the same kind.
        if fields_type in FIELDS_ENCAPSULATION:
            return FIELDS_ENCAPSULATION[fields_type]

        # Initialize encapsulation dictionary for this type of fields.
        FIELDS_ENCAPSULATION[fields_type] = {}

        # Initialize encapsulation information for this type of fields.
        # Holds the index, the field names and encapsulation flags.
        # Great for debugging.
        ENCAPSULATION_INFORMATION[fields_type] = {}

        # What other UpdateFields are involved, e.g. PlayerFields [ObjectFields -> UnitFields -> PlayerFields]
        update_field_types = []

        # The UpdateField we stand on before looping through.
        field_type = fields_type

        # Loop through until we visit each parent and find root. (ObjectFields)
        while True:
            update_field_types.insert(0, field_type)
            if field_type == ObjectFields:
                break
            field_type = field_type.parent_fields()

        # Extract encapsulation flag for all affected UpdateFields.
        for index, _type in enumerate(update_field_types):
            # _type represent an UpdateFields type [UnitFields, PlayerFields, ItemFields, ContainerFields, etc]
            for update_field in _type:
                # How many integers do this field represents.
                for _index in range(update_field.size):
                    # Hold the update field index, name and flag.
                    ENCAPSULATION_INFORMATION[fields_type][update_field.value + _index] = f'[{update_field.value + _index}] {update_field.name}_{_index} - [{update_field.flags.name}]'
                    # { index : encapsulation flag }
                    FIELDS_ENCAPSULATION[fields_type][update_field.value + _index] = update_field.flags

    def is_dynamic_field(self, index):
        if not self._validate_field_existence(index):
            return False

        return FIELDS_ENCAPSULATION[self.fields_type][index] == EncapsulationType.DYNAMIC

    def has_read_rights_for_field(self, index, requester):
        if not self._validate_field_existence(index):
            return False

        if requester.guid != self.owner_guid and FIELDS_ENCAPSULATION[self.fields_type][index] == EncapsulationType.PRIVATE:
            self._debug_field_acquisition(requester, index, was_protected=True)
            return False

        self._debug_field_acquisition(requester, index, was_protected=False)
        return True

    def _validate_field_existence(self, index):
        if self.fields_type not in FIELDS_ENCAPSULATION:
            return False

        if index not in FIELDS_ENCAPSULATION[self.fields_type]:
            return False

        return True

    # Debug what UpdateFields players sees from self, other player, units, items, gameobjects, etc.
    def _debug_field_acquisition(self, requester, index, was_protected):
        update_field_info = ENCAPSULATION_INFORMATION[self.fields_type][index]
        result = {'[PROTECTED]' if was_protected else '[ACCESSED]'}
        Logger.debug(f"{requester.get_name()} - [{update_field_info}] - {result}, Value [{self.update_values[index]}]")

    # Makes sure every single player gets the same mask and values.
    def generate_update_data(self, flush_current=True):
        with self.update_mask.lock:
            update_object = UpdateData(self.update_mask.copy(), self.update_values_bytes.copy())
            if flush_current:
                self.update_mask.clear()
            return update_object

    def reset(self):
        self.update_mask.clear()

    def has_pending_updates(self):
        return not self.update_mask.is_empty()

    def reset_older_than(self, timestamp_to_compare):
        with self.update_mask.lock:
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
    def should_update(self, index, value, value_type):
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
