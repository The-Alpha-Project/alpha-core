from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.ItemCodes import InventoryTypes, InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds


AVAILABLE_EQUIP_SLOTS = [
    InventorySlots.SLOT_INBACKPACK,  # None equip
    InventorySlots.SLOT_HEAD,
    InventorySlots.SLOT_NECK,
    InventorySlots.SLOT_SHOULDERS,
    InventorySlots.SLOT_SHIRT,
    InventorySlots.SLOT_CHEST,
    InventorySlots.SLOT_WAIST,
    InventorySlots.SLOT_LEGS,
    InventorySlots.SLOT_FEET,
    InventorySlots.SLOT_WRISTS,
    InventorySlots.SLOT_HANDS,
    InventorySlots.SLOT_FINGERL,
    InventorySlots.SLOT_TRINKETL,
    InventorySlots.SLOT_MAINHAND,  # 1H
    InventorySlots.SLOT_OFFHAND,  # Shield
    InventorySlots.SLOT_RANGED,
    InventorySlots.SLOT_BACK,
    InventorySlots.SLOT_MAINHAND,  # 2H
    InventorySlots.SLOT_BAG1,
    InventorySlots.SLOT_TABARD,
    InventorySlots.SLOT_CHEST,  # Robe
    InventorySlots.SLOT_MAINHAND,  # Main Hand
    InventorySlots.SLOT_OFFHAND,  # Off Hand
    InventorySlots.SLOT_OFFHAND,  # Held
    InventorySlots.SLOT_INBACKPACK,  # Ammo
    InventorySlots.SLOT_RANGED,  # Throw
    InventorySlots.SLOT_RANGED  # Ranged right
]


class ItemManager(ObjectManager):
    def __init__(self,
                 item_template,
                 item_instance,
                 inventory_type=0,
                 current_slot=0,
                 stack_count=1,
                 soulbound=False,
                 **kwargs):
        super().__init__(**kwargs)

        self.item_template = item_template
        self.item_instance = item_instance
        self.entry = item_template.entry
        self.guid = item_instance.guid if item_instance else 0
        self.display_id = item_template.display_id
        self.inventory_type = inventory_type
        self.current_slot = current_slot
        self.stack_count = stack_count
        self.soulbound = soulbound
        self.equip_slot = self.get_inv_slot_by_type(self.inventory_type)

        self.object_type.append(ObjectTypes.TYPE_ITEM)

    def is_container(self):
        return self.inventory_type == InventoryTypes.BAG

    def is_equipped(self):
        return self.current_slot < InventorySlots.SLOT_BAG1

    def get_inv_slot_by_type(self, inventory_type):
        return AVAILABLE_EQUIP_SLOTS[inventory_type if inventory_type <= 26 else 0]

    # override
    def get_type(self):
        return ObjectTypes.TYPE_ITEM

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_ITEM
