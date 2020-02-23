from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterInventory
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter, OpCode
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.ItemCodes import InventoryTypes, InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, UpdateTypes
from utils.constants.UpdateFields import ObjectFields, ItemFields, ContainerFields

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
                 item_instance=None,
                 current_slot=0,
                 **kwargs):
        super().__init__(**kwargs)

        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_ITEM])

        self.item_template = item_template
        self.item_instance = item_instance
        self.guid = item_instance.guid if item_instance else 0
        self.current_slot = item_instance.slot if item_instance else 0
        self.is_contained = self.guid

        self.stats = []
        self.damage_stats = []
        self.spell_stats = []

        if item_template:
            self.display_id = item_template.display_id
            self.equip_slot = self.get_inv_slot_by_type(self.item_template.inventory_type)

            self.stats.append(ItemManager.Stat(self.item_template.stat_type1, self.item_template.stat_value1))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type2, self.item_template.stat_value2))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type3, self.item_template.stat_value3))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type4, self.item_template.stat_value4))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type5, self.item_template.stat_value5))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type6, self.item_template.stat_value6))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type7, self.item_template.stat_value7))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type8, self.item_template.stat_value8))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type9, self.item_template.stat_value9))
            self.stats.append(ItemManager.Stat(self.item_template.stat_type10, self.item_template.stat_value10))

            self.damage_stats.append(ItemManager.DamageStat(self.item_template.dmg_min1, self.item_template.dmg_max1,
                                                            self.item_template.dmg_type1))
            self.damage_stats.append(ItemManager.DamageStat(self.item_template.dmg_min2, self.item_template.dmg_max2,
                                                            self.item_template.dmg_type2))
            self.damage_stats.append(ItemManager.DamageStat(self.item_template.dmg_min3, self.item_template.dmg_max3,
                                                            self.item_template.dmg_type3))
            self.damage_stats.append(ItemManager.DamageStat(self.item_template.dmg_min4, self.item_template.dmg_max4,
                                                            self.item_template.dmg_type4))
            self.damage_stats.append(ItemManager.DamageStat(self.item_template.dmg_min5, self.item_template.dmg_max5,
                                                            self.item_template.dmg_type5))

            self.spell_stats.append(
                ItemManager.SpellStat(self.item_template.spellid_1, self.item_template.spelltrigger_1,
                                      self.item_template.spellcharges_1, self.item_template.spellcooldown_1,
                                      self.item_template.spellcategory_1, self.item_template.spellcategorycooldown_1))
            self.spell_stats.append(
                ItemManager.SpellStat(self.item_template.spellid_2, self.item_template.spelltrigger_2,
                                      self.item_template.spellcharges_2, self.item_template.spellcooldown_2,
                                      self.item_template.spellcategory_2, self.item_template.spellcategorycooldown_2))
            self.spell_stats.append(
                ItemManager.SpellStat(self.item_template.spellid_3, self.item_template.spelltrigger_3,
                                      self.item_template.spellcharges_3, self.item_template.spellcooldown_3,
                                      self.item_template.spellcategory_3, self.item_template.spellcategorycooldown_3))
            self.spell_stats.append(
                ItemManager.SpellStat(self.item_template.spellid_4, self.item_template.spelltrigger_4,
                                      self.item_template.spellcharges_4, self.item_template.spellcooldown_4,
                                      self.item_template.spellcategory_4, self.item_template.spellcategorycooldown_4))
            self.spell_stats.append(
                ItemManager.SpellStat(self.item_template.spellid_5, self.item_template.spelltrigger_5,
                                      self.item_template.spellcharges_5, self.item_template.spellcooldown_5,
                                      self.item_template.spellcategory_5, self.item_template.spellcategorycooldown_5))

        self.object_type.append(ObjectTypes.TYPE_ITEM)

    class Stat(object):
        def __init__(self, stat_type, value):
            self.stat_type = stat_type
            self.value = value

    class DamageStat(object):
        def __init__(self, minimum, maximum, stat_type):
            self.minimum = minimum
            self.maximum = maximum
            self.stat_type = stat_type

    class SpellStat(object):
        def __init__(self, spell_id, trigger, charges, cooldown, category, category_cooldown):
            self.spell_id = spell_id
            self.trigger = trigger
            self.charges = charges
            self.cooldown = cooldown
            self.category = category
            self.category_cooldown = category_cooldown

    def is_container(self):
        if self.item_template:
            return self.item_template.inventory_type == InventoryTypes.BAG
        return False

    def is_equipped(self):
        return self.current_slot < InventorySlots.SLOT_BAG1

    @staticmethod
    def get_inv_slot_by_type(inventory_type):
        return AVAILABLE_EQUIP_SLOTS[inventory_type if inventory_type <= 26 else 0].value

    @staticmethod
    def generate_item(world_session, owner, creator, bag, entry, slot=-1, count=1):
        item_template = WorldDatabaseManager.item_template_get_by_entry(world_session.world_db_session, entry)
        if item_template:
            if slot == -1:
                slot = ItemManager.get_inv_slot_by_type(item_template.inventory_type)
            item = CharacterInventory(
                owner=owner,
                player=creator,
                item_template=item_template.entry,
                stackcount=count,
                slot=slot,
                bag=bag
            )
            RealmDatabaseManager.character_inventory_add_item(world_session.realm_db_session, item)

            item_mgr = ItemManager(
                item_template=item_template,
                item_instance=item
            )
            return item_mgr
        return None

    def query_details(self):
        item_name_bytes = PacketWriter.string_to_bytes(self.item_template.name)
        data = pack(
            '<3I%ussss6I2i7I' % len(item_name_bytes),
            self.item_template.entry,
            self.item_template.class_,
            self.item_template.subclass,
            item_name_bytes, b'\x00', b'\x00', b'\x00',
            self.item_template.display_id,
            self.item_template.quality,
            self.item_template.flags,
            self.item_template.buy_price,
            self.item_template.sell_price,
            self.item_template.inventory_type,
            self.item_template.allowable_class,
            self.item_template.allowable_race,
            self.item_template.item_level,
            self.item_template.required_level,
            self.item_template.required_skill,
            self.item_template.required_skill_rank,
            self.item_template.max_count,
            self.item_template.stackable,
            self.item_template.container_slots
        )

        for stat in self.stats:
            data += pack('<Ii', stat.stat_type, stat.value)

        for damage_stat in self.damage_stats:
            data += pack('<3i', int(damage_stat.minimum), int(damage_stat.maximum), damage_stat.stat_type)

        data += pack(
            '<9I',
            self.item_template.armor,
            self.item_template.holy_res,
            self.item_template.fire_res,
            self.item_template.nature_res,
            self.item_template.frost_res,
            self.item_template.shadow_res,
            self.item_template.delay,
            self.item_template.ammo_type,
            0  # TODO: Durability, not implemented
        )

        for spell_stat in self.spell_stats:
            data += pack(
                '<5i',
                spell_stat.spell_id,
                spell_stat.trigger,
                spell_stat.charges,
                spell_stat.cooldown,
                spell_stat.category_cooldown
            )

        description_bytes = PacketWriter.string_to_bytes(self.item_template.description)
        data += pack(
            '<I%us5IiI' % len(description_bytes),
            self.item_template.bonding,
            description_bytes,
            self.item_template.page_text,
            self.item_template.page_language,
            self.item_template.page_material,
            self.item_template.start_quest,
            self.item_template.lock_id,
            self.item_template.material,
            self.item_template.sheath
        )

        return PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, data)

    # override
    def get_update_packet(self, update_type=UpdateTypes.UPDATE_FULL, is_self=True):
        if self.item_template and self.item_instance:
            from game.world.managers.objects.item.ContainerManager import MAX_BAG_SLOTS, ContainerManager

            # Object fields
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_GUID, self.guid, 'L')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value(), 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_ENTRY, self.item_template.entry, 'I')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_SCALE_X, 1, 'f')
            self.update_packet_factory.update(self.update_packet_factory.object_values, self.update_packet_factory.updated_object_fields, ObjectFields.OBJECT_FIELD_PADDING, 0, 'I')

            # Item fields
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_OWNER, self.item_instance.owner, 'L')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_CREATOR, self.item_instance.player, 'L')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_CONTAINED, self.is_contained, 'L')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount, 'I')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_FLAGS, self.item_template.flags, 'I')

            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_SPELL_CHARGES, self.item_instance.SpellCharges1, 'i')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_SPELL_CHARGES + 1, self.item_instance.SpellCharges2, 'i')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_SPELL_CHARGES + 2, self.item_instance.SpellCharges3, 'i')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_SPELL_CHARGES + 3, self.item_instance.SpellCharges4, 'i')
            self.update_packet_factory.update(self.update_packet_factory.item_values, self.update_packet_factory.updated_item_fields, ItemFields.ITEM_FIELD_SPELL_CHARGES + 4, self.item_instance.SpellCharges5, 'i')

            # Container fields
            if self.is_container() and isinstance(self, ContainerManager):
                self.update_packet_factory.update(self.update_packet_factory.container_values,
                                                  self.update_packet_factory.updated_container_fields,
                                                  ContainerFields.CONTAINER_FIELD_NUM_SLOTS,
                                                  self.item_template.container_slots, 'I')

                for x in range(0, MAX_BAG_SLOTS):
                    guid = self.sorted_slots[x] if x in self.sorted_slots else 0
                    self.update_packet_factory.update(self.update_packet_factory.container_values,
                                                      self.update_packet_factory.updated_container_fields,
                                                      ContainerFields.CONTAINER_FIELD_SLOT_1 + x * 2,
                                                      guid, 'L')

            packet = b''
            if update_type == UpdateTypes.UPDATE_FULL:
                packet += self.create_update_packet(is_self)
            else:
                packet += self.create_partial_update_packet(self.update_packet_factory)

            update_packet = packet + self.update_packet_factory.build_packet()
            return update_packet

    # override
    def get_type(self):
        return ObjectTypes.TYPE_ITEM

    # override
    def get_type_id(self):
        return ObjectTypeIds.TYPEID_ITEM
