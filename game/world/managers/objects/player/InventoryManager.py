from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.UpdatePacketFactory import UpdatePacketFactory, UpdateTypes
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, InventoryError
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
                if 19 <= container_mgr.current_slot <= 22 or 63 <= container_mgr.current_slot <= 68:
                    self.containers[item_instance.bag].sorted_slots[container_mgr.current_slot] = container_mgr
                    self.containers[container_mgr.current_slot] = container_mgr

        # Then load items
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(item_instance.item_template)
            if item_template:
                item_mgr = ItemManager(
                    item_template=item_template,
                    item_instance=item_instance
                )
                if item_mgr.is_container() and (19 <= item_mgr.current_slot <= 22 or
                                                63 <= item_mgr.current_slot <= 68):
                    continue
                if item_instance.bag in self.containers:
                    self.containers[item_instance.bag].sorted_slots[item_mgr.current_slot] = item_mgr

    def get_backpack(self):
        return self.containers[InventorySlots.SLOT_INBACKPACK]

    def add_item(self, entry, count=1):
        item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
        if item_template:
            if not self.can_store_item(item_template, count):
                self.owner.send_equip_error(InventoryError.EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)

            if count <= item_template.stackable:
                pass
            # TODO: Finish
        return None

    def get_item_count(self, entry):
        count = 0
        for container_slot, container in list(self.containers.items()):
            for slot, item in list(container.sorted_slots.items()):
                if item.item_template.entry == entry:
                    count += 1
        return count

    def can_store_item(self, item_template, count, on_bank=False):
        amount = count

        # Reached unique limit
        if 0 < item_template.max_count <= self.get_item_count(item_template.entry):
            return False

        # Check backpack or bank
        if not on_bank:
            for x in range(InventorySlots.SLOT_ITEM_START, InventorySlots.SLOT_ITEM_END):
                if x not in self.get_backpack():
                    amount -= item_template.stackable
        else:
            for x in range(InventorySlots.SLOT_BANK_ITEM_START, InventorySlots.SLOT_BANK_ITEM_END):
                if x not in self.get_backpack():
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
