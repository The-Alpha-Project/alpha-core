from functools import lru_cache
from struct import pack
from typing import List

from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.realm.RealmModels import CharacterInventory, CharacterGifts
from database.world.WorldDatabaseManager import WorldDatabaseManager
from database.world.WorldModels import ItemTemplate
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.item.EnchantmentHolder import EnchantmentHolder
from game.world.managers.objects.item.Stats import DamageStat, Stat, SpellStat
from game.world.managers.objects.units.player.EnchantmentManager import MAX_ENCHANTMENTS
from network.packet.PacketWriter import PacketWriter
from game.world.managers.objects.item.ItemLootManager import ItemLootManager
from utils.ByteUtils import ByteUtils
from utils.Logger import Logger
from utils.constants.ItemCodes import InventoryTypes, InventorySlots, ItemDynFlags, ItemClasses, ItemFlags
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, HighGuid, ItemBondingTypes
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import ObjectFields, ItemFields, PlayerFields

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

GIFT_ENTRY_RELATIONSHIP = {
    5014: 5015,  # Wrapping Paper (PT) -> Wrapped Item (PT).
    5042: 5043,  # Red Ribboned Wrapping Paper -> Red Ribboned Gift.
    5047: 5045,  # Skull Wrapping Paper -> Skull Gift.
    5048: 5044,  # Blue Ribboned Wrapping Paper -> Blue Ribboned Gift.
    5049: 5046   # Self-locking Ironpaper -> Locked Gift.
}


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
        self.duration = item_instance.duration if item_instance else 0

        self.enchantments = []  # Handled by EnchantmentManager.
        self.stats = []
        self.damage_stats = []
        self.spell_stats = []
        self.lock = 0  # Unlocked (0)
        self.display_id = 0
        self.loot_manager = None  # Optional.
        self.equip_slot = 0

        if self.item_template:
            self.load_item_template(self.item_template)

        self.update_packet_factory.init_values(self.get_owner_guid(), ItemFields)

    def load_item_template(self, item_template):
        self.item_template = item_template
        if self.item_template:
            self.entry = self.item_template.entry
            self.display_id = self.item_template.display_id
            self.equip_slot = self.get_inv_slot_by_type(self.item_template.inventory_type)
            self.enchantments = [EnchantmentHolder() for _ in range(MAX_ENCHANTMENTS)]
            self.stats = Stat.generate_stat_list(self.item_template)
            self.damage_stats = DamageStat.generate_damage_stat_list(self.item_template)
            self.spell_stats = SpellStat.generate_spell_stat_list(self.item_template)
            self.lock = self.item_template.lock_id
            # Do dont restore duration.
            self.duration = self.item_template.duration if not self.duration else self.duration

            # Load loot_manager if needed.
            if self.item_template.flags & ItemFlags.ITEM_FLAG_HAS_LOOT:
                self.loot_manager = ItemLootManager(self)

            # Reload fields if this item was already initialized.
            if self.initialized:
                self.initialized = False
                self.initialize_field_values()

    def is_container(self):
        if self.item_template:
            return self.item_template.inventory_type == InventoryTypes.BAG
        return False

    def is_equipped(self):
        player_mgr = self._get_owner_unit()
        return (player_mgr and self.item_instance.bag == InventorySlots.SLOT_INBACKPACK.value
                and self.current_slot < InventorySlots.SLOT_BAG1
                and player_mgr.get_uint64(PlayerFields.PLAYER_FIELD_INV_SLOT_1 + self.current_slot * 2) == self.guid)

    def is_soulbound(self):
        # I don't think quest items were soulbound in 0.5.3, so not checking.
        if self.item_template.bonding == ItemBondingTypes.BIND_WHEN_PICKED_UP:
            return True

        return self.item_instance.item_flags & ItemDynFlags.ITEM_DYNFLAG_BOUND == ItemDynFlags.ITEM_DYNFLAG_BOUND

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
            # Change count and bag for arrows and bullets.
            if item_template.inventory_type == InventoryTypes.AMMO:
                count = 100  # Start with 100 arrows / bullets.
                bag = InventorySlots.SLOT_BAG1.value  # Quiver / Pouch
                slot = 0
            else:
                slot = ItemManager.get_inv_slot_by_type(item_template.inventory_type)
                if slot >= InventorySlots.SLOT_INBACKPACK:
                    slot = last_bag_slot
                bag = InventorySlots.SLOT_INBACKPACK.value
                # Change count for food and water.
                if item_template.inventory_type == InventoryTypes.NONE_EQUIP \
                        and item_template.class_ == ItemClasses.ITEM_CLASS_CONSUMABLE:
                    count = 2 if item_template.spellid_1 == 430 else 4  # 430 spell -> Low level drink.
                # Rest of items start with 1 instance.
                else:
                    count = 1
            return ItemManager.generate_item(item_template, owner, bag, slot, stack_count=count)
        return None

    @staticmethod
    def generate_item(item_template, owner, bag, slot, perm_enchant=0, creator=0, stack_count=1):
        if item_template and item_template.entry > 0:
            item = CharacterInventory(
                owner=owner,
                creator=creator if creator and item_template.stackable == 1 else 0,
                item_template=item_template.entry,
                stackcount=stack_count,
                duration=item_template.duration,
                slot=slot,
                enchantments=ItemManager._get_enchantments_db_initialization(perm_enchant),
                SpellCharges1=item_template.spellcharges_1,
                SpellCharges2=item_template.spellcharges_2,
                SpellCharges3=item_template.spellcharges_3,
                SpellCharges4=item_template.spellcharges_4,
                SpellCharges5=item_template.spellcharges_5,
                bag=bag,
                item_flags=0  # Dynamic flags start at 0. Static flags are filled at runtime from item template.
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
        )
        return data

    @staticmethod
    def generate_query_details_data(item_template):
        # Initialize stat values if none are supplied.
        stats = Stat.generate_stat_list(item_template)
        damage_stats = DamageStat.generate_damage_stat_list(item_template)
        spell_stats = SpellStat.generate_spell_stat_list(item_template)

        item_name_bytes = PacketWriter.string_to_bytes(item_template.name)
        data = bytearray(pack(
            f'<3I{len(item_name_bytes)}ssss6I2i7I',
            item_template.entry,
            item_template.class_,
            item_template.subclass,
            item_name_bytes, b'\x00', b'\x00', b'\x00',
            item_template.display_id,
            item_template.quality,
            item_template.flags,
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
        ))

        for stat in stats:
            data.extend(pack('<2i', stat.stat_type, stat.value))

        for damage_stat in damage_stats:
            data.extend(pack('<3i', int(damage_stat.minimum), int(damage_stat.maximum), damage_stat.stat_type))

        data.extend(pack(
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
        ))

        for spell_stat in spell_stats:
            data.extend(pack(
                '<6i',
                spell_stat.spell_id,
                spell_stat.trigger,
                spell_stat.charges,
                spell_stat.cooldown,
                spell_stat.category,
                spell_stat.category_cooldown,
            ))

        description_bytes = PacketWriter.string_to_bytes(item_template.description)
        data.extend(pack(
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
        ))

        return data

    # override
    def initialize_field_values(self):
        # Initial field values, after this, fields must be modified by setters or directly writing values to them.
        if not self.initialized and self.item_template and self.item_instance:
            from game.world.managers.objects.item.ContainerManager import ContainerManager

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.item_template.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, 1)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Item fields.
            self.set_uint64(ItemFields.ITEM_FIELD_OWNER, self.item_instance.owner)
            self.set_uint64(ItemFields.ITEM_FIELD_CREATOR, self.item_instance.creator)  # Wrapped/Crafted Items.
            self.set_uint32(ItemFields.ITEM_FIELD_DURATION, self.item_instance.duration)
            self.set_uint64(ItemFields.ITEM_FIELD_CONTAINED, self.get_contained())
            self.set_uint32(ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount)
            self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self._get_item_flags())

            # Spell charges.
            for slot in range(5):
                charges = eval(f'self.item_instance.SpellCharges{slot + 1}')
                self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + slot, charges if self.has_charges() else -1)
            
            # Enchantments.
            for slot in range(MAX_ENCHANTMENTS):
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, self.enchantments[slot].entry)
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, self.enchantments[slot].duration)
                self.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, self.enchantments[slot].charges)

            # Container fields.
            if self.is_container() and isinstance(self, ContainerManager):
                self.build_container_update_packet()

            self.initialized = True

    def get_owner_guid(self):
        return self.item_instance.owner if self.item_instance else 0

    def get_creator_guid(self):
        return self.item_instance.creator if self.item_instance else 0

    def set_stack_count(self, count):
        if self.item_instance:
            self.item_instance.stackcount = count
            if self.set_uint32(ItemFields.ITEM_FIELD_STACK_COUNT, self.item_instance.stackcount)[0]:
                self.save()

    # noinspection PyMethodMayBeStatic
    def has_charges(self):
        for index in range(5):
            charges = eval(f'self.item_instance.SpellCharges{index + 1}')
            if charges:
                return True
        return False

    def set_charges(self, spell_id, charges):
        for index, spell_stats in enumerate(self.spell_stats):
            if spell_stats.spell_id == spell_id:
                if self.set_int32(ItemFields.ITEM_FIELD_SPELL_CHARGES + index, charges)[0] and self.item_instance:
                    # Update our item_instance, else charges wont serialize properly.
                    exec(f'self.item_instance.SpellCharges{index + 1} = {charges}')
                    self.save()
                break

    def get_charges(self, spell_id):
        if self.item_instance:
            for index, spell_stats in enumerate(self.spell_stats):
                if spell_stats.spell_id == spell_id:
                    return eval(f'self.item_instance.SpellCharges{index + 1}')
        return 0

    def charges_removes_item(self, spell_id):
        for index, spell_stats in enumerate(self.spell_stats):
            if spell_stats.spell_id == spell_id:
                return eval(f'self.item_template.spellcharges_{index + 1}') == -1
        return False

    def set_unlocked(self):
        self.item_instance.item_flags |= ItemDynFlags.ITEM_DYNFLAG_UNLOCKED
        if self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self._get_item_flags())[0]:
            self.save()

    def has_flag(self, flag: ItemDynFlags):
        return self.item_instance.item_flags & flag

    # Transform an item into the wrapped item using the same item instance.
    def set_wrapped(self, player_mgr, wrapper_item_entry):
        gift_entry = GIFT_ENTRY_RELATIONSHIP.get(wrapper_item_entry)
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(gift_entry)
        if item_template:
            character_gift = CharacterGifts()
            character_gift.creator = self.get_creator_guid()  # Creator of the original item.
            character_gift.item_guid = self.get_low_guid()
            character_gift.entry = self.entry
            character_gift.flags = self.item_instance.item_flags
            RealmDatabaseManager.character_add_gift(character_gift)

            # Swap this item instance values to our wrapped item values.
            self.item_instance.item_template = item_template.entry
            self.item_instance.creator = player_mgr.guid  # Creator of the wrapped gift.
            self.item_instance.item_flags |= ItemDynFlags.ITEM_DYNFLAG_WRAPPED

            # Reload this item with its new template and instance values.
            self.load_item_template(item_template)
            self.save()
            return True
        return False

    # Transform a wrapped item into the actual item using the same item instance.
    def unwrap(self, character_gift):
        item_template = WorldDatabaseManager.ItemTemplateHolder.item_template_get_by_entry(character_gift.entry)
        if item_template:
            # Swap this item instance values to our wrapped item values.
            self.item_instance.item_template = item_template.entry
            self.item_instance.creator = character_gift.creator
            self.item_instance.item_flags &= ~ItemDynFlags.ITEM_DYNFLAG_WRAPPED
            # Reload this item with its new template and instance values.
            self.load_item_template(item_template)
            self.save()
            return True
        return False

    def set_binding(self, bind=True):
        if bind:
            self.item_instance.item_flags |= ItemDynFlags.ITEM_DYNFLAG_BOUND
        else:
            self.item_instance.item_flags &= ~ItemDynFlags.ITEM_DYNFLAG_BOUND
        # If field actually changed, save.
        if self.set_uint32(ItemFields.ITEM_FIELD_FLAGS, self._get_item_flags())[0]:
            self.save()

    def send_item_duration(self, owner_guid):
        if owner_guid != self.get_owner_guid():
            return

        player_mgr = WorldSessionStateHandler.find_player_by_guid(owner_guid)
        if not player_mgr:
            return

        data = pack('<QI', self.guid, self.duration)
        player_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_TIME_UPDATE, data))

    def _get_item_flags(self):
        # Prior to Patch 1.7 ITEM_FIELD_FLAGS 32 bit value was built using 2 16 bit integers, dynamic item flags and
        # static item flags. For example an item with ITEM_FIELD_FLAGS = 0x00010000 would mean that it has dynamic
        # flags = 0x0001 (ITEM_DYNFLAG_BOUND) and static flags = 0x0000.
        return ByteUtils.shorts_to_int(self.item_instance.item_flags, self.item_template.flags)

    # Enchantments.

    @staticmethod
    def get_enchantments_entries_from_db(item_instance: CharacterInventory):
        db_enchantments = item_instance.enchantments
        if not db_enchantments:
            return [0 for _ in range(MAX_ENCHANTMENTS)]
        values = db_enchantments.rsplit(',')
        return [int(values[slot * 3 + 0]) for slot in range(MAX_ENCHANTMENTS)]

    def has_enchantments(self):
        return any(enchantment.entry > 0 for enchantment in self.enchantments)

    # Initial enchantment db state, empty or initialized with given permanent enchant. (Used for trade or new items)
    @staticmethod
    @lru_cache
    def _get_enchantments_db_initialization(permanent_enchant=0):
        db_enchantments = ''
        for index in range(MAX_ENCHANTMENTS):
            db_enchantments += str(permanent_enchant if index == 0 else 0) + ','
            db_enchantments += str(0) + ','
            db_enchantments += str(0) + (',' if index != MAX_ENCHANTMENTS - 1 else '')
        return db_enchantments

    # Enchantments persistence.
    def _get_enchantments_db_string(self):
        db_enchantments = ''
        for index in range(MAX_ENCHANTMENTS):
            db_enchantments += str(self.enchantments[index].entry) + ','
            db_enchantments += str(self.enchantments[index].duration) + ','
            db_enchantments += str(self.enchantments[index].charges) + (',' if index != MAX_ENCHANTMENTS - 1 else '')
        return db_enchantments

    def remove(self):
        player_mgr = self._get_owner_unit()
        if player_mgr and self.item_instance and self.item_instance.bag:
            player_mgr.inventory.remove_item(self.item_instance.bag, self.current_slot)

    # Persist item in database.
    def save(self):
        if not self.item_instance:
            if not self.is_backpack:
                Logger.error(f'Item {self.get_name()} has no item instance, unable to save.')
            return
        if not self.get_owner_guid():
            Logger.error(f'Item {self.get_name()} has no owner, unable to save.')
            return
        self.item_instance.duration = self.duration
        self.item_instance.enchantments = self._get_enchantments_db_string()
        RealmDatabaseManager.character_inventory_update_item(self.item_instance)

    def _get_owner_unit(self):
        return WorldSessionStateHandler.find_player_by_guid(self.get_owner_guid())

    # override
    def get_name(self):
        return self.item_template.name if self.item_template else 'Backpack' if self.is_backpack else 'None'

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_ITEM

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_ITEM

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_ITEM

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_ITEM

    @staticmethod
    def get_item_query_packets(item_templates: List[ItemTemplate]) -> List[bytes]:
        packets = []

        # The client expects a response containing all requested items (with duplicates).
        # Attempting to optimize packet size by sending only unique items
        # leads to some items not having an icon (in bank only? Only case noticed when testing).

        query_data = bytearray()
        written_items = 0
        while item_templates:
            item = item_templates.pop()
            item_bytes = ItemManager.generate_query_details_data(item)

            # Normal packet header + uint32 (written_items) + length of the total query + length of the current query.
            exceeds_max_length = PacketWriter.HEADER_SIZE + 4 + len(query_data) + len(item_bytes) > PacketWriter.MAX_PACKET_SIZE
            if exceeds_max_length or not item_templates:
                if exceeds_max_length:
                    item_templates.append(item)
                else:
                    # Last item to send.
                    query_data.extend(item_bytes)
                    written_items += 1

                packet = pack(f'<I{len(query_data)}s', written_items, bytes(query_data))
                packets.append(PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_MULTIPLE_RESPONSE, packet))
                query_data.clear()
                written_items = 0
                continue

            query_data.extend(item_bytes)
            written_items += 1

        return packets
