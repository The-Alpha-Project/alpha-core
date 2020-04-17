from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.UpdatePacketFactory import UpdatePacketFactory, UpdateTypes
from utils.ConfigManager import config
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, InventoryError
from utils.constants.ObjectCodes import BankSlots
from utils.constants.UpdateFields import PlayerFields


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

    def add_item(self, entry, count=1):
        item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
        if item_template:
            if not self.can_store_item(item_template, count):
                self.send_equip_error(InventoryError.BAG_INV_FULL)
                return None

            if count <= item_template.stackable:
                for slot, container in self.containers.items():
                    if not container.is_full():
                        item_mgr = container.add_item(item_template)
                        if item_mgr:
                            self.owner.send_update_self()
                            return item_mgr
        return None

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

            # Check backpack / paperdoll placement
            if source_container.is_backpack:
                if source_item.item_template.required_level > self.owner.level and \
                        self.is_equipment_pos(dest_bag, dest_slot):
                    # Not enough level
                    self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, source_item, dest_item)
                    return

            # Destination slot checks
            if dest_container.is_backpack:
                if self.is_equipment_pos(dest_bag, dest_slot) and dest_slot != source_item.equip_slot \
                        and source_item.equip_slot != InventorySlots.SLOT_INBACKPACK or \
                        self.is_bag_pos(dest_slot) and source_item.item_template.inventory_type != InventoryTypes.BAG:
                    self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                    return

            # Original item being swapped to backpack
            if dest_item and source_container.is_backpack:
                if self.is_equipment_pos(source_bag, source_slot) or self.is_bag_pos(source_slot):
                    # Wrong destination slot
                    if source_slot != dest_item.equip_slot and dest_item.equip_slot \
                            != InventorySlots.SLOT_INBACKPACK:
                        self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                        return

                    # Not enough level
                    if dest_item.item_template.required_level > self.owner.level:
                        self.send_equip_error(InventoryError.BAG_LEVEL_MISMATCH, source_item, dest_item)
                        return

                    # Wrong destination slot
                    if dest_item.item_template.class_ == InventoryTypes.BAG and self.is_equipment_pos(source_bag, source_slot):
                        self.send_equip_error(InventoryError.BAG_SLOT_MISMATCH, source_item, dest_item)
                        return

            # Prevent non empty bag in bag
            if (source_container.is_backpack or source_item and source_item.is_container()) and self.is_bag_pos(source_slot) \
                    and source_item and not source_item.is_empty():
                self.send_equip_error(InventoryError.BAG_NO_BAGS_IN_BAGS, source_item, dest_item)
                return
            elif (dest_container.is_backpack or dest_item and dest_item.is_container()) and self.is_bag_pos(dest_slot) \
                    and dest_item and not dest_item.is_empty():
                self.send_equip_error(InventoryError.BAG_NO_BAGS_IN_BAGS, dest_item, source_item)
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
                else:
                    # Update stack values
                    source_item.item_instance.stackcount -= diff
                    dest_item.item_instance.stackcount = dest_item.item_template.stackable

                self.owner.send_update_self()
                return

            # Actual transfer

            # Remove items
            if source_bag in self.containers:
                self.containers[source_bag].remove_item_in_slot(source_slot)
            if dest_bag in self.containers:
                self.containers[dest_bag].remove_item_in_slot(dest_slot)

            if source_item and self.is_bag_pos(source_slot):
                if source_item.is_empty():
                    self.remove_bag(source_slot)
                else:
                    self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                    return

            if dest_item and dest_item.is_backpack and self.is_bag_pos(dest_slot):
                if dest_item.is_empty():
                    self.remove_bag(dest_slot)
                else:
                    self.send_equip_error(InventoryError.BAG_NOT_EMPTY, source_item, dest_item)
                    return

            # Bag transfers
            if source_item and self.is_bag_pos(dest_slot) and source_item.is_container():
                self.add_bag(dest_slot, source_item)

            if dest_item and self.is_bag_pos(source_slot) and dest_item.is_container():
                self.add_bag(source_slot, dest_item)

            # Add items
            if source_item and source_bag in self.containers:
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

    def add_bag(self, slot, container):
        if not self.is_bag_pos(slot):
            return False

        if slot in self.get_backpack().sorted_slots and self.get_backpack().sorted_slots[slot] != container:
            self.get_backpack().sorted_slots[slot] = container
        self.containers[slot] = container

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

        # Check backpack or bank
        if not on_bank:
            for x in range(InventorySlots.SLOT_ITEM_START, InventorySlots.SLOT_ITEM_END):
                if x not in self.get_backpack().sorted_slots:
                    amount -= item_template.stackable
        else:
            for x in range(InventorySlots.SLOT_BANK_ITEM_START, InventorySlots.SLOT_BANK_ITEM_END):
                if x not in self.get_backpack().sorted_slots:
                    amount -= item_template.stackable
        if amount <= 0:
            return True

        for container_slot, container in list(self.containers.items()):
            if container.is_backpack:
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
        return bag_slot == InventorySlots.SLOT_INBACKPACK \
               and InventorySlots.SLOT_ITEM_START <= slot < InventorySlots.SLOT_ITEM_END

    def send_equip_error(self, error, item_1=None, item_2=None):
        data = pack('<B', error)
        if error != InventoryError.BAG_OK:
            if error == InventoryError.BAG_LEVEL_MISMATCH:
                data += pack('<I', item_1.item_template.required_level if item_1 else 0)
            data += pack(
                '<2QB',
                item_1.guid if item_1 else self.owner.guid,
                item_2.guid if item_2 else self.owner.guid,
                0
            )
        self.owner.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_INVENTORY_CHANGE_FAILURE, data))

    def build_update(self, update_packet_factory):
        for slot, item in self.get_backpack().sorted_slots.items():
            update_packet_factory.update(update_packet_factory.player_values,
                                         update_packet_factory.updated_player_fields,
                                         PlayerFields.PLAYER_FIELD_INV_SLOT_1 + item.current_slot * 2, item.guid, 'Q')

    def send_single_item_update(self, world_session, item, is_self):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT, item.get_update_packet(update_type=UpdateTypes.UPDATE_FULL,
                                                              is_self=False)))
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
