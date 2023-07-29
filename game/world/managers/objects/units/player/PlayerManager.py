import math

from bitarray import bitarray
from database.dbc.DbcDatabaseManager import *
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.InstancesManager import InstancesManager
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.maps.helpers.PendingTeleportDataHolder import PendingTeleportDataHolder
from game.world.managers.objects.gameobjects.utils.GoQueryUtils import GoQueryUtils
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.loot.LootSelection import LootSelection
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.creature.ThreatManager import ThreatManager
from game.world.managers.objects.units.creature.utils.UnitQueryUtils import UnitQueryUtils
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from game.world.managers.objects.units.player.SkillManager import SkillManager
from game.world.managers.objects.units.player.TalentManager import TalentManager
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from game.world.managers.objects.units.player.quest.QuestManager import QuestManager
from game.world.managers.objects.units.UnitManager import UnitManager
from game.world.managers.objects.units.player.FriendsManager import FriendsManager
from game.world.managers.objects.units.player.InventoryManager import InventoryManager
from game.world.managers.objects.units.player.ReputationManager import ReputationManager
from game.world.managers.objects.timers.MirrorTimersManager import MirrorTimersManager
from game.world.managers.objects.units.player.taxi.TaxiManager import TaxiManager
from game.world.opcode_handling.handlers.player.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import *
from utils import Formulas
from utils.ByteUtils import ByteUtils
from utils.GuidUtils import GuidUtils
from utils.Logger import Logger
from utils.constants.DuelCodes import *
from utils.constants.ItemCodes import InventoryTypes
from utils.constants.MiscCodes import ChatFlags, LootTypes, LiquidTypes, MountResults, DismountResults, LockTypes
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, PlayerFlags, WhoPartyStatus, HighGuid, \
    AttackTypes, MoveFlags
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import Classes, PowerTypes, Races, Genders, UnitFlags, Teams, \
    RegenStatsFlags, CreatureTypes, UnitStates
from utils.constants.UpdateFields import *

MAX_ACTION_BUTTONS = 120
MAX_EXPLORED_AREAS = 488


class PlayerManager(UnitManager):
    def __init__(self,
                 player=None,
                 session=None,
                 num_inv_slots=0x89,  # Paperdoll + Bag slots + Bag space
                 player_bytes=0,  # skin, face, hairstyle, hair color
                 xp=0,
                 next_level_xp=0,
                 player_bytes_2=0,  # player flags, facial hair, bank slots, 0
                 block_percentage=0,
                 dodge_percentage=0,
                 parry_percentage=0,
                 combo_points=0,
                 combo_target=0,
                 chat_flags=0,
                 online=False,
                 current_selection=0,
                 deathbind=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.session = session
        self.pending_teleport_data = []
        self.update_lock = False
        self.possessed_unit = None
        self.known_objects = dict()
        self.known_items = dict()
        self.known_stealth_units = dict()

        self.pending_known_object_types_updates = {
            ObjectTypeIds.ID_PLAYER: False,
            ObjectTypeIds.ID_UNIT: False,
            ObjectTypeIds.ID_GAMEOBJECT: False,
            ObjectTypeIds.ID_DYNAMICOBJECT: False,
            ObjectTypeIds.ID_CORPSE: False
        }

        self.player = player
        self.online = online
        self.num_inv_slots = num_inv_slots
        self.xp = xp
        self.next_level_xp = next_level_xp
        self.block_percentage = block_percentage
        self.dodge_percentage = dodge_percentage
        self.parry_percentage = parry_percentage
        self.combo_points = combo_points
        self.combo_target = combo_target

        self.current_selection = current_selection
        self.loot_selection: Optional[LootSelection] = None

        self.chat_flags = chat_flags
        self.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY
        self.race_mask = 0
        self.class_mask = 0
        self.deathbind = deathbind
        self.resurrect_data = None
        self.team = Teams.TEAM_NONE  # Set at set_player_variables().
        self.trade_data = None
        self.last_swimming_check_timer = 0
        self.stealth_detect_timer = 0
        self.spirit_release_timer = 0
        self.logout_timer = -1
        self.pending_taxi_destination = None
        self.explored_areas = bitarray(MAX_EXPLORED_AREAS, 'little')
        self.explored_areas.setall(0)
        self.liquid_information = None

        if self.player:
            self.race = player.race
            self.class_ = player.class_
            self.set_player_variables()
            self.guid = self.generate_object_guid(self.player.guid)
            self.inventory = InventoryManager(self)
            self.level = self.player.level
            self.player_bytes = self.get_player_bytes()
            self.player_bytes_2 = self.get_player_bytes_2()
            self.xp = player.xp
            self.talent_points = self.player.talentpoints
            self.skill_points = self.player.skillpoints
            self.map_id = self.player.map
            self.zone = self.player.zone
            self.location.x = self.player.position_x
            self.location.y = self.player.position_y
            self.location.z = self.player.position_z
            self.location.o = self.player.orientation
            self.health = self.player.health
            self.max_health = self.player.health
            self.max_power_1 = self.player.power1
            self.power_1 = self.player.power1
            self.max_power_2 = 1000
            self.power_2 = self.player.power2
            self.max_power_3 = 100
            self.power_3 = self.player.power3
            self.max_power_4 = 100
            self.power_4 = self.player.power4
            self.coinage = self.player.money
            self.regen_flags = RegenStatsFlags.REGEN_FLAG_HEALTH | RegenStatsFlags.REGEN_FLAG_POWER
            self.online = self.player.online

            # GM checks
            self.is_god = False
            if self.session.account_mgr.is_gm():
                self.set_gm()

            # Update exploration data.
            if self.player.explored_areas and len(self.player.explored_areas) > 0:
                self.explored_areas = bitarray(self.player.explored_areas, 'little')

            self.next_level_xp = Formulas.PlayerFormulas.xp_to_level(self.level)
            self.is_alive = self.health > 0

            self.update_packet_factory.init_values(self.guid, PlayerFields)

            self.unit_flags |= UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED

            self.threat_manager = ThreatManager(self)
            self.enchantment_manager = EnchantmentManager(self)
            self.talent_manager = TalentManager(self)
            self.skill_manager = SkillManager(self)
            self.quest_manager = QuestManager(self)
            self.friends_manager = FriendsManager(self)
            self.reputation_manager = ReputationManager(self)
            self.taxi_manager = TaxiManager(self)
            self.duel_manager = None
            self.guild_manager = None
            self.has_pending_group_invite = False
            self.group_manager = None
            self.mirror_timers_manager = MirrorTimersManager(self)

    def get_native_display_id(self, is_male, race_data=None):
        if not race_data:
            race_data = DbcDatabaseManager.chr_races_get_by_race(self.player.race)
        return race_data.MaleDisplayId if is_male else race_data.FemaleDisplayId

    def set_player_variables(self):
        race = DbcDatabaseManager.chr_races_get_by_race(self.race)

        self.faction = race.FactionID
        self.creature_type = race.CreatureType

        self.gender = self.player.gender
        is_male = self.gender == Genders.GENDER_MALE

        self.native_display_id = self.get_native_display_id(is_male, race)
        self.current_display_id = self.native_display_id

        # Initialize power type
        self.update_power_type()

        if self.race == Races.RACE_HUMAN:
            self.bounding_radius = 0.306 if is_male else 0.208
            self.combat_reach = 1.5
        elif self.race == Races.RACE_ORC:
            self.bounding_radius = 0.372 if is_male else 0.236
            self.combat_reach = 1.5
        elif self.race == Races.RACE_DWARF:
            self.bounding_radius = 0.347
            self.combat_reach = 1.5
        elif self.race == Races.RACE_NIGHT_ELF:
            self.bounding_radius = 0.389 if is_male else 0.306
            self.combat_reach = 1.5
        elif self.race == Races.RACE_UNDEAD:
            self.bounding_radius = 0.383
            self.combat_reach = 1.5
        elif self.race == Races.RACE_TAUREN:
            self.bounding_radius = 0.9747 if is_male else 0.8725
            self.combat_reach = 4.05 if is_male else 3.75
            self.native_scale = 1.35 if is_male else 1.25
        elif self.race == Races.RACE_GNOME:
            self.bounding_radius = 0.3519
            self.combat_reach = 1.725
            self.native_scale = 1.15
        elif self.race == Races.RACE_TROLL:
            self.bounding_radius = 0.306
            self.combat_reach = 1.5

        self.current_scale = self.native_scale
        self.race_mask = 1 << self.race - 1
        self.class_mask = 1 << self.class_ - 1

        self.team = PlayerManager.get_team_for_race(self.race)

    def set_gm(self, on=True):
        if on:
            self.player.extra_flags |= PlayerFlags.PLAYER_FLAGS_GM
            self.chat_flags |= ChatFlags.CHAT_TAG_GM
        else:
            self.player.extra_flags &= ~PlayerFlags.PLAYER_FLAGS_GM
            self.chat_flags &= ~ChatFlags.CHAT_TAG_GM

    def set_player_to_deathbind_location(self):
        self.map_id = self.deathbind.deathbind_map
        self.instance_id = self.map_id
        self.location.x = self.deathbind.deathbind_position_x
        self.location.y = self.deathbind.deathbind_position_y
        self.location.z = self.deathbind.deathbind_position_z

    def complete_login(self, first_login=False):
        instance_token = InstancesManager.get_or_create_instance_token_by_player(self, self.map_id)
        self.instance_id = instance_token.id
        if MapManager.is_dungeon_map_id(self.map_id) and not MapManager.get_or_create_instance_map(instance_token):
            self.set_player_to_deathbind_location()

        self.online = True

        # Join default channels.
        ChannelManager.join_default_channels(self)

        # Init faction status.
        self.reputation_manager.send_initialize_factions()

        # If a flight needs to be resumed, make sure create packet uses last known waypoint location.
        taxi_resume_info = self.taxi_manager.taxi_resume_info
        if taxi_resume_info.is_valid():
            self.location = taxi_resume_info.start_location
            # Set player flags.
            self.set_taxi_flying_state(True, taxi_resume_info.mount_display_id)

        # Notify player with create related packets:
        self.enqueue_packet(NameQueryHandler.get_query_details(self.player))
        # Initial inventory create packets.
        self.enqueue_packets(self.inventory.get_inventory_update_packets(self))
        # Player create packet.
        self.enqueue_packet(self.generate_create_packet(requester=self))

        # Load & Apply enchantments.
        self.enchantment_manager.apply_enchantments(load=True)

        # Apply stat bonuses.
        self.stat_manager.apply_bonuses(replenish=first_login)

        # Place player in a world cell.
        MapManager.update_object(self)

        # Try to resume pending flight once player has been created and set on a world cell.
        if taxi_resume_info.is_valid() and not self.taxi_manager.resume_taxi_flight():
            self.set_taxi_flying_state(False)

        # Notify friends about player login.
        self.friends_manager.send_online_notification()

        # If guild, send guild Message of the Day.
        if self.guild_manager:
            self.guild_manager.send_motd(player_mgr=self)

        # Notify group members if needed.
        if self.group_manager:
            self.group_manager.send_update()

        self.spell_manager.send_login_effect()
        self.pet_manager.handle_login()
        self.on_zone_change(self.zone)

    def logout(self):
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_COMPLETE))
        self.online = False
        self.logout_timer = -1
        self.mirror_timers_manager.stop_all()

        if self.duel_manager:
            self.duel_manager.force_duel_end(self)

        self.spell_manager.remove_casts()
        self.aura_manager.remove_all_auras()
        self.pet_manager.detach_active_pets(is_logout=True)
        self.leave_combat()

        # Channels weren't saved on logout until Patch 0.5.5
        ChannelManager.leave_all_channels(self, logout=True)

        MapManager.remove_object(self)

        self.friends_manager.send_offline_notification()
        self.session.save_character()

        # Destroy all known objects to self.
        self.destroy_all_known_objects()

        # Flush known items/objects cache.
        self.known_items.clear()
        self.known_objects.clear()

        # Destroy self and self items.
        self.enqueue_packet(self.get_destroy_packet())
        self.enqueue_packets(self.inventory.get_inventory_destroy_packets(requester=self).values())

        WorldSessionStateHandler.pop_active_player(self)
        self.session.player_mgr = None
        self.session = None

    @staticmethod
    def get_tutorial_packet():
        return PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, pack('<18I', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                                        0, 0, 0, 0, 0))

    def get_action_buttons(self):
        data = bytearray()
        player_buttons = RealmDatabaseManager.character_get_buttons(self.player.guid)
        for x in range(MAX_ACTION_BUTTONS):
            if player_buttons and x in player_buttons:
                data.extend(pack('<i', player_buttons[x]))
            else:
                data.extend(pack('<i', 0))
        return PacketWriter.get_packet(OpCode.SMSG_ACTION_BUTTONS, data)

    def get_deathbind_packet(self):
        data = b''
        if self.deathbind:
            data = pack(
                '<3fI',
                self.deathbind.deathbind_position_x,
                self.deathbind.deathbind_position_y,
                self.deathbind.deathbind_position_z,
                self.deathbind.deathbind_map
            )
        return PacketWriter.get_packet(OpCode.SMSG_BINDPOINTUPDATE, data)

    # Retrieve update packets from world objects, this is called only if object has pending changes.
    # (update_mask bits set).
    def update_world_object_on_me(self, world_object, has_changes=False, has_inventory_changes=False):
        can_detect = self.can_detect_target(world_object)[0]
        is_self = world_object.guid == self.guid

        # We know the unit and can detect.
        if world_object.guid in self.known_objects and can_detect:
            is_player = world_object.get_type_id() == ObjectTypeIds.ID_PLAYER
            # Check for inventory updates.
            if is_player and has_inventory_changes:
                # This is a known player and has inventory changes.
                self.enqueue_packets(world_object.inventory.get_inventory_update_packets(self))
            # Update self with known world object partial update packet.
            if has_changes:
                self.enqueue_packet(world_object.generate_partial_packet(requester=self))
        elif is_self:  # Self (Player)
            # Update self inventory if needed.
            if has_inventory_changes:
                self.enqueue_packets(self.inventory.get_inventory_update_packets(self))
            # Send self a partial update if needed.
            if has_changes:
                self.enqueue_packet(self.generate_partial_packet(requester=self))
        # Stealth detection.
        else:
            # Unit is now visible.
            if world_object.guid not in self.known_objects and can_detect \
                    and world_object.guid in self.known_stealth_units:
                self.known_stealth_units[world_object.guid] = (world_object, False)
            # Unit went stealth.
            elif world_object.guid in self.known_objects and not can_detect \
                    and world_object.guid not in self.known_stealth_units:
                # Update self with known world object partial update packet.
                if has_changes:
                    self.enqueue_packet(world_object.generate_partial_packet(requester=self))
                self.known_stealth_units[world_object.guid] = (world_object, True)

    def enqueue_known_objects_update(self, object_type=None):
        if object_type:
            self.pending_known_object_types_updates[object_type] = True
            return

        for type_id in ObjectTypeIds:
            if type_id not in self.pending_known_object_types_updates:
                continue
            self.pending_known_object_types_updates[type_id] = True

    def update_surrounding_known_objects(self):
        for obj_type, update in self.pending_known_object_types_updates.items():
            if not update:
                continue
            self.pending_known_object_types_updates[obj_type] = False
            self.update_known_objects_for_type(obj_type)

    def update_known_objects_for_type(self, object_type):
        objects = MapManager.get_surrounding_objects(self, [object_type])[0]

        # Which objects were found in self surroundings.
        active_objects = dict()

        if objects:
            if object_type == ObjectTypeIds.ID_UNIT:
                update_func = self._update_known_creature
            elif object_type == ObjectTypeIds.ID_PLAYER:
                update_func = self._update_known_player
            elif object_type == ObjectTypeIds.ID_GAMEOBJECT:
                update_func = self._update_known_gameobject
            elif object_type == ObjectTypeIds.ID_DYNAMICOBJECT:
                update_func = self._update_known_dynobject
            else:
                update_func = self._update_known_corpse

            # Surrounding objects.
            [update_func(object_, active_objects) for object_ in objects.values()]

        # World objects which are known but no longer active to self should be destroyed.
        if self.known_objects:
            for guid, known_object in list(self.known_objects.items()):
                if guid not in active_objects and known_object.get_type_id() == object_type:
                    self.destroy_near_object(guid, object_type=object_type)

        active_objects.clear()

    def destroy_all_known_objects(self):
        for guid, known_object in list(self.known_objects.items()):
            self.destroy_near_object(guid)
        return

    def update_not_known_world_object(self, world_object):
        active_objects = dict()
        if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER:
            self._update_known_player(world_object, active_objects)
        elif world_object.get_type_id() == ObjectTypeIds.ID_UNIT:
            self._update_known_creature(world_object, active_objects)
        elif world_object.get_type_id() == ObjectTypeIds.ID_GAMEOBJECT:
            self._update_known_gameobject(world_object, active_objects)
        elif world_object.get_type_id() == ObjectTypeIds.ID_CORPSE:
            self._update_known_corpse(world_object, active_objects)
        elif world_object.get_type_id() == ObjectTypeIds.ID_DYNAMICOBJECT:
            self._update_known_dynobject(world_object, active_objects)

    def _update_known_dynobject(self, dynobject, active_objects):
        active_objects[dynobject.guid] = dynobject
        if dynobject.guid not in self.known_objects or not self.known_objects[dynobject.guid]:
            if dynobject.is_spawned:
                self.enqueue_packet(dynobject.generate_create_packet(requester=self))
                # We only consider 'known' if its spawned, the details query is still sent.
                self.known_objects[dynobject.guid] = dynobject
        # Player knows the dynamic object but is not spawned anymore, destroy it for self.
        elif dynobject.guid in self.known_objects and not dynobject.is_spawned:
            active_objects.pop(dynobject.guid)

    def _update_known_gameobject(self, gobject, active_objects: dict):
        active_objects[gobject.guid] = gobject
        if gobject.guid not in self.known_objects or not self.known_objects[gobject.guid]:
            # We don't know this game object, notify self with its update packet.
            self.enqueue_packet(GoQueryUtils.query_details(gameobject_mgr=gobject))
            if gobject.is_spawned:
                self.enqueue_packet(gobject.generate_create_packet(requester=self))
                # We only consider 'known' if its spawned, the details query is still sent.
                self.known_objects[gobject.guid] = gobject
                # Add ourselves to gameobject known players.
                gobject.known_players[self.guid] = self
        # Player knows the game object but is not spawned anymore, destroy it for self.
        elif gobject.guid in self.known_objects and not gobject.is_spawned:
            active_objects.pop(gobject.guid)

    def _update_known_creature(self, creature, active_objects: dict):
        # Handle visibility/stealth.
        if not self.can_detect_target(creature)[0]:
            self.known_stealth_units[creature.guid] = (creature, True)
            creature.known_players[self.guid] = self
            return
        elif creature.guid in self.known_stealth_units:
            del self.known_stealth_units[creature.guid]

        active_objects[creature.guid] = creature
        if creature.guid not in self.known_objects or not self.known_objects[creature.guid]:
            # We don't know this creature, notify self with its update packet.
            self.enqueue_packet(UnitQueryUtils.query_details(creature_mgr=creature))
            if not creature.is_spawned:
                return
            self.enqueue_packet(creature.generate_create_packet(requester=self))
            # Get partial movement packet if any.
            movement_packet = creature.movement_manager.try_build_movement_packet()
            if movement_packet:
                self.enqueue_packet(movement_packet)
            # We only consider 'known' if its spawned, the details query is still sent.
            self.known_objects[creature.guid] = creature
            # Add ourselves to creature known players.
            creature.known_players[self.guid] = self
        # Player knows the creature but is not spawned anymore, destroy it for self.
        elif creature.guid in self.known_objects and not creature.is_spawned:
            active_objects.pop(creature.guid)

    def _update_known_corpse(self, corpse, active_objects: dict):
        if self.guid == corpse.guid:
            return
        active_objects[corpse.guid] = corpse
        if corpse.guid not in self.known_objects or not self.known_objects[corpse.guid]:
            # Create packet.
            self.enqueue_packet(corpse.generate_create_packet(requester=self))
        self.known_objects[corpse.guid] = corpse

    def _update_known_player(self, player_mgr, active_objects: dict):
        if self.guid == player_mgr.guid:
            return

        # Handle visibility/stealth.
        if not self.can_detect_target(player_mgr)[0]:
            self.known_stealth_units[player_mgr.guid] = (player_mgr, True)
            return
        elif player_mgr.guid in self.known_stealth_units:
            del self.known_stealth_units[player_mgr.guid]

        active_objects[player_mgr.guid] = player_mgr
        if player_mgr.guid not in self.known_objects or not self.known_objects[player_mgr.guid]:
            # We don't know this player, notify self with its update packet.
            self.enqueue_packet(NameQueryHandler.get_query_details(player_mgr.player))
            # Retrieve their inventory updates.
            self.enqueue_packets(player_mgr.inventory.get_inventory_update_packets(self))
            # Create packet.
            self.enqueue_packet(player_mgr.generate_create_packet(requester=self))
            # Get partial movement packet if any.
            movement_packet = player_mgr.movement_manager.try_build_movement_packet()
            if movement_packet:
                self.enqueue_packet(movement_packet)
        self.known_objects[player_mgr.guid] = player_mgr

    def destroy_near_object(self, guid, object_type=None):
        implements_known_players = {ObjectTypeIds.ID_UNIT, ObjectTypeIds.ID_GAMEOBJECT}
        known_object = self.known_objects.get(guid)
        if known_object and not object_type:
            object_type = known_object.get_type_id()

        if known_object:
            is_player = object_type == ObjectTypeIds.ID_PLAYER
            del self.known_objects[guid]
            # Remove self from creature/go known players if needed.
            if object_type in implements_known_players:
                if self.guid in known_object.known_players:
                    del known_object.known_players[self.guid]
            # Destroy other player items for self.
            if is_player:
                destroy_packets = known_object.inventory.get_inventory_destroy_packets(requester=self)
                for guid in destroy_packets.keys():
                    self.known_items.pop(guid, None)
                self.enqueue_packets(destroy_packets.values())
            # Destroy world object from self.
            self.enqueue_packet(known_object.get_destroy_packet())
            # Destroyed a player which is in our party, update party stats.
            # We do this here because we need to make sure client no longer knows the player object if it went offline.
            if is_player and self.group_manager and self.group_manager.is_party_member(known_object.guid):
                self.group_manager.send_update()

            return True
        return False

    def synchronize_db_player(self):
        if self.player:
            self.player.level = self.level
            self.player.xp = self.xp
            self.player.talentpoints = self.talent_points
            self.player.skillpoints = self.skill_points
            self.player.position_x = self.location.x
            self.player.position_y = self.location.y
            self.player.position_z = self.location.z
            self.player.map = self.map_id
            self.player.orientation = self.location.o
            self.player.zone = self.zone
            self.player.explored_areas = self.explored_areas.to01()
            self.player.taximask = self.taxi_manager.available_taxi_nodes.to01()
            self.player.taxi_path = self.taxi_manager.taxi_resume_info.taxi_path_db_state
            self.player.health = self.health
            self.player.power1 = self.power_1
            self.player.power2 = self.power_2
            self.player.power3 = self.power_3
            self.player.power4 = self.power_4
            self.player.money = self.coinage
            self.player.online = self.online

    def teleport(self, map_, location, is_instant=False, recovery: float = -1.0):
        dbc_map = DbcDatabaseManager.map_get_by_id(map_)
        if not dbc_map:
            Logger.warning(f'Teleport, invalid map {map_}.')
            return False

        if not MapManager.validate_teleport_destination(map_, location.x, location.y):
            Logger.warning(f'Teleport, invalid destination, Map {map_}, X {location.x} Y {location.y}.')
            return False

        # End duel and detach pets if this is a long-distance teleport.
        if not is_instant:
            self.pet_manager.detach_active_pets()
            if self.duel_manager:
                self.duel_manager.force_duel_end(self)

        # If unit is being moved by a spline, stop it.
        if self.movement_manager.unit_is_moving():
            self.movement_manager.reset()

        # Remove any ongoing cast.
        if self.spell_manager.is_casting():
            self.spell_manager.remove_casts(remove_active=False)

        pending_teleport = PendingTeleportDataHolder(recovery_percentage=recovery,
                                                     origin_location=self.location.copy(),
                                                     origin_map=self.map_id,
                                                     destination_location=location.copy(),
                                                     destination_map=map_)

        self.pending_teleport_data.append(pending_teleport)

        if is_instant:
            self.trigger_teleport()

        return True

    def trigger_teleport(self):
        # From here on, the update is blocked until the player teleports to a new location.
        # If another teleport triggers from a client message, then it will proceed once this TP is done.
        self.update_lock = True

        # Pending teleport information.
        pending_teleport = self.pending_teleport_data[0]

        # Remove from transport.
        self.movement_info.remove_from_transport()

        # Leave combat.
        self.leave_combat()
        self.threat_manager.reset()

        # Same map.
        if self.map_id == pending_teleport.destination_map:
            data = pack(
                '<Q9fI',
                self.transport_id,
                self.transport_location.x,
                self.transport_location.y,
                self.transport_location.z,
                self.transport_location.o,
                pending_teleport.destination_location.x,
                pending_teleport.destination_location.y,
                pending_teleport.destination_location.z,
                pending_teleport.destination_location.o,
                self.pitch,
                MoveFlags.MOVEFLAG_NONE,
            )

            self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MOVE_TELEPORT_ACK, data))

        # Different map, send loading screen.
        else:
            # Always remove the player from world before sending a Loading Screen, preventing unexpected packets
            # while the screen is still present.
            # Remove to others.
            MapManager.remove_object(self)
            # Destroy all objects known to self.
            self.destroy_all_known_objects()
            # Flush known items/objects cache.
            self.known_items.clear()
            self.known_objects.clear()
            # Loading screen.
            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRANSFER_PENDING))

            data = pack(
                '<B4f',
                pending_teleport.destination_map,
                pending_teleport.destination_location.x,
                pending_teleport.destination_location.y,
                pending_teleport.destination_location.z,
                pending_teleport.destination_location.o
            )

            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_WORLD, data))

    def spawn_player_from_teleport(self):
        # Pending teleport information.
        pending_teleport = self.pending_teleport_data[0]

        # Check if player changed maps before setting the new value.
        changed_map = self.map_id != pending_teleport.destination_map

        dbc_map = DbcDatabaseManager.map_get_by_id(pending_teleport.destination_map)
        if not dbc_map and changed_map:
            self.pending_teleport_data.pop(0)
            self.teleport(pending_teleport.origin_map, pending_teleport.origin_location, True)
            return

        instance_token = InstancesManager.get_or_create_instance_token_by_player(self, dbc_map.ID)
        if changed_map and MapManager.is_dungeon_map_id(dbc_map.ID):
            if not MapManager.get_or_create_instance_map(instance_token):
                self.pending_teleport_data.pop(0)
                self.teleport(pending_teleport.origin_map, pending_teleport.origin_location, True)
                return

        self.map_id = pending_teleport.destination_map
        self.instance_id = instance_token.id
        self.location = pending_teleport.destination_location.copy()

        # Player changed map. Send initial spells, action buttons and create packet.
        if changed_map:
            # Send initial packets for spells, action buttons and player creation.
            self.enqueue_packet(self.spell_manager.get_initial_spells())
            self.enqueue_packet(self.get_action_buttons())
            # Inventory updates before spawning.
            self.enqueue_packets(self.inventory.get_inventory_update_packets(requester=self))
            # Reset move flags before create packet in order to avoid player starting automatically moving after tele.
            self.movement_flags = MoveFlags.MOVEFLAG_NONE
            # Create packet.
            self.enqueue_packet(self.generate_create_packet(requester=self))
            # Apply enchantments again.
            self.enchantment_manager.apply_enchantments()
            # Apply stat bonuses again.
            self.stat_manager.apply_bonuses()

        # Remove taxi flying state, if any.
        if self.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            self.set_taxi_flying_state(False)
            self.pending_taxi_destination = None

        # Unmount if needed.
        if self.unit_flags & UnitFlags.UNIT_MASK_MOUNTED:
            self.unmount()

        # Repop/Resurrect.
        if pending_teleport.recovery_percentage != -1:
            self.respawn(pending_teleport.recovery_percentage)
            self.spirit_release_timer = 0
            self.resurrect_data = None
            # Update passives, learned spells and stat bonuses.
            self.spell_manager.cast_passive_spells()
            self.spell_manager.apply_cast_when_learned_spells()
            self.stat_manager.apply_bonuses()

        if not changed_map:
            # Get us in a new cell.
            MapManager.update_object(self)
        else:
            MapManager.spawn_object(world_object_instance=self)

        # Notify movement data to surrounding players when teleporting within the same map
        # (for example when using Charge)
        if not changed_map:
            self.movement_flags |= MoveFlags.MOVEFLAG_MOVED
            heart_beat_packet = self.get_heartbeat_packet()
            MapManager.send_surrounding(heart_beat_packet, self, True)

        # Update managers.
        self.friends_manager.send_update_to_friends()
        if self.group_manager and self.group_manager.is_party_formed():
            self.group_manager.send_update()

        # Notify surrounding for proximity checks.
        self._on_relocation()

        # Remove this pending teleport data.
        self.pending_teleport_data.pop(0)

        # Remove soft lock if there are no pending teleports remaining.
        self.update_lock = len(self.pending_teleport_data) > 0

    # override
    def set_stunned(self, active, index=-1) -> bool:
        if active and self.pending_taxi_destination:
            return False  # Ignore on flight path.

        is_stunned = super().set_stunned(active, index)
        if is_stunned:
            # Release loot if any.
            self.interrupt_looting()

        return is_stunned

    # override
    def set_rooted(self, active, index=-1):
        was_rooted = self.unit_state & UnitStates.ROOTED
        is_rooted = super().set_rooted(active, index)

        if is_rooted == was_rooted:
            return  # No state change.

        if is_rooted and not was_rooted:
            opcode = OpCode.SMSG_FORCE_MOVE_ROOT
        else:
            opcode = OpCode.SMSG_FORCE_MOVE_UNROOT

        self.enqueue_packet(PacketWriter.get_packet(opcode))

    def set_tracked_creature_type(self, creature_type, active, index=-1):
        is_tracking = self._set_effect_flag_state(CreatureTypes, creature_type, active, index)
        current_flags = self.get_uint32(PlayerFields.PLAYER_TRACK_CREATURES)
        if is_tracking:
            current_flags |= (1 << (creature_type - 1))
        else:
            current_flags &= ~(1 << (creature_type - 1))

        self.set_uint32(PlayerFields.PLAYER_TRACK_CREATURES, current_flags)

    def set_tracked_resource_type(self, lock_type, active, index=-1):
        is_tracking = self._set_effect_flag_state(LockTypes, lock_type, active, index)
        current_flags = self.get_uint32(PlayerFields.PLAYER_TRACK_RESOURCES)
        if is_tracking:
            current_flags |= (1 << (lock_type - 1))
        else:
            current_flags &= ~(1 << (lock_type - 1))

        self.set_uint32(PlayerFields.PLAYER_TRACK_RESOURCES, current_flags)

    # override
    def is_active_object(self):
        return True

    # override
    def mount(self, mount_display_id):
        # TODO: validate mount. Check MountResults.
        if not super().mount(mount_display_id):
            data = pack('<QI', self.guid, MountResults.MOUNTRESULT_INVALID_MOUNTEE)
            packet = PacketWriter.get_packet(OpCode.SMSG_MOUNTRESULT, data)
            self.enqueue_packet(packet)

    # override
    def unmount(self):
        # TODO: validate unmount. Check DismountResults.
        if not super().unmount():
            data = pack('<QI', self.guid, DismountResults.DISMOUNT_RESULT_NOT_MOUNTED)
            packet = PacketWriter.get_packet(OpCode.SMSG_DISMOUNTRESULT, data)
            self.enqueue_packet(packet)

    # TODO Maybe merge all speed changes in one method
    # override
    def change_speed(self, speed=0):
        if super().change_speed(speed):
            data = pack('<f', self.running_speed)
            self.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FORCE_SPEED_CHANGE, data))

    def change_swim_speed(self, swim_speed=0):
        if swim_speed <= 0:
            swim_speed = config.Unit.Defaults.swim_speed
        elif swim_speed >= 56:
            swim_speed = 56  # Max possible swim speed
        self.swim_speed = swim_speed
        data = pack('<f', self.swim_speed)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FORCE_SWIM_SPEED_CHANGE, data))
        MapManager.send_surrounding(self.generate_movement_packet(), self)

    def change_walk_speed(self, walk_speed=0):
        if walk_speed <= 0:
            walk_speed = config.Unit.Defaults.walk_speed
        elif walk_speed >= 56:
            walk_speed = 56  # Max speed without glitches
        self.walk_speed = walk_speed
        data = pack('<f', self.walk_speed)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_WALK_SPEED, data))
        MapManager.send_surrounding(self.generate_movement_packet(), self)

    def change_turn_speed(self, turn_speed=0):
        if turn_speed <= 0:
            turn_speed = config.Unit.Player.Defaults.turn_speed
        self.turn_rate = turn_speed
        data = pack('<f', self.turn_rate)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_TURN_RATE, data))
        MapManager.send_surrounding(self.generate_movement_packet(), self)

    # override
    def update_power_type(self):
        if not self.shapeshift_form:
            if self.class_ == Classes.CLASS_WARRIOR:
                self.power_type = PowerTypes.TYPE_RAGE
            elif self.class_ == Classes.CLASS_HUNTER:
                self.power_type = PowerTypes.TYPE_FOCUS
            elif self.class_ == Classes.CLASS_ROGUE:
                self.power_type = PowerTypes.TYPE_ENERGY
            else:
                self.power_type = PowerTypes.TYPE_MANA
        else:
            self.power_type = ShapeshiftInfo.get_power_for_form(self.shapeshift_form)

        self.bytes_0 = self.get_bytes_0()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)

    # override
    def set_stealthed(self, active, index=-1):
        stealthed = super().set_stealthed(active, index)
        if not stealthed:
            # Notify surrounding units about fading stealth for proximity aggro.
            self._on_relocation()

    # override
    def set_sanctuary(self, active, time_secs=0):
        super().set_sanctuary(active, time_secs)
        if active:
            self.spell_manager.remove_casts()
            self.spell_manager.remove_unit_from_all_cast_targets(self.guid)
            # Remove self from combat and attackers.
            self.leave_combat()
        else:
            self._on_relocation()

    def send_minimap_ping(self, guid, vector):
        data = pack('<Q2f', guid, vector.x, vector.y)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MINIMAP_PING, data))

    def interrupt_looting(self):
        if self.loot_selection:
            self.send_loot_release(self.loot_selection)

    def send_loot_release(self, loot_selection):
        self.unit_flags &= ~UnitFlags.UNIT_FLAG_LOOTING
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        high_guid: HighGuid = GuidUtils.extract_high_guid(self.loot_selection.object_guid)
        data = pack('<QB', loot_selection.object_guid, 1)  # Must be 1 otherwise client keeps the loot window open
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_RELEASE_RESPONSE, data))

        # Resolve loot target first.
        target_world_object = None
        if high_guid == HighGuid.HIGHGUID_UNIT:
            target_world_object = MapManager.get_surrounding_unit_by_guid(self, loot_selection.object_guid,
                                                                          include_players=False)
        elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
            target_world_object = MapManager.get_surrounding_gameobject_by_guid(self, self.loot_selection.object_guid)
        elif high_guid == HighGuid.HIGHGUID_ITEM:
            target_world_object = self.inventory.get_item_by_guid(self.loot_selection.object_guid)
        else:
            Logger.warning(f'Unhandled loot release for type {HighGuid(high_guid).name}')

        if target_world_object:
            # Retrieve the loot manager for the corresponding world object.
            loot_manager = self.loot_selection.get_loot_manager(target_world_object)
            # Remove self from active looters.
            loot_manager.remove_active_looter(self)
            object_type = target_world_object.get_type_id()
            # UNITS.
            if object_type == ObjectTypeIds.ID_UNIT:
                enemy = target_world_object
                if loot_selection.loot_type != LootTypes.LOOT_TYPE_PICKLOCK:
                    # If this release comes from the loot owner and has no party, set killed_by to None to allow FFA.
                    if enemy.killed_by and enemy.killed_by == self and not enemy.killed_by.group_manager:
                        enemy.killed_by = None
                    # If in party, check if this player has rights to release the loot for FFA.
                    elif enemy.killed_by and enemy.killed_by.group_manager:
                        if self in enemy.killed_by.group_manager.get_allowed_looters(enemy):
                            if not loot_manager.has_loot():  # Flush looters for this enemy.
                                enemy.killed_by.group_manager.clear_looters_for_victim(enemy)
                            enemy.killed_by = None
                    # Empty loot, remove looting flags.
                    if not loot_manager.has_loot():
                        enemy.set_lootable(False)
            # GAMEOBJECTS.
            elif object_type == ObjectTypeIds.ID_GAMEOBJECT:
                game_object = target_world_object
                game_object.handle_loot_release(self)
            # ITEMS.
            elif object_type == ObjectTypeIds.ID_ITEM:
                item_mgr = target_world_object
                # Empty loot, remove item from player inventory bag.
                if not loot_manager.has_loot():
                    self.inventory.remove_item(item_mgr.item_instance.bag, item_mgr.current_slot)

            # Finally, clear the loot manager if it has no loot remaining.
            if not loot_manager.has_loot():
                loot_manager.clear()
        self.loot_selection = None

    def send_loot(self, loot_manager, from_item_container=False):
        loot_type = loot_manager.get_loot_type(self, loot_manager.world_object)
        self.loot_selection = LootSelection(loot_manager.world_object, loot_type)

        # Loot item data.
        item_data = bytearray()
        # Items for query data.
        item_templates = []

        item_count = 0

        # Do not send loot if player has no permission.
        if loot_type != LootTypes.LOOT_TYPE_NOTALLOWED:
            slot = 0
            # Slot should match real current_loot indexes.
            for loot in loot_manager.current_loot:
                if loot:
                    # Skip conditions:
                    # - Is quest item and player does not have the involved quest.
                    # - Is quest multi-drop item and is no longer visible to this player.
                    if not from_item_container and loot.is_quest_item() and \
                            not self.player_or_group_require_quest_item(loot.get_item_entry(), only_self=True) or \
                            not loot.is_visible_to_player(self):
                        slot += 1
                        continue

                    item_templates.append(loot.item.item_template)
                    item_count += 1

                    item_data.extend(pack(
                        '<B3I',
                        slot,
                        loot.item.item_template.entry,
                        loot.quantity,
                        loot.item.item_template.display_id,
                    ))
                slot += 1

            # At this point, this player has access to the loot window, add him to the active looters.
            loot_manager.add_active_looter(self)

        # Set the header, now that we know how many actual items were sent.
        data = bytearray(pack(
            '<QBIB',
            loot_manager.world_object.guid,
            loot_type,
            loot_manager.current_money,
            item_count
        ))

        # Append item data and send all the packed item detail queries for current loot, if any.
        if item_count:
            data.extend(item_data)
            self.enqueue_packets(ItemManager.get_item_query_packets(item_templates))

        packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_RESPONSE, data)
        self.enqueue_packet(packet)

        return loot_type != LootTypes.LOOT_TYPE_NOTALLOWED

    def reward_reputation_on_kill(self, creature, rate=1.0):
        reputation_on_kill_entry = WorldDatabaseManager.CreatureOnKillReputationHolder.\
            creature_on_kill_reputation_get_by_entry(creature.entry)
        if not reputation_on_kill_entry:
            return
        self.reputation_manager.reward_reputation_on_kill(creature, rate)

    def give_xp(self, amounts, victim=None, notify=True):
        if self.level >= config.Unit.Player.Defaults.max_level or not self.is_alive:
            return 0

        """
        0.5.3 supports multiple amounts of XP and then combines them all

        uint64_t victim,
        uint32_t count

        loop (for each count):
            uint64_t guid,
            int32_t xp
        """

        amount_bytes = b''
        total_amount = 0
        for amount in amounts:
            # Adjust XP gaining rates using config.
            amount = max(0, int(amount * config.Server.Settings.xp_rate))

            total_amount += amount
            amount_bytes += pack('<QI', self.guid, amount)

        if notify:
            data = pack('<QI',
                        victim.guid if victim else self.guid,
                        len(amounts)
                        )
            data += amount_bytes
            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOG_XPGAIN, data))

        # Reward kill experience to pet.
        if victim:
            pet = self.pet_manager.get_active_permanent_pet()
            if pet:
                pet.get_pet_data().add_experience(total_amount)

        if self.xp + total_amount >= self.next_level_xp:  # Level up!
            xp_to_level = self.next_level_xp - self.xp
            level_amount = 0
            remaining_amount = total_amount
            # Do the actual XP conversion into level(s).
            while remaining_amount >= xp_to_level:
                level_amount += 1
                remaining_amount -= xp_to_level
                xp_to_level = Formulas.PlayerFormulas.xp_to_level(self.level + level_amount)

            self.xp = remaining_amount  # Set the remaining amount XP as current.
            self.set_uint32(PlayerFields.PLAYER_XP, self.xp)
            self.mod_level(self.level + level_amount)
        else:
            self.xp = self.xp + total_amount
            self.set_uint32(PlayerFields.PLAYER_XP, self.xp)

        return total_amount

    def mod_level(self, level):
        if level != self.level:
            # Even if level 255 is the maximum supported, client doesn't expect a level higher than 100
            # (player won't even appear in the /who list).
            max_level = 100 if self.session.account_mgr.is_gm() else config.Unit.Player.Defaults.max_level
            if 0 < level <= max_level:
                # Check if the new level is higher than the current one or not.
                is_leveling_up = level > self.level
                # Store the difference between the starting level and the target level.
                level_count = abs(level - self.level)

                # Calculate total talent and skill points for each level starting from the current character level.
                talent_points = 0
                skill_points = 0
                for i in range(level_count):
                    if is_leveling_up:
                        level_for_calculation = self.level + (i + 1)
                    else:
                        level_for_calculation = self.level - i
                    talent_points += Formulas.PlayerFormulas.talent_points_gain_per_level(level_for_calculation)
                    skill_points += Formulas.PlayerFormulas.skill_points_gain_per_level(level_for_calculation)

                if is_leveling_up:
                    # Add Talent and Skill points.
                    self.add_talent_points(talent_points)
                    self.add_skill_points(skill_points)
                else:
                    # Remove Talent and Skill points.
                    self.remove_talent_points(talent_points)
                    self.remove_skill_points(skill_points)

                self.level = level
                self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
                self.player.leveltime = 0

                self.skill_manager.update_skills_max_value()
                self.skill_manager.build_update()

                self.pet_manager.handle_owner_level_change()

                self.stat_manager.init_stats()
                hp_diff, mana_diff = self.stat_manager.apply_bonuses()
                self.replenish_powers()

                if is_leveling_up:
                    data = pack(
                        '<3I',
                        level,
                        hp_diff,
                        mana_diff if self.power_type == PowerTypes.TYPE_MANA else 0
                    )

                    self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LEVELUP_INFO, data))

                self.next_level_xp = Formulas.PlayerFormulas.xp_to_level(self.level)
                self.set_uint32(PlayerFields.PLAYER_NEXT_LEVEL_XP, self.next_level_xp)
                self.quest_manager.update_surrounding_quest_status()
                self.friends_manager.send_update_to_friends()

    def player_or_group_require_quest_item(self, item_entry, only_self=False):
        if not self.group_manager or only_self:
            return self.quest_manager.item_needed_by_quests(item_entry)
        else:
            for member in list(self.group_manager.members.values()):
                player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
                if player_mgr and player_mgr.quest_manager.item_needed_by_quests(item_entry):
                    return True
        return False

    def add_bank_slot(self, slot_cost):
        self.player.bankslots += 1
        self.player_bytes_2 = self.get_player_bytes_2()
        self.set_uint32(PlayerFields.PLAYER_BYTES_2, self.player_bytes_2)
        self.mod_money(-slot_cost)

    def mod_money(self, amount):
        if self.coinage + amount < 0:
            amount = -self.coinage

        # Gold hard cap: 214748 gold, 36 silver and 47 copper
        if self.coinage + amount > 2147483647:
            self.coinage = 2147483647
        else:
            self.coinage += amount

        self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)

    def on_zone_change(self, new_zone):
        is_new_zone = new_zone != self.zone
        # Update player zone.
        self.zone = new_zone

        if is_new_zone:
            # Update friends and group.
            self.friends_manager.send_update_to_friends()
            if self.group_manager:
                self.group_manager.send_update()

        # Checks below this condition can only happen if map loading is enabled.
        if not config.Server.Settings.use_map_tiles:
            return

        # Exploration handling (only if player is not flying).
        if self.unit_flags & UnitFlags.UNIT_FLAG_TAXI_FLIGHT:
            return

        area_information = MapManager.get_area_information(self.map_id, self.location.x, self.location.y)

        # Did not find, or zone id does not match due resolution, try to resolve.
        if not area_information or area_information.zone_id != new_zone:
            area_information = DbcDatabaseManager.AreaInformationHolder.get_by_map_and_zone(self.map_id, new_zone)

        # Did not find a match from neither, MapTile area information nor cached AreaInformation.
        if not area_information:
            return

        # Check if we need to set this zone as explored.
        if area_information.explore_bit >= 0 and not self.has_area_explored(area_information.explore_bit):
            self.set_area_explored(area_information)

    def has_area_explored(self, area_explore_bit):
        return self.explored_areas[area_explore_bit]

    def set_area_explored(self, area_information):
        self.explored_areas[area_information.explore_bit] = True
        if area_information.level > 0:
            if self.level < config.Unit.Player.Defaults.max_level:
                # The following calculations are taken from VMaNGOS core.
                xp_rate = int(config.Server.Settings.xp_rate)
                diff = self.level - area_information.level
                if diff < -5:
                    xp_gain = WorldDatabaseManager.exploration_base_xp_get_by_level(self.level + 5) * xp_rate
                elif diff > 5:
                    exploration_percent = (100 - ((diff - 5) * 5))
                    if exploration_percent > 100:
                        exploration_percent = 100
                    elif exploration_percent < 0:
                        exploration_percent = 0
                    base_xp = WorldDatabaseManager.exploration_base_xp_get_by_level(area_information.level)
                    xp_gain = base_xp * exploration_percent / 100 * xp_rate
                else:
                    xp_gain = WorldDatabaseManager.exploration_base_xp_get_by_level(area_information.level) * xp_rate
                self.give_xp([xp_gain], notify=False)
            else:
                xp_gain = 0

            # Notify client new discovered zone + xp gain.
            data = pack('<2I', area_information.zone_id, int(xp_gain * config.Server.Settings.xp_rate))
            packet = PacketWriter.get_packet(OpCode.SMSG_EXPLORATION_EXPERIENCE, data)
            self.enqueue_packet(packet)

    def update_swimming_state(self, state):
        if state:
            self.liquid_information = MapManager.get_liquid_information(self.map_id, self.location.x, self.location.y,
                                                                        self.location.z)
            if not self.liquid_information:
                Logger.warning(f'Unable to retrieve liquids information. Map {self.map_id} X {self.location.x} Y '
                               f'{self.location.y}')
        else:
            self.liquid_information = None

    def is_swimming(self):
        return self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING

    # override
    def is_above_water(self):
        return not self.is_swimming()

    # override
    def is_under_water(self):
        if not self.liquid_information or not self.is_swimming():
            return False
        return self.location.z + (self.current_scale * 2) < self.liquid_information.height

    # override
    def is_in_deep_water(self):
        if self.liquid_information is None or not self.is_swimming():
            return False
        return self.liquid_information.liquid_type == LiquidTypes.DEEP

    def update_liquid_information(self):
        # Retrieve the latest liquid information, only if player is swimming.
        if self.is_swimming():
            self.liquid_information = MapManager.get_liquid_information(self.map_id, self.location.x, self.location.y,
                                                                        self.location.z)

    # override
    def initialize_field_values(self):
        # Initial field values, after this, fields must be modified by setters or directly writing values to them.
        if not self.initialized:
            self.bytes_0 = self.get_bytes_0()
            self.bytes_1 = self.get_bytes_1()
            self.bytes_2 = self.get_bytes_2()
            self.player_bytes_2 = self.get_player_bytes_2()

            # Object fields.
            self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.player.guid)
            self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_type_mask())
            self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
            self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

            # Unit fields.
            self.set_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
            self.set_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
            self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER2, self.power_2)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER3, self.power_3)
            self.set_uint32(UnitFields.UNIT_FIELD_POWER4, self.power_4)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, self.max_power_1)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER2, self.max_power_2)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER3, self.max_power_3)
            self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER4, self.max_power_4)
            self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
            self.set_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)
            self.set_int32(UnitFields.UNIT_FIELD_STAT0, self.str)
            self.set_int32(UnitFields.UNIT_FIELD_STAT1, self.agi)
            self.set_int32(UnitFields.UNIT_FIELD_STAT2, self.sta)
            self.set_int32(UnitFields.UNIT_FIELD_STAT3, self.int)
            self.set_int32(UnitFields.UNIT_FIELD_STAT4, self.spi)
            self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT0, self.base_str)
            self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT1, self.base_agi)
            self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT2, self.base_sta)
            self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT3, self.base_int)
            self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT4, self.base_spi)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
            self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, self.offhand_attack_time)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)
            self.set_float(UnitFields.UNIT_FIELD_BOUNDINGRADIUS, self.bounding_radius)
            self.set_float(UnitFields.UNIT_FIELD_COMBATREACH, self.combat_reach)
            self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, self.weapon_reach)
            self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.current_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE, self.resistance_buff_mods_positive_0)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 1, self.resistance_buff_mods_positive_1)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 2, self.resistance_buff_mods_positive_2)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 3, self.resistance_buff_mods_positive_3)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 4, self.resistance_buff_mods_positive_4)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 5, self.resistance_buff_mods_positive_5)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE, self.resistance_buff_mods_negative_0)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 1, self.resistance_buff_mods_negative_1)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 2, self.resistance_buff_mods_negative_2)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 3, self.resistance_buff_mods_negative_3)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 4, self.resistance_buff_mods_negative_4)
            self.set_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 5, self.resistance_buff_mods_negative_5)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
            self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)
            self.set_uint32(UnitFields.UNIT_MOD_CAST_SPEED, 0)
            self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
            self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)

            # Player fields.
            self.set_uint32(PlayerFields.PLAYER_FIELD_NUM_INV_SLOTS, self.num_inv_slots)
            self.set_uint32(PlayerFields.PLAYER_BYTES, self.player_bytes)
            self.set_uint32(PlayerFields.PLAYER_XP, self.xp)
            self.set_uint32(PlayerFields.PLAYER_NEXT_LEVEL_XP, self.next_level_xp)
            self.set_uint32(PlayerFields.PLAYER_BYTES_2, self.player_bytes_2)
            self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS1, self.talent_points)
            self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS2, self.skill_points)
            self.set_float(PlayerFields.PLAYER_BLOCK_PERCENTAGE, self.block_percentage)
            self.set_float(PlayerFields.PLAYER_DODGE_PERCENTAGE, self.dodge_percentage)
            self.set_float(PlayerFields.PLAYER_PARRY_PERCENTAGE, self.parry_percentage)
            self.set_uint32(PlayerFields.PLAYER_BASE_MANA, self.base_mana)

            # Skills.
            self.skill_manager.build_update()

            # Guild.
            if self.guild_manager:
                self.guild_manager.build_update(self)

            # Duel.
            if self.duel_manager:
                self.duel_manager.build_update(self)

            # Inventory.
            self.inventory.build_update()

            # Auras.
            self.aura_manager.build_update()

            # Quests.
            self.quest_manager.build_update()

            self.initialized = True

    def set_current_selection(self, guid):
        self.current_selection = guid
        self.set_uint64(PlayerFields.PLAYER_SELECTION, guid)

    def set_base_str(self, str_):
        self.base_str = str_
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT0, str_)

    def set_base_agi(self, agi):
        self.base_agi = agi
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT1, agi)

    def set_base_sta(self, sta):
        self.base_sta = sta
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT2, sta)

    def set_base_int(self, int_):
        self.base_int = int_
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT3, int_)

    def set_base_spi(self, spi):
        self.base_spi = spi
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT4, spi)

    def set_str(self, str_):
        self.str = str_
        self.set_int32(UnitFields.UNIT_FIELD_STAT0, str_)

    def set_agi(self, agi):
        self.agi = agi
        self.set_int32(UnitFields.UNIT_FIELD_STAT1, agi)

    def set_sta(self, sta):
        self.sta = sta
        self.set_int32(UnitFields.UNIT_FIELD_STAT2, sta)

    def set_int(self, int_):
        self.int = int_
        self.set_int32(UnitFields.UNIT_FIELD_STAT3, int_)

    def set_spi(self, spi):
        self.spi = spi
        self.set_int32(UnitFields.UNIT_FIELD_STAT4, spi)

    def set_block_chance(self, block):
        self.block_percentage = block
        self.set_float(PlayerFields.PLAYER_BLOCK_PERCENTAGE, block)

    def set_parry_chance(self, parry):
        self.parry_percentage = parry
        self.set_float(PlayerFields.PLAYER_PARRY_PERCENTAGE, parry)

    def set_dodge_chance(self, dodge):
        self.dodge_percentage = dodge
        self.set_float(PlayerFields.PLAYER_DODGE_PERCENTAGE, dodge)

    def add_talent_points(self, talent_points):
        self.talent_points += talent_points
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS1, self.talent_points)

    def add_skill_points(self, skill_points):
        self.skill_points += skill_points
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS2, self.skill_points)

    def remove_talent_points(self, talent_points):
        self.talent_points = max(0, self.talent_points - talent_points)
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS1, self.talent_points)

    def remove_skill_points(self, skill_points):
        self.skill_points = max(0, self.skill_points - skill_points)
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS2, self.skill_points)

    # override
    def handle_spell_cast_skill_gain(self, casting_spell):
        return self.skill_manager.handle_spell_cast_skill_gain(casting_spell)

    # override
    def handle_combat_skill_gain(self, damage_info, spell_id=0):
        if damage_info.attacker == self:
            self.skill_manager.handle_weapon_skill_gain_chance(damage_info.attack_type)
        else:
            self.skill_manager.handle_defense_skill_gain_chance(damage_info)

    # override
    def handle_melee_attack_procs(self, damage_info):
        super().handle_melee_attack_procs(damage_info)
        self.enchantment_manager.handle_melee_attack_procs(damage_info)

    def _send_attack_swing_error(self, victim, opcode):
        data = pack('<2Q', self.guid, victim.guid if victim else 0)
        self.enqueue_packet(PacketWriter.get_packet(opcode, data))

    # override
    def send_attack_swing_not_in_range(self, victim):
        self._send_attack_swing_error(victim, OpCode.SMSG_ATTACKSWING_NOTINRANGE)

    # override
    def send_attack_swing_facing_wrong_way(self, victim):
        self._send_attack_swing_error(victim, OpCode.SMSG_ATTACKSWING_BADFACING)

    # override
    def send_attack_swing_cant_attack(self, victim):
        self._send_attack_swing_error(victim, OpCode.SMSG_ATTACKSWING_CANT_ATTACK)

    # override
    def send_attack_swing_dead_target(self, victim):
        self._send_attack_swing_error(victim, OpCode.SMSG_ATTACKSWING_DEADTARGET)

    # override
    def send_attack_swing_not_standing(self, victim):
        self._send_attack_swing_error(victim, OpCode.SMSG_ATTACKSWING_NOTSTANDING)

    # override
    def has_mainhand_weapon(self):
        return self.inventory.has_main_weapon() or self.inventory.has_two_handed_weapon()

    # override
    def has_offhand_weapon(self):
        return self.inventory.has_offhand_weapon()

    # override
    def has_ranged_weapon(self):
        return self.inventory.has_ranged_weapon()

    # override
    def can_block(self, attacker_location=None):
        if not super().can_block(attacker_location):
            return False

        if attacker_location and not self.location.has_in_arc(attacker_location, math.pi):
            return False  # players can't block from behind.

        return self.inventory.has_offhand() and \
            self.inventory.get_offhand().item_template.inventory_type == InventoryTypes.SHIELD

    # override
    def can_parry(self, attacker_location=None):
        if not super().can_parry(attacker_location):
            return False

        if attacker_location and not self.location.has_in_arc(attacker_location, math.pi):
            return False  # players can't parry from behind.

        return True

    # override
    def can_dodge(self, attacker_location=None):
        if not super().can_dodge(attacker_location):
            return False

        if attacker_location and not self.location.has_in_arc(attacker_location, math.pi):
            return False  # players can't dodge from behind.

        return True

    def set_far_sight(self, guid):
        self.set_uint64(PlayerFields.PLAYER_FARSIGHT, guid)
        # Upon changing players view camera, need to force the update so client is aware immediately.
        self.force_fields_update()

    def set_charmed_by(self, charmer, subtype=0, movement_type=None, remove=False):
        # Charmer must be set here not in parent.
        self.charmer = charmer if not remove else None

        if remove:
            # Restore faction.
            self.set_player_variables()
        else:
            # Charmer faction.
            self.faction = charmer.faction
        super().set_charmed_by(charmer, subtype=subtype, remove=remove)

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def set_shapeshift_form(self, shapeshift_form):
        super().set_shapeshift_form(shapeshift_form)
        self.bytes_1 = self.get_bytes_1()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def add_combo_points_on_target(self, target, combo_points, hide=False):
        # Killing a unit with a combo generator can generate a combo point after death.
        if combo_points <= 0 or not target.is_alive:
            return

        if target.guid != self.combo_target:
            self.combo_points = min(combo_points, 5)
            self.combo_target = target.guid
        else:
            self.combo_points = min(combo_points + self.combo_points, 5)

        self.bytes_2 = self.get_bytes_2()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        # Set combo target to a valid but non-existent guid if hiding.
        #  TODO: it's unclear if combo points should be hidden in 0.5.3 for warriors, and if so, how it was done.
        self.set_uint64(UnitFields.UNIT_FIELD_COMBO_TARGET, self.combo_target if not hide else 0xffffffffffffffff)

    # override
    def remove_combo_points(self):
        self.combo_points = 0
        self.bytes_2 = self.get_bytes_2()
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        self.combo_target = 0
        self.set_uint64(UnitFields.UNIT_FIELD_COMBO_TARGET, self.combo_target)

    # override
    def receive_damage(self, damage_info, source=None, casting_spell=None, is_periodic=False):
        # Set damage to 0 but still continue, else threat system will fail to link units.
        # Causing leave_combat to fail using god mode, affecting also Beastmaster.
        damage_info.total_damage = 0 if self.is_god else damage_info.total_damage
        return super().receive_damage(damage_info, source, casting_spell=casting_spell, is_periodic=is_periodic)

    # override
    def receive_healing(self, amount, source=None):
        if not super().receive_healing(amount, source):
            return False

        if source:
            data = pack('<IQ', amount, source.guid)
            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_HEALSPELL_ON_PLAYER, data))
        return True

    def enqueue_packets(self, packets):
        if self.session:
            self.session.enqueue_packets(packets)
        else:
            Logger.warning('Tried to send packet to null session.')

    def enqueue_packet(self, data):
        if self.session:
            self.session.enqueue_packet(data)
        else:
            Logger.warning('Tried to send packet to null session.')

    def check_swimming_state(self, elapsed):
        if not self.is_alive:
            return

        self.last_swimming_check_timer += elapsed
        if self.last_swimming_check_timer >= 1:
            self.last_swimming_check_timer = 0
            if self.is_swimming() and not self.liquid_information:
                self.update_swimming_state(True)
            elif not self.is_swimming() and self.liquid_information:
                self.update_swimming_state(False)

    # override
    def update(self, now):
        if now > self.last_tick > 0 and self.online:
            elapsed = now - self.last_tick

            # Surrounding timer.
            self.update_surroundings_timer += elapsed
            # Relocation timer.
            self.relocation_call_for_help_timer += elapsed

            # Update played time.
            self.player.totaltime += elapsed
            self.player.leveltime += elapsed

            # Stealth detect.
            self.units_stealth_detection_check(elapsed)
            # Regeneration.
            self.regenerate(elapsed)
            # Attack update.
            self.attack_update(elapsed)
            # Check swimming state.
            self.check_swimming_state(elapsed)
            # Sanctuary check.
            self.update_sanctuary(elapsed)

            # SpellManager.
            self.spell_manager.update(now)
            # AuraManager.
            self.aura_manager.update(now)
            # QuestManager.
            self.quest_manager.update(elapsed)

            # Waypoints (mostly flying paths) update.
            self.movement_manager.update(now, elapsed)

            # Duel tick.
            if self.duel_manager:
                self.duel_manager.update(self, elapsed)

            # Enchantment manager.
            self.enchantment_manager.update(elapsed)

            # Release spirit timer.
            if not self.is_alive:
                if self.spirit_release_timer < 300:  # 5 min.
                    self.spirit_release_timer += elapsed
                else:
                    self.resurrect()

            # Update timers (Breath, Fatigue, Feign Death).
            if self.is_alive:
                self.mirror_timers_manager.update(elapsed)

            # Logout timer.
            if self.logout_timer > 0:
                self.logout_timer -= elapsed
                if self.logout_timer < 0:
                    self.logout()
                    return

            # Check if player has update fields changes.
            has_changes = self.has_pending_updates()
            # Avoid inventory/item update if there is an ongoing inventory operation.
            has_inventory_changes = not self.inventory.update_locked and self.inventory.has_pending_updates()

            # Movement checks and group updates.
            has_moved = self.has_moved or self.has_turned
            if has_moved or has_changes:
                # Update self stats and location to other party members.
                if self.group_manager:
                    self.group_manager.update_party_member_stats(elapsed, requester=self)
                # Player moved, notify surrounding units for proximity aggro.
                if has_moved:
                    # Check spell and aura move interrupts.
                    self.spell_manager.check_spell_interrupts(moved=self.has_moved, turned=self.has_turned)
                    self.aura_manager.check_aura_interrupts(moved=self.has_moved, turned=self.has_turned)
                    # Relocate only if x, y changed.
                    if self.has_moved and not self.pending_relocation:
                        self.pending_relocation = True
                    # Reset flags.
                    self.set_has_moved(False, False, flush=True)

            # Update system, propagate player changes to surrounding units.
            if self.online and has_changes or has_inventory_changes:
                MapManager.update_object(self, has_changes=has_changes, has_inventory_changes=has_inventory_changes)
            # Not dirty, has a pending teleport and a teleport is not ongoing.
            elif not has_changes and not has_inventory_changes and self.pending_teleport_data and not self.update_lock:
                self.trigger_teleport()
            # Do normal update.
            else:
                MapManager.update_object(self)
                self.synchronize_db_player()

            # If not teleporting, notify self movement to surrounding units for proximity aggro.
            if not self.update_lock:
                # Relocation.
                if self.relocation_call_for_help_timer >= 1:
                    if self.pending_relocation:
                        self._on_relocation()
                    self.relocation_call_for_help_timer = 0
                # Update known surrounding objects.
                if self.update_surroundings_timer >= 1:
                    self.update_surrounding_known_objects()
                    self.update_surroundings_timer = 0

        self.last_tick = now

    def get_deathbind_coordinates(self):
        return (self.deathbind.deathbind_map, Vector(self.deathbind.deathbind_position_x,
                                                     self.deathbind.deathbind_position_y,
                                                     self.deathbind.deathbind_position_z))

    # override
    def die(self, killer=None):
        if not self.is_alive:
            return False

        if killer:
            # If this player is dueling and the death blow comes from the opponent just end duel and set HP to 1.
            if self.duel_manager and self.duel_manager.is_unit_involved(killer):
                if killer.get_type_id() != ObjectTypeIds.ID_PLAYER:
                    killer = killer.get_charmer_or_summoner()  # Pet dealt killing blow - pass owner to duel manager.
                self.duel_manager.end_duel(DuelWinner.DUEL_WINNER_KNOCKOUT, DuelComplete.DUEL_FINISHED, killer)
                self.set_health(1)
                return False

            # Shows a message in chat with the name of the killer.
            if killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
                death_notify_packet = PacketWriter.get_packet(OpCode.SMSG_DEATH_NOTIFY, pack('<Q', killer.guid))
                self.enqueue_packet(death_notify_packet)

        TradeManager.cancel_trade(self)
        self.spirit_release_timer = 0
        self.mirror_timers_manager.stop_all()
        self.update_swimming_state(False)

        self.unit_flags = UnitFlags.UNIT_FLAG_PLAYER_CONTROLLED

        return super().die(killer)

    # override
    def respawn(self, recovery_percentage: float = 1):
        # Set expected HP / Power before respawning.
        # It wasn't until Patch 0.6 that players had 50% of health and mana after reviving. It is currently unknown
        # the % that players had in 0.5.3, so 100% is assumed.
        self.set_health(math.ceil(self.max_health * recovery_percentage))
        if self.power_type == PowerTypes.TYPE_MANA:
            self.set_power_value(math.ceil(self.get_max_power_value() * recovery_percentage))
        elif self.power_type == PowerTypes.TYPE_ENERGY:
            self.recharge_power()
        else:  # Rage or focus.
            self.set_power_value(0)

        super().respawn()

        # Add Resurrection Sickness (2146) to the player.
        # TODO: Unsure if it should always be applied regardless of whether the player resurrected normally or was
        #  resurrected by another player, assuming it was always applied for now.
        self.spell_manager.handle_cast_attempt(2146, self, SpellTargetMask.SELF, validate=False)

    def resurrect(self, release_spirit=False):
        # Spawn its corpse.
        if not self.resurrect_data:
            from game.world.managers.objects.corpse.CorpseManager import CorpseManager
            CorpseManager.spawn(self)

        if self.resurrect_data and not release_spirit:
            is_instant = self.resurrect_data.resurrect_map == self.map_id and \
                         self.resurrect_data.resurrect_location == self.location
            self.teleport(self.resurrect_data.resurrect_map, self.resurrect_data.resurrect_location,
                          is_instant=is_instant, recovery=self.resurrect_data.recovery_percentage)
        else:
            deathbind_map, deathbind_location = self.get_deathbind_coordinates()
            self.teleport(deathbind_map, deathbind_location, recovery=1, is_instant=False)

    # override
    def get_name(self):
        return self.player.name

    def set_extra_flag(self, flag, enable=True):
        if enable:
            self.player.extra_flags |= flag
        else:
            self.player.extra_flags &= ~flag
        self.set_uint32(PlayerFields.PLAYER_BYTES_2, self.get_player_bytes_2())

    def get_player_bytes(self):
        return ByteUtils.bytes_to_int(
            self.player.haircolour,  # Hair colour.
            self.player.hairstyle,  # Hairstyle.
            self.player.face,  # Player face.
            self.player.skin  # Player skin.
        )

    def get_player_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # Values from Exhaustion.dbc in later versions, unknown here.
            self.player.bankslots,  # Bank slots.
            self.player.facialhair,  # Facial hair.
            self.player.extra_flags  # Extra flags.
        )

    # override
    def get_bytes_0(self):
        return ByteUtils.bytes_to_int(
            self.power_type,  # Power type.
            self.gender,  # Gender.
            self.class_,  # Player class.
            self.race  # Player race.
        )

    # override
    def get_bytes_1(self):
        return ByteUtils.bytes_to_int(
            self.sheath_state,  # Sheath state.
            self.shapeshift_form,  # Shapeshift form.
            0,  # NPC flags (0 for players).
            self.stand_state  # Stand state.
        )

    # override
    def get_bytes_2(self):
        return ByteUtils.bytes_to_int(
            0,  # Unknown.
            0,  # Pet flags (0 for players).
            0,  # Misc flags (0 for players?).
            self.combo_points  # Combo points.
        )

    # override
    def get_damages(self):
        return self.damage

    # override
    def can_detect_target(self, target, distance=0):
        # Party group.
        if self.group_manager and self.group_manager.is_party_member(target.guid):
            # Not dueling.
            if not self.duel_manager or not self.duel_manager.is_unit_involved(target):
                return True, False
        return super().can_detect_target(target, distance)

    def units_stealth_detection_check(self, elapsed):
        if len(self.known_stealth_units) == 0:
            return
        self.stealth_detect_timer += elapsed
        if self.stealth_detect_timer >= 1:  # Secs.
            for guid, stealth_status in list(self.known_stealth_units.items()):
                is_stealth = stealth_status[1]
                unit = stealth_status[0]
                can_detect = self.can_detect_target(unit)[0]
                # Can detect and we had the object invisible.
                if is_stealth and can_detect and guid in self.known_objects:
                    # Unit is no longer stealth, pop.
                    if not unit.unit_flags & UnitFlags.UNIT_FLAG_SNEAK:
                        del self.known_stealth_units[guid]
                    self.enqueue_known_objects_update(object_type=ObjectTypeIds.ID_UNIT)
                # Unit is stealth but remains visible to us, should destroy.
                elif is_stealth and not can_detect and guid in self.known_objects:
                    self.enqueue_known_objects_update(object_type=ObjectTypeIds.ID_UNIT)
                # Unit is no longer stealth, can detect, and we don't know this unit, should create.
                elif not is_stealth and can_detect and guid not in self.known_objects:
                    # Unit is no longer stealth, pop.
                    if not unit.unit_flags & UnitFlags.UNIT_FLAG_SNEAK:
                        del self.known_stealth_units[guid]
                    self.enqueue_known_objects_update(object_type=ObjectTypeIds.ID_UNIT)

            self.stealth_detect_timer = 0

    def _on_relocation(self):
        self.notify_move_in_line_of_sight()

    # override
    def on_cell_change(self):
        self.quest_manager.update_surrounding_quest_status()

    # override
    def can_attack_target(self, target):
        if not target or target is self:
            return False

        if target.get_type_id() == ObjectTypeIds.ID_PLAYER:
            # Return True if players are dueling.
            if self.duel_manager and self.duel_manager.is_unit_involved(target) and \
                    self.duel_manager.duel_state == DuelState.DUEL_STATE_STARTED:
                return True

            # Only allow pvp in pvp maps (PvP system was not added until Patch 0.7).
            if not MapManager.get_map(target.map_id, target.instance_id).is_pvp():
                return False

        return super().can_attack_target(target)

    # override
    def is_in_world(self):
        return self.online and not self.update_lock and self.get_map()

    # override
    def get_type_mask(self):
        return super().get_type_mask() | ObjectTypeFlags.TYPE_PLAYER

    # override
    def get_low_guid(self):
        return self.guid & ~HighGuid.HIGHGUID_PLAYER

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_PLAYER

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_PLAYER

    # override
    def get_current_weapon_for_attack_type(self, attack_type: AttackTypes) -> Optional[ItemManager]:
        # Feral form attacks don't use a weapon.
        if self.is_in_feral_form():
            return None

        # Handle disarmed main hand.
        if attack_type == AttackTypes.BASE_ATTACK and self.unit_flags & UnitFlags.UNIT_FLAG_DISARMED:
            return None

        if attack_type == AttackTypes.BASE_ATTACK:
            return self.inventory.get_main_hand()
        elif attack_type == AttackTypes.OFFHAND_ATTACK:
            return self.inventory.get_offhand()
        else:
            return self.inventory.get_ranged()

    @staticmethod
    def get_team_for_race(race):
        race_entry = DbcDatabaseManager.chr_races_get_by_race(race)
        if race_entry:
            if race_entry.BaseLanguage == 1:
                return Teams.TEAM_HORDE
            elif race_entry.BaseLanguage == 7:
                return Teams.TEAM_ALLIANCE

        return Teams.TEAM_NONE
