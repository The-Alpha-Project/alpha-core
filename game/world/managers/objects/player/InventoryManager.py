from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.item.ContainerManager import ContainerManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.UpdatePacketFactory import UpdatePacketFactory, UpdateTypes
from utils.constants.ItemCodes import InventoryTypes, InventorySlots
from utils.constants.UpdateFields import PlayerFields


class InventoryManager(object):
    def __init__(self, owner):
        self.containers = dict()
        self.owner = owner

    def load_items(self, world_session):
        # Add backpack
        self.containers[InventorySlots.SLOT_INBACKPACK] = ContainerManager(is_backpack=True,
                                                                           owner=world_session.player_mgr.guid)

        character_inventory = RealmDatabaseManager.character_get_inventory(world_session.player_mgr.guid)

        # First load bags
        for item_instance in character_inventory:
            item_template = WorldDatabaseManager.item_template_get_by_entry(item_instance.item_template)
            if item_template and item_template.inventory_type == InventoryTypes.BAG:
                container_mgr = ContainerManager(
                    owner=world_session.player_mgr.guid,
                    item_template=item_template,
                    item_instance=item_instance
                )
                if 19 <= container_mgr.current_slot <= 22 or 63 <= container_mgr.current_slot <= 68:
                    self.containers[item_instance.slot] = container_mgr

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
