from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.GuidManager import GuidManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from utils.ByteUtils import ByteUtils
from utils.constants.ItemCodes import InventorySlots
from utils.constants.MiscCodes import ObjectTypeIds, HighGuid, ObjectTypeFlags
from utils.constants.UpdateFields import ObjectFields, CorpseFields


class CorpseManager(ObjectManager):
    GUID_MANAGER = GuidManager()

    def __init__(self, owner: PlayerManager, **kwargs):
        super().__init__(**kwargs)

        self.owner = owner
        self.map_id = owner.map_id
        self.instance_id = owner.instance_id
        self.guild_id = owner.guild_manager.guild.guild_id if owner.guild_manager else 0
        self.location = owner.location.copy()
        self.current_scale = owner.current_scale
        self.native_display_id = owner.native_display_id
        self.current_display_id = owner.native_display_id
        self.ttl = 600  # 10 Minutes.
        self.name = f'Corpse - Player {self.owner.get_name()}'

        self.guid = self.generate_object_guid(CorpseManager.GUID_MANAGER.get_new_guid())

        self.update_packet_factory.init_values(self.owner.guid, CorpseFields)

    def __hash__(self):
        return self.guid

    # override
    def initialize_field_values(self):
        # Object fields.
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
        self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

        # Corpse fields.
        self.set_uint64(CorpseFields.CORPSE_FIELD_OWNER, self.owner.guid)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_X, self.location.x)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_Y, self.location.y)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_Z, self.location.z)
        self.set_float(CorpseFields.CORPSE_FIELD_FACING, self.location.o)
        self.set_uint32(CorpseFields.CORPSE_FIELD_DISPLAY_ID, self.native_display_id)

        for slot in range(InventorySlots.SLOT_HEAD, InventorySlots.SLOT_BAG1):
            item_mngr = self.owner.inventory.get_item(InventorySlots.SLOT_INBACKPACK, slot)
            if item_mngr and item_mngr.item_template:
                field_item = item_mngr.item_template.display_id | (item_mngr.item_template.inventory_type << 24)
                self.set_uint32(CorpseFields.CORPSE_FIELD_ITEM + slot, field_item)

        self.set_uint32(CorpseFields.CORPSE_FIELD_BYTES_1, self.get_bytes_1())
        self.set_uint32(CorpseFields.CORPSE_FIELD_BYTES_2, self.get_bytes_2())
        self.set_uint32(CorpseFields.CORPSE_FIELD_GUILD, self.guild_id)
        self.set_uint32(CorpseFields.CORPSE_FIELD_LEVEL, self.owner.level)

        self.initialized = True

    # override
    def get_bytes_1(self):
        return ByteUtils.bytes_to_int(
            self.owner.player.skin,
            self.owner.player.gender,
            self.owner.player.race,
            0
        )

    # override
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            self.owner.player.facialhair,
            self.owner.player.haircolour,
            self.owner.player.hairstyle,
            self.owner.player.face
        )

    # override
    def update(self, now):
        if now > self.last_tick > 0 and self.is_spawned:
            elapsed = now - self.last_tick
            self.ttl -= elapsed
            if self.ttl <= 0:
                self.despawn()
        self.last_tick = now

    def spawn(self, owner=None):
        self.owner.get_map().update_object(self)

    # override
    def get_name(self):
        return self.name

    # override
    def get_entry(self):
        if self.entry:
            return self.entry
        return 0

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_CORPSE

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_CORPSE

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_CORPSE

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_CORPSE
