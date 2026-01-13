import math
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.GuidManager import GuidManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.ObjectQueryUtils import ObjectQueryUtils
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, HighGuid, GameObjectTypes, \
    GameObjectStates, ScriptTypes
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellMissReason
from utils.constants.UpdateFields import ObjectFields, GameObjectFields


class GameObjectManager(ObjectManager):
    GUID_MANAGER = GuidManager()

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.spawn_id = 0
        self.entry = 0
        self.guid = 0
        self.gobject_template = None
        self.rot0 = 0
        self.rot1 = 0
        self.rot2 = 0
        self.rot3 = 0
        self.spell_id = 0  # Spell that summoned this object.
        self.known_players = {}
        self.summoner = None

        self.native_display_id = 0
        self.current_display_id = 0
        self.native_scale = 0
        self.current_scale = 0
        self.faction = 0
        self.lock = 0  # Unlocked.
        self.unlocked_by = set()
        self.unlock_result = None
        self.flags = 0
        self.initial_state = 0
        self.state = 0

        self.update_packet_factory.init_values(self.guid, GameObjectFields)

        self.time_to_live = 0
        self.time_to_live_timer = 0
        self.loot_manager = None  # Optional.

    def __hash__(self):
        return self.guid

    # override
    def update(self, now):
        super().update(now)

        if now <= self.last_tick or self.last_tick <= 0:
            self.last_tick = now
            return

        elapsed = now - self.last_tick

        if self.is_active_object():
            # Time to live checks for standalone instances.
            if not self._check_time_to_live(elapsed):
                self.last_tick = now
                return  # Object destroyed.

            # SpellManager update.
            self.spell_manager.update(now)

        # Check if this game object should be updated yet or not.
        if self.has_pending_updates():
            self.get_map().update_object(self, has_changes=True)

        self.last_tick = now

    def check_cooldown(self, now):
        cooldown = self.get_cooldown()
        if not cooldown:
            return True
        if cooldown > now:
            return False
        self.set_cooldown(now)
        return True  # Can use/reset.

    def initialize_from_gameobject_template(self, gobject_template):
        if not gobject_template:
            return

        self.state = self.initial_state
        self.entry = gobject_template.entry
        self.gobject_template = gobject_template
        self.native_display_id = self.gobject_template.display_id
        self.current_display_id = self.native_display_id
        self.native_scale = self.gobject_template.scale
        self.current_scale = self.native_scale
        self.faction = self.gobject_template.faction
        self.lock = 0  # Unlocked.
        self.flags = self.gobject_template.flags

    # override
    def initialize_field_values(self):
        # Initial field values, after this, fields must be modified by setters or directly writing values to them.
        if not self.initialized and self.gobject_template:
            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Gameobject fields.
            self.set_uint32(GameObjectFields.GAMEOBJECT_DISPLAYID, self.current_display_id)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.flags)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FACTION, self.faction)
            self.set_uint32(GameObjectFields.GAMEOBJECT_STATE, self.state)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION, self.rot0)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 1, self.rot1)

            if self.rot2 == 0 and self.rot3 == 0:
                f_rot1 = math.sin(self.location.o / 2.0)
                f_rot2 = math.cos(self.location.o / 2.0)
            else:
                f_rot1 = self.rot2
                f_rot2 = self.rot3

            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 2, f_rot1)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 3, f_rot2)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_X, self.location.x)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Y, self.location.y)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Z, self.location.z)
            self.set_float(GameObjectFields.GAMEOBJECT_FACING, self.location.o)

            self.initialized = True

    def handle_loot_release(self, player):
        if not self.loot_manager:
            return
        if self.loot_manager.has_loot():
            self.set_ready()
            self.set_flag(GameObjectFlags.IN_USE, False)
        else:  # Despawn or destroy.
            self.despawn()

    # override
    def is_active_object(self):
        return ((self.is_spawned and self.initialized and
                len(self.known_players) > 0) or self.gobject_template.type == GameObjectTypes.TYPE_TRANSPORT)

    # override
    def has_player_observers(self):
        return len(self.known_players) > 0

    def apply_spell_damage(self, target, damage, spell_effect, is_periodic=False):
        # Skip if target is invalid or already dead.
        if not target or not target.is_alive:
            return

        spell = spell_effect.casting_spell
        damage_info = spell.get_cast_damage_info(self, target, damage, absorb=0)
        damage_info.spell_miss_reason = SpellMissReason.MISS_REASON_NONE

        target.send_spell_cast_debug_info(damage_info, spell)
        target.receive_damage(damage_info, self, casting_spell=spell, is_periodic=is_periodic)

        # Send environmental damage log packet to the affected player.
        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP and target.is_player():
            data = pack(
                '<Q2I',
                target.guid,
                spell.get_damage_school(),
                damage
            )
            target.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ENVIRONMENTALDAMAGELOG, data))

    def apply_spell_healing(self, target, value, casting_spell, is_periodic=False):
        damage_info = casting_spell.get_cast_damage_info(self, target, value, 0, healing=True)
        damage_info.spell_miss_reason = casting_spell.object_target_results[target.guid].result
        target.send_spell_cast_debug_info(damage_info, casting_spell)
        target.receive_healing(value, self)

    def use(self, unit=None, target=None, from_script=False):
        if from_script:
            self.set_active()

        # Force surrounding players to refresh this GO interactive state.
        self.refresh_dynamic_flag()

    def set_state(self, state, force=False):
        self.state = state
        self.set_uint32(GameObjectFields.GAMEOBJECT_STATE, self.state, force=force)

    def set_flag(self, flag, state):
        if state:
            self.flags |= flag
        else:
            self.flags &= ~flag
        self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.flags)

    def has_flag(self, flag: GameObjectFlags):
        return self.flags & flag

    def set_active(self, alternative=False, force=False):
        if self.state == GameObjectStates.GO_STATE_READY:
            self.set_state(GameObjectStates.GO_STATE_ACTIVE if not alternative
                           else GameObjectStates.GO_STATE_ACTIVE_ALTERNATIVE, force=force)
            return True
        return False

    def refresh_dynamic_flag(self):
        self.set_uint32(GameObjectFields.GAMEOBJECT_DYN_FLAGS, self.dynamic_flags, force=True)

    def is_active(self):
        return self.state in {GameObjectStates.GO_STATE_ACTIVE, GameObjectStates.GO_STATE_ACTIVE_ALTERNATIVE}

    def is_ready(self):
        return self.state == GameObjectStates.GO_STATE_READY

    def set_ready(self):
        if not self.is_ready():
            self.set_state(GameObjectStates.GO_STATE_READY)
            return True
        return False

    # override
    def set_display_id(self, display_id):
        super().set_display_id(display_id)
        if display_id <= 0 or not \
                DbcDatabaseManager.gameobject_display_info_get_by_id(display_id):
            return False

        self.set_uint32(GameObjectFields.GAMEOBJECT_DISPLAYID, self.current_display_id)
        return True

    def is_within_interactable_distance(self, victim):
        # TODO: https://github.com/cmangos/mangos-tbc/blob/master/src/game/Entities/GameObject.cpp#L2438
        return self.location.distance(victim.location) <= 6.0

    # There are only 3 possible animations that can be used here.
    # Effect might depend on the gameobject type, apparently. e.g. Fishing bobber does its animation by sending 0.
    # TODO: See if we can retrieve the animation names.
    def send_custom_animation(self, animation):
        data = pack('<QI', self.guid, animation)
        packet = PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_CUSTOM_ANIM, data)
        self.get_map().send_surrounding(packet, self, include_self=False)

    def send_page_text(self, player_mgr):
        packet = PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_PAGETEXT, pack('<Q', self.guid))
        player_mgr.enqueue_packet(packet)

    def has_script(self):
        return WorldDatabaseManager.GameobjectScriptHolder.has_script(self.spawn_id)

    def trigger_script(self, target):
        self.get_map().enqueue_script(self, target, ScriptTypes.SCRIPT_TYPE_GAMEOBJECT, self.spawn_id)

    def spawn_linked_trap(self, trap_entry):
        from game.world.managers.objects.gameobjects.GameObjectBuilder import GameObjectBuilder
        trap_object = GameObjectBuilder.create(trap_entry, self.location, self.map_id, self.instance_id,
                                               state=GameObjectStates.GO_STATE_READY, summoner=self,
                                               faction=self.faction, ttl=self.time_to_live)

        self.get_map().spawn_object(instance=trap_object)
        return trap_object

    def trigger_linked_trap(self, trap_entry, unit, radius=2.5):
        from game.world.managers.objects.gameobjects.managers.TrapManager import TrapManager
        go_objects = self.get_map().get_surrounding_gameobjects(self).values()
        if not go_objects:
            return
        for go_object in go_objects:
            if go_object.entry != trap_entry:
                continue
            if self.location.distance(go_object.location) >= radius:
                continue
            if isinstance(go_object, TrapManager) and go_object.is_spawned:
                go_object.use(unit=unit)
                break

    def cast_spell(self, spell_id, target):
        spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if spell_template:
            spell_target_mask = spell_template.Targets
            casting_spell = self.spell_manager.try_initialize_spell(spell_template, target if target else self,
                                                                    spell_target_mask, validate=True)
            if not casting_spell:
                Logger.warning(
                    f'Unable to initialize spell for GameObject {self.get_name()}, Id {self.spawn_id}, spell {spell_id}')
                return

            self.spell_manager.start_spell_cast(initialized_spell=casting_spell)

        else:
            Logger.warning(f'Invalid spell id for GameObject {self.get_name()}, Id {self.spawn_id}, spell {spell_id}')

    def generate_dynamic_field_value(self, requester):
        go_handled_types = {GameObjectTypes.TYPE_QUESTGIVER, GameObjectTypes.TYPE_GOOBER, GameObjectTypes.TYPE_CHEST}
        if self.gobject_template.type in go_handled_types:
            if requester.quest_manager.should_interact_with_go(self):
                return 1
        return 0

    def has_custom_animation(self):
        return self.native_display_id in {2570, 3071, 3072, 3073, 3074, 4392, 4472, 4491, 6785, 6747, 6871}

    def get_auto_close_time(self):
        return 0

    def get_cooldown(self):
        return 0

    def set_cooldown(self, now):
        pass

    # override
    def get_fall_time(self):
        return 0

    """
        So far this is only needed for GameObjects, client doesn't remove collision for doors sent with active state,
        so we need to always send them as ready first, and then send the actual state.
    """
    # Used by DoorManager.
    def get_door_state_update_bytes(self):
        return None

    def get_dynamic_flag_update_bytes(self, requester):
        dyn_flag_value = self.generate_dynamic_field_value(requester=requester)
        return self.get_single_field_update_bytes(GameObjectFields.GAMEOBJECT_DYN_FLAGS, dyn_flag_value)

    # override
    def _get_fields_update(self, is_create, requester, update_data=None):
        # Make sure we work on a copy of the current mask and values.
        if not update_data:
            update_data = self.update_packet_factory.generate_update_data(flush_current=True, ignore_timestamps=True)

        mask = update_data.update_bit_mask
        values = update_data.update_field_values

        data = bytearray()
        for index in range(self.update_packet_factory.update_mask.field_count):
            # Partial packets only care for fields that had changes.
            if not is_create and mask[index] == 0 and not self.update_packet_factory.is_dynamic_field(index):
                continue
            # Check for encapsulation, turn off the bit if the requester has no read access.
            if not self.update_packet_factory.has_read_rights_for_field(index, requester):
                mask[index] = 0
                continue

            if self.update_packet_factory.is_dynamic_field(index):
                value = pack('<I', self.generate_dynamic_field_value(requester))
            elif is_create and \
                    index == GameObjectFields.GAMEOBJECT_STATE and \
                    self.gobject_template.type == GameObjectTypes.TYPE_DOOR:
                # Client doesn't remove collision for doors sent with active state - always send as ready.
                value = pack('<I', GameObjectStates.GO_STATE_READY)
            else:
                value = values[index]

            data.extend(value)
            mask[index] = 1
        return pack('<B', self.update_packet_factory.update_mask.block_count) + mask.tobytes() + data

    def _check_time_to_live(self, elapsed):
        if self.time_to_live and self.time_to_live_timer < self.time_to_live:
            self.time_to_live_timer += elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer >= self.time_to_live:
                self.despawn()
                return False
        return True

    # override
    def respawn(self, ttl=0):
        self.initialize_from_gameobject_template(self.gobject_template)
        self.time_to_live_timer = 0
        self.time_to_live = ttl
        super().respawn()

    # override
    def despawn(self, ttl=0, respawn_delay=0):
        # Handle temporary respawn_delay if provided.
        if not self.is_dynamic_spawn and respawn_delay:
            go_spawn = self.get_map().get_surrounding_gameobject_spawn_by_spawn_id(self, self.spawn_id)
            if go_spawn:
                go_spawn.set_respawn_time(respawn_delay)

        # Delayed despawn.
        if ttl:
            self.time_to_live = ttl / 1000  # Seconds.
            self.time_to_live_timer = 0
            return

        self.unlocked_by.clear()
        self.time_to_live_timer = 0
        self.time_to_live = 0

        super().despawn(ttl, respawn_delay)

    # override
    def on_cell_change(self):
        pass

    # override
    def get_debug_messages(self, requester=None):
        return [
            f'Spawn ID {self.spawn_id}, Guid: {self.get_low_guid()}, Entry: {self.entry}, Display ID: {self.current_display_id}',
            f'X: {self.location.x:.3f}, Y: {self.location.y:.3f}, Z: {self.location.z:.3f}, O: {self.location.o:.3f}',
            f'Distance: {self.location.distance(requester.location) if requester else 0} yd'
        ]

    # override
    def get_name(self):
        return self.gobject_template.name

    # override
    def get_entry(self):
        if self.entry:
            return self.entry
        if self.gobject_template:
            return self.gobject_template.entry
        return 0

    def get_data_field(self, field, data_type):
        if not self.gobject_template:
            return 0
        return data_type(getattr(self.gobject_template, f'data{field}'))

    # override
    def get_stationary_position(self):
        return self.location

    # override
    def get_query_details_packet(self):
        return ObjectQueryUtils.get_query_details_data(instance=self)

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_GAMEOBJECT

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_GAMEOBJECT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_GAMEOBJECT
