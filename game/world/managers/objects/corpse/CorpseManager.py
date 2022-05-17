from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.units.player.PlayerManager import PlayerManager
from utils.constants.MiscCodes import ObjectTypeIds, HighGuid
from utils.constants.UpdateFields import ObjectFields, CorpseFields


# TODO: Finish implementing.
class CorpseManager(ObjectManager):
    CURRENT_HIGHEST_GUID = 0

    def __init__(self, owner: PlayerManager, **kwargs):
        super().__init__(**kwargs)

        self.owner = owner.guid
        self.location = owner.location
        self.current_scale = owner.current_scale
        self.native_display_id = owner.native_display_id
        self.current_display_id = owner.native_display_id

        CorpseManager.CURRENT_HIGHEST_GUID += 1
        self.guid = CorpseManager.CURRENT_HIGHEST_GUID

    # override
    def get_full_update_packet(self, requester):
        # Object fields.
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
        self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

        # Corpse fields.
        self.set_uint64(CorpseFields.CORPSE_FIELD_OWNER, self.owner)
        self.set_float(CorpseFields.CORPSE_FIELD_FACING, self.location.o)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_X, self.location.x)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_Y, self.location.y)
        self.set_float(CorpseFields.CORPSE_FIELD_POS_Z, self.location.z)
        self.set_uint32(CorpseFields.CORPSE_FIELD_DISPLAY_ID, self.native_display_id)

        return self.get_object_create_packet(requester)

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_CORPSE

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_CORPSE
