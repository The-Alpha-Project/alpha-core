from utils.constants.UpdateFields import ContainerFields, PlayerFields


class ContainerSlots(dict):
    def __init__(self, container_manager):
        super().__init__()
        self.container = container_manager
        # UpdateField base slot.
        self.update_field_slot = ContainerFields.CONTAINER_FIELD_SLOT_1 if not container_manager.is_backpack \
            else PlayerFields.PLAYER_FIELD_INV_SLOT_1
        # UpdateFields owner.
        self.update_entity = container_manager if not container_manager.is_backpack \
            else container_manager.get_owner_unit()

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
