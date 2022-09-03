from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from utils.constants.MiscCodes import ObjectTypeIds, HighGuid, ObjectTypeFlags
from utils.constants.UpdateFields import ObjectFields, DynamicObjectFields


# TODO: Finish implementing.
class DynamicObjectManager(ObjectManager):
    CURRENT_HIGHEST_GUID = 50000

    def __init__(self, owner, location, radius, spell_id, dynamic_type, **kwargs):
        super().__init__(**kwargs)

        self.owner = owner.guid
        self.map_ = owner.map_
        self.location = location
        self.dynamic_type = dynamic_type
        self.spell_id = spell_id
        self.radius = radius

        DynamicObjectManager.CURRENT_HIGHEST_GUID += 1
        self.guid = DynamicObjectManager.CURRENT_HIGHEST_GUID

        self.object_type_mask |= ObjectTypeFlags.TYPE_DYNAMICOBJECT
        self.update_packet_factory.init_values(self.owner, DynamicObjectFields)

    # override
    def initialize_field_values(self):
        # Object fields.
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
        self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

        # DynamicObject fields.
        self.set_uint64(DynamicObjectFields.DYNAMICOBJECT_CASTER, self.owner)
        self.set_uint32(DynamicObjectFields.DYNAMICOBJECT_BYTES, self.dynamic_type)
        self.set_uint32(DynamicObjectFields.DYNAMICOBJECT_SPELLID, self.spell_id)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_RADIUS, self.radius)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_X, self.location.x)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_Y, self.location.y)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_Z, self.location.z)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_FACING, self.location.o)

        self.initialized = True

    @staticmethod
    def spawn(summoner, location, radius, spell_id, dynamic_type):
        dynamic_object = DynamicObjectManager(owner=summoner, location=location, radius=radius, spell_id=spell_id,
                                              dynamic_type=dynamic_type)
        MapManager.update_object(dynamic_object)
        return dynamic_object

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_DYNAMICOBJECT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_DYNAMICOBJECT
