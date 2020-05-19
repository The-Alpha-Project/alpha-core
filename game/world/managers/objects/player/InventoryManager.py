from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.UpdatePacketFactory import UpdatePacketFactory, UpdateTypes
from utils.ConfigManager import config
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, InventoryError
from utils.constants.ObjectCodes import BankSlots, ItemBondingTypes
from utils.constants.UpdateFields import PlayerFields


MAX_3368_ITEM_DISPLAY_ID = 11802


class InventoryManager(object):
    def __init__(self, owner):
        self.containers = dict()
        self.owner = owner

    def load_items(self):
        # Add backpack
        self.containers[InventorySlots.SLOT_INBACKPACK] = ContainerManager(is_backpack=True,
                                                                           owner=self.owner.guid)

        character_inventory = RealmDatabaseManager.character_get_inventory(self.owner.guid)

        # First load bags
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(item_instance.item_template)
            if item_template and item_template.inventory_type == InventoryTypes.BAG:
                container_mgr = ContainerManager(
                    owner=self.owner.guid,
                    item_template=item_template,
                    item_instance=item_instance
                )
                if self.is_bag_pos(container_mgr.current_slot):
                    self.containers[item_instance.bag].sorted_slots[container_mgr.current_slot] = container_mgr
                    self.containers[container_mgr.current_slot] = container_mgr

        # Then load items
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(item_instance.item_template)
            if item_template:
                if item_template.display_id > MAX_3368_ITEM_DISPLAY_ID and \
                        self.is_equipment_pos(item_instance.bag, item_instance.slot):
                    Logger.error('Character %s has an equipped item (%u - %s) with out of bounds display_id (%u), '
                                 'deleting in order to prevent crashes.' % (self.owner.player.name,
                                                                            item_template.entry,
                                                                            item_template.name,
                                                                            item_template.display_id))
                    RealmDatabaseManager.character_inventory_delete(item_instance)
                    continue

                if item_template.inventory_type == InventoryTypes.BAG:
                    if self.is_bag_pos(item_instance.slot):
                        continue

                    item_mgr = ContainerManager(
                        owner=self.owner.guid,
                        item_template=item_template,
                        item_instance=item_instance
                    )
                else:
                    item_mgr = ItemManager(
                        item_template=item_template,
                        item_instance=item_instance
                    )
                if item_instance.bag in self.containers:
                    self.containers[item_instance.bag].sorted_slots[item_mgr.current_slot] = item_mgr

        self.set_base_attack_time()

    def get_backpack(self):
        return self.containers[InventorySlots.SLOT_INBACKPACK]

    def get_container_slot_by_guid(self, container_guid):
        for slot in self.containers.keys():
            if self.containers[slot].guid == container_guid:
                return slot
        return InventorySlots.SLOT_INBACKPACK.value  # What is the logic behind backpack guid?

    def get_sorted_containers(self, backpack_first=True):
        # This is done to have the expected order or Backpack -> Bag1 -> Bag2 -> Bag3 -> Bag4
        # Example (slots): 23 - 19 - 20 - 21 - 22
        def override_backpack_slot_order(bag):
            if not backpack_first or bag[0] != InventorySlots.SLOT_INBACKPACK.value:
                return bag[0]
            return 0
        return dict(sorted(self.containers.items(), key=override_backpack_slot_order))

    def add_item(self, entry=0, item_template=None, count=1, handle_error=True, from_npc=True, send_message=True):
        if entry != 0 and not item_template:
            item_template = WorldDatabaseManager.item_template_get_by_entry(entry)

        items_added = False

        target_bag_slot = -1  # Highest bag slot items were added to
        if item_template:
            if not self.can_store_item(item_template, count):
                if handle_error:
                    self.send_equip_error(InventoryError.BAG_INV_FULL)
                return False

            # First, add to any pre-existing stacks
            amount_left = count
            for slot, container in self.get_sorted_containers().items():
                if not container.can_contain_item(item_template):
                    continue
                for x in range(container.start_slot, container.max_slot):
                    if self.is_bank_slot(slot, x):
                        continue
                    if x not in container.sorted_slots:
                        continue  # Skip any reserved slots
                    item_mgr = container.sorted_slots[x]
                    if item_mgr.item_template.entry == item_template.entry \
                            and item_mgr.item_instance.stackcount < item_mgr.item_template.stackable:
                        stack_missing = item_template.stackable - item_mgr.item_instance.stackcount
                        items_added = True
                        if slot > target_bag_slot and slot != InventorySlots.SLOT_INBACKPACK:
                            target_bag_slot = slot
                        if stack_missing >= amount_left:
                            item_mgr.item_instance.stackcount += amount_left
                            amount_left = 0
                            RealmDatabaseManager.character_inventory_update_item(item_mgr.item_instance)
                            break
                        else:
                            item_mgr.item_instance.stackcount += stack_missing
                            amount_left -= stack_missing
                            RealmDatabaseManager.character_inventory_update_item(item_mgr.item_instance)

            # Add the remaining stack(s) to empty slots.
            if amount_left > 0:
                for slot, container in self.get_sorted_containers().items():
                    if not container.can_contain_item(item_template):
                        continue
                    items_added = True
                    if slot > target_bag_slot and slot != InventorySlots.SLOT_INBACKPACK:
                        target_bag_slot = slot
                    if not container.is_full():
                        if amount_left > item_template.stackable:
                            container.add_item(item_template, count=item_template.stackable)
                            amount_left -= item_template.stackable
                        else:
                            container.add_item(item_template, count=amount_left)
                            break

        if items_added:
            # Default to backpack so we can prefer highest slot ID to receive message (backpack ID is highest)
            if target_bag_slot == -1:
                target_bag_slot = InventorySlots.SLOT_INBACKPACK

            self.send_item_receive_message(self.owner.guid, item_template.entry,
                                           target_bag_slot, from_npc, send_message)
            self.owner.send_update_self()
        return items_added

    def add_item_to_slot(self, dest_bag_slot, dest_slot, entry=0, item_template=None, count=1, handle_error=True):
        if dest_bag_slot not in self.containers:
            if handle_error:
                self.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return
        if entry != 0 and not item_template:
            item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
        if not item_template:
            if handle_error:
                self.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return

        dest_container = self.containers[dest_bag_slot]
        dest_item = dest_container.get_item(dest_slot)

        # Bag family check
        if self.is_inventory_pos(dest_bag_slot, dest_slot) and \
                not dest_container.can_contain_item(item_template):
            self.send_equip_error(InventoryError.BAG_ITEM_CLASS_MISMATCH, None, dest_item)
            return

        if not self.can_store_item(item_template, count):
            if handle_error:
                self.send_equip_error(InventoryError.BAG_INV_FULL)
            return

        if not self.owner.is_alive:
            if handle_error:
                self.send_equip_error(InventoryError.BAG_NOT_WHILE_DEAD, None, dest_item)
            return

        # Destination slot checks
        if dest_container.is_backpack:
            template_equip_slot = ItemManager.get_inv_slot_by_type(item_template.inventory_type)
            if self.is_equipment_pos(dest_bag_slot, dest_slot) and dest_slot != template_equip_slot or \
                    self.is_bag_pos(dest_slot) and item_template.inventory_type != InventoryTypes.BAG or \
                    dest_slot == 255:  # slot 255 is the backpack slot
                if handle_error:
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, None, dest_item)
                return

        # Check backpack / paperdoll placement
        if item_template.required_level > self.owner.level and \
                self.is_equipment_pos(dest_bag_slot, dest_slot):
            # Not enough level
            if handle_error:
                self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, None, dest_item, item_template.required_level)
            return

        # Stack handling
        if dest_item:
            if self.is_inventory_pos(dest_bag_slot, dest_slot):
                if item_template.entry == dest_item.item_template.entry:
                    diff = dest_item.item_template.stackable - dest_item.item_instance.stackcount
                    if diff >= count:
                        dest_item.item_instance.stackcount += count
                    else:
                        # Update stack values
                        # Case where an item is dragged to stack but there's no space.
                        # Test on later version shows that the items will go to another stack if there's space
                        dest_item.item_instance.stackcount += diff
                        self.add_item(item_template=item_template, count=count-diff, handle_error=False)

                    self.owner.send_update_self()
                    RealmDatabaseManager.character_inventory_update_item(dest_item.item_instance)
                    return True
                else:
                    if handle_error:
                        self.send_equip_error(InventoryError.BAG_CANT_STACK, None, dest_item)
                    return
            else:
                if handle_error:
                    self.send_equip_error(InventoryError.BAG_NOT_EQUIPPABLE, None, dest_item)
                return

        generated_item = dest_container.set_item(item_template, dest_slot, count)
        # Add to containers if a bag was dragged to bag slots
        if self.is_bag_pos(dest_slot):
            if item_template.inventory_type == InventoryTypes.BAG:
                self.add_bag(dest_slot, generated_item)
            else:
                if handle_error:
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, None, dest_item)
                return

        # Update attack time
        if dest_slot == InventorySlots.SLOT_MAINHAND:
            self.set_base_attack_time()

        if self.is_equipment_pos(dest_bag_slot, dest_slot):
            self.owner.flagged_for_update = True
        else:
            self.owner.send_update_self()
        return True

    def swap_item(self, source_bag, source_slot, dest_bag, dest_slot):
        if source_bag not in self.containers or dest_bag not in self.containers:
            return

        source_container = self.containers[source_bag]
        dest_container = self.containers[dest_bag]
        source_item = source_container.get_item(source_slot)
        dest_item = dest_container.get_item(dest_slot)

        if source_item:
            if not self.owner.is_alive:
                self.send_equip_error(InventoryError.BAG_NOT_WHILE_DEAD, source_item, dest_item)
                return

            # Check paper doll placement
            if self.is_equipment_pos(dest_bag, dest_slot) and \
                    source_item.item_template.required_level > self.owner.level:
                # Not enough level
                self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, source_item, dest_item)
                return

            # Destination slot checks
            if dest_container.is_backpack or self.is_bag_pos(dest_slot):
                if (self.is_equipment_pos(dest_bag, dest_slot) and dest_slot != source_item.equip_slot
                        and source_item.equip_slot != InventorySlots.SLOT_INBACKPACK) or \
                        (self.is_bag_pos(dest_slot) and source_item.item_template.inventory_type != InventoryTypes.BAG):
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                    return

            # Bag family checks
            if self.is_inventory_pos(dest_bag, dest_slot) and \
                    not dest_container.can_contain_item(source_item.item_template) or \
                    dest_item and self.is_inventory_pos(source_bag, source_slot) and \
                    not source_container.can_contain_item(dest_item.item_template):
                self.send_equip_error(InventoryError.BAG_ITEM_CLASS_MISMATCH, source_item, dest_item)
                return

            # Original item being swapped to backpack
            if dest_item and self.is_equipment_pos(source_bag, source_slot):
                # Equip_slot mismatch
                if source_slot != dest_item.equip_slot and \
                        dest_item.equip_slot != InventorySlots.SLOT_INBACKPACK:
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                    return

                # Not enough level
                if dest_item.item_template.required_level > self.owner.level:
                    self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, source_item, dest_item,
                                          dest_item.item_template.required_level)
                    return

                # Item isn't equippable
                if dest_item.equip_slot == InventorySlots.SLOT_INBACKPACK and \
                        self.is_equipment_pos(source_bag, source_slot):
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                    return

            if (source_item.is_container() or (dest_item and dest_item.is_container())) and \
                    not (self.is_bag_pos(source_slot) and self.is_bag_pos(dest_slot)):
                # Source or dest is a container and both aren't equipped
                if source_item.is_container() and not source_item.is_empty():  # Moving non-empty bag from bag slots
                    self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                    return
                if dest_item and source_item.is_container() and dest_item.is_container() \
                        and not dest_item.is_empty():  # Swapping bags to bag bar from inv
                    self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                    return

            # Stack handling
            if dest_item and source_item.item_template.entry == dest_item.item_template.entry \
                    and dest_item.item_template.stackable > dest_item.item_instance.stackcount:
                diff = dest_item.item_template.stackable - dest_item.item_instance.stackcount
                if diff >= source_item.item_instance.stackcount:
                    # Destroy source stack
                    dest_item.item_instance.stackcount += source_item.item_instance.stackcount
                    if source_bag in self.containers:
                        self.containers[source_bag].remove_item_in_slot(source_slot)
                        RealmDatabaseManager.character_inventory_delete(source_item.item_instance)
                else:
                    # Update stack values
                    source_item.item_instance.stackcount -= diff
                    dest_item.item_instance.stackcount = dest_item.item_template.stackable
                    RealmDatabaseManager.character_inventory_update_item(source_item.item_instance)

                self.owner.send_update_self()
                RealmDatabaseManager.character_inventory_update_item(dest_item.item_instance)
                return

            if dest_item and dest_item.is_backpack and self.is_bag_pos(dest_slot):  # Swapping item to bag bar
                if dest_item.is_empty():
                    self.remove_bag(dest_slot)
                else:
                    self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                    return

            if self.is_bag_pos(source_slot):
                self.remove_bag(source_slot)

            # Actual transfer

            # Remove items
            if source_bag in self.containers:
                self.containers[source_bag].remove_item_in_slot(source_slot)
            if dest_bag in self.containers:
                self.containers[dest_bag].remove_item_in_slot(dest_slot)

            # Bag transfers
            if self.is_bag_pos(dest_slot) and source_item.is_container():
                self.add_bag(dest_slot, source_item)
                RealmDatabaseManager.character_inventory_update_container_contents(source_item)

            if dest_item and self.is_bag_pos(source_slot) and dest_item.is_container():
                self.add_bag(source_slot, dest_item)
                RealmDatabaseManager.character_inventory_update_container_contents(dest_item)

            # Add items
            if source_bag in self.containers:
                self.containers[dest_bag].set_item(source_item, dest_slot, source_item.item_instance.stackcount)
                source_item.item_instance.bag = dest_bag
                source_item.item_instance.slot = dest_slot
                RealmDatabaseManager.character_inventory_update_item(source_item.item_instance)
            if dest_item and dest_bag in self.containers:
                self.containers[source_bag].set_item(dest_item, source_slot, dest_item.item_instance.stackcount)
                dest_item.item_instance.bag = source_bag
                dest_item.item_instance.slot = source_slot
                RealmDatabaseManager.character_inventory_update_item(dest_item.item_instance)

            # Update attack time
            if source_slot == InventorySlots.SLOT_MAINHAND or \
                    dest_slot == InventorySlots.SLOT_MAINHAND:
                self.set_base_attack_time()

            # TODO: Save current binding state in db (also load it)
            if source_item.item_template.bonding == ItemBondingTypes.BIND_WHEN_EQUIPPED and \
                    (self.is_equipment_pos(dest_bag, dest_slot) or self.is_bag_pos(source_slot)):
                source_item.set_binding(True)

            if self.is_equipment_pos(source_bag, source_slot) or self.is_equipment_pos(dest_bag, dest_slot):
                self.owner.flagged_for_update = True
            else:
                self.owner.send_update_self()

    def set_base_attack_time(self):
        if InventorySlots.SLOT_MAINHAND in self.get_backpack().sorted_slots:
            weapon = self.get_backpack().sorted_slots[InventorySlots.SLOT_MAINHAND]
            if weapon:
                self.owner.base_attack_time = weapon.item_template.delay
            return
        self.owner.base_attack_time = config.Unit.Defaults.base_attack_time

    def get_item_count(self, entry):
        count = 0
        for container_slot, container in list(self.containers.items()):
            for slot, item in list(container.sorted_slots.items()):
                if item.item_template.entry == entry:
                    count += 1
        return count

    def get_item(self, bag, slot):
        if bag in self.containers:
            return self.containers[bag].get_item(slot)
        return None

    def get_item_info_by_guid(self, guid):
        for container_slot, container in list(self.containers.items()):
            for slot, item in list(container.sorted_slots.items()):
                if item.guid == guid:
                    return container_slot, container, slot, item
        return -1, None, -1, None

    def add_bag(self, slot, container):
        if not self.is_bag_pos(slot):
            return False

        if slot in self.get_backpack().sorted_slots and self.get_backpack().sorted_slots[slot] != container:
            self.get_backpack().sorted_slots[slot] = container
        self.containers[slot] = container

        # Update items' bag slot field
        for item in self.containers[slot].sorted_slots.values():
            item.item_instance.bag = slot
        return True

    def remove_bag(self, slot):
        if not self.is_bag_pos(slot) or slot not in self.containers:
            return False

        if slot in self.get_backpack().sorted_slots:
            self.get_backpack().sorted_slots.pop(slot)
        self.containers.pop(slot)

        return False

    def can_store_item(self, item_template, count, on_bank=False):
        amount = count

        # Reached unique limit
        if 0 < item_template.max_count <= self.get_item_count(item_template.entry):
            return False

        # Check bags
        if not on_bank:
            for slot, container in self.containers.items():
                if not container.can_contain_item(item_template):
                    continue
                for x in range(container.start_slot, container.max_slot):
                    if self.is_bank_slot(slot, x):
                        continue
                    if x not in container.sorted_slots:
                        amount -= item_template.stackable
                        continue  # Skip any reserved slots
                    item_mgr = container.sorted_slots[x]
                    if item_mgr.item_template.entry == item_template.entry:
                        amount -= item_template.stackable - item_mgr.item_instance.stackcount
        else:
            for x in range(InventorySlots.SLOT_BANK_ITEM_START, InventorySlots.SLOT_ITEM_BANK_END):
                if x not in self.get_backpack().sorted_slots:
                    amount -= item_template.stackable
                    continue
                item_mgr = self.get_backpack().sorted_slots[x]
                if item_mgr.item_template.entry == item_template.entry:
                    amount -= item_template.stackable - item_mgr.item_instance.stackcount

        if amount <= 0:
            return True

        for container_slot, container in list(self.containers.items()):
            if container.is_backpack or not container.can_contain_item(item_template):
                continue
            if (on_bank and container_slot < InventorySlots.SLOT_BANK_BAG_1) or \
                    (not on_bank and container_slot >= InventorySlots.SLOT_BANK_BAG_1):
                continue

            # Free slots * Max stack count
            amount -= (container.total_slots - len(container.sorted_slots)) * item_template.stackable
            if amount <= 0:
                return True

        return False

    def get_next_available_slot(self):
        for container_slot, container in list(self.containers.items()):
            if not container.is_full():
                return container.next_available_slot()
        return -1

    def is_bag_pos(self, slot):
        return (InventorySlots.SLOT_BAG1 <= slot < InventorySlots.SLOT_INBACKPACK) or \
               (InventorySlots.SLOT_BANK_BAG_1 <= slot < InventorySlots.SLOT_BANK_END)

    def is_bank_slot(self, bag_slot, slot):
        if bag_slot == InventorySlots.SLOT_INBACKPACK:
            if slot >= BankSlots.BANK_SLOT_ITEM_START < BankSlots.BANK_SLOT_ITEM_END:
                return True
            if slot >= BankSlots.BANK_SLOT_BAG_START < BankSlots.BANK_SLOT_BAG_END:
                return True

        if BankSlots.BANK_SLOT_BAG_START <= bag_slot < BankSlots.BANK_SLOT_BAG_END:
            return True

        return False

    def is_equipment_pos(self, bag_slot, slot):
        return bag_slot == InventorySlots.SLOT_INBACKPACK and slot < InventorySlots.SLOT_BAG1

    def is_inventory_pos(self, bag_slot, slot):
        if bag_slot == InventorySlots.SLOT_INBACKPACK \
                and InventorySlots.SLOT_ITEM_START <= slot < InventorySlots.SLOT_ITEM_END:
            return True

        if InventorySlots.SLOT_BAG1 <= bag_slot <= InventorySlots.SLOT_BAG4:
            if bag_slot not in self.containers:
                return False
            return slot < self.containers[bag_slot].max_slot
        return False

    def send_equip_error(self, error, item_1=None, item_2=None, required_level=0):
        data = pack('<B', error)
        if error != InventoryError.BAG_OK:
            if error == InventoryError.BAG_LEVEL_MISMATCH:
                data += pack('<I', item_1.item_template.required_level if item_1 else required_level)
            data += pack(
                '<2QB',
                item_1.guid if item_1 else self.owner.guid,
                item_2.guid if item_2 else self.owner.guid,
                0
            )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_INVENTORY_CHANGE_FAILURE, data))

    def send_buy_error(self, error, entry, vendor_guid=0):
        data = pack(
            '<QIB',
            vendor_guid if vendor_guid > 0 else self.owner.guid,
            entry,
            error
        )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_BUY_FAILED, data))

    def send_sell_error(self, error, item_guid, vendor_guid=0):
        data = pack(
            '<QQB',
            vendor_guid if vendor_guid > 0 else self.owner.guid,
            item_guid,
            error
        )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_SELL_ITEM, data))

    def send_item_receive_message(self, guid, item_entry, bag_slot, from_npc=True, show_in_chat=True):
        if bag_slot == InventorySlots.SLOT_INBACKPACK:
            bag_slot = 255
        data = pack(
            '<Q2IBI',
            guid, from_npc, show_in_chat, bag_slot, item_entry
        )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_ITEM_PUSH_RESULT, data))

    def build_update(self):
        for slot, item in self.get_backpack().sorted_slots.items():
            self.owner.set_ply_uint64(PlayerFields.PLAYER_FIELD_INV_SLOT_1 + item.current_slot * 2, item.guid)

    def send_single_item_update(self, world_session, item, is_self):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT, item.get_full_update_packet(is_self=False)))
        if is_self:
            world_session.request.sendall(update_packet)
            world_session.request.sendall(item.query_details())
        else:
            GridManager.send_surrounding(update_packet, world_session.player_mgr, include_self=False)
            GridManager.send_surrounding(item.query_details(), world_session.player_mgr,
                                         include_self=False)

    def send_inventory_update(self, world_session, is_self=True):
        for container_slot, container in list(self.containers.items()):
            if not container.is_backpack:
                self.send_single_item_update(world_session, container, is_self)

            for slot, item in list(container.sorted_slots.items()):
                self.send_single_item_update(world_session, item, is_self)
