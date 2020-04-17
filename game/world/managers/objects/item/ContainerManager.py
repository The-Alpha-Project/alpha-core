from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ItemCodes import InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid

MAX_BAG_SLOTS = 20


class ContainerManager(ItemManager):
    def __init__(self, owner, item_template=None, item_instance=None, is_backpack=False, **kwargs):
        super().__init__(item_template, item_instance, **kwargs)

        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_OBJECT,
                                                          ObjectTypes.TYPE_ITEM,
                                                          ObjectTypes.TYPE_CONTAINER])

        self.guid = (item_instance.guid if item_instance else 0) | HighGuid.HIGHGUID_CONTAINER
        self.owner = owner
        self.is_backpack = is_backpack
        if self.is_backpack:
            self.current_slot = InventorySlots.SLOT_INBACKPACK.value

        self.sorted_slots = dict()

        if not self.is_backpack:
            self.total_slots = self.item_template.container_slots
            self.start_slot = 0
            self.max_slot = self.total_slots
            self.is_contained = self.guid
        else:
            self.total_slots = InventorySlots.SLOT_ITEM_END - InventorySlots.SLOT_ITEM_START
            self.start_slot = InventorySlots.SLOT_ITEM_START
            self.max_slot = InventorySlots.SLOT_BANK_END
            self.is_contained = self.owner

        self.object_type.append(ObjectTypes.TYPE_CONTAINER)

    @classmethod
    def from_item(cls, item_manager):
        return cls(
            owner=item_manager.item_instance.owner,
            item_template=item_manager.item_template,
            item_instance=item_manager.item_instance
        )

    def can_set_item(self, item, slot):
        if item:
            if 0 > slot > self.max_slot:
                return False
            if not self.is_backpack and len(self.sorted_slots) == self.total_slots:
                return False
            return True
        return False

    def set_item(self, item, slot, count=1):
        if self.can_set_item(item, slot):
            if isinstance(item, ItemManager):
                item_mgr = item
                if item_mgr == self:
                    return None
            else:
                item_mgr = ItemManager.generate_item(item, self.owner, self.current_slot, slot, count=count)

            if item_mgr:
                item_mgr.current_slot = slot
                self.sorted_slots[slot] = item_mgr

            return item_mgr
        return None

    def add_item(self, item, count=1):
        if item:
            slot = self.next_available_slot()
            if slot >= self.start_slot:
                return self.set_item(item, slot, count)
        return None

    def get_item(self, slot):
        if slot in self.sorted_slots:
            return self.sorted_slots[slot]
        return None

    def remove_item(self, item):
        if item:
            return self.remove_item_in_slot(item.current_slot)
        return False

    def remove_item_in_slot(self, slot):
        if slot in self.sorted_slots:
            self.sorted_slots.pop(slot)
            return True
        return False

    def next_available_slot(self):
        for slot in range(self.start_slot, self.start_slot + self.total_slots):
            if slot not in self.sorted_slots:
                return slot
        return -1

    def is_full(self):
        if self.is_backpack:
            item_count = 0
            for bag_slot in range(InventorySlots.SLOT_ITEM_START, InventorySlots.SLOT_ITEM_END + 1):
                if bag_slot in self.sorted_slots:
                    item_count += 1
            return item_count >= self.total_slots
        else:
            return len(self.sorted_slots) >= self.total_slots

    def is_empty(self):
        if self.is_backpack:
            for bag_slot in range(InventorySlots.SLOT_ITEM_START, InventorySlots.SLOT_ITEM_END + 1):
                if bag_slot in self.sorted_slots:
                    return False
            return True
        else:
            return len(self.sorted_slots) == 0

    # override
    def get_type(self):
        return ObjectTypes.TYPE_CONTAINER

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_CONTAINER
