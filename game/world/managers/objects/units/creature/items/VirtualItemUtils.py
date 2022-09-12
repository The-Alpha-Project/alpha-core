from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.units.creature.items.VirtualItemInfoHolder import VirtualItemInfoHolder
from utils.ByteUtils import ByteUtils
from utils.constants.ItemCodes import InventoryTypes
from utils.constants.UpdateFields import UnitFields


class VirtualItemsUtils:

    @staticmethod
    def set_virtual_item(creature_mgr, slot, item_entry):
        item_template = None
        if item_entry > 0:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_entry)

        if item_template:
            virtual_item_info = ByteUtils.bytes_to_int(
                item_template.inventory_type,
                item_template.material,
                item_template.subclass,
                item_template.class_,
            )

            virtual_item_info_2 = ByteUtils.bytes_to_int(
                0, 0, 0,  # Padding.
                item_template.sheath
            )

            creature_mgr.virtual_item_info[slot] = VirtualItemInfoHolder(
                item_template.display_id, virtual_item_info, virtual_item_info_2
            )

            # Main hand.
            if slot == 0:
                creature_mgr.wearing_mainhand_weapon = (item_template.inventory_type == InventoryTypes.WEAPON or
                                                        item_template.inventory_type == InventoryTypes.WEAPONMAINHAND or
                                                        item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON)

            # Offhand.
            if slot == 1:
                creature_mgr.wearing_offhand_weapon = (item_template.inventory_type == InventoryTypes.WEAPON or
                                                       item_template.inventory_type == InventoryTypes.WEAPONOFFHAND)
            # Ranged.
            if slot == 2:
                creature_mgr.wearing_ranged_weapon = (item_template.inventory_type == InventoryTypes.RANGED or
                                                      item_template.inventory_type == InventoryTypes.RANGEDRIGHT)
        else:
            creature_mgr.virtual_item_info[slot] = VirtualItemInfoHolder()

        creature_mgr.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, creature_mgr.weapon_reach)
