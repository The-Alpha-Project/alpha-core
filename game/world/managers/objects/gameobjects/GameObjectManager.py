import math
from math import pi, cos, sin
from random import randint
from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager, SpawnsGameobjects
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.gameobjects.FishingNodeManager import FishingNodeManager
from game.world.managers.objects.gameobjects.GameObjectLootManager import GameObjectLootManager
from game.world.managers.objects.gameobjects.MiningNodeManager import MiningNodeManager
from game.world.managers.objects.gameobjects.TrapManager import TrapManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, HighGuid, GameObjectTypes, \
    GameObjectStates
from utils.constants.MiscFlags import GameObjectFlags
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask, SpellCheckCastResult
from utils.constants.UnitCodes import StandState, UnitFlags
from utils.constants.UpdateFields import ObjectFields, GameObjectFields, UnitFields


class GameObjectManager(ObjectManager):
    CURRENT_HIGHEST_GUID = 0

    def __init__(self,
                 gobject_template,
                 gobject_instance=None,
                 summoner=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.gobject_template = gobject_template
        self.gobject_instance = gobject_instance
        self.summoner = summoner
        self.spell_id = 0  # Spell that summoned this object.
        self.known_players = {}

        self.entry = self.gobject_template.entry
        self.native_display_id = self.gobject_template.display_id
        self.current_display_id = self.native_display_id
        self.native_scale = self.gobject_template.scale
        self.current_scale = self.native_scale
        self.faction = self.gobject_template.faction
        self.lock = 0  # Unlocked.
        self.flags = self.gobject_template.flags

        if self.summoner:
            self.flags |= GameObjectFlags.TRIGGERED

        if gobject_instance:
            if GameObjectManager.CURRENT_HIGHEST_GUID < gobject_instance.spawn_id:
                GameObjectManager.CURRENT_HIGHEST_GUID = gobject_instance.spawn_id

            self.guid = self.generate_object_guid(gobject_instance.spawn_id)
            self.state = self.gobject_instance.spawn_state
            self.location.x = self.gobject_instance.spawn_positionX
            self.location.y = self.gobject_instance.spawn_positionY
            self.location.z = self.gobject_instance.spawn_positionZ
            self.location.o = self.gobject_instance.spawn_orientation
            # If spawned by another unit, use that unit map and zone.
            self.map_ = self.gobject_instance.spawn_map if not self.summoner else self.summoner.map_
            self.zone = self.summoner.zone if self.summoner else 0
            self.respawn_time = randint(self.gobject_instance.spawn_spawntimemin,
                                        self.gobject_instance.spawn_spawntimemax)

        self.object_type_mask |= ObjectTypeFlags.TYPE_GAMEOBJECT
        self.update_packet_factory.init_values(self.guid, GameObjectFields)

        self.respawn_timer = 0
        self.loot_manager = None  # Optional.
        self.trap_manager = None  # Optional.
        self.fishing_node_manager = None  # Optional.
        self.mining_node_manager = None  # Optional.

        from game.world.managers.objects.spell.SpellManager import SpellManager  # Local due to circular imports.
        self.spell_manager = SpellManager(self)

        # Chest initializations.
        if self.gobject_template.type == GameObjectTypes.TYPE_CHEST:
            self.lock = self.gobject_template.data0
            self.loot_manager = GameObjectLootManager(self)
            # Mining node.
            if self.gobject_template.data4 != 0 and self.gobject_template.data5 > self.gobject_template.data4:
                self.mining_node_manager = MiningNodeManager(self)

        # Fishing node initialization.
        if self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self.loot_manager = GameObjectLootManager(self)
            self.fishing_node_manager = FishingNodeManager(self)

        # Ritual initializations.
        if self.gobject_template.type == GameObjectTypes.TYPE_RITUAL:
            self.ritual_participants = []

        # Set channeled object for fishing nodes or rituals.
        if summoner and summoner.get_type_id() == ObjectTypeIds.ID_PLAYER:
            if self.gobject_template.type == GameObjectTypes.TYPE_RITUAL or \
                    self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
                summoner.set_channel_object(self.guid)

        # Trap collision initializations.
        self.lock = self.gobject_template.data0
        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP:
            self.trap_manager = TrapManager.generate(self)

        # Lock initialization for button and door.
        if self.gobject_template.type == GameObjectTypes.TYPE_BUTTON or \
                self.gobject_template.type == GameObjectTypes.TYPE_DOOR:
            self.lock = self.gobject_template.data1

        # Lock initialization for quest giver, goober and camera.
        if self.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER or \
                self.gobject_template.type == GameObjectTypes.TYPE_GOOBER or \
                self.gobject_template.type == GameObjectTypes.TYPE_CAMERA:
            self.lock = gobject_template.data0

    def load(self):
        MapManager.update_object(self)

    @staticmethod
    def spawn(entry, location, map_id, summoner=None, spell_id=0, override_faction=0, despawn_time=1):
        go_template = WorldDatabaseManager.gameobject_template_get_by_entry(entry)

        if not go_template:
            return None

        instance = SpawnsGameobjects()
        instance.spawn_id = GameObjectManager.CURRENT_HIGHEST_GUID + 1
        instance.spawn_entry = entry
        instance.spawn_map = map_id
        instance.spawn_rotation0 = 0
        instance.spawn_rotation2 = 0
        instance.spawn_rotation1 = 0
        instance.spawn_rotation3 = 0
        instance.spawn_positionX = location.x
        instance.spawn_positionY = location.y
        instance.spawn_positionZ = location.z
        instance.spawn_orientation = location.o
        if despawn_time < 1:
            despawn_time = 1
        instance.spawn_spawntimemin = despawn_time
        instance.spawn_spawntimemax = despawn_time
        instance.spawn_state = GameObjectStates.GO_STATE_READY

        gameobject = GameObjectManager(
            gobject_template=go_template,
            gobject_instance=instance,
            summoner=summoner
        )

        if spell_id:
            gameobject.spell_id = spell_id

        if override_faction:
            gameobject.faction = override_faction
            gameobject.set_uint32(GameObjectFields.GAMEOBJECT_FACTION, override_faction)

        gameobject.load()
        return gameobject

    def handle_loot_release(self, player):
        # On loot release, always despawn the fishing bobber regardless of it still having loot or not.
        if self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
            self.despawn(True)
            return

        if self.loot_manager:
            # Normal chest.
            if not self.mining_node_manager:
                # Chest still has loot.
                if self.loot_manager.has_loot():
                    self.set_ready()
                else:  # Despawn or destroy.
                    self.despawn(True if self.summoner else False)
            # Mining node.
            else:
                self.mining_node_manager.handle_looted(player)

    def _handle_use_door(self, player):
        # TODO: Check locks etc.
        self.set_active()

    def _handle_use_button(self, player):
        # TODO: Trigger scripts / events on cooldown restart.
        self.set_active()

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
            player.teleport(player.map_, Vector(x_lowest, y_lowest, self.location.z, self.location.o), is_instant=True)
            player.set_stand_state(StandState.UNIT_SITTINGCHAIRLOW.value + height)

    # noinspection PyMethodMayBeStatic
    def _handle_use_quest_giver(self, player, target):
        if target:
            player.quest_manager.handle_quest_giver_hello(target, target.guid)

    def _handle_fishing_node(self, player):
        # Generate loot if it's empty.
        if not self.loot_manager.has_loot():
            self.loot_manager.generate_loot(player)

        if self.fishing_node_manager.try_hook_attempt(player):
            player.send_loot(self.loot_manager)

        # Remove cast.
        player.spell_manager.remove_cast_by_id(self.spell_id)

    def _handle_use_chest(self, player):
        # Activate chest open animation, while active, it won't let any other player loot.
        if self.state == GameObjectStates.GO_STATE_READY:
            self.set_state(GameObjectStates.GO_STATE_ACTIVE)

        # Player kneel loot.
        player.unit_flags |= UnitFlags.UNIT_FLAG_LOOTING
        player.set_uint32(UnitFields.UNIT_FIELD_FLAGS, player.unit_flags)

        # Generate loot if it's empty.
        if not self.loot_manager.has_loot():
            self.loot_manager.generate_loot(player)

        player.send_loot(self.loot_manager)

    def _handle_use_ritual(self, player):
        # Group check.
        if not self.summoner.group_manager or not self.summoner.group_manager.is_party_member(player.guid):
            player.spell_manager.send_cast_result(self.spell_id, SpellCheckCastResult.SPELL_FAILED_TARGET_NOT_IN_PARTY)
            return

        ritual_channel_spell_id = self.gobject_template.data2
        if player is self.summoner or player in self.ritual_participants:
            return  # No action needed for this player.

        # Make the player channel for summoning.
        channel_spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(ritual_channel_spell_id)
        spell = player.spell_manager.try_initialize_spell(channel_spell_entry, self, SpellTargetMask.GAMEOBJECT,
                                                          validate=False)

        # Note: these triggered casts will skip the actual effects of the summon spell, only starting the channel.
        player.spell_manager.remove_colliding_casts(spell)
        player.spell_manager.casting_spells.append(spell)
        player.spell_manager.handle_channel_start(spell)
        self.ritual_participants.append(player)

        # Check if the ritual can be completed with the current participants.
        required_participants = self.gobject_template.data0 - 1  # -1 to include caster.
        if len(self.ritual_participants) >= required_participants:
            ritual_finish_spell_id = self.gobject_template.data1

            # Cast the finishing spell.
            spell_entry = DbcDatabaseManager.SpellHolder.spell_get_by_id(ritual_finish_spell_id)
            spell_cast = self.summoner.spell_manager.try_initialize_spell(spell_entry, self.summoner,
                                                                          SpellTargetMask.SELF,
                                                                          triggered=True, validate=False)
            if spell_cast:
                self.summoner.spell_manager.start_spell_cast(initialized_spell=spell_cast)
            else:
                # Interrupt ritual channel if the summon fails.
                self.summoner.spell_manager.remove_cast_by_id(ritual_channel_spell_id)

    def has_observers(self):
        return any(self.known_players)

    def apply_spell_damage(self, target, damage, casting_spell, is_periodic=False):
        damage_info = casting_spell.get_cast_damage_info(self, target, damage, 0)
        miss_info = casting_spell.object_target_results[target.guid].result

        target.send_spell_cast_debug_info(damage_info, miss_info, casting_spell.spell_entry.ID, is_periodic=is_periodic)
        target.receive_damage(damage, self, is_periodic)

        # Send environmental damage log packet to the affected player.
        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP and target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            data = pack(
                '<Q2I',
                target.guid,
                casting_spell.spell_entry.School,
                damage
            )
            target.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ENVIRONMENTALDAMAGELOG, data))

    def apply_spell_healing(self, target, healing, casting_spell, is_periodic=False):
        miss_info = casting_spell.object_target_results[target.guid].result
        damage_info = casting_spell.get_cast_damage_info(self, target, healing, 0)

        target.send_spell_cast_debug_info(damage_info, miss_info, casting_spell.spell_entry.ID, healing=True, is_periodic=is_periodic)
        target.receive_healing(healing, self)

    def _handle_use_goober(self, player):
        # Deadmines IronClad door (After triggering cannon)
        # TODO: This should be moved somewhere else to avoid hardcoding entries in the core GameObject manager.
        #  Future instance/map scripts?
        if self.entry == 16398:  # Cannon.
            # TODO, scripting, instancing, etc.
            iron_clad_doors = [go for go in MapManager.get_surrounding_gameobjects(self).values() if go.entry == 16397]
            if len(iron_clad_doors) > 0:
                self.send_custom_animation(0)
                iron_clad_doors[0].set_active()
        else:
            Logger.warning(f'Unimplemented gameobject use for type Goober entry {self.entry} name {self.gobject_template.name}')
        pass

    def use(self, player, target=None):
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

    def has_flag(self, flag: GameObjectFlags):
        return self.flags & flag

    def set_active(self):
        if self.state == GameObjectStates.GO_STATE_READY:
            self.set_state(GameObjectStates.GO_STATE_ACTIVE)
            return True
        return False

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

    # override
    def _get_fields_update(self, is_create, requester):
        data = b''
        mask = self.update_packet_factory.update_mask.copy()
        for field_index in range(self.update_packet_factory.update_mask.field_count):
            # Partial packets only care for fields that had changes.
            if not is_create and mask[field_index] == 0 and not self.update_packet_factory.is_dynamic_field(field_index):
                continue
            # Check for encapsulation, turn off the bit if requester has no read access.
            if not self.update_packet_factory.has_read_rights_for_field(field_index, requester):
                mask[field_index] = 0
                continue
            # Handle dynamic field, turn on this extra bit.
            if self.update_packet_factory.is_dynamic_field(field_index):
                data += pack('<I', self.generate_dynamic_field_value(requester))
                mask[field_index] = 1
            else:
                # Append field value and turn on bit on mask.
                data += self.update_packet_factory.update_values_bytes[field_index]
                mask[field_index] = 1
        return pack('<B', self.update_packet_factory.update_mask.block_count) + mask.tobytes() + data

    # There are only 3 possible animations that can be used here.
    # Effect might depend on the gameobject type, apparently. e.g. Fishing bobber does its animation by sending 0.
    # TODO: See if we can retrieve the animation names.
    def send_custom_animation(self, animation):
        data = pack('<QI', self.guid, animation)
        packet = PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_CUSTOM_ANIM, data)
        MapManager.send_surrounding(packet, self, include_self=False)

    def generate_dynamic_field_value(self, requester):
        # TODO: Handle more dynamic cases.
        # QUESTGIVERS and CHESTS (This includes other interactive game objects).
        if self.gobject_template.type == GameObjectTypes.TYPE_CHEST or \
                self.gobject_template.type == GameObjectTypes.TYPE_QUESTGIVER:
            if requester.quest_manager.should_interact_with_go(self):
                return 1
        return 0

    # override
    def initialize_field_values(self):
        # Initial field values, after this, fields must be modified by setters or directly writing values to them.
        if not self.initialized and self.gobject_template and self.gobject_instance:
            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)
            self.set_uint32(ObjectFields.OBJECT_FIELD_PADDING, 0)

            # Gameobject fields.
            self.set_uint32(GameObjectFields.GAMEOBJECT_DISPLAYID, self.current_display_id)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FLAGS, self.flags)
            self.set_uint32(GameObjectFields.GAMEOBJECT_FACTION, self.faction)
            self.set_uint32(GameObjectFields.GAMEOBJECT_STATE, self.state)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION, self.gobject_instance.spawn_rotation0)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 1, self.gobject_instance.spawn_rotation1)

            if self.gobject_instance.spawn_rotation2 == 0 and self.gobject_instance.spawn_rotation3 == 0:
                f_rot1 = math.sin(self.location.o / 2.0)
                f_rot2 = math.cos(self.location.o / 2.0)
            else:
                f_rot1 = self.gobject_instance.spawn_rotation2
                f_rot2 = self.gobject_instance.spawn_rotation3

            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 2, f_rot1)
            self.set_float(GameObjectFields.GAMEOBJECT_ROTATION + 3, f_rot2)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_X, self.location.x)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Y, self.location.y)
            self.set_float(GameObjectFields.GAMEOBJECT_POS_Z, self.location.z)
            self.set_float(GameObjectFields.GAMEOBJECT_FACING, self.location.o)

            self.initialized = True

    def query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.gobject_template.name)
        data = pack(
            f'<3I{len(name_bytes)}ssss10I',
            self.gobject_template.entry,
            self.gobject_template.type,
            self.current_display_id,
            name_bytes, b'\x00', b'\x00', b'\x00',
            self.gobject_template.data0,
            self.gobject_template.data1,
            self.gobject_template.data2,
            self.gobject_template.data3,
            self.gobject_template.data4,
            self.gobject_template.data5,
            self.gobject_template.data6,
            self.gobject_template.data7,
            self.gobject_template.data8,
            self.gobject_template.data9
        )
        return PacketWriter.get_packet(OpCode.SMSG_GAMEOBJECT_QUERY_RESPONSE, data)

    # override
    def respawn(self):
        # Set properties before making it visible.
        self.set_state(GameObjectStates.GO_STATE_READY)
        self.respawn_timer = 0
        self.respawn_time = randint(self.gobject_instance.spawn_spawntimemin,
                                    self.gobject_instance.spawn_spawntimemin)

        if self.gobject_template.type == GameObjectTypes.TYPE_TRAP:
            self.trap_manager.reset()

        MapManager.respawn_object(self)

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            if self.is_spawned and self.initialized:
                # Logic for Trap GameObjects (type 6).
                if self.has_observers() and self.gobject_template.type == GameObjectTypes.TYPE_TRAP:
                    self.trap_manager.update(elapsed)
                # Logic for Fishing node.
                if self.has_observers() and self.gobject_template.type == GameObjectTypes.TYPE_FISHINGNODE:
                    self.fishing_node_manager.update(elapsed)

                # SpellManager update.
                self.spell_manager.update(now)

                # Check if this game object should be updated yet or not.
                if self.has_pending_updates():
                    MapManager.update_object(self, has_changes=True)
                    self.reset_fields_older_than(now)
            # Not spawned but initialized.
            elif self.initialized:
                self.respawn_timer += elapsed
                if self.respawn_timer >= self.respawn_time:
                    if self.summoner:
                        self.despawn(destroy=True)
                    else:
                        self.respawn()

        self.last_tick = now

    # override
    def on_cell_change(self):
        pass

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_GAMEOBJECT

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_GAMEOBJECT
