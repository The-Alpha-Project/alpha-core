from database.realm.RealmDatabaseManager import RealmDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ItemCodes import InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds

MAX_BAG_SLOTS = 20


class ContainerManager(ItemManager):
    def __init__(self, owner, item_template=None, item_instance=None, is_backpack=False, **kwargs):
        super().__init__(item_template, item_instance, **kwargs)

        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_OBJECT,
                                                          ObjectTypes.TYPE_ITEM,
                                                          ObjectTypes.TYPE_CONTAINER])

        self.owner = owner
        self.is_backpack = is_backpack
        if self.is_backpack:
            self.current_slot = InventorySlots.SLOT_INBACKPACK.value

        self.sorted_slots = dict()

        if not self.is_backpack:
            self.total_slots = self.item_template.container_slots
            self.is_contained = self.guid
        else:
            self.total_slots = InventorySlots.SLOT_BANK_END
            self.is_contained = self.owner

        self.object_type.append(ObjectTypes.TYPE_CONTAINER)

    def set_item(self, item, slot, count=1):
        if not item or len(self.sorted_slots) == self.total_slots or slot > self.total_slots:
            return None

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

    def add_item(self, item, count=1):
        if item:
            slot = self.next_available_slot()
            if slot >= 0:
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
        start_slot = InventorySlots.SLOT_INBACKPACK.value if self.is_backpack else 0
        for slot in range(start_slot, self.total_slots):
            if slot not in self.sorted_slots:
                return slot
        return -1

    def is_full(self):
        return len(self.sorted_slots) >= self.total_slots

    # override
    def get_type(self):
        return ObjectTypes.TYPE_CONTAINER

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_CONTAINER
