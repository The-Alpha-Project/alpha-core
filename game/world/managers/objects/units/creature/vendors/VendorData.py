import time
from collections import OrderedDict
from typing import Optional
from database.world.WorldModels import NpcVendorTemplateBase


class LimitedItem:
    def __init__(self, item_entry, max_count, expected_timestamp):
        self.item_entry: int = item_entry
        self.max_count: int = max_count
        self.expected_timestamp: int = expected_timestamp

    def can_unlock(self):
        return time.time() >= self.expected_timestamp

    def unlock(self, max_count):
        self.max_count = max_count
        self.expected_timestamp = 0


class VendorData:
    def __init__(self, vendor_data: Optional[list[NpcVendorTemplateBase]]):
        self.vendor_items = OrderedDict()
        self.limited_items = {}
        for entry in vendor_data:
            if entry.maxcount:
                self.limited_items[entry.item] = LimitedItem(entry.item, entry.maxcount, 0)
            self.vendor_items[entry.item] = entry

    def is_limited_item(self, item_entry):
        return item_entry in self.limited_items

    def is_limited_item_locked(self, item_entry):
        return self.is_limited_item(item_entry) and self.limited_items[item_entry].expected_timestamp > 0

    def get_item_slot(self, item_entry):
        return list(self.vendor_items.keys()).index(item_entry) + 1  # Numbered from 1 at client.

    def update_limited_item(self, item_entry, qty=1):
        if item_entry not in self.limited_items:
            return
        self.limited_items[item_entry].max_count -= qty
        # Depleted, set the expected restocking time.
        if not self.limited_items[item_entry].max_count:
            # Current time in seconds + restock time in seconds.
            self.limited_items[item_entry].expected_timestamp = time.time() + self.vendor_items[item_entry].incrtime

    def has_item_data(self, item_entry):
        return item_entry in self.vendor_items

    def get_max_count(self, item_entry):
        return self.limited_items[item_entry].max_count if item_entry in self.limited_items \
            else 0xFFFFFFFF if self.vendor_items[item_entry].maxcount <= 0 else self.vendor_items[item_entry].maxcount

    def get_vendor_items(self):
        vendor_items = []
        # Extract vendor items from the dictionary and set stock availability if needed.
        for item_entry, item in self.vendor_items.items():
            # Instead of having timers for limited items, we just check them upon vendor list request.
            if self.is_limited_item_locked(item_entry) and self.limited_items[item_entry].can_unlock():
                # Unlock, set original max count availability.
                self.limited_items[item_entry].unlock(self.vendor_items[item_entry].maxcount)
            vendor_items.append(item)

        return vendor_items
