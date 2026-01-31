from struct import pack

from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.farsight.FarSightManager import FarSightManager
from game.world.managers.objects.GuidManager import GuidManager
from network.packet.PacketWriter import PacketWriter
from utils.ByteUtils import ByteUtils
from utils.constants.MiscCodes import ObjectTypeIds, HighGuid, ObjectTypeFlags
from utils.constants.OpCodes import OpCode
from utils.constants.UpdateFields import ObjectFields, DynamicObjectFields


# TODO: Finish implementing.
class DynamicObjectManager(ObjectManager):
    GUID_MANAGER = GuidManager()

    def __init__(self, owner, location, radius, effect, dynamic_type, ttl, **kwargs):
        super().__init__(**kwargs)

        self.summoner = owner
        self.targets = set()
        self.owner = owner
        self.map_id = owner.map_id
        self.instance_id = owner.instance_id
        self.location = location.copy()
        self.dynamic_type = dynamic_type
        self.spell_id = effect.casting_spell.spell_entry.ID
        self.name = f'DynamicObject - Spell {effect.casting_spell.spell_entry.Name_enUS}'
        self.radius = radius
        self.ttl = ttl

        self.guid = self.generate_object_guid(DynamicObjectManager.GUID_MANAGER.get_new_guid())

        self.update_packet_factory.init_values(owner.guid, DynamicObjectFields)

    def __hash__(self):
        return self.guid

    # override
    def initialize_field_values(self):
        # Object fields.
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
        self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

        # DynamicObject fields.
        self.set_uint64(DynamicObjectFields.DYNAMICOBJECT_CASTER, self.owner.guid)
        self.set_uint32(DynamicObjectFields.DYNAMICOBJECT_BYTES, self.get_dynamic_bytes())
        self.set_uint32(DynamicObjectFields.DYNAMICOBJECT_SPELLID, self.spell_id)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_RADIUS, self.radius)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_X, self.location.x)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_Y, self.location.y)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_POS_Z, self.location.z)
        self.set_float(DynamicObjectFields.DYNAMICOBJECT_FACING, self.location.o)

        self.initialized = True

    # override
    def update(self, now):
        super().update(now)

        if now <= self.last_tick or self.last_tick <= 0:
            self.last_tick = now
            return

        elapsed = now - self.last_tick
        if self.ttl > 0:
            self.ttl = max(0, self.ttl - elapsed)
            if self.ttl == 0:
                self.despawn()

        if self.has_pending_updates():
            self.get_map().update_object(self, has_changes=True)
            self.reset_update_fields()

        self.last_tick = now

    @classmethod
    def spawn_from_spell_effect(cls, effect, dynamic_type, orientation=0, ttl=-1):
        target = effect.casting_spell.initial_target

        # Target must be a vector.
        if isinstance(target, ObjectManager):
            target = target.location.copy()
        else:
            target = target.get_ray_vector(is_terrain=True)

        if orientation:
            target.set_orientation(orientation)

        effect.casting_spell.dynamic_object = DynamicObjectManager(effect.casting_spell.spell_caster, target,
                                                                   effect.get_radius(), effect,
                                                                   dynamic_type, ttl=ttl)
        effect.casting_spell.dynamic_object.spawn()

        return effect.casting_spell.dynamic_object

    def add_dynamic_target(self, target):
        if target.guid in self.targets:
            return
        self.targets.add(target.guid)
        data = pack('<2Q', self.guid, target.guid)
        self.get_map().send_surrounding(PacketWriter.get_packet(OpCode.MSG_ADD_DYNAMIC_TARGET, data), self, False)

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
    def get_dynamic_bytes(self):
        return ByteUtils.bytes_to_int(
            self.dynamic_type,
            0,  # Dynamic type flags. (Unknown)
            0,  # Padding.
            0   # Padding.
        )

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
