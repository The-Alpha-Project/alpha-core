from game.world.managers.objects.item.ItemManager import ItemManager
from utils.constants.ItemCodes import InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds

MAX_BAG_SLOTS = 20


class ContainerManager(ItemManager):
    def __init__(self, items, item_template=None, item_instance=None, is_backpack=False, **kwargs):
        super().__init__(item_template, item_instance, **kwargs)
        self.is_backpack = is_backpack
        self.items = items

        self.sorted_slots = dict()

        if not self.is_backpack:
            self.total_slots = self.item_template.container_slots
        else:
            self.total_slots = InventorySlots.SLOT_BANK_END

        self.object_type.append(ObjectTypes.TYPE_CONTAINER)

    def set_item(self, item, slot):
        if not item or len(self.items) == self.total_slots or slot > self.total_slots or item == self:
            return False

        item.current_slot = slot
        self.sorted_slots[slot] = item
        return True

    def add_item(self, item):
        if item:
            slot = self.next_slot()
            return slot >= 0 and self.set_item(item, slot)

    def get_item(self, slot):
        if slot in self.sorted_slots:
            return self.sorted_slots[slot]
        return None

    def next_slot(self):
        start_slot = InventorySlots.SLOT_INBACKPACK if self.is_backpack else 0
        for slot in range(start_slot, self.total_slots):
            if slot not in self.sorted_slots:
                return slot
        return -1

    def is_bag_pos(self, slot):
        return (InventorySlots.SLOT_BAG1 <= slot < InventorySlots.SLOT_INBACKPACK) or (63 <= slot < 69)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_CONTAINER

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_CONTAINER
