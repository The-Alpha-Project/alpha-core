import math
from struct import unpack
from bitarray import bitarray
from database.dbc.DbcDatabaseManager import *
from database.realm.RealmDatabaseManager import RealmDatabaseManager
from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.WorldSessionStateHandler import WorldSessionStateHandler
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.maps.MapManager import MapManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.spell.ExtendedSpellData import ShapeshiftInfo
from game.world.managers.objects.units.player.ChannelManager import ChannelManager
from game.world.managers.objects.units.player.SkillManager import SkillManager
from game.world.managers.objects.units.player.StatManager import UnitStats
from game.world.managers.objects.units.player.TalentManager import TalentManager
from game.world.managers.objects.units.player.TradeManager import TradeManager
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
from utils.Logger import Logger
from utils.constants.DuelCodes import *
from utils.constants.ItemCodes import InventoryTypes
from utils.constants.MiscCodes import ChatFlags, LootTypes, LiquidTypes
from utils.constants.MiscCodes import ObjectTypeFlags, ObjectTypeIds, PlayerFlags, WhoPartyStatus, HighGuid, \
    AttackTypes, MoveFlags
from utils.constants.SpellCodes import ShapeshiftForms, SpellSchools, SpellTargetMask
from utils.constants.UnitCodes import Classes, PowerTypes, Races, Genders, UnitFlags, Teams, SplineFlags
from utils.constants.UpdateFields import *

MAX_ACTION_BUTTONS = 120
MAX_EXPLORED_AREAS = 488


class PlayerManager(UnitManager):
    def __init__(self,
                 player=None,
                 session=None,
                 num_inv_slots=0x89,  # Paperdoll + Bag slots + Bag space
                 player_bytes=0,  # skin, face, hair style, hair color
                 xp=0,
                 next_level_xp=0,
                 player_bytes_2=0,  # player flags, facial hair, bank slots, 0
                 block_percentage=0,
                 dodge_percentage=0,
                 parry_percentage=0,
                 base_hp=0,
                 base_mana=0,
                 combo_points=0,
                 combo_target=0,
                 chat_flags=0,
                 online=False,
                 current_selection=0,
                 deathbind=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.session = session
        self.pending_teleport_destination = None
        self.pending_teleport_destination_map = -1
        self.update_lock = False
        self.is_relocating = False
        self.known_objects = dict()

        self.player = player
        self.online = online
        self.num_inv_slots = num_inv_slots
        self.xp = xp
        self.next_level_xp = next_level_xp
        self.block_percentage = block_percentage
        self.dodge_percentage = dodge_percentage
        self.parry_percentage = parry_percentage
        self.base_hp = base_hp
        self.base_mana = base_mana
        self.combo_points = combo_points
        self.combo_target = combo_target

        self.current_selection = current_selection
        self.current_loot_selection = current_selection

        self.chat_flags = chat_flags
        self.group_status = WhoPartyStatus.WHO_PARTY_STATUS_NOT_IN_PARTY
        self.race_mask = 0
        self.class_mask = 0
        self.deathbind = deathbind
        self.team = Teams.TEAM_NONE  # Set at set_player_variables().
        self.trade_data = None
        self.last_regen = 0
        self.last_swimming_check = 0
        self.spirit_release_timer = 0
        self.logout_timer = -1
        self.dirty_inventory = False
        self.pending_taxi_destination = None
        self.explored_areas = bitarray(MAX_EXPLORED_AREAS, 'little')
        self.explored_areas.setall(0)
        self.liquid_information = None

        if self.player:
            self.set_player_variables()
            self.guid = self.generate_object_guid(self.player.guid)
            self.inventory = InventoryManager(self)
            self.level = self.player.level
            self.player_bytes = unpack('<I', pack('<4B', self.player.skin, self.player.face, self.player.hairstyle, self.player.haircolour))[0]
            self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]
            self.xp = player.xp
            self.talent_points = self.player.talentpoints
            self.skill_points = self.player.skillpoints
            self.map_ = self.player.map
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
            self.online = self.player.online

            # GM checks
            self.is_god = False
            self.is_gm = self.session.account_mgr.account.gmlevel > 0
            if self.is_gm:
                self.set_gm()

            # Update exploration data.
            if self.player.explored_areas and len(self.player.explored_areas) > 0:
                self.explored_areas = bitarray(self.player.explored_areas, 'little')

            self.next_level_xp = Formulas.PlayerFormulas.xp_to_level(self.level)
            self.is_alive = self.health > 0

            self.object_type_mask |= ObjectTypeFlags.TYPE_PLAYER
            self.update_packet_factory.init_values(PlayerFields.PLAYER_END)

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
        race = DbcDatabaseManager.chr_races_get_by_race(self.player.race)

        self.faction = race.FactionID
        self.creature_type = race.CreatureType

        self.gender = self.player.gender
        is_male = self.gender == Genders.GENDER_MALE

        self.native_display_id = self.get_native_display_id(is_male, race)
        self.current_display_id = self.native_display_id

        # Initialize power type
        self.update_power_type()

        if self.player.race == Races.RACE_HUMAN:
            self.bounding_radius = 0.306 if is_male else 0.208
            self.combat_reach = 1.5
        elif self.player.race == Races.RACE_ORC:
            self.bounding_radius = 0.372 if is_male else 0.236
            self.combat_reach = 1.5
        elif self.player.race == Races.RACE_DWARF:
            self.bounding_radius = 0.347
            self.combat_reach = 1.5
        elif self.player.race == Races.RACE_NIGHT_ELF:
            self.bounding_radius = 0.389 if is_male else 0.306
            self.combat_reach = 1.5
        elif self.player.race == Races.RACE_UNDEAD:
            self.bounding_radius = 0.383
            self.combat_reach = 1.5
        elif self.player.race == Races.RACE_TAUREN:
            self.bounding_radius = 0.9747 if is_male else 0.8725
            self.combat_reach = 4.05 if is_male else 3.75
            self.native_scale = 1.35 if is_male else 1.25
        elif self.player.race == Races.RACE_GNOME:
            self.bounding_radius = 0.3519
            self.combat_reach = 1.725
            self.native_scale = 1.15
        elif self.player.race == Races.RACE_TROLL:
            self.bounding_radius = 0.306
            self.combat_reach = 1.5

        self.current_scale = self.native_scale
        self.race_mask = 1 << self.player.race - 1
        self.class_mask = 1 << self.player.class_ - 1

        self.team = PlayerManager.get_team_for_race(self.player.race)

    def set_gm(self, on=True):
        self.player.extra_flags |= PlayerFlags.PLAYER_FLAGS_GM
        self.chat_flags = ChatFlags.CHAT_TAG_GM

    def complete_login(self, first_login=False):
        self.online = True

        # Calculate stat bonuses at this point.
        self.stat_manager.apply_bonuses(replenish=first_login)

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

        # Notify player with create packet.
        self.send_update_self(create=True)

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

        # If group, notify group members.
        if self.group_manager:
            self.group_manager.send_update()

    def logout(self):
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOGOUT_COMPLETE))
        self.online = False
        self.logout_timer = -1
        self.mirror_timers_manager.stop_all()

        self.taxi_manager.update_flight_state()

        if self.duel_manager:
            self.duel_manager.force_duel_end(self)

        self.spell_manager.remove_all_casts()
        self.aura_manager.remove_all_auras()
        self.leave_combat(force=True)

        # Channels weren't saved on logout until Patch 0.5.5
        ChannelManager.leave_all_channels(self, logout=True)

        MapManager.remove_object(self)

        if self.group_manager:
            self.group_manager.send_update()

        self.friends_manager.send_offline_notification()
        self.session.save_character()

        WorldSessionStateHandler.pop_active_player(self)
        self.session.player_mgr = None
        self.session = None

    def get_tutorial_packet(self):
        return PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, pack('<18I', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                                        0, 0, 0, 0, 0))

    def get_action_buttons(self):
        data = b''
        player_buttons = RealmDatabaseManager.character_get_buttons(self.player.guid)
        for x in range(0, MAX_ACTION_BUTTONS):
            if player_buttons and x in player_buttons:
                data += pack('<i', player_buttons[x])
            else:
                data += pack('<i', 0)
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

    def set_dirty_inventory(self):
        self.inventory.build_update()
        self.dirty_inventory = True

    # Retrieve update packets from world objects, this is called only if object has pending changes.
    # (update_mask bits set).
    def update_world_object_on_me(self, world_object):
        if world_object.guid in self.known_objects:
            if world_object.get_type_id() == ObjectTypeIds.ID_PLAYER and world_object.dirty_inventory:
                # This is a known player and has inventory changes.
                for update_packet in world_object.inventory.get_inventory_update_packets(self):
                    self.enqueue_packet(update_packet)
            # Update self with known world object update packet.
            self.enqueue_packet(world_object.generate_partial_packet(requester=self))
        # Self (Player), send proper update packets to self.
        elif world_object.guid == self.guid:
            self.enqueue_packet(self.generate_partial_packet(requester=self))
            if self.dirty_inventory:
                for update_packet in self.inventory.get_inventory_update_packets(self):
                    self.enqueue_packet(update_packet)
                self.inventory.build_update()

    # Notify self with create / destroy / partial movement packets of world objects in range.
    # Range = This player current active cell plus its adjacent cells.
    def update_known_world_objects(self, force_update=False):
        players, creatures, game_objects = MapManager.get_surrounding_objects(self, [ObjectTypeIds.ID_PLAYER,
                                                                                     ObjectTypeIds.ID_UNIT,
                                                                                     ObjectTypeIds.ID_GAMEOBJECT])

        # Which objects were found in self surroundings.
        active_objects = dict()

        # Surrounding players.
        for guid, player in players.items():
            if self.guid != guid:
                active_objects[guid] = player
                if guid not in self.known_objects or not self.known_objects[guid]:
                    # We don't know this player, notify self with its update packet.
                    self.enqueue_packet(NameQueryHandler.get_query_details(player.player))
                    # Retrieve their inventory updates.
                    for update_packet in player.inventory.get_inventory_update_packets(self):
                        self.enqueue_packet(update_packet)
                    self.enqueue_packet(player.generate_create_packet(requester=self))
                    # Get partial movement packet if any.
                    if player.movement_manager.unit_is_moving():
                        packet = player.movement_manager.try_build_movement_packet(is_initial=False)
                        if packet:
                            self.enqueue_packet(packet)
                elif force_update and guid in active_objects:
                    self.update_world_object_on_me(player)
                self.known_objects[guid] = player

        # Surrounding creatures.
        for guid, creature in creatures.items():
            active_objects[guid] = creature
            if guid not in self.known_objects or not self.known_objects[guid]:
                # We don't know this creature, notify self with its update packet.
                self.enqueue_packet(creature.query_details())
                if creature.is_spawned:
                    self.enqueue_packet(creature.generate_create_packet(requester=self))
                    # Get partial movement packet if any.
                    if creature.movement_manager.unit_is_moving():
                        packet = creature.movement_manager.try_build_movement_packet(is_initial=False)
                        if packet:
                            self.enqueue_packet(packet)
                    # We only consider 'known' if its spawned, the details query is still sent.
                    self.known_objects[guid] = creature
            # Player knows the creature but is not spawned anymore, destroy it for self.
            elif guid in self.known_objects and not creature.is_spawned:
                active_objects.pop(guid)
            elif force_update and guid in active_objects:
                self.update_world_object_on_me(creature)

        # Surrounding game objects.
        for guid, gobject in game_objects.items():
            active_objects[guid] = gobject
            if guid not in self.known_objects or not self.known_objects[guid]:
                # We don't know this game object, notify self with its update packet.
                self.enqueue_packet(gobject.query_details())
                if gobject.is_spawned:
                    self.enqueue_packet(gobject.generate_create_packet(requester=self))
                    # We only consider 'known' if its spawned, the details query is still sent.
                    self.known_objects[guid] = gobject
            # Player knows the game object but is not spawned anymore, destroy it for self.
            elif guid in self.known_objects and not gobject.is_spawned:
                active_objects.pop(guid)
            elif force_update and guid in active_objects:
                self.update_world_object_on_me(gobject)

        # World objects which are known but no longer active to self should be destroyed.
        for guid, known_object in list(self.known_objects.items()):
            if guid not in active_objects:
                self.destroy_near_object(guid, skip_check=True)

        # Cleanup.
        active_objects.clear()

    def destroy_near_object(self, guid, skip_check=False):
        if skip_check or guid in self.known_objects:
            if self.known_objects[guid] is not None:
                self.enqueue_packet(self.known_objects[guid].get_destroy_packet())
                del self.known_objects[guid]
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
            self.player.map = self.map_
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

    # TODO: teleport system needs a complete rework
    def teleport(self, map_, location, is_instant=False):
        if not DbcDatabaseManager.map_get_by_id(map_):
            return False

        if not MapManager.validate_teleport_destination(map_, location.x, location.y):
            return False

        # Make sure to end duel before starting the teleport process.
        if self.duel_manager:
            self.duel_manager.force_duel_end(self)

        # If unit is being moved by a spline, stop it.
        if self.movement_manager.unit_is_moving():
            self.movement_manager.reset()

        # TODO: Stop any movement, cancel spell cast, etc.
        # New destination we will use when we receive an acknowledge message from client.
        self.pending_teleport_destination_map = map_
        self.pending_teleport_destination = Vector(location.x, location.y, location.z, location.o)

        if is_instant:
            self.trigger_teleport()

        return True

    def trigger_teleport(self):
        # From here on, the update is blocked until the player teleports to a new location.
        # If another teleport triggers from a client message, then it will proceed once this TP is done.
        self.update_lock = True

        # Same map.
        if self.map_ == self.pending_teleport_destination_map:
            if MapManager.should_relocate(self, self.pending_teleport_destination, self.pending_teleport_destination_map):
                self.is_relocating = True

            data = pack(
                '<Q9fI',
                self.transport_id,
                self.transport.x,
                self.transport.y,
                self.transport.z,
                self.transport.o,
                self.pending_teleport_destination.x,
                self.pending_teleport_destination.y,
                self.pending_teleport_destination.z,
                self.pending_teleport_destination.o,
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
            # Destroy self.
            self.enqueue_packet(self.get_destroy_packet())
            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_TRANSFER_PENDING))

            data = pack(
                '<B4f',
                self.pending_teleport_destination_map,
                self.pending_teleport_destination.x,
                self.pending_teleport_destination.y,
                self.pending_teleport_destination.z,
                self.pending_teleport_destination.o
            )

            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_NEW_WORLD, data))

    def spawn_player_from_teleport(self):
        # Update new coordinates and map.
        if self.pending_teleport_destination_map != -1 and self.pending_teleport_destination:
            self.map_ = self.pending_teleport_destination_map
            self.location = Vector(self.pending_teleport_destination.x, self.pending_teleport_destination.y, self.pending_teleport_destination.z, self.pending_teleport_destination.o)

        # Player changed map, send initial spells, action buttons and create packet.
        if not self.is_relocating:
            self.enqueue_packet(self.spell_manager.get_initial_spells())
            self.enqueue_packet(self.get_action_buttons())
            self.enqueue_packet(self.generate_create_packet(requester=self))

        self.unmount()

        # Get us in a new cell and check for pending changes.
        MapManager.update_object(self, check_pending_changes=True)

        self.pending_teleport_destination_map = -1
        self.pending_teleport_destination = None
        self.update_lock = False
        self.is_relocating = False

        # Update managers.
        self.friends_manager.send_update_to_friends()
        if self.group_manager and self.group_manager.is_party_formed():
            self.group_manager.send_update()

    def set_root(self, active):
        if not self.session:
            return

        super().set_root(active)

        if active:
            opcode = OpCode.SMSG_FORCE_MOVE_ROOT
        else:
            opcode = OpCode.SMSG_FORCE_MOVE_UNROOT
        self.enqueue_packet(PacketWriter.get_packet(opcode))

    # TODO Maybe merge all speed changes in one method
    # override
    def change_speed(self, speed=0):
        if super().change_speed(speed):
            data = pack('<f', self.running_speed)
            self.session.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FORCE_SPEED_CHANGE, data))
            # TODO Move object update to UnitManager
            MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                                                self.get_movement_update_packet()), self)

    def change_swim_speed(self, swim_speed=0):
        if swim_speed <= 0:
            swim_speed = config.Unit.Defaults.swim_speed
        elif swim_speed >= 56:
            swim_speed = 56  # Max possible swim speed
        self.swim_speed = swim_speed
        data = pack('<f', self.swim_speed)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_FORCE_SWIM_SPEED_CHANGE, data))

        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                                            self.get_movement_update_packet()), self)

    def change_walk_speed(self, walk_speed=0):
        if walk_speed <= 0:
            walk_speed = config.Unit.Defaults.walk_speed
        elif walk_speed >= 56:
            walk_speed = 56  # Max speed without glitches
        self.walk_speed = walk_speed
        data = pack('<f', self.walk_speed)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_WALK_SPEED, data))

        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                                            self.get_movement_update_packet()), self)

    def change_turn_speed(self, turn_speed=0):
        if turn_speed <= 0:
            turn_speed = config.Unit.Player.Defaults.turn_speed
        self.turn_rate = turn_speed
        data = pack('<f', self.turn_rate)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_TURN_RATE, data))

        MapManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                                            self.get_movement_update_packet()), self)

    # override
    def update_power_type(self):
        if not self.shapeshift_form:
            if self.player.class_ == Classes.CLASS_WARRIOR:
                self.power_type = PowerTypes.TYPE_RAGE
            elif self.player.class_ == Classes.CLASS_HUNTER:
                self.power_type = PowerTypes.TYPE_FOCUS
            elif self.player.class_ == Classes.CLASS_ROGUE:
                self.power_type = PowerTypes.TYPE_ENERGY
            else:
                self.power_type = PowerTypes.TYPE_MANA
        else:
            self.power_type = ShapeshiftInfo.get_power_for_form(self.shapeshift_form)

        self.bytes_0 = unpack('<I', pack('<4B', self.player.race, self.player.class_, self.gender, self.power_type))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)

    def loot_money(self):
        if self.current_selection > 0:
            enemy = MapManager.get_surrounding_unit_by_guid(self, self.current_selection)
            if enemy and enemy.loot_manager.has_money():
                # If party is formed, try to split money.
                if self.group_manager and self.group_manager.is_party_formed():
                    # Try to split money and finish on success.
                    if self.group_manager.reward_group_money(self, enemy):
                        return
                    else:  # Not able to split, notify the whole amount to the sole player.
                        data = pack('<I', enemy.loot_manager.current_money)
                        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_MONEY_NOTIFY, data))

                # Not able to split money or no group, loot money to self only.
                self.mod_money(enemy.loot_manager.current_money)
                enemy.loot_manager.clear_money()
                packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_CLEAR_MONEY)
                for looter in enemy.loot_manager.get_active_looters():
                    looter.enqueue_packet(packet)

    def loot_item(self, slot):
        if self.current_loot_selection > 0:
            high_guid: HighGuid = self.extract_high_guid(self.current_loot_selection)
            world_obj_target = None
            if high_guid == HighGuid.HIGHGUID_UNIT:
                world_obj_target = MapManager.get_surrounding_unit_by_guid(self, self.current_loot_selection, include_players=False)
            elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
                world_obj_target = MapManager.get_surrounding_gameobject_by_guid(self, self.current_loot_selection)
            elif high_guid == HighGuid.HIGHGUID_ITEM:
                world_obj_target = self.inventory.get_item_by_guid(self.current_loot_selection)

            if world_obj_target and world_obj_target.loot_manager.has_loot():
                loot = world_obj_target.loot_manager.get_loot_in_slot(slot)
                if loot and loot.item:
                    if self.inventory.add_item(item_template=loot.item.item_template, count=loot.quantity, looted=True, update_inventory=True):
                        world_obj_target.loot_manager.do_loot(slot)
                        data = pack('<B', slot)
                        packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_REMOVED, data)
                        for looter in world_obj_target.loot_manager.get_active_looters():
                            looter.enqueue_packet(packet)

    def send_loot_release(self, guid):
        self.unit_flags &= ~UnitFlags.UNIT_FLAG_LOOTING
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        high_guid: HighGuid = self.extract_high_guid(self.current_loot_selection)
        data = pack('<QB', guid, 1)  # Must be 1 otherwise client keeps the loot window open
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOOT_RELEASE_RESPONSE, data))

        if high_guid == HighGuid.HIGHGUID_UNIT:
            # If this release comes from the loot owner and has no party, set killed_by to None to allow FFA loot.
            enemy = MapManager.get_surrounding_unit_by_guid(self, guid, include_players=False)
            if enemy:
                if enemy.killed_by and enemy.killed_by == self and not enemy.killed_by.group_manager:
                    enemy.killed_by = None
                # If in party, check if this player has rights to release the loot for FFA.
                elif enemy.killed_by and enemy.killed_by.group_manager:
                    if self in enemy.killed_by.group_manager.get_allowed_looters(enemy):
                        if not enemy.loot_manager.has_loot():  # Flush looters for this enemy.
                            enemy.killed_by.group_manager.clear_looters_for_victim(enemy)
                        enemy.killed_by = None

                if not enemy.loot_manager.has_loot():
                    enemy.set_lootable(False)
                    enemy.loot_manager.clear()

                enemy.loot_manager.remove_active_looter(self)
        elif high_guid == HighGuid.HIGHGUID_GAMEOBJECT:
            game_object = MapManager.get_surrounding_gameobject_by_guid(self, self.current_loot_selection)
            if game_object:
                if game_object.loot_manager.has_loot():
                    game_object.set_ready()
                else:
                    game_object.despawn()
        elif high_guid == HighGuid.HIGHGUID_ITEM:
            item_mgr = self.inventory.get_item_by_guid(self.current_loot_selection)
            if item_mgr and not item_mgr.loot_manager.has_loot():
                item_mgr.loot_manager.clear()
                self.inventory.remove_items(item_mgr.item_template.entry, 1)
        else:
            Logger.warning(f'Unhandled loot release for type {HighGuid(high_guid).name}')

        self.current_loot_selection = 0

    def send_loot(self, world_object):
        self.current_loot_selection = world_object.guid
        loot_type = world_object.loot_manager.get_loot_type(self, world_object)
        data = pack(
            '<QBIB',
            world_object.guid,
            loot_type,
            world_object.loot_manager.current_money,
            len(world_object.loot_manager.current_loot)
         )

        # Do not send loot if player has no permission.
        if loot_type != LootTypes.LOOT_TYPE_NOTALLOWED:
            slot = 0
            # Slot should match real current_loot indexes.
            for loot in world_object.loot_manager.current_loot:
                if loot:
                    # If this is a quest item and player does not need it, don't show it to this player.
                    if loot.is_quest_item() and not self.player_or_group_require_quest_item(
                            loot.get_item_entry(), only_self=True):
                        slot += 1
                        continue

                    # Send item query information
                    query_data = ItemManager.generate_query_details_data(loot.item.item_template)
                    self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_QUERY_SINGLE_RESPONSE, query_data))

                    data += pack(
                        '<B3I',
                        slot,
                        loot.item.item_template.entry,
                        loot.quantity,
                        loot.item.item_template.display_id
                    )
                slot += 1

            # At this point, this player have access to the loot window, add him to the active looters.
            world_object.loot_manager.add_active_looter(self)

        packet = PacketWriter.get_packet(OpCode.SMSG_LOOT_RESPONSE, data)
        self.enqueue_packet(packet)

        return loot_type != LootTypes.LOOT_TYPE_NOTALLOWED

    def give_xp(self, amounts, victim=None, notify=True):
        if self.level >= config.Unit.Player.Defaults.max_level or not self.is_alive:
            return

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
            # Adjust XP gaining rates using config
            amount = int(amount * config.Server.Settings.xp_rate)

            total_amount += amount
            amount_bytes += pack('<QI', self.guid, amount)

        if notify:
            data = pack('<QI',
                        victim.guid if victim else self.guid,
                        len(amounts)
                        )
            data += amount_bytes
            self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_LOG_XPGAIN, data))

        if self.xp + total_amount >= self.next_level_xp:  # Level up!
            xp_to_level = self.next_level_xp - self.xp
            level_amount = 0
            # Do the actual XP conversion into level(s).
            while total_amount >= xp_to_level:
                level_amount += 1
                total_amount -= xp_to_level
                xp_to_level = Formulas.PlayerFormulas.xp_to_level(self.level + level_amount)

            self.xp = total_amount  # Set the remaining amount XP as current.
            self.set_uint32(PlayerFields.PLAYER_XP, self.xp)
            self.mod_level(self.level + level_amount)
        else:
            self.xp = self.xp + total_amount
            self.set_uint32(PlayerFields.PLAYER_XP, self.xp)

    def mod_level(self, level):
        if level != self.level:
            max_level = 255 if self.is_gm else config.Unit.Player.Defaults.max_level
            if 0 < level <= max_level:
                # Check if the new level is higher than the current one or not.
                is_leveling_up = level > self.level
                # Store the difference between the starting level and the target level.
                level_count = abs(level - self.level)

                # Calculate total talent points for each level starting from the current character level.
                talent_points = 0
                for i in range(level_count):
                    if is_leveling_up:
                        level_for_calculation = self.level + (i + 1)
                    else:
                        level_for_calculation = self.level - i
                    talent_points += Formulas.PlayerFormulas.talent_points_gain_per_level(level_for_calculation)

                if is_leveling_up:
                    # Add Talent and Skill points.
                    self.add_talent_points(talent_points)
                    self.add_skill_points(level_count)
                else:
                    # Remove Talent and Skill points.
                    self.remove_talent_points(talent_points)
                    self.remove_skill_points(level_count)

                self.level = level
                self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
                self.player.leveltime = 0

                self.stat_manager.init_stats()
                hp_diff, mana_diff = self.stat_manager.apply_bonuses()
                self.set_health(self.max_health)
                self.set_mana(self.max_power_1)

                self.skill_manager.update_skills_max_value()
                self.skill_manager.build_update()

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
            return self.quest_manager.item_is_still_needed_by_any_quest(item_entry)
        else:
            for member in self.group_manager.members.values():
                player_mgr = WorldSessionStateHandler.find_player_by_guid(member.guid)
                if player_mgr and player_mgr.quest_manager.item_is_still_needed_by_any_quest(item_entry):
                    return True
        return False

    def add_bank_slot(self, slot_cost):
        self.player.bankslots += 1
        self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]
        self.set_uint32(PlayerFields.PLAYER_BYTES_2, self.player_bytes_2)
        self.mod_money(-slot_cost, update_inventory=True)

    def mod_money(self, amount, update_inventory=False):
        if self.coinage + amount < 0:
            amount = -self.coinage

        # Gold hard cap: 214748 gold, 36 silver and 47 copper
        if self.coinage + amount > 2147483647:
            self.coinage = 2147483647
        else:
            self.coinage += amount

        self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)

        # Only override to True.
        if update_inventory and not self.dirty_inventory:
            self.dirty_inventory = True

    def on_zone_change(self, new_zone):
        # Update player zone.
        self.zone = new_zone
        # Update friends and group.
        self.friends_manager.send_update_to_friends()
        if self.group_manager:
            self.group_manager.send_update()

        # Checks below this condition can only happen if map loading is enabled.
        if not config.Server.Settings.use_map_tiles:
            return

        # Exploration handling (only if player is not flying).
        if not self.movement_spline or self.movement_spline.flags != SplineFlags.SPLINEFLAG_FLYING:
            area_information = MapManager.get_area_information(self.map_, self.location.x, self.location.y)
            if area_information:
                # Check if we need to set this zone as explored.
                if area_information.explore_bit >= 0 and not self.has_area_explored(area_information.explore_bit):
                    self.set_area_explored(area_information)

    def has_area_explored(self, area_explore_bit):
        return self.explored_areas[area_explore_bit]

    # TODO, Trigger quest explore requirement checks.
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
                    xp_gain = WorldDatabaseManager.exploration_base_xp_get_by_level(area_information.level) * exploration_percent / 100 * xp_rate
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
            self.liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y, self.location.z)
            if not self.liquid_information:
                Logger.warning(f'Unable to retrieve liquid information.')
        else:
            self.liquid_information = None

    def is_swimming(self):
        return self.movement_flags & MoveFlags.MOVEFLAG_SWIMMING and self.is_alive

    # override
    def is_on_water(self):
        self.liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y, self.location.z)
        map_z = MapManager.calculate_z_for_object(self)[0]
        return self.liquid_information and map_z < self.liquid_information.height

    # override
    def is_under_water(self):
        if self.liquid_information is None or not self.is_swimming():
            return False
        return self.location.z + (self.current_scale * 2) < self.liquid_information.height

    # override
    def is_in_deep_water(self):
        if self.liquid_information is None or not self.is_swimming():
            return False
        return self.liquid_information.liquid_type == LiquidTypes.DEEP

    def update_liquid_information(self):
        # Retrieve latest liquid information, only if player is swimming.
        if self.is_swimming():
            self.liquid_information = MapManager.get_liquid_information(self.map_, self.location.x, self.location.y, self.location.z)

    # override
    def get_full_update_packet(self, requester):
        self.bytes_0 = unpack('<I', pack('<4B', self.player.race, self.player.class_, self.gender, self.power_type))[0]
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
        self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]

        # Object fields
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.player.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.object_type_mask)
        self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.current_scale)

        # Unit fields
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
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)
        self.set_uint32(UnitFields.UNIT_FIELD_STAT0, self.str)
        self.set_uint32(UnitFields.UNIT_FIELD_STAT1, self.agi)
        self.set_uint32(UnitFields.UNIT_FIELD_STAT2, self.sta)
        self.set_uint32(UnitFields.UNIT_FIELD_STAT3, self.int)
        self.set_uint32(UnitFields.UNIT_FIELD_STAT4, self.spi)
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT0, self.base_str)
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT1, self.base_agi)
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT2, self.base_sta)
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT3, self.base_int)
        self.set_uint32(UnitFields.UNIT_FIELD_BASESTAT4, self.base_spi)
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
        self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, self.offhand_attack_time)
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
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
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.set_float(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        # Player fields
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

        # Skills
        self.skill_manager.build_update()

        # Guild
        if self.guild_manager:
            self.guild_manager.build_update(self)
        else:
            self.set_uint32(PlayerFields.PLAYER_GUILDID, 0)

        # Duel
        if self.duel_manager:
            self.duel_manager.build_update(self)

        # Inventory
        for update_packet in self.inventory.get_inventory_update_packets(self):
            self.enqueue_packet(update_packet)
        self.inventory.build_update()

        # Quests
        self.quest_manager.build_update()

        return self.get_object_create_packet(requester)

    def set_current_selection(self, guid):
        self.current_selection = guid
        self.set_uint64(PlayerFields.PLAYER_SELECTION, guid)

    def set_weapon_reach(self, reach):
        self.weapon_reach = reach
        self.set_float(UnitFields.UNIT_FIELD_WEAPONREACH, reach)

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

    def regenerate(self, elapsed):
        if not self.is_alive or self.health == 0:
            return

        self.last_regen += elapsed
        # Every 2 seconds
        if self.last_regen >= 2:
            self.last_regen = 0
            # Healing aura increases regeneration "by 2 every second", and base points equal to 10. Calculate 2/5 of hp5/mp5.
            health_regen = self.stat_manager.get_total_stat(UnitStats.HEALTH_REGENERATION_PER_5) * 0.4
            mana_regen = self.stat_manager.get_total_stat(UnitStats.POWER_REGENERATION_PER_5) * 0.4

            # Health

            if self.health < self.max_health and not self.in_combat or self.player.race == Races.RACE_TROLL:
                if self.player.race == Races.RACE_TROLL:
                    health_regen *= 0.1 if self.in_combat else 1.1

                if health_regen < 1:
                    health_regen = 1
                # Apply bonus if sitting.
                if self.is_sitting():
                    health_regen += health_regen * 0.33

                if self.health + health_regen >= self.max_health:
                    self.set_health(self.max_health)
                elif self.health < self.max_health:
                    self.set_health(self.health + int(health_regen))

            # Powers

            # Mana
            if self.power_type == PowerTypes.TYPE_MANA:
                if self.power_1 < self.max_power_1:
                    if self.in_combat:
                        # 1% per second (5% per 5 seconds)
                        mana_regen = self.base_mana * 0.02

                    if mana_regen < 1:
                        mana_regen = 1
                    if self.power_1 + mana_regen >= self.max_power_1:
                        self.set_mana(self.max_power_1)
                    elif self.power_1 < self.max_power_1:
                        self.set_mana(self.power_1 + int(mana_regen))
            # Rage decay
            elif self.power_type == PowerTypes.TYPE_RAGE:
                if self.power_2 > 0:
                    if not self.in_combat:
                        # Defensive Stance (71) description says:
                        #     "A defensive stance that reduces rage decay when out of combat. [...]."
                        # We assume the rage decay value is reduced by 50% when on Defensive Stance. We don't really
                        # know how much it should be reduced, but 50% seemed reasonable (1 point instead of 2).
                        rage_decay_value = 10 if self.has_form(ShapeshiftForms.SHAPESHIFT_FORM_DEFENSIVESTANCE) else 20
                        self.set_rage(self.power_2 - rage_decay_value)
            # Focus
            elif self.power_type == PowerTypes.TYPE_FOCUS:
                # Apparently focus didn't regenerate while moving.
                # Note: Needs source, not 100% confirmed.
                if self.power_3 < self.max_power_3 or not (self.movement_flags & MoveFlags.MOVEFLAG_MOTION_MASK):
                    if self.power_3 + 5 >= self.max_power_3:
                        self.set_focus(self.max_power_3)
                    elif self.power_3 < self.max_power_3:
                        self.set_focus(self.power_3 + 5)
            # Energy
            elif self.power_type == PowerTypes.TYPE_ENERGY:
                if self.power_4 < self.max_power_4:
                    if self.power_4 + 20 >= self.max_power_4:
                        self.set_energy(self.max_power_4)
                    elif self.power_4 < self.max_power_4:
                        self.set_energy(self.power_4 + 20)

    def calculate_base_attack_damage(self, attack_type: AttackTypes, attack_school: SpellSchools, target: UnitManager, apply_bonuses=True):
        rolled_damage = super().calculate_base_attack_damage(attack_type, attack_school, target, apply_bonuses)

        if apply_bonuses:
            subclass = -1
            equipped_weapon = self.get_current_weapon_for_attack_type(attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass
            rolled_damage = self.stat_manager.apply_bonuses_for_damage(rolled_damage, attack_school, target, subclass)

        return max(0, int(rolled_damage))

    # override
    def calculate_spell_damage(self, base_damage, spell_school: SpellSchools, target, spell_attack_type: AttackTypes = -1):
        subclass = 0
        if spell_attack_type != -1:
            equipped_weapon = self.get_current_weapon_for_attack_type(spell_attack_type)
            if equipped_weapon:
                subclass = equipped_weapon.item_template.subclass

        damage = self.stat_manager.apply_bonuses_for_damage(base_damage, spell_school, target, subclass)
        return max(0, int(damage))

    # override
    def handle_combat_skill_gain(self, damage_info):
        if damage_info.attacker == self:
            self.skill_manager.handle_weapon_skill_gain_chance(damage_info.attack_type)
        else:
            self.skill_manager.handle_defense_skill_gain_chance(damage_info)

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

        return

    # override
    def can_dodge(self, attacker_location=None):
        if not super().can_dodge(attacker_location):
            return False

        if attacker_location and not self.location.has_in_arc(attacker_location, math.pi):
            return False  # players can't dodge from behind.

        return True  # TODO Stunned check

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def set_shapeshift_form(self, shapeshift_form):
        super().set_shapeshift_form(shapeshift_form)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    # override
    def add_combo_points_on_target(self, target, combo_points):
        if combo_points <= 0 or not target.is_alive:  # Killing a unit with a combo generator can generate a combo point after death
            return

        if target.guid != self.combo_target:
            self.combo_points = min(combo_points, 5)
            self.combo_target = target.guid
        else:
            self.combo_points = min(combo_points + self.combo_points, 5)

        self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        self.combo_target = target.guid
        self.set_uint64(UnitFields.UNIT_FIELD_COMBO_TARGET, self.combo_target)

    # override
    def remove_combo_points(self):
        self.combo_points = 0
        self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        self.combo_target = 0
        self.set_uint64(UnitFields.UNIT_FIELD_COMBO_TARGET, self.combo_target)

    # override
    def receive_damage(self, amount, source=None, is_periodic=False):
        if self.is_god:
            return

        super().receive_damage(amount, source, is_periodic=False)

    # override
    def receive_healing(self, amount, source=None):
        super().receive_healing(amount, source)

        data = pack('<IQ', amount, source.guid)
        self.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_HEALSPELL_ON_PLAYER, data))

    def enqueue_packet(self, data):
        if self.session:
            self.session.enqueue_packet(data)
        else:
            Logger.warning('Tried to send packet to null session.')

    def check_swimming_state(self, elapsed):
        if not self.is_alive:
            return

        self.last_swimming_check += elapsed
        if self.last_swimming_check >= 1:
            self.last_swimming_check = 0
            if self.is_swimming() and not self.liquid_information:
                self.update_swimming_state(True)
            elif not self.is_swimming() and self.liquid_information:
                self.update_swimming_state(False)

    # override
    def has_pending_updates(self):
        return self.update_packet_factory.has_pending_updates() or self.dirty_inventory

    # override
    def update(self, now):
        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            # Update played time.
            self.player.totaltime += elapsed
            self.player.leveltime += elapsed

            # Regeneration.
            self.regenerate(elapsed)
            # Attack update.
            self.attack_update(elapsed)
            # Waypoints (mostly flying paths) update.
            self.movement_manager.update_pending_waypoints(elapsed)
            # Check swimming state.
            self.check_swimming_state(elapsed)

            # SpellManager tick.
            self.spell_manager.update(now)
            # AuraManager tick.
            self.aura_manager.update(now)

            # Duel tick.
            if self.duel_manager:
                self.duel_manager.update(self, elapsed)

            # Release spirit timer.
            if not self.is_alive:
                if self.spirit_release_timer < 300:  # 5 min.
                    self.spirit_release_timer += elapsed
                else:
                    self.repop()

            # Update timers (Breath, Fatigue, Feign Death).
            if self.is_alive:
                self.mirror_timers_manager.update(elapsed)

            # Logout timer.
            if self.logout_timer > 0:
                self.logout_timer -= elapsed
                if self.logout_timer < 0:
                    self.logout()
                    return

            # Check if player has pending updates.
            if self.has_pending_updates() and self.online:
                MapManager.update_object(self, check_pending_changes=True)
                self.reset_fields_older_than(now)
                if self.dirty_inventory:
                    self.dirty_inventory = False
            # Not dirty, has a pending teleport and a teleport is not ongoing.
            elif not self.has_pending_updates() and self.pending_teleport_destination and not self.update_lock:
                self.trigger_teleport()
            else:
                MapManager.update_object(self)
                self.synchronize_db_player()

        self.last_tick = now

    def send_update_self(self, update_packet=None, create=False):
        if create:
            self.enqueue_packet(NameQueryHandler.get_query_details(self.player))
        else:
            if self.dirty_inventory:
                for update_packet in self.inventory.get_inventory_update_packets(self):
                    self.enqueue_packet(update_packet)

        if not update_packet:
            if create:
                update_packet = self.generate_create_packet(requester=self)
            else:
                update_packet = self.generate_partial_packet(requester=self)

        self.enqueue_packet(update_packet)

    def teleport_deathbind(self):
        self.teleport(self.deathbind.deathbind_map, Vector(self.deathbind.deathbind_position_x,
                                                           self.deathbind.deathbind_position_y,
                                                           self.deathbind.deathbind_position_z))

    def get_deathbind_coordinates(self):
        return (self.deathbind.deathbind_map, Vector(self.deathbind.deathbind_position_x,
                                                     self.deathbind.deathbind_position_y,
                                                     self.deathbind.deathbind_position_z))

    # override
    def die(self, killer=None):
        if killer and self.duel_manager and self.duel_manager.is_player_involved(killer):
            self.duel_manager.end_duel(DuelWinner.DUEL_WINNER_KNOCKOUT, DuelComplete.DUEL_FINISHED, killer)
            self.set_health(1)
            return False

        if not super().die(killer):
            return False

        if killer and killer.get_type_id() == ObjectTypeIds.ID_PLAYER:
            death_notify_packet = PacketWriter.get_packet(OpCode.SMSG_DEATH_NOTIFY, pack('<Q', killer.guid))
            self.enqueue_packet(death_notify_packet)

        TradeManager.cancel_trade(self)
        self.spirit_release_timer = 0
        self.mirror_timers_manager.stop_all()
        self.update_swimming_state(False)

        return True

    # override
    def respawn(self):
        # Set expected HP / Power before respawning.
        # It wasn't until Patch 0.6 that players had 50% of health and mana after reviving. It is currently unknown
        # the % that players had in 0.5.3, so 100% is assumed.
        self.set_health(self.max_health)
        if self.power_type == PowerTypes.TYPE_MANA:
            self.set_mana(self.max_power_1)
        if self.power_type == PowerTypes.TYPE_RAGE:
            self.set_rage(0)
        if self.power_type == PowerTypes.TYPE_FOCUS:
            self.set_focus(self.max_power_3)
        if self.power_type == PowerTypes.TYPE_ENERGY:
            self.set_energy(self.max_power_4)

        super().respawn()

        # Add Resurrection Sickness (2146) to the player.
        # TODO: Unsure if it should always be applied regardless of whether the player resurrected normally or was
        #  resurrected by another player, assuming it was always applied for now.
        self.spell_manager.handle_cast_attempt(2146, self, SpellTargetMask.SELF, validate=False)

    def repop(self):
        self.respawn()
        self.spirit_release_timer = 0
        self.teleport_deathbind()

    # override
    def on_cell_change(self):
        self.quest_manager.update_surrounding_quest_status()

    # override
    def can_attack_target(self, target):
        is_enemy = super().can_attack_target(target)
        if is_enemy:
            return True

        # Return True if players are friendly but dueling.
        if self.duel_manager and target is not self and self.duel_manager.is_player_involved(target):
            return self.duel_manager.duel_state == DuelState.DUEL_STATE_STARTED

        return False

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_PLAYER

    # override
    def generate_object_guid(self, low_guid):
        return low_guid | HighGuid.HIGHGUID_PLAYER

    def get_current_weapon_for_attack_type(self, attack_type: AttackTypes):
        if self.is_in_feral_form():
            return None  # Feral form attacks don't use a weapon.

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
