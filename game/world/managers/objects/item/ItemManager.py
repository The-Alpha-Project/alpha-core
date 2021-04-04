from struct import pack

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterInventory
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, ItemDynFlags
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, ItemBondingTypes
from utils.constants.UpdateFields import ObjectFields, ItemFields

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

        self.item_template = item_template
        self.item_instance = item_instance
        self.guid = (item_instance.guid if item_instance else 0) | HighGuid.HIGHGUID_ITEM
        self.current_slot = item_instance.slot if item_instance else 0
        self.is_contained = item_instance.owner if item_instance else 0
        self.is_backpack = False

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
        self.update_packet_factory.init_values(ItemFields.ITEM_END)

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

    def is_soulbound(self):
        # I don't think quest items were soulbound in 0.5.3, so not checking
        if self.item_template.bonding == ItemBondingTypes.BIND_WHEN_PICKED_UP:
            return True

        return self.dynamic_flags & ItemDynFlags.ITEM_DYNFLAG_UNK16 == ItemDynFlags.ITEM_DYNFLAG_UNK16

    @staticmethod
    def get_inv_slot_by_type(inventory_type):
        return AVAILABLE_EQUIP_SLOTS[inventory_type if inventory_type <= 26 else 0].value

    @staticmethod
    def item_can_go_in_paperdoll_slot(item_template, slot):
        inventory_type = item_template.inventory_type
        if inventory_type == InventoryTypes.NONE_EQUIP:
            return False

        if inventory_type == InventoryTypes.FINGER:
            return slot == InventorySlots.SLOT_FINGERL or slot == InventorySlots.SLOT_FINGERR

        if inventory_type == InventoryTypes.TRINKET:
            return slot == InventorySlots.SLOT_TRINKETL or slot == InventorySlots.SLOT_TRINKETR

        if inventory_type == InventoryTypes.WEAPON:
            return slot == InventorySlots.SLOT_MAINHAND or slot == InventorySlots.SLOT_OFFHAND

        return slot == ItemManager.get_inv_slot_by_type(inventory_type)

    @staticmethod
    def generate_item_from_entry(entry):
        item_template = WorldDatabaseManager.item_template_get_by_entry(entry)

        if item_template:
            item_mgr = ItemManager(item_template=item_template)
            return item_mgr

        return None

    @staticmethod
    def generate_starting_item(owner, entry, last_bag_slot):
        item_template = WorldDatabaseManager.item_template_get_by_entry(entry)
        if item_template:
            if item_template.inventory_type == 24:  # Ammo
                count = 100
                bag = 19
                slot = 0
            else:
                slot = ItemManager.get_inv_slot_by_type(item_template.inventory_type)
                if slot >= InventorySlots.SLOT_INBACKPACK:
                    slot = last_bag_slot
                bag = InventorySlots.SLOT_INBACKPACK.value
                if item_template.inventory_type == 0 and item_template.class_ == 0:  # Food and Water
                    count = 2 if item_template.spellid_1 == 430 else 4
                else:
                    count = 1
            return ItemManager.generate_item(item_template, owner, bag, slot, count=count)
        return None

    @staticmethod
    def generate_item(item_template, owner, bag, slot, creator=0, count=1):
        if item_template and item_template.entry > 0:
            item = CharacterInventory(
                owner=owner,
                creator=creator,
                item_template=item_template.entry,
                stackcount=count,
                slot=slot,
                bag=bag,
                item_flags=item_template.flags
            )
            RealmDatabaseManager.character_inventory_add_item(item)

            if item_template.inventory_type == InventoryTypes.BAG:
                from game.world.managers.objects.item.ContainerManager import ContainerManager
                item_mgr = ContainerManager(
                    owner=owner,
                    item_template=item_template,
                    item_instance=item
                )
            else:
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
            self.item_instance.item_flags if self.item_instance else self.item_template.flags,
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
            data += pack('<2i', stat.stat_type, stat.value)

        for damage_stat in self.damage_stats:
            data += pack('<3i', int(damage_stat.minimum), int(damage_stat.maximum), damage_stat.stat_type)

        data += pack(
            '<6i3I',
            self.item_template.armor,
            self.item_template.holy_res,
            self.item_template.fire_res,
            self.item_template.nature_res,
            self.item_template.frost_res,
            self.item_template.shadow_res,
            self.item_template.delay,
            self.item_template.ammo_type,
            0  # Durability, not implemented
        )

        for spell_stat in self.spell_stats:
            data += pack(
                '<Q4i',
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
    def get_full_update_packet(self, is_self=True):
        if self.item_template and self.item_instance:
            from game.world.managers.objects.item.ContainerManager import ContainerManager

            # Object fields
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.item_template.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, 1)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Item fields
            self.set_uint64(ItemFields.ITEM_FIELD_OWNER, self.item_instance.owner)
            self.set_uint64(ItemFields.ITEM_FIELD_CREATOR, self.item_instance.creator)
            self.set_uint64(ItemFields.ITEM_FIELD_CONTAINED, self.is_contained)
            self.set_uint32(ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount)
            self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self.item_instance.item_flags)

            self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES, self.item_instance.SpellCharges1)
            self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + 1, self.item_instance.SpellCharges2)
            self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + 2, self.item_instance.SpellCharges3)
            self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + 3, self.item_instance.SpellCharges4)
            self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + 4, self.item_instance.SpellCharges5)

            # Container fields
            if self.is_container() and isinstance(self, ContainerManager):
                self.build_container_update_packet()

            return self.get_object_create_packet(is_self)

    def set_binding(self, bind=True):
        if bind:
            self.item_instance.item_flags |= ItemDynFlags.ITEM_DYNFLAG_UNK16
        else:
            self.item_instance.item_flags &= ~ItemDynFlags.ITEM_DYNFLAG_UNK16
        self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self.item_instance.item_flags)

    # override
    def get_type(self):
        return ObjectTypes.TYPE_ITEM

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_ITEM
