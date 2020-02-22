from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterInventory
from database.world.WorldDatabaseManager import WorldDatabaseManager
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
                 current_slot=0,
                 **kwargs):
        super().__init__(**kwargs)

        self.item_template = item_template
        self.item_instance = item_instance
        self.guid = item_instance.guid if item_instance else 0
        self.display_id = item_template.display_id
        self.current_slot = current_slot
        self.equip_slot = self.get_inv_slot_by_type(self.item_template.inventory_type)

        self.object_type.append(ObjectTypes.TYPE_ITEM)

    def is_container(self):
        return self.item_template.inventory_type == InventoryTypes.BAG

    def is_equipped(self):
        return self.current_slot < InventorySlots.SLOT_BAG1

    def get_inv_slot_by_type(self, inventory_type):
        return AVAILABLE_EQUIP_SLOTS[inventory_type if inventory_type <= 26 else 0]

    @staticmethod
    def generate_item(world_session, entry, count=1):
        item_template = WorldDatabaseManager.item_template_get_by_entry(world_session.world_db_session, entry)
        if item_template:
            item = CharacterInventory(
                owner=world_session.player_mgr.guid,
                player=world_session.player_mgr.guid,
                item_template=item_template.entry,
                stackcount=count
            )
            RealmDatabaseManager.character_inventory_add_item(world_session.realm_db_session, item)

            item_mgr = ItemManager(
                item_template=item_template,
                item_instance=item
            )
            return item_mgr
        return None

    # override
    def get_type(self):
        return ObjectTypes.TYPE_ITEM

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_ITEM
