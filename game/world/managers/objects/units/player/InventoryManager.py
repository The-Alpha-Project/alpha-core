from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from game.world.managers.objects.item.ItemManager import ItemManager
from network.packet.PacketWriter import PacketWriter
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, InventoryError, ItemSubClasses, ItemClasses
from utils.constants.MiscCodes import BankSlots, ItemBondingTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import PlayerFields, ContainerFields

MAX_3368_ITEM_DISPLAY_ID = 11802


class InventoryManager(object):
    def __init__(self, owner):
        self.owner = owner
        self.containers = {
            InventorySlots.SLOT_INBACKPACK: ContainerManager(is_backpack=True, owner=self.owner.guid),
            InventorySlots.SLOT_BAG1: None,
            InventorySlots.SLOT_BAG2: None,
            InventorySlots.SLOT_BAG3: None,
            InventorySlots.SLOT_BAG4: None
        }

    def load_items(self):
        character_inventory = RealmDatabaseManager.character_get_inventory(self.owner.guid)

        # First load bags
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_instance.item_template)
            if item_template and item_template.inventory_type == InventoryTypes.BAG:
                container_mgr = ContainerManager(
                    owner=self.owner.guid,
                    item_template=item_template,
                    item_instance=item_instance
                )
                if self.is_bag_pos(container_mgr.current_slot):
                    if item_instance.bag > 23:
                        low_guid = container_mgr.get_low_guid()
                        Logger.warning(f'Invalid bag slot {item_instance.bag} for guid {low_guid} owner {self.owner.guid}')
                        continue

                    self.containers[item_instance.bag].modify_container_slot(container_mgr.current_slot, container_mgr)
                    self.containers[container_mgr.current_slot] = container_mgr

        # Then load items
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(item_instance.item_template)
            if item_template:
                if item_template.display_id > MAX_3368_ITEM_DISPLAY_ID and \
                        self.is_equipment_pos(item_instance.bag, item_instance.slot):
                    Logger.error(f'Character {self.owner.get_name()} has an equipped item ({item_template.entry} - {item_template.name}) '
                                 f'with out of bounds display_id ({item_template.display_id}), '
                                 f'deleting in order to prevent crashes.')
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

                if item_instance.bag in self.containers and self.containers[item_instance.bag]:
                    self.containers[item_instance.bag].modify_container_slot(item_mgr.current_slot, item_mgr)

    def update_items_durations(self):
        for item in self.get_all_items():
            if item.duration:
                item.send_item_duration()

    def get_all_items(self, include_bank=False):
        items = []
        for container_slot, container in list(self.containers.items()):
            if not container:
                continue
            for slot, item in list(container.sorted_slots.items()):
                if not include_bank and self.is_bank_slot(container_slot, slot):
                    continue
                items.append(item)
        return items

    def get_backpack(self):
        return self.containers[InventorySlots.SLOT_INBACKPACK]

    def get_container_slot_by_guid(self, container_guid):
        for slot in self.containers.keys():
            container = self.get_container(slot)
            if container and container.guid == container_guid:
                return slot
        return InventorySlots.SLOT_INBACKPACK.value

    def add_item(self, entry=0, item_template=None, count=1, handle_error=True, looted=False, created_by=0,
                 perm_enchant=0, send_message=True, show_item_get=True):
        if entry != 0 and not item_template:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
        amount_left = count
        target_bag_slot = -1  # Highest bag slot items were added to

        if item_template:
            error = self.can_store_item(item_template, count)
            if error != InventoryError.BAG_OK:
                if handle_error:
                    self.send_equip_error(error)
                return False

            # Add to any existing stacks.
            for slot, container in self.containers.items():
                if (not container or not container.can_contain_item(item_template) or
                        self.is_bank_slot(container.current_slot, slot)):
                    continue
                amount_left = container.add_item_to_existing_stacks(item_template, amount_left)

                if amount_left <= 0:
                    target_bag_slot = slot
                    break

            if amount_left > 0:
                for slot, container in self.containers.items():
                    if not container or not container.can_contain_item(item_template):
                        continue
                    prev_left = amount_left
                    amount_left, item_mgr = container.add_item(item_template, count=amount_left,
                                                               perm_enchant=perm_enchant, check_existing=False,
                                                               created_by=created_by)
                    # New item, apply enchantments and persist.
                    if item_mgr:
                        # Load enchantments, if any.
                        self.owner.enchantment_manager.load_enchantments_for_item(item_mgr)
                        # Persist.
                        item_mgr.save()

                    if slot != InventorySlots.SLOT_INBACKPACK and prev_left > amount_left and slot > target_bag_slot:
                        target_bag_slot = slot

                    if amount_left <= 0:
                        break

        # Default to backpack if bag slot was not set.
        if target_bag_slot == -1:
            target_bag_slot = InventorySlots.SLOT_INBACKPACK

        items_added = amount_left != count
        if items_added:
            if show_item_get:
                self.send_item_receive_message(self.owner.guid, item_template.entry,
                                               target_bag_slot, looted, send_message)
            # Update quest item count, if needed.
            self.owner.quest_manager.reward_item(item_template.entry, item_count=count)

        return items_added

    def add_item_to_slot(self, dest_bag_slot, dest_slot, entry=0, item=None, item_template=None, count=1,
                         handle_error=True):
        created_by = 0 if not item else item.item_instance.creator
        if entry != 0 and not item_template:
            item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
        if not item_template:
            if handle_error:
                self.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return False

        dest_container = self.get_container(dest_bag_slot)
        if not dest_container:
            self.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return False

        dest_item = dest_container.get_item(dest_slot)

        error = self.can_store_item(item_template, count)
        if error != InventoryError.BAG_OK:
            if handle_error:
                self.send_equip_error(error)
            return False

        is_valid_target_slot = self.item_can_be_moved_to_slot(item_template, dest_slot, dest_bag_slot, item)

        if not is_valid_target_slot:
            return False

        if dest_slot == 0xFF:  # Dragging an item to bag bar. Acts like adding item but with container priority
            dest_slot = dest_container.next_available_slot()
            remaining = count

            # Add items to target container.
            if not dest_slot == -1:  # If the target container has a slot open.
                remaining, item_mgr = dest_container.add_item(item_template, count=count, created_by=created_by)

            # Overflow to inventory.
            if remaining > 0:
                self.add_item(item_template=item_template, count=remaining, created_by=created_by)

            return True

        # Stack handling
        if dest_item:
            if self.is_inventory_pos(dest_bag_slot, dest_slot):
                if item_template.entry == dest_item.item_template.entry:
                    diff = dest_item.item_template.stackable - dest_item.item_instance.stackcount
                    if diff >= count:
                        new_stack_count = dest_item.item_instance.stackcount + count
                        dest_item.set_stack_count(new_stack_count)
                    else:
                        new_stack_count = dest_item.item_instance.stackcount + diff
                        dest_item.set_stack_count(new_stack_count)
                        self.add_item(item_template=item_template, count=count-diff, handle_error=False)

                    return True
                else:
                    if handle_error:
                        self.send_equip_error(InventoryError.BAG_CANT_STACK, item, dest_item)
                    return False
            else:
                if handle_error:
                    self.send_equip_error(InventoryError.BAG_NOT_EQUIPPABLE, item, dest_item)
                return False

        generated_item = dest_container.set_item(item_template, dest_slot, count=count, created_by=created_by)
        # Add to containers if a bag was dragged to bag slots
        if dest_container.is_backpack and self.is_bag_pos(dest_slot):
            self.add_bag(dest_slot, generated_item)

        if dest_container.is_backpack and \
                (self.is_equipment_pos(dest_bag_slot, dest_slot) or self.is_bag_pos(dest_slot)):  # Added equipment or bag
            self.handle_equipment_change(generated_item)
            generated_item.save()

        return True

    def swap_item(self, source_bag, source_slot, dest_bag, dest_slot):
        source_container = self.get_container(source_bag)
        dest_container = self.get_container(dest_bag)
        if not source_container or not dest_container:
            return

        source_item = source_container.get_item(source_slot)
        dest_item = dest_container.get_item(dest_slot)

        if source_bag == dest_bag and source_slot == dest_slot:
            return
        if not source_item:
            return

        source_to_dest = self.item_can_be_moved_to_slot(source_item.item_template, dest_slot, dest_bag, source_item, source_container)
        dest_to_source = True  # If dest_item doesn't exist, default to True
        if dest_item:
            dest_to_source = self.item_can_be_moved_to_slot(dest_item.item_template, source_slot, source_bag, dest_item, dest_container)
        if not source_to_dest or (dest_item and not dest_to_source):
            return

        # Stack handling
        if dest_item and source_item.item_template.entry == dest_item.item_template.entry \
                and dest_item.item_template.stackable > dest_item.item_instance.stackcount:
            diff = dest_item.item_template.stackable - dest_item.item_instance.stackcount
            if diff >= source_item.item_instance.stackcount:
                new_stack_count = dest_item.item_instance.stackcount + source_item.item_instance.stackcount
                dest_item.set_stack_count(new_stack_count)
                # Add items to dest stack.
                self.remove_item(source_bag, source_slot, True)  # Remove the source item.
            else:
                # Update stack values.
                new_stack_count = source_item.item_instance.stackcount - diff
                source_item.set_stack_count(new_stack_count)
                new_stack_count = dest_item.item_template.stackable
                dest_item.set_stack_count(new_stack_count)

            return

        # Remove source item.
        self.remove_item(source_bag, source_slot, False, dest_item)

        # Remove dest item, if any.
        if dest_item:
            self.remove_item(dest_bag, dest_slot, False, source_item)

        # Register bags if source/dest are bag slots
        if dest_container.is_backpack and self.is_bag_pos(dest_slot):
            self.add_bag(dest_slot, source_item)
            RealmDatabaseManager.character_inventory_update_container_contents(source_item)

        if dest_container.is_backpack and dest_item and self.is_bag_pos(source_slot):
            self.add_bag(source_slot, dest_item)
            RealmDatabaseManager.character_inventory_update_container_contents(dest_item)

        dest_container.set_item(source_item, dest_slot, is_swap=True)

        if dest_item:
            source_container.set_item(dest_item, source_slot, count=dest_item.item_instance.stackcount, is_swap=True)
            dest_item.set_bag(source_bag)
            dest_item.item_instance.slot = source_slot

        # Equipment-specific behaviour: binding, offhand unequip, equipment update packet etc.
        if (source_container.is_backpack and
                (self.is_equipment_pos(source_bag, source_slot) or self.is_bag_pos(source_slot))) or \
           (dest_container.is_backpack and
                (self.is_equipment_pos(dest_bag, dest_slot) or self.is_bag_pos(dest_slot))):
            # Added/removed equipment or bag.
            self.handle_equipment_change(source_item, dest_item)

        # Finally, update items and client
        source_item.save()
        if dest_item:
            dest_item.save()

    def get_item_count(self, entry, include_bank=False):
        return sum(item.item_instance.stackcount for item in self.get_all_items(include_bank=include_bank)
                   if item.item_template.entry == entry)

    def get_container(self, slot):
        # The client sometimes refers to backpack with values over to SLOT_BANK_END
        if slot > InventorySlots.SLOT_BANK_END:
            slot = InventorySlots.SLOT_INBACKPACK
        if slot in self.containers:
            return self.containers[slot]
        return None

    def get_item(self, bag, slot):
        container = self.get_container(bag)
        if container:
            return container.get_item(slot)
        return None

    def get_first_item_by_entry(self, entry):
        for item in self.get_all_items():
            if item.item_template.entry == entry:
                return item
        return None

    # Clear_slot should be set as False if another item will be placed in this slot (swap_item)
    def remove_item(self, target_bag, target_slot, clear_slot=True, swap_item=None):
        target_container = self.get_container(target_bag)
        if not target_container:
            return
        target_item = target_container.get_item(target_slot)
        if not target_item:
            return

        # We are not really removing this slot, source and destination slots will be replaced by swap_item().
        if not swap_item:
            target_container.remove_item_in_slot(target_slot)

        if clear_slot:
            RealmDatabaseManager.character_inventory_delete(target_item.item_instance)

        if not swap_item and target_container.is_backpack and \
                self.is_bag_pos(target_slot) and self.get_container(target_slot):  # Equipped bags
            self.remove_bag(target_slot)

        if not swap_item and clear_slot:
            # Update the quest db state if needed. (Destroying item affects a quest, or forced update).
            self.owner.quest_manager.pop_item(target_item.item_template.entry)

            # Update equipment.
            if target_item.is_equipped() or clear_slot:
                self.handle_equipment_change(target_item)

        if clear_slot:
            self.owner.enqueue_packet(target_item.get_destroy_packet())

    def remove_items(self, entry, count, include_bank=False):
        for container_slot in self.containers:
            count = self.remove_from_container(entry, count, container_slot, include_bank=include_bank)
            if count == 0:
                break

        return count  # Return the amount of items not removed

    def remove_from_container_by_slots(self, container_slot, item_slot, item_count):
        if item_count == 0:
            return 0

        target_container = self.get_container(container_slot)
        if not target_container:
            return item_count

        item = target_container.get_item(item_slot)
        if item:
            new_stack_count = item.item_instance.stackcount - item_count
            item.set_stack_count(new_stack_count)
            if item.item_instance.stackcount == 0:
                self.remove_item(container_slot, item_slot, True)
            item_count = new_stack_count

        return item_count  # Return the amount of items not removed

    def remove_from_container(self, item_entry, item_count, container_slot, include_bank=False):
        if item_count == 0:
            return 0

        target_container = self.get_container(container_slot)
        if not target_container:
            return item_count

        for slot, item in list(target_container.sorted_slots.items()):
            if not include_bank and target_container.is_backpack and \
                    self.is_bank_slot(InventorySlots.SLOT_INBACKPACK, slot):
                continue

            if item.item_template.entry == item_entry:
                if item_count < item.item_instance.stackcount:
                    new_stack_count = item.item_instance.stackcount - item_count
                    item.set_stack_count(new_stack_count)
                    item_count = 0
                    break
                elif item_count >= item.item_instance.stackcount:
                    self.remove_item(container_slot, slot, True)
                    item_count -= item.item_instance.stackcount

        return item_count  # Return the amount of items not removed

    def get_item_by_guid(self, guid):
        for item in self.get_all_items():
            if item.guid == guid:
                return item
        return None

    def get_item_info_by_guid(self, guid):
        for container_slot, container in list(self.containers.items()):
            if not container:
                continue
            for slot, item in list(container.sorted_slots.items()):
                if item.guid == guid:
                    return container_slot, container, slot, item
        return -1, None, -1, None

    def add_bag(self, slot, container):
        slot = InventorySlots(slot)
        if not self.is_bag_pos(slot):
            return False

        if slot in self.get_backpack().sorted_slots and self.get_backpack().sorted_slots[slot] != container:
            self.get_backpack().modify_container_slot(slot, container)
        self.containers[slot] = container

        # Update items' bag slot field.
        for item in self.containers[slot].sorted_slots.values():
            item.set_bag(slot.value)
        return True

    def remove_bag(self, slot):
        slot = InventorySlots(slot)
        if not self.is_bag_pos(slot) or not self.get_container(slot):
            return False

        if slot in self.get_backpack().sorted_slots:
            self.owner.enqueue_packet(self.get_backpack().sorted_slots[slot].get_destroy_packet())
            self.get_backpack().modify_container_slot(slot, None, delete_item=True)

        self.containers[slot] = None

        return True

    def get_empty_slots(self):
        empty_slots = 0
        for slot, container in self.containers.items():
            if container:
                empty_slots += container.get_empty_slots()
        return empty_slots

    def can_store_item(self, item_template, count, on_bank=False):
        amount = count

        # Reached unique limit
        if 0 < item_template.max_count <= self.get_item_count(item_template.entry, include_bank=True):
            return InventoryError.BAG_ITEM_MAX_COUNT_EXCEEDED

        # Check bags
        if not on_bank:
            for slot, container in self.containers.items():
                if not container or not container.can_contain_item(item_template):
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
            for x in range(InventorySlots.SLOT_BANK_ITEM_START, InventorySlots.SLOT_BANK_ITEM_END):
                if x not in self.get_backpack().sorted_slots:
                    amount -= item_template.stackable
                    continue
                item_mgr = self.get_backpack().sorted_slots[x]
                if item_mgr.item_template.entry == item_template.entry:
                    amount -= item_template.stackable - item_mgr.item_instance.stackcount

        if amount <= 0:
            return InventoryError.BAG_OK

        for container_slot, container in list(self.containers.items()):
            if not container or container.is_backpack or not container.can_contain_item(item_template):
                continue
            if (on_bank and container_slot < InventorySlots.SLOT_BANK_BAG_1) or \
                    (not on_bank and container_slot >= InventorySlots.SLOT_BANK_BAG_1):
                continue

            # Free slots * Max stack count
            amount -= (container.total_slots - len(container.sorted_slots)) * item_template.stackable
            if amount <= 0:
                return InventoryError.BAG_OK

        return InventoryError.BAG_INV_FULL

    def get_remaining_space(self, include_ammo=False):
        empty_slots = 0
        for container_slot, container in list(self.containers.items()):
            if not container:
                continue
            if not include_ammo:
                if not container.is_backpack and container.item_template.class_ != ItemClasses.ITEM_CLASS_CONTAINER:
                    continue
            empty_slots += container.get_empty_slots()
        return empty_slots

    def get_next_available_inventory_slot(self):
        for container_slot, container in list(self.containers.items()):
            if not container:
                continue
            if not container.is_full():
                return container_slot.value, container.next_available_slot()
        return -1, -1

    def get_next_available_slot_for_inv_type(self, inventory_type):
        if inventory_type == InventoryTypes.BAG:
            for container_slot, container in list(self.containers.items()):
                if not container:
                    return container_slot.value

        # Inventory types that can target multiple slots (bags handled separately)

        if inventory_type == InventoryTypes.FINGER:
            target_slots = (InventorySlots.SLOT_FINGERL.value,
                            InventorySlots.SLOT_FINGERR.value)
        elif inventory_type == InventoryTypes.TRINKET:
            target_slots = (InventorySlots.SLOT_TRINKETL.value,
                            InventorySlots.SLOT_TRINKETR.value)
        elif inventory_type == InventoryTypes.WEAPON and \
                self.owner.skill_manager.can_dual_wield() and not self.has_two_handed_weapon():
            target_slots = (InventorySlots.SLOT_MAINHAND.value,
                            InventorySlots.SLOT_OFFHAND.value)  # Offhand option is only valid when player can dual wield and doesn't have a 2H weapon (autoequip 1H weapon should replace 2H)
        else:
            target_slots = (ItemManager.get_inv_slot_by_type(inventory_type),)

        for slot in target_slots:
            if not self.get_backpack().get_item(slot):
                return slot

        return -1

    def item_can_be_moved_to_slot(self, source_template, dest_slot, dest_bag, source_item=None, source_container=None):
        dest_container = self.get_container(dest_bag)
        if not dest_container:
            self.send_equip_error(InventoryError.BAG_ITEM_NOT_FOUND)
            return False

        dest_item = dest_container.get_item(dest_slot)

        if not source_template:
            return False

        if not self.owner.is_alive:
            self.send_equip_error(InventoryError.BAG_NOT_WHILE_DEAD, source_item, dest_item)
            return False

        # Equipment requirements.
        if self.is_equipment_pos(dest_bag, dest_slot):
            # If the display id of the item is invalid, prevent equipping it to avoid a client crash on next login.
            if source_template.display_id > MAX_3368_ITEM_DISPLAY_ID:
                self.send_equip_error(InventoryError.BAG_NOT_EQUIPPABLE, source_item, dest_item)
                return False
            # Check if the player has the required level.
            if source_template.required_level > self.owner.level:
                self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, source_item, dest_item)
                return False
            # Check if the player has the required proficiency/skill.
            equip_result = self.owner.skill_manager.get_equip_result_for(source_template)
            if equip_result != InventoryError.BAG_OK:
                self.send_equip_error(equip_result, source_item, dest_item)
                return False

        # Destination slot (item type) check for paper doll and bag slots
        if dest_container.is_backpack:
            if (self.is_equipment_pos(dest_bag, dest_slot) and not ItemManager.item_can_go_in_paperdoll_slot(source_template, dest_slot)) or \
                    (self.is_bag_pos(dest_slot) and source_template.inventory_type != InventoryTypes.BAG):  # dest is paperdoll/bag slots but item isn't equipment/bag
                self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                return False

        # Bag item family checks
        if self.is_inventory_pos(dest_bag, dest_slot) and not dest_container.can_contain_item(source_template):
            self.send_equip_error(InventoryError.BAG_ITEM_CLASS_MISMATCH, source_item, dest_item)
            return False

        # Moving a container, excluding case where source and destination are bag slots
        # These cases are only relevant if the source item and source container exist
        if source_item and source_item.is_container() and source_container and not \
                (source_container.is_backpack and dest_container.is_backpack and self.is_bag_pos(
                    source_item.current_slot) and self.is_bag_pos(dest_slot)):
            if source_item.guid == dest_container.guid:  # Moving bag inside itself
                self.send_equip_error(InventoryError.BAG_NO_BAGS_IN_BAGS, source_item, dest_item)
                return False

            if source_container.is_backpack and self.is_bag_pos(
                    source_item.current_slot) and not source_item.is_empty():  # Moving non-empty bag from bag slots
                self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                return False

        source_is_weapon = source_template.inventory_type == InventoryTypes.WEAPON or \
            source_template.inventory_type == InventoryTypes.WEAPONOFFHAND

        # Dual wield check
        if source_is_weapon and dest_slot == InventorySlots.SLOT_OFFHAND and not \
                self.owner.skill_manager.can_dual_wield():  # Equipping weapon in OH without DW skill
            if dest_slot == InventorySlots.SLOT_OFFHAND and not \
                    self.owner.skill_manager.can_dual_wield():
                self.send_equip_error(InventoryError.BAG_NOT_EQUIPPABLE, source_item, dest_item)
                return False

        if dest_container.is_backpack and dest_slot == InventorySlots.SLOT_MAINHAND:
            current_oh = self.get_offhand()
            source_is_2h = source_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON
            # Equipping 2H with OH equipped but inv is full
            if current_oh and source_is_2h:
                error = self.can_store_item(current_oh.item_template, current_oh.item_instance.stackcount)
                if error != InventoryError.BAG_OK:
                    self.send_equip_error(InventoryError.BAG_CANT_SWAP, source_item, dest_item)
                    return False

        # Offhand equip
        if dest_container.is_backpack and dest_slot == InventorySlots.SLOT_OFFHAND and self.has_two_handed_weapon():
            self.send_equip_error(InventoryError.BAG_2HWEAPONBEINGWIELDED, source_item, dest_item)
            return False

        return True

    def handle_equipment_change(self, source_item, dest_item=None):
        # Binding
        if source_item.current_slot < InventorySlots.SLOT_INBACKPACK and \
                source_item.item_template.bonding == ItemBondingTypes.BIND_WHEN_EQUIPPED:
            source_item.set_binding(True)

        if dest_item and dest_item.current_slot < InventorySlots.SLOT_INBACKPACK and \
                dest_item.item_template.bonding == ItemBondingTypes.BIND_WHEN_EQUIPPED:
            dest_item.set_binding(True)

        # Offhand removal on 2H equip
        if source_item.is_equipped():
            current_oh = self.get_offhand()
            source_is_2h = source_item.item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON
            dest_is_2h = dest_item and dest_item.item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON
            # Case where OH is equipped and 2h is equipped, and it's possible to unequip OH.
            if current_oh and (source_is_2h or dest_is_2h):
                error = self.can_store_item(current_oh.item_template, current_oh.item_instance.stackcount)
                if error != InventoryError.BAG_OK:
                    return

                # Remove the offhand item from OH and add it to inventory.
                # This is necessary in case of a stacking offhand (3675) - otherwise swap_item to free slot would be valid.
                self.add_item(item_template=current_oh.item_template, count=current_oh.item_instance.stackcount,
                              send_message=False, show_item_get=False)
                self.remove_item(InventorySlots.SLOT_INBACKPACK, InventorySlots.SLOT_OFFHAND)

        # Handle cast interrupt and equipment effects.
        self.owner.spell_manager.handle_equipment_change(source_item, dest_item)
        self.owner.enchantment_manager.handle_equipment_change(source_item, dest_item)
        self.owner.equipment_proc_manager.handle_equipment_change(source_item, dest_item)

        # Bonus application.
        self.owner.stat_manager.apply_bonuses()

    def is_bag_pos(self, slot):
        return (InventorySlots.SLOT_BAG1 <= slot < InventorySlots.SLOT_INBACKPACK) or \
               (InventorySlots.SLOT_BANK_BAG_1 <= slot <= InventorySlots.SLOT_BANK_END)

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
        container = self.get_container(bag_slot)
        if not container:
            return False
        if container.is_backpack and \
                InventorySlots.SLOT_ITEM_START <= slot < InventorySlots.SLOT_ITEM_END:
            return True

        if InventorySlots.SLOT_BAG1 <= bag_slot <= InventorySlots.SLOT_BAG4:
            return slot < container.max_slot

        if BankSlots.BANK_SLOT_BAG_START <= bag_slot < BankSlots.BANK_SLOT_BAG_END:
            return slot < container.max_slot

        return False

    def get_main_hand(self):
        return self.get_backpack().get_item(InventorySlots.SLOT_MAINHAND)

    def get_offhand(self):
        return self.get_backpack().get_item(InventorySlots.SLOT_OFFHAND)

    def get_ranged(self):
        return self.get_backpack().get_item(InventorySlots.SLOT_RANGED)

    def get_bag_slot_for_ammo(self, ammo_type):
        # 0.9 patch notes imply that previously an ammo pouch or quiver was required to spend ammo.
        # ... ... Ammo will be fired from a quiver, ammo pouch, or any other bag.
        # Quivers and ammo pouches **are no longer required.**
        # The client also does not allow any ranged casts without the required ammo pouch/quiver.
        for slot, container in self.containers.items():
            if not container or container.is_backpack:
                continue

            container_class = container.item_template.class_
            container_subclass = container.item_template.subclass

            if container_class != ItemClasses.ITEM_CLASS_QUIVER:
                continue

            if ammo_type == ItemSubClasses.ITEM_SUBCLASS_ARROW:
                if container_subclass == ItemSubClasses.ITEM_SUBCLASS_QUIVER:
                    return slot
                continue

            # Must be bullets.
            if container_subclass == ItemSubClasses.ITEM_SUBCLASS_BULLET:
                return slot
            continue

        return -1

    def has_main_weapon(self):
        item = self.get_main_hand()
        return item and (item.item_template.inventory_type == InventoryTypes.WEAPONMAINHAND or
                         item.item_template.inventory_type == InventoryTypes.WEAPON)

    def has_offhand(self):
        return self.get_offhand() is not None

    def has_offhand_weapon(self):
        item = self.get_offhand()
        return item and (item.item_template.inventory_type == InventoryTypes.WEAPONOFFHAND or
                         item.item_template.inventory_type == InventoryTypes.WEAPON)

    def has_two_handed_weapon(self):
        item = self.get_main_hand()
        return item and item.item_template.inventory_type == InventoryTypes.TWOHANDEDWEAPON

    def has_ranged_weapon(self):
        return self.get_ranged() is not None

    # Note: Not providing item_1 or item_2 can cause client-side greyed-out items.
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
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_INVENTORY_CHANGE_FAILURE, data))

    def send_buy_error(self, error, entry, vendor_guid=0, quantity=0):
        data = pack(
            '<QI2B',
            vendor_guid if vendor_guid > 0 else self.owner.guid,
            entry,
            quantity,
            error
        )
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_BUY_FAILED, data))

    def send_sell_error(self, error, item_guid, vendor_guid=0):
        data = pack(
            '<2QB',
            vendor_guid if vendor_guid > 0 else self.owner.guid,
            item_guid,
            error
        )
        self.owner.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_SELL_ITEM, data))

    def send_item_receive_message(self, guid, item_entry, bag_slot, looted=False, show_in_chat=True):
        if bag_slot == InventorySlots.SLOT_INBACKPACK:
            bag_slot = 0xFF
        data = pack(
            '<Q2IBI',
            guid, not looted, show_in_chat, bag_slot, item_entry
        )

        packet = PacketWriter.get_packet(OpCode.SMSG_ITEM_PUSH_RESULT, data)
        if looted and self.owner.group_manager:
            self.owner.group_manager.send_packet_to_members(packet, source=self.owner, surrounding_only=True)
        else:
            self.owner.enqueue_packet(packet)

    def reset_fields_older_than(self, now):
        for container_slot, container in list(self.containers.items()):
            if container:
                container.reset_fields_older_than(now)
                [item.reset_fields_older_than(now) for item in container.sorted_slots.values()]

    # Owner will check for backpack/inventory changes, and if it has pending changes on other bags/items.
    def has_pending_updates(self):
        if self.has_backpack_changes():
            return True
        return any(container.has_pending_updates() for container in list(self.containers.values()) if container)

    # Backpack items are changed on PlayerFields.
    # Owner must know if he has pending changes in inventory or main bag.
    def has_backpack_changes(self):
        return any([item.has_pending_updates() for item in self.get_backpack().sorted_slots.values()])

    def get_inventory_destroy_packets(self, requester):
        destroy_packets = {}
        for container_slot, container in list(self.containers.items()):
            if not container:
                continue

            # Only destroy containers to self, other players don't care about them.
            if requester.guid == self.owner.guid:
                destroy_packets[container.guid] = container.get_destroy_packet()

            for slot, item in list(container.sorted_slots.items()):
                if item and requester.guid == self.owner.guid or item.guid in requester.known_items:
                    destroy_packets[item.guid] = item.get_destroy_packet()
        return destroy_packets

    def get_inventory_update_packets(self, requester):
        item_templates = []
        create_packets = []
        partial_packets = []

        for container_slot, container in list(self.containers.items()):
            if not container:
                continue

            # Other players do not care about items out of their scope.
            if not container.is_backpack and requester != self.owner:
                continue

            if not container.is_backpack and requester == self.owner:
                # Add item query details if the requester does not know container item.
                if container.guid not in requester.known_items:
                    create_packets.append(self._get_update_packet_or_bytes(container, requester=requester))
                    item_templates.append(container.item_template)
                    requester.known_items[container.guid] = container
                # Requester knows this container, send a partial update.
                elif container.has_container_updates():
                    partial_packets.append(self._get_update_packet_or_bytes(container, requester=requester, partial=True))

            for slot, item in list(container.sorted_slots.items()):
                # Other players do not care about other items outside the inventory of another player.
                if (not item or (self.is_bag_pos(slot) or self.is_inventory_pos(container_slot, slot))
                        and requester != self.owner):
                    continue

                # Add item query details if the requester does not know this item.
                if item.guid not in requester.known_items:
                    create_packets.append(self._get_update_packet_or_bytes(item, requester=requester))
                    requester.known_items[item.guid] = item
                    item_templates.append(item.item_template)
                # Requester knows this item but has pending changes, send a partial update.
                elif item.has_pending_updates():
                    partial_packets.append(self._get_update_packet_or_bytes(item, requester=requester, partial=True))

            # Exit loop if this a request from another player.
            if container.is_backpack and requester != self.owner:
                break

        item_updates = ItemManager.get_item_query_packets(item_templates)
        return item_updates, create_packets, partial_packets

    def _get_update_packet_or_bytes(self, item_mgr, requester, partial=False):
        if partial:
            if requester == self.owner:
                return item_mgr.generate_partial_packet(requester=requester)
            else:
                return item_mgr.get_partial_update_bytes(requester=requester)
        else:
            if requester == self.owner:
                return item_mgr.generate_create_packet(requester=requester)
            else:
                return item_mgr.get_create_update_bytes(requester=requester)
