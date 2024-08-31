import math
from math import pi, cos, sin
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.gameobjects.managers.ButtonManager import ButtonManager
from game.world.managers.objects.gameobjects.managers.ChestMananger import ChestManager
from game.world.managers.objects.gameobjects.managers.TransportManager import TransportManager
from game.world.managers.objects.gameobjects.managers.FishingNodeManager import FishingNodeManager
from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from game.world.managers.objects.gameobjects.managers.GooberManager import GooberManager
from game.world.managers.objects.gameobjects.managers.MiningNodeManager import MiningNodeManager
from game.world.managers.objects.gameobjects.managers.RitualManager import RitualManager
from game.world.managers.objects.gameobjects.managers.SpellFocusManager import SpellFocusManager
from game.world.managers.objects.gameobjects.managers.TrapManager import TrapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from game.world.managers.objects.GuidManager import GuidManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, HighGuid, GameObjectTypes, \
    GameObjectStates, ScriptTypes
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellMissReason
from utils.constants.UnitCodes import StandState
from utils.constants.UpdateFields import ObjectFields, GameObjectFields


# TODO: Trigger scripts / events on cooldown restart.
# TODO: Check locks etc.
class GameObjectManager(ObjectManager):
    GUID_MANAGER = GuidManager()

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.spawn_id = 0
        self.is_dynamic_spawn = False
        self.entry = 0
        self.guid = 0
        self.gobject_template = None
        self.location = None
        self.stationary_position = None
        self.rot0 = 0
        self.rot1 = 0
        self.rot2 = 0
        self.rot3 = 0
        self.summoner = None
        self.spell_id = 0  # Spell that summoned this object.
        self.known_players = {}

        self.native_display_id = 0
        self.current_display_id = 0
        self.native_scale = 0
        self.current_scale = 0
        self.faction = 0
        self.lock = 0  # Unlocked.
        self.unlocked_by = set()
        self.flags = 0
        self.state = 0

        self.update_packet_factory.init_values(self.guid, GameObjectFields)

        self.time_to_live_timer = 0
        self.loot_manager = None  # Optional.
        self.button_manager = None  # Optional.
        self.chest_manager = None  # Optional.
        self.trap_manager = None  # Optional.
        self.fishing_node_manager = None  # Optional.
        self.transport_manager = None  # Optional.
        self.mining_node_manager = None  # Optional.
        self.goober_manager = None  # Optional.
        self.ritual_manager = None  # Optional.
        self.spell_focus_manager = None  # Optional.

    def __hash__(self):
        return self.guid

    def initialize_from_gameobject_template(self, gobject_template):
        if not gobject_template:
            return

        self.entry = gobject_template.entry
        self.gobject_template = gobject_template
        self.native_display_id = self.gobject_template.display_id
        self.current_display_id = self.native_display_id
        self.native_scale = self.gobject_template.scale
        self.current_scale = self.native_scale
        self.faction = self.gobject_template.faction
        self.lock = 0  # Unlocked.
        self.flags = self.gobject_template.flags

        # Loot initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_CHEST or \
                self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self.loot_manager = GameObjectLootManager(self)

        # Chest initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            self.chest_manager = ChestManager(self)

        # Mining node initializations.
        if self._is_mining_node():
            self.mining_node_manager = MiningNodeManager(self)

        # Button initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            self.button_manager = ButtonManager(self)

        # Fishing node initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self.fishing_node_manager = FishingNodeManager(self)

        # Transports.
        if self.gobject_template.type == GameObjectTypes.TYPE_TRANSPORT:
            self.transport_manager = TransportManager(self)

        # Ritual initializations.
        if self.gobject_template.type == GameObjectTypes.TYPE_RITUAL:
            self.ritual_manager = RitualManager(self)

        # Spell focus objects.
        if self.gobject_template.type == GameObjectTypes.TYPE_SPELL_FOCUS:
            self.spell_focus_manager = SpellFocusManager(self)

        # Trap initializations.
        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP:
            self.trap_manager = TrapManager(self)

        # Goober initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_GOOBER:
            self.goober_manager = GooberManager(self)

        # Lock initialization for button and door.
        if self.gobject_template.type == GameObjectTypes.TYPE_BUTTON or \
                self.gobject_template.type == GameObjectTypes.TYPE_DOOR:
            self.lock = self.gobject_template.data1

        # Lock initialization for quest giver, goober, camera, trap and chest.
        if self.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER or \
                self.gobject_template.type == GameObjectTypes.TYPE_GOOBER or \
                self.gobject_template.type == GameObjectTypes.TYPE_CAMERA or \
                self.gobject_template.type == GameObjectTypes.TYPE_TRAP or \
                self.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            self.lock = gobject_template.data0

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
        # On loot release, always despawn the fishing bobber regardless of it still having loot or not.
        if self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self.despawn()
            return

        if self.loot_manager:
            # Normal chest.
            if not self.mining_node_manager:
                # Chest still has loot.
                if self.loot_manager.has_loot():
                    self.set_ready()
                else:  # Despawn or destroy.
                    self.despawn()
            # Mining node.
            else:
                self.mining_node_manager.handle_looted(player)

    def _handle_use_door(self, player):
        self.set_active()

    def _handle_use_button(self, player):
        self.button_manager.use_button(player)

    def _handle_use_camera(self, player):
        cinematic_id = self.gobject_template.data1
        if DbcDatabaseManager.cinematic_sequences_get_by_id(cinematic_id):
            data = pack('<I', cinematic_id)
            player.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRIGGER_CINEMATIC, data))

    def _handle_use_chair(self, player):
        slots = self.gobject_template.data0
        height = self.gobject_template.data1

        lowest_distance = 90.0
        x_lowest = self.location.x
        y_lowest = self.location.y

        if slots > 0:
            orthogonal_orientation = self.location.o + pi * 0.5
            for x in range(slots):
                relative_distance = (self.current_scale * x) - (self.current_scale * (slots - 1) / 2.0)
                x_i = self.location.x + relative_distance * cos(orthogonal_orientation)
                y_i = self.location.y + relative_distance * sin(orthogonal_orientation)

                player_slot_distance = player.location.distance(Vector(x_i, y_i, player.location.z))
                if player_slot_distance <= lowest_distance:
                    lowest_distance = player_slot_distance
                    x_lowest = x_i
                    y_lowest = y_i
            player.teleport(player.map_id, Vector(x_lowest, y_lowest, self.location.z, self.location.o))
            player.set_stand_state(StandState.UNIT_SITTINGCHAIRLOW.value + height)

    # noinspection PyMethodMayBeStatic
    def _handle_use_quest_giver(self, player, target):
        if target:
            player.quest_manager.handle_quest_giver_hello(target, target.guid)

    def _handle_use_chest(self, player):
        self.chest_manager.use_chest(player)

    def _handle_fishing_node(self, player):
        self.fishing_node_manager.fishing_node_use(player)

    def _handle_use_goober(self, player):
        self.goober_manager.goober_use(player)

    def _handle_use_ritual(self, player):
        self.ritual_manager.ritual_use(player)

    # override
    def is_active_object(self):
        return len(self.known_players) > 0 or self.gobject_template.type == GameObjectTypes.TYPE_TRANSPORT

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
        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP and target.get_type_id() == ObjectTypeIds.ID_PLAYER:
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

    def use(self, player=None, target=None, from_script=False):
        if self.gobject_template.type == GameObjectTypes.TYPE_DOOR:
            self._handle_use_door(player)
        if self.gobject_template.type == GameObjectTypes.TYPE_BUTTON:
            self._handle_use_button(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_CAMERA:
            self._handle_use_camera(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_CHAIR:
            self._handle_use_chair(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            self._handle_use_chest(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_RITUAL:
            self._handle_use_ritual(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_GOOBER:
            self._handle_use_goober(player)
        elif self.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER:
            self._handle_use_quest_giver(player, target)
        elif self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self._handle_fishing_node(player)

        if from_script:
            self.set_active()
        else:
            # TODO: Do we need separate AI handler for gameobjects?
            self.get_map().enqueue_script(self, player, ScriptTypes.SCRIPT_TYPE_GAMEOBJECT, self.spawn_id)

        # Force surrounding players to refresh this GO interactive state.
        self.refresh_dynamic_flag()

    def set_state(self, state):
        self.state = state
        self.set_uint32(GameObjectFields.GAMEOBJECT_STATE, self.state)

        # If not a fishing node, set this go in_use flag.
        if not self.fishing_node_manager:
            if state == GameObjectStates.GO_STATE_ACTIVE:
                self.flags |= GameObjectFlags.IN_USE
                self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.flags)
            else:
                self.flags &= ~GameObjectFlags.IN_USE
                self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.flags)

    def is_transport(self):
        return self.gobject_template.type == GameObjectTypes.TYPE_TRANSPORT

    def has_flag(self, flag: GameObjectFlags):
        return self.flags & flag

    def set_active(self):
        if self.state == GameObjectStates.GO_STATE_READY:
            self.set_state(GameObjectStates.GO_STATE_ACTIVE)
            return True
        return False

    def refresh_dynamic_flag(self):
        self.set_uint32(GameObjectFields.GAMEOBJECT_DYN_FLAGS, self.dynamic_flags, force=True)

    def is_active(self):
        return self.state == GameObjectStates.GO_STATE_ACTIVE

    def set_ready(self):
        if self.state != GameObjectStates.GO_STATE_READY:
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

    def trigger_linked_trap(self, trap_entry, unit, radius=2.5):
        go_objects = self.get_map().get_surrounding_gameobjects(self).values()
        if not go_objects:
            return
        for go_object in go_objects:
            if go_object.entry != trap_entry:
                continue
            if self.location.distance(go_object.location) >= radius:
                continue
            go_object.trap_manager.trigger(who=unit)

    def cast_spell(self, spell_id, target):
        spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell_id)
        if spell_template:
            spell_target_mask = spell_template.Targets
            casting_spell = self.spell_manager.try_initialize_spell(spell_template, target,
                                                                    spell_target_mask, validate=True)
            self.spell_manager.start_spell_cast(initialized_spell=casting_spell)

        else:
            Logger.warning(f'Invalid spell id for GameObject trap {self.spawn_id}, spell {spell_id}')

    def generate_dynamic_field_value(self, requester):
        go_handled_types = {GameObjectTypes.TYPE_QUESTGIVER, GameObjectTypes.TYPE_GOOBER, GameObjectTypes.TYPE_CHEST}
        if self.gobject_template.type in go_handled_types:
            if requester.quest_manager.should_interact_with_go(self):
                return 1
        return 0

    def _is_mining_node(self):
        return self.gobject_template and self.gobject_template.type == GameObjectTypes.TYPE_CHEST and \
               self.gobject_template.data4 != 0 and self.gobject_template.data5 > self.gobject_template.data4

    def get_transport(self):
        if self.transport_manager:
            return self.transport_manager
        return None

    def get_fall_time(self):
        if self.transport_manager:
            return self.transport_manager.get_path_progress()
        return 0

    """
        So far this is only needed for GameObjects, client doesn't remove collision for doors sent with active state,
        so we need to always send them as ready first, and then send the actual state.
    """
    def get_door_state_update_bytes(self):
        if self.gobject_template.type != GameObjectTypes.TYPE_DOOR or self.state == GameObjectStates.GO_STATE_READY:
            return None
        # Send real GO state for doors after create packet.
        return self.get_single_field_update_bytes(GameObjectFields.GAMEOBJECT_STATE, self.state)

    def get_dynamic_flag_update_bytes(self, requester):
        dyn_flag_value = self.generate_dynamic_field_value(requester=requester)
        return self.get_single_field_update_bytes(GameObjectFields.GAMEOBJECT_DYN_FLAGS, dyn_flag_value)

    # override
    def _get_fields_update(self, is_create, requester, update_data=None):
        data = bytearray()
        mask = self.update_packet_factory.update_mask.copy() if not update_data else update_data.update_bit_mask
        values = self.update_packet_factory.update_values_bytes if not update_data else update_data.update_field_values

        for index in range(self.update_packet_factory.update_mask.field_count):
            # Partial packets only care for fields that had changes.
            if not is_create and mask[index] == 0 and not self.update_packet_factory.is_dynamic_field(index):
                continue
            # Check for encapsulation, turn off the bit if requester has no read access.
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
        if self.time_to_live_timer > 0:
            self.time_to_live_timer -= elapsed
            # Time to live expired, destroy.
            if self.time_to_live_timer <= 0:
                self.despawn()
                return False
        return True

    # override
    def despawn(self, ttl=0):
        self.unlocked_by.clear()
        super().despawn()

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_spawned and self.initialized:
                # Time to live checks for standalone instances.
                if not self._check_time_to_live(elapsed):
                    return  # Object destroyed.

                if self.is_active_object():
                    if self.trap_manager:
                        self.trap_manager.update(elapsed)
                    if self.fishing_node_manager:
                        self.fishing_node_manager.update(elapsed)
                    if self.transport_manager and self.transport_manager.has_passengers():
                        self.transport_manager.update()

                # SpellManager update.
                self.spell_manager.update(now)

            # Check if this game object should be updated yet or not.
            if self.has_pending_updates():
                self.get_map().update_object(self, has_changes=True)

        self.last_tick = now

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
    def get_stationary_position(self):
        return self.stationary_position if self.stationary_position else self.location

    # override
    def get_query_details_packet(self):
        from game.world.managers.objects.gameobjects.utils.GoQueryUtils import GoQueryUtils
        return GoQueryUtils.query_details(gameobject_mgr=self)

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_GAMEOBJECT

    # override
    def get_low_guid(self):
        if self.is_transport():
            return self.guid & ~HighGuid.HIGHGUID_TRANSPORT
        return self.guid & ~HighGuid.HIGHGUID_GAMEOBJECT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_GAMEOBJECT

    # override
    def generate_object_guid(self, low_guid):
        if self.is_transport():
            return low_guid | HighGuid.HIGHGUID_TRANSPORT
        return low_guid | HighGuid.HIGHGUID_GAMEOBJECT
