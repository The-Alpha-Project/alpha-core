from utils.constants.UpdateFields import ContainerFields, PlayerFields


class ContainerSlots(dict):
    def __init__(self, container_manager):
        super().__init__()
        self.container = container_manager
        self.unit = container_manager.get_owner_unit()
        # UpdateField base slot.
        self.update_field_slot = ContainerFields.CONTAINER_FIELD_SLOT_1 if not container_manager.is_backpack \
            else PlayerFields.PLAYER_FIELD_INV_SLOT_1
        # UpdateFields owner, either a Container or a Player.
        self.update_entity = container_manager if not container_manager.is_backpack else self.unit

    def __setitem__(self, key, value):
        self.modify_container_slot(key, value)
        return super().__setitem__(key, value)

    def __delitem__(self, key):
        self.modify_container_slot(key, self[key], delete_item=True)
        return super().__delitem__(key)

    def pop(self, __key, *args, **kwargs):
        self.modify_container_slot(__key, self[__key], delete_item=True)
        return super().pop(__key, *args, **kwargs)

    def modify_container_slot(self, slot, item_mgr, delete_item=False):
        item_guid = item_mgr.guid if item_mgr and not delete_item else 0
        self.update_entity.set_uint64(self.update_field_slot + slot * 2, item_guid)
        # Notify changed update fields to owner.
        if self.unit and self.unit.is_in_world():
            # Update fields belong to a Container (Item)
            has_inventory_changes = not self.container.is_backpack
            # Update fields belong to PlayerFields.
            has_changes = not has_inventory_changes
            self.unit.update_manager.update_world_object_on_self(self.unit,
                                                                 has_changes=has_changes,
                                                                 has_inventory_changes=has_inventory_changes,
                                                                 update_data=None)
