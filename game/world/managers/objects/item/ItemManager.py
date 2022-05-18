from struct import pack, unpack
from typing import NamedTuple
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterInventory
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter, OpCode
from game.world.managers.objects.item.ItemLootManager import ItemLootManager
from utils.ByteUtils import ByteUtils
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, ItemDynFlags, ItemClasses, ItemFlags, \
    EnchantmentSlots
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, HighGuid, ItemBondingTypes
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


class SpellEnchantment(NamedTuple):
    entry: int
    duration: int
    charges: int


class ItemManager(ObjectManager):
    def __init__(self,
                 item_template,
                 item_instance=None,
                 current_slot=0,
                 **kwargs):
        super().__init__(**kwargs)

        self.item_template = item_template
        self.item_instance = item_instance

        self.guid = self.generate_object_guid(item_instance.guid if item_instance else 0)
        self.current_slot = item_instance.slot if item_instance else 0
        self.is_backpack = False
        self.enchantments: dict[int, SpellEnchantment] = {}

        self.stats = []
        self.damage_stats = []
        self.spell_stats = []

        if item_template:
            self.display_id = item_template.display_id
            self.equip_slot = self.get_inv_slot_by_type(self.item_template.inventory_type)

            self.stats = ItemManager.Stat.generate_stat_list(self.item_template)
            self.damage_stats = ItemManager.DamageStat.generate_damage_stat_list(self.item_template)
            self.spell_stats = ItemManager.SpellStat.generate_spell_stat_list(self.item_template, self.item_instance)

            # Load loot_manager if needed.
            if item_template.flags & ItemFlags.ITEM_FLAG_HAS_LOOT:
                self.loot_manager = ItemLootManager(self)

        self.object_type_mask |= ObjectTypeFlags.TYPE_ITEM
        self.update_packet_factory.init_values(ItemFields.ITEM_END)

    class Stat(object):
        def __init__(self, stat_type, value):
            self.stat_type = stat_type
            self.value = value

        @staticmethod
        def generate_stat_list(item_template):
            return [
                ItemManager.Stat(item_template.stat_type1, item_template.stat_value1),
                ItemManager.Stat(item_template.stat_type2, item_template.stat_value2),
                ItemManager.Stat(item_template.stat_type3, item_template.stat_value3),
                ItemManager.Stat(item_template.stat_type4, item_template.stat_value4),
                ItemManager.Stat(item_template.stat_type5, item_template.stat_value5),
                ItemManager.Stat(item_template.stat_type6, item_template.stat_value6),
                ItemManager.Stat(item_template.stat_type7, item_template.stat_value7),
                ItemManager.Stat(item_template.stat_type8, item_template.stat_value8),
                ItemManager.Stat(item_template.stat_type9, item_template.stat_value9),
                ItemManager.Stat(item_template.stat_type10, item_template.stat_value10)
            ]

    class DamageStat(object):
        def __init__(self, minimum, maximum, stat_type):
            self.minimum = minimum
            self.maximum = maximum
            self.stat_type = stat_type

        @staticmethod
        def generate_damage_stat_list(item_template):
            return [
                ItemManager.DamageStat(item_template.dmg_min1, item_template.dmg_max1, item_template.dmg_type1),
                ItemManager.DamageStat(item_template.dmg_min2, item_template.dmg_max2, item_template.dmg_type2),
                ItemManager.DamageStat(item_template.dmg_min3, item_template.dmg_max3, item_template.dmg_type3),
                ItemManager.DamageStat(item_template.dmg_min4, item_template.dmg_max4, item_template.dmg_type4),
                ItemManager.DamageStat(item_template.dmg_min5, item_template.dmg_max5, item_template.dmg_type5)
            ]

    class SpellStat(object):
        def __init__(self, spell_id, trigger, charges, cooldown, category, category_cooldown):
            self.spell_id = spell_id
            self.trigger = trigger
            self.charges = charges
            self.cooldown = cooldown
            self.category = category
            self.category_cooldown = category_cooldown

        @staticmethod
        def generate_spell_stat_list(item_template, item_instance=None):
            # Spell charges will use item template if there is no item instance available. This should allow for
            # serialization to work for charges as well.
            return [
                ItemManager.SpellStat(item_template.spellid_1, item_template.spelltrigger_1,
                                      item_template.spellcharges_1 if not item_instance else item_instance.SpellCharges1,
                                      item_template.spellcooldown_1, item_template.spellcategory_1,
                                      item_template.spellcategorycooldown_1),
                ItemManager.SpellStat(item_template.spellid_2, item_template.spelltrigger_2,
                                      item_template.spellcharges_2 if not item_instance else item_instance.SpellCharges2,
                                      item_template.spellcooldown_2, item_template.spellcategory_2,
                                      item_template.spellcategorycooldown_2),
                ItemManager.SpellStat(item_template.spellid_3, item_template.spelltrigger_3,
                                      item_template.spellcharges_3 if not item_instance else item_instance.SpellCharges3,
                                      item_template.spellcooldown_3, item_template.spellcategory_3,
                                      item_template.spellcategorycooldown_3),
                ItemManager.SpellStat(item_template.spellid_4, item_template.spelltrigger_4,
                                      item_template.spellcharges_4 if not item_instance else item_instance.SpellCharges4,
                                      item_template.spellcooldown_4, item_template.spellcategory_4,
                                      item_template.spellcategorycooldown_4),
                ItemManager.SpellStat(item_template.spellid_5, item_template.spelltrigger_5,
                                      item_template.spellcharges_5 if not item_instance else item_instance.SpellCharges5,
                                      item_template.spellcooldown_5, item_template.spellcategory_5,
                                      item_template.spellcategorycooldown_5)
            ]

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

        return self.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_BOUND == ItemDynFlags.ITEM_DYNFLAG_BOUND

    def has_charges(self):
        charges = [self.item_template.spellcharges_1, self.item_template.spellcharges_2,
                   self.item_template.spellcharges_3, self.item_template.spellcharges_4,
                   self.item_template.spellcharges_5]

        return any(charge != 0 for charge in charges)

    def get_contained(self):
        if not self.item_instance:
            return 0

        if self.item_instance.bag == InventorySlots.SLOT_INBACKPACK:
            return self.item_instance.owner
        else:
            player_mgr = WorldSessionStateHandler.find_player_by_guid(self.item_instance.owner)
            if player_mgr:
                return player_mgr.inventory.get_container(self.item_instance.bag).guid
        return 0

    def set_bag(self, bag):
        if self.item_instance:
            self.item_instance.bag = bag
            self.set_uint64(ItemFields.ITEM_FIELD_CONTAINED, self.get_contained())

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
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)

        if item_template:
            item_mgr = ItemManager(item_template=item_template)
            return item_mgr

        return None

    @staticmethod
    def generate_starting_item(owner, entry, last_bag_slot):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(entry)
        if item_template:
            # Change count and bag for arrows and bullets
            if item_template.inventory_type == InventoryTypes.AMMO:
                count = 100  # Start with 100 arrows / bullets
                bag = InventorySlots.SLOT_BAG1.value  # Quiver / Pouch
                slot = 0
            else:
                slot = ItemManager.get_inv_slot_by_type(item_template.inventory_type)
                if slot >= InventorySlots.SLOT_INBACKPACK:
                    slot = last_bag_slot
                bag = InventorySlots.SLOT_INBACKPACK.value
                # Change count for food and water
                if item_template.inventory_type == InventoryTypes.NONE_EQUIP \
                        and item_template.class_ == ItemClasses.ITEM_CLASS_CONSUMABLE:
                    count = 2 if item_template.spellid_1 == 430 else 4  # 430 spell -> Low level drink
                # Rest of items start with 1 instance
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

    def query_details_packet(self):
        data = self.query_details_data()
        return PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, data)

    def query_details_data(self):
        data = ItemManager.generate_query_details_data(
            self.item_template,
            self.item_instance.item_flags if self.item_instance else self.item_template.flags,
            self.stats,
            self.damage_stats,
            self.spell_stats,
            self.item_instance
        )
        return data

    @staticmethod
    def generate_query_details_data(item_template, item_flags=-1, stats=None, damage_stats=None, spell_stats=None, item_instance=None):
        # Initialize stat values if none are supplied.
        if not stats:
            stats = ItemManager.Stat.generate_stat_list(item_template)
        if not damage_stats:
            damage_stats = ItemManager.DamageStat.generate_damage_stat_list(item_template)
        if not spell_stats:
            spell_stats = ItemManager.SpellStat.generate_spell_stat_list(item_template, item_instance)

        item_name_bytes = PacketWriter.string_to_bytes(item_template.name)
        data = pack(
            f'<3I{len(item_name_bytes)}ssss6I2i7I',
            item_template.entry,
            item_template.class_,
            item_template.subclass,
            item_name_bytes, b'\x00', b'\x00', b'\x00',
            item_template.display_id,
            item_template.quality,
            item_flags if item_flags > -1 else item_template.flags,
            item_template.buy_price,
            item_template.sell_price,
            item_template.inventory_type,
            item_template.allowable_class,
            item_template.allowable_race,
            item_template.item_level,
            item_template.required_level,
            item_template.required_skill,
            item_template.required_skill_rank,
            item_template.max_count,
            item_template.stackable,
            item_template.container_slots
        )

        for stat in stats:
            data += pack('<2i', stat.stat_type, stat.value)

        for damage_stat in damage_stats:
            data += pack('<3i', int(damage_stat.minimum), int(damage_stat.maximum), damage_stat.stat_type)

        data += pack(
            '<6i3I',
            item_template.armor,
            item_template.holy_res,
            item_template.fire_res,
            item_template.nature_res,
            item_template.frost_res,
            item_template.shadow_res,
            item_template.delay,
            item_template.ammo_type,
            0  # Durability, not implemented client side.
        )

        for spell_stat in spell_stats:
            data += pack(
                '<Q4i',
                spell_stat.spell_id,
                spell_stat.trigger,
                spell_stat.charges,
                spell_stat.cooldown,
                spell_stat.category_cooldown
            )

        description_bytes = PacketWriter.string_to_bytes(item_template.description)
        data += pack(
            f'<I{len(description_bytes)}s5IiI',
            item_template.bonding,
            description_bytes,
            item_template.page_text,
            item_template.page_language,
            item_template.page_material,
            item_template.start_quest,
            item_template.lock_id,
            item_template.material,
            item_template.sheath
        )

        return data

    # override
    def get_full_update_packet(self, requester):
        if self.item_template and self.item_instance:
            from game.world.managers.objects.item.ContainerManager import ContainerManager

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.item_template.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, 1)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Item fields.
            self.set_uint64(ItemFields.ITEM_FIELD_OWNER, self.item_instance.owner)
            self.set_uint64(ItemFields.ITEM_FIELD_CREATOR, self.item_instance.creator)  # Wrapped Items
            self.set_uint64(ItemFields.ITEM_FIELD_CONTAINED, self.get_contained())
            self.set_uint32(ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount)
            self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self._get_item_flags())
            
            # Spell stats.
            for slot, spell_stat in enumerate(self.spell_stats):
                self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + slot, self.spell_stats[slot].charges)
            
            # Enchantments.
            for slot, enchantment in self.enchantments.items():
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, enchantment.entry)
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, enchantment.duration)
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, enchantment.charges)

            # Container fields.
            if self.is_container() and isinstance(self, ContainerManager):
                self.build_container_update_packet()

        return self.get_object_create_packet(requester)

    def get_owner_guid(self):
        return self.item_instance.owner if self.item_instance else 0

    def get_creator_guid(self):
        return self.item_instance.creator if self.item_instance else 0

    def get_permanent_enchant_value(self):
        return self.enchantments[EnchantmentSlots.PermanentSlot].entry if \
            EnchantmentSlots.PermanentSlot in self.enchantments else 0

    def set_stack_count(self, count):
        if self.item_instance:
            self.item_instance.stackcount = count
            self.set_uint32(ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount)

    def set_charges(self, spell_id, charges):
        for index, spell_stats in enumerate(self.spell_stats):
            if spell_stats.spell_id == spell_id:
                spell_stats.charges = charges
                # Update our item_instance, else charges wont serialize properly.
                if self.item_instance:
                    eval(f'self.item_instance.SpellCharges{index + 1} = {charges}')
                self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + index, charges)
                break

    def set_enchantment(self, slot, value, duration, charges):
        self.enchantments[slot] = SpellEnchantment(value, duration, charges)
        self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, value)
        self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, duration)
        self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, charges)

        # Notify player with duration.
        if slot != EnchantmentSlots.PermanentSlot:
            self.send_enchantment_duration(slot)

    def send_enchantment_duration(self, slot):
        if slot not in self.enchantments:
            return
        player = WorldSessionStateHandler.find_player_by_guid(self.get_owner_guid())
        if player:
            duration = int(self.enchantments[slot].duration / 1000) * 60  # Minutes
            data = pack('<Q2IQ', self.guid, slot, duration, player.guid)
            player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_ENCHANT_TIME_UPDATE, data))

    def set_binding(self, bind=True):
        if bind:
            self.item_instance.item_flags |= ItemDynFlags.ITEM_DYNFLAG_BOUND
        else:
            self.item_instance.item_flags &= ~ItemDynFlags.ITEM_DYNFLAG_BOUND
        self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self._get_item_flags())

    def _get_item_flags(self):
        # Prior to Patch 1.7 ITEM_FIELD_FLAGS 32 bit value was built using 2 16 bit integers, dynamic item flags and
        # static item flags. For example an item with ITEM_FIELD_FLAGS = 0x00010000 would mean that it has dynamic
        # flags = 0x0001 (ITEM_DYNFLAG_BOUND) and static flags = 0x0000.
        return ByteUtils.shorts_to_int(self.item_instance.item_flags, self.item_template.flags)

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_ITEM

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_ITEM
