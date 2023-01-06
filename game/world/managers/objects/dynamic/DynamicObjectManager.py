from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.guids.GuidManager import GuidManager
from utils.constants.MiscCodes import ObjectTypeIds, HighGuid, ObjectTypeFlags
from utils.constants.UpdateFields import ObjectFields, DynamicObjectFields


# TODO: Finish implementing.
class DynamicObjectManager(ObjectManager):
    GUID_MANAGER = GuidManager()

    def __init__(self, owner, location, radius, effect, dynamic_type, ttl, **kwargs):
        super().__init__(**kwargs)

        self.summoner = owner
        self.owner = owner.guid
        self.map_ = owner.map_
        self.instance_id = owner.instance_id
        self.location = location.copy()
        self.dynamic_type = dynamic_type
        self.spell_id = effect.casting_spell.spell_entry.ID
        self.radius = radius
        self.ttl = ttl

        self.guid = self.generate_object_guid(DynamicObjectManager.GUID_MANAGER.get_new_guid())

        self.update_packet_factory.init_values(owner.guid, DynamicObjectFields)

    # override
    def initialize_field_values(self):
        # Object fields.
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
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

    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick
            if self.ttl > 0:
                self.ttl = max(0, self.ttl - elapsed)
                if self.ttl == 0:
                    self.destroy()

        self.last_tick = now

    @staticmethod
    def spawn(summoner, location, radius, effect, dynamic_type, ttl=-1):
        dynamic_object = DynamicObjectManager(owner=summoner, location=location, radius=radius, effect=effect,
                                              dynamic_type=dynamic_type, ttl=ttl)
        MapManager.spawn_object(world_object_instance=dynamic_object)
        return dynamic_object

    @classmethod
    def spawn_from_spell_effect(cls, effect, dynamic_type, orientation=0, ttl=-1):
        target = effect.casting_spell.initial_target

        # Target must be a vector.
        if isinstance(target, ObjectManager):
            target = target.location.copy()
        else:
            target = target.get_ray_vector(is_terrain=True)

        if orientation:
            target.o = orientation

        effect.casting_spell.dynamic_object = DynamicObjectManager.spawn(effect.casting_spell.spell_caster,
                                                                         target, effect.get_radius(), effect,
                                                                         dynamic_type, ttl=ttl)
        return effect.casting_spell.dynamic_object

    # override
    def get_charmer_or_summoner(self, include_self=False):
        charmer_or_summoner = self.charmer if self.charmer else self.summoner if self.summoner else None
        return charmer_or_summoner if charmer_or_summoner else self if include_self else None

    # override
    def is_temp_summon(self):
        return True

    # override
    def is_active_object(self):
        return FarSightManager.object_is_camera_view_point(self)

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_DYNAMICOBJECT

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_DYNAMICOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_DYNAMICOBJECT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_DYNAMICOBJECT
