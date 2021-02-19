import math
import time
from struct import unpack
from math import pi

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.UnitManager import UnitManager
from game.world.managers.objects.player.StatManager import StatManager
from game.world.managers.objects.player.TalentManager import TalentManager
from game.world.managers.objects.player.TradeManager import TradeManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from game.world.managers.objects.player.InventoryManager import InventoryManager
from game.world.opcode_handling.handlers.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import *
from utils import Formulas
from utils.constants.ItemCodes import InventorySlots
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, PlayerFlags, WhoPartyStatuses, HighGuid, UpdateTypes
from utils.constants.UnitCodes import Classes, PowerTypes, Races, Genders, UnitFlags, Teams
from network.packet.update.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.UpdateFields import *
from database.dbc.DbcDatabaseManager import *
from utils.constants.ObjectCodes import ChatFlags


MAX_ACTION_BUTTONS = 120


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
                 chat_flags=0,
                 is_online=False,
                 current_target=0,
                 current_selection=0,
                 deathbind=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.session = session
        self.is_teleporting = False
        self.objects_in_range = dict()

        self.player = player
        self.is_online = is_online
        self.num_inv_slots = num_inv_slots
        self.xp = xp
        self.next_level_xp = next_level_xp
        self.block_percentage = block_percentage
        self.dodge_percentage = dodge_percentage
        self.parry_percentage = parry_percentage
        self.base_hp = base_hp
        self.base_mana = base_mana
        self.combo_points = combo_points
        self.current_target = current_target
        self.current_selection = current_selection

        self.chat_flags = chat_flags
        self.group_status = WhoPartyStatuses.WHO_PARTY_STATUS_NOT_IN_PARTY
        self.race_mask = 0
        self.class_mask = 0
        self.spells = {}
        self.skills = {}
        self.deathbind = deathbind
        self.team = PlayerManager.get_team_for_race(self.race_mask)
        self.trade_data = None
        self.last_regen = 0
        self.dirty_inventory = False

        if self.player:
            self.set_player_variables()
            self.guid = self.player.guid | HighGuid.HIGHGUID_PLAYER
            self.inventory = InventoryManager(self)
            self.level = self.player.level
            self.bytes_0 = unpack('<I', pack('<4B', self.player.race, self.player.class_, self.player.gender, self.power_type))[0]
            self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
            self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
            self.player_bytes = unpack('<I', pack('<4B', self.player.skin, self.player.face, self.player.hairstyle, self.player.haircolour))[0]
            self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]
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

            self.is_gm = self.session.account_mgr.account.gmlevel > 0

            if self.is_gm:
                self.set_gm()

            self.object_type.append(ObjectTypes.TYPE_PLAYER)
            self.update_packet_factory.init_values(PlayerFields.PLAYER_END)

            self.xp = 0  # test
            self.next_level_xp = Formulas.PlayerFormulas.xp_to_level(self.level)

            self.guild_manager = GuildManager()
            self.stat_manager = StatManager(self)
            self.talent_manager = TalentManager(self)

    def get_native_display_id(self, is_male, race_data=None):
        if not race_data:
            race_data = DbcDatabaseManager.chr_races_get_by_race(self.player.race)
        return race_data.MaleDisplayId if is_male else race_data.FemaleDisplayId

    def set_player_variables(self):
        race = DbcDatabaseManager.chr_races_get_by_race(self.player.race)

        self.faction = race.FactionID
        self.creature_type = race.CreatureType

        is_male = self.player.gender == Genders.GENDER_MALE

        self.display_id = self.get_native_display_id(is_male, race)

        # Power type
        if self.player.class_ == Classes.CLASS_WARRIOR:
            self.power_type = PowerTypes.TYPE_RAGE
        elif self.player.class_ == Classes.CLASS_HUNTER:
            self.power_type = PowerTypes.TYPE_FOCUS
        elif self.player.class_ == Classes.CLASS_ROGUE:
            self.power_type = PowerTypes.TYPE_ENERGY
        else:
            self.power_type = PowerTypes.TYPE_MANA

        if self.player.race == Races.RACE_HUMAN:
            self.bounding_radius = 0.306 if is_male else 0.208
        elif self.player.race == Races.RACE_ORC:
            self.bounding_radius = 0.372 if is_male else 0.236
        elif self.player.race == Races.RACE_DWARF:
            self.bounding_radius = 0.347
        elif self.player.race == Races.RACE_NIGHT_ELF:
            self.bounding_radius = 0.389 if is_male else 0.306
        elif self.player.race == Races.RACE_UNDEAD:
            self.bounding_radius = 0.383
        elif self.player.race == Races.RACE_TAUREN:
            self.bounding_radius = 0.9747 if is_male else 0.8725
            self.scale = 1.35 if is_male else 1.25
        elif self.player.race == Races.RACE_GNOME:
            self.bounding_radius = 0.3519
        elif self.player.race == Races.RACE_TROLL:
            self.bounding_radius = 0.306

        self.race_mask = 1 << (self.player.race - 1)
        self.class_mask = 1 << (self.player.class_ - 1)

    def set_gm(self, on=True):
        self.player.extra_flags |= PlayerFlags.PLAYER_FLAGS_GM
        self.chat_flags = ChatFlags.CHAT_TAG_GM

    def complete_login(self):
        self.is_online = True

        GridManager.update_object(self)
        self.send_update_surrounding(self.generate_proper_update_packet(create=True), include_self=False, create=True)

    def logout(self):
        self.session.save_character()
        GridManager.remove_object(self)
        self.session.player_mgr = None
        self.session = None
        self.is_online = False

    def get_tutorial_packet(self):
        return PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, pack('<18I', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                                        0, 0, 0, 0, 0))

    def get_initial_spells(self):
        data = pack('<BH', 0, len(self.spells))
        for spell_id, spell in self.spells.items():
            data += pack('<2H', spell.ID, 0)
        data += pack('<H', 0)

        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, data)

    def get_action_buttons(self):
        data = b''
        for x in range(0, MAX_ACTION_BUTTONS):
            data += pack('<I', 0)  # TODO: Handle action buttons later
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

    def update_surrounding_on_me(self):
        players, creatures, gobjects = GridManager.get_surrounding_objects(self, [ObjectTypes.TYPE_PLAYER,
                                                                                  ObjectTypes.TYPE_UNIT,
                                                                                  ObjectTypes.TYPE_GAMEOBJECT])

        # At this point, all objects aren't synced unless proven otherwise
        for guid, object_info in list(self.objects_in_range.items()):
            self.objects_in_range[guid]['synced'] = False

        for guid, player in players.items():
            if self.guid != guid:
                if guid not in self.objects_in_range:
                    update_packet = player.generate_proper_update_packet(create=True)
                    self.session.request.sendall(update_packet)
                    self.session.request.sendall(NameQueryHandler.get_query_details(player.player))
                self.objects_in_range[guid] = {'object': player, 'synced': True}

        for guid, creature in creatures.items():
            if guid not in self.objects_in_range:
                update_packet = UpdatePacketFactory.compress_if_needed(
                    PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                            creature.get_full_update_packet(is_self=False)))
                self.session.request.sendall(update_packet)
                self.session.request.sendall(creature.query_details())
            self.objects_in_range[guid] = {'object': creature, 'synced': True}

        for guid, gobject in gobjects.items():
            if guid not in self.objects_in_range:
                update_packet = UpdatePacketFactory.compress_if_needed(
                    PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                            gobject.get_full_update_packet(is_self=False)))
                self.session.request.sendall(update_packet)
                self.session.request.sendall(gobject.query_details())
            self.objects_in_range[guid] = {'object': gobject, 'synced': True}

        for guid, object_info in list(self.objects_in_range.items()):
            if not object_info['synced']:
                self.destroy_near_object(guid, skip_check=True)

    def destroy_near_object(self, guid, skip_check=False):
        if skip_check or guid in self.objects_in_range:
            self.session.request.sendall(self.objects_in_range[guid]['object'].get_destroy_packet())
            del self.objects_in_range[guid]

    def sync_player(self):
        if self.player and self.player.guid == self.guid:
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
            self.player.health = self.health
            self.player.power1 = self.power_1
            self.player.power2 = self.power_2
            self.player.power3 = self.power_3
            self.player.power4 = self.power_4
            self.player.money = self.coinage

    # TODO: teleport system needs a complete rework
    def teleport(self, map_, location):
        if not DbcDatabaseManager.map_get_by_id(map_):
            return False

        self.is_teleporting = True

        for guid, player in list(GridManager.get_surrounding_players(self).items()):
            player.destroy_near_object(self.guid)
        # GridManager.send_surrounding(self.get_destroy_packet(), self, include_self=False)

        # Same map and not inside instance
        if self.map_ == map_ and self.map_ <= 1:
            data = pack(
                '<Q9fI',
                self.transport_id,
                self.transport.x,
                self.transport.y,
                self.transport.z,
                self.transport.o,
                location.x,
                location.y,
                location.z,
                location.o,
                0,  # ?
                0  # MovementFlags
            )
            self.session.request.sendall(PacketWriter.get_packet(OpCode.MSG_MOVE_TELEPORT_ACK, data))
        # Loading screen
        else:
            data = pack('<I', map_)
            self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_TRANSFER_PENDING, data))

            data = pack(
                '<B4f',
                map_,
                location.x,
                location.y,
                location.z,
                location.o
            )

            self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_NEW_WORLD, data))

        self.map_ = map_
        self.location.x = location.x
        self.location.y = location.y
        self.location.z = location.z
        self.location.o = location.o

        return True

    def mount(self, mount_display_id):
        if mount_display_id > 0 and self.mount_display_id == 0 and \
                DbcDatabaseManager.creature_display_info_get_by_id(mount_display_id):
            self.mount_display_id = mount_display_id
            self.unit_flags |= UnitFlags.UNIT_FLAG_MOUNTED
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_dirty()

    def unmount(self):
        if self.mount_display_id > 0:
            self.mount_display_id = 0
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_MOUNTED
            self.set_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
            self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
            self.set_dirty()

    def demorph(self):
        self.set_display_id(self.get_native_display_id(self.player.gender == 0))

    # TODO Maybe merge all speed changes in one method
    def change_speed(self, speed=0):
        if speed <= 0:
            speed = 7.0  # Default run speed
        elif speed >= 56:
            speed = 56  # Max speed without glitches
        self.running_speed = speed
        data = pack('<f', speed)
        self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FORCE_SPEED_CHANGE, data))

    def change_swim_speed(self, swim_speed=0):
        if swim_speed <= 0:
            swim_speed = 4.7222223  # Default swim speed
        elif swim_speed >= 56:
            swim_speed = 56  # Max possible swim speed
        self.swim_speed = swim_speed
        data = pack('<f', swim_speed)
        self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_FORCE_SWIM_SPEED_CHANGE, data))

    def change_walk_speed(self, walk_speed=0):
        if walk_speed <= 0:
            walk_speed = 2.5  # Default walk speed
        elif walk_speed >= 56:
            walk_speed = 56  # Max speed without glitches
        self.swim_speed = walk_speed
        data = pack('<f', walk_speed)
        self.session.request.sendall(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_WALK_SPEED, data))

    def change_turn_speed(self, turn_speed=0):
        if turn_speed <= 0:
            turn_speed = pi  # Default turn rate speed
        self.turn_rate = turn_speed
        data = pack('<f', turn_speed)
        # TODO NOT WORKING
        self.session.request.sendall(PacketWriter.get_packet(OpCode.MSG_MOVE_SET_TURN_RATE_CHEAT, data))

    def mod_level(self, level):
        if level != self.level:
            max_level = 255 if self.is_gm else config.Unit.Player.Defaults.max_level
            if 0 < level <= max_level:
                should_send_info = level > self.level

                self.level = level
                self.set_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)

                self.stat_manager.init_stats()
                hp_diff, mana_diff = self.stat_manager.apply_bonuses()
                self.set_health(self.max_health)
                self.set_mana(self.max_power_1)

                if should_send_info:
                    data = pack('<3I',
                                level,
                                hp_diff,
                                mana_diff if self.power_type == PowerTypes.TYPE_MANA else 0
                                )
                    self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_LEVELUP_INFO, data))

                    # Add Talent and Skill points
                    self.add_talent_points(Formulas.PlayerFormulas.talent_points_gain_per_level(self.level))
                    self.add_skill_points(1)

                self.next_level_xp = Formulas.PlayerFormulas.xp_to_level(self.level)
                self.set_uint32(PlayerFields.PLAYER_NEXT_LEVEL_XP, self.next_level_xp)

                self.set_dirty()

    def mod_money(self, amount, reload_items=False):
        if self.coinage + amount < 0:
            amount = -self.coinage
        self.coinage += amount
        self.set_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)

        self.send_update_self(self.generate_proper_update_packet(is_self=True), include_items=reload_items)

    def load_skills(self):
        for skill in WorldDatabaseManager.player_create_skill_get(self.player.race,
                                                                  self.player.class_):
            skill_to_add = DbcDatabaseManager.skill_get_by_id(skill.Skill)
            self.skills[skill.Skill] = skill_to_add

    def load_spells(self):
        for spell in WorldDatabaseManager.player_create_spell_get(self.player.race,
                                                                  self.player.class_):
            spell_to_load = DbcDatabaseManager.SpellHolder.spell_get_by_id(spell.Spell)
            if spell_to_load:
                self.spells[spell.Spell] = spell_to_load

    # override
    def get_full_update_packet(self, is_self=True):
        self.inventory.send_inventory_update(self.session, is_self)

        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
        self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]

        # Object fields
        self.set_uint64(ObjectFields.OBJECT_FIELD_GUID, self.player.guid)
        self.set_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value())
        self.set_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
        self.set_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.scale)

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
        self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.display_id)
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

        self.inventory.build_update()

        return self.get_object_create_packet(is_self)

    def set_current_selection(self, guid):
        self.current_selection = guid
        self.set_uint64(PlayerFields.PLAYER_SELECTION, guid)

    def set_current_target(self, guid):
        self.current_target = guid
        self.set_uint64(UnitFields.UNIT_FIELD_TARGET, guid)

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
        self.set_uint32(UnitFields.UNIT_FIELD_STAT0, str_)

    def set_agi(self, agi):
        self.agi = agi
        self.set_uint32(UnitFields.UNIT_FIELD_STAT1, agi)

    def set_sta(self, sta):
        self.sta = sta
        self.set_uint32(UnitFields.UNIT_FIELD_STAT2, sta)

    def set_int(self, int_):
        self.int = int_
        self.set_uint32(UnitFields.UNIT_FIELD_STAT3, int_)

    def set_spi(self, spi):
        self.spi = spi
        self.set_uint32(UnitFields.UNIT_FIELD_STAT4, spi)

    def add_talent_points(self, talent_points):
        self.talent_points += talent_points
        if self.talent_points > 255:
            self.talent_points = 255
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS1, self.talent_points)

    def add_skill_points(self, skill_points):
        self.skill_points += skill_points
        if self.skill_points > 255:
            self.skill_points = 255
        self.set_uint32(PlayerFields.PLAYER_CHARACTER_POINTS2, self.skill_points)

    def regenerate(self, current_time):
        if not self.is_alive or self.health == 0:
            return

        # Every 2 seconds
        if current_time > self.last_regen + 2:
            # Rate calculation per class

            should_update_health = self.health < self.max_health
            should_update_power = True

            health_regen = 0
            mana_regen = 0
            if self.player.class_ == Classes.CLASS_DRUID:
                health_regen = self.spi * 0.11 + 1
                mana_regen = (self.spi / 5 + 15) / 2
            elif self.player.class_ == Classes.CLASS_HUNTER:
                health_regen = self.spi * 0.43 - 5.5
            elif self.player.class_ == Classes.CLASS_PRIEST:
                health_regen = self.spi * 0.15 + 1.4
                mana_regen = (self.spi / 4 + 12.5) / 2
            elif self.player.class_ == Classes.CLASS_MAGE:
                health_regen = self.spi * 0.11 + 1
                mana_regen = (self.spi / 4 + 12.5) / 2
            elif self.player.class_ == Classes.CLASS_PALADIN:
                health_regen = self.spi * 0.25
                mana_regen = (self.spi / 5 + 15) / 2
            elif self.player.class_ == Classes.CLASS_ROGUE:
                health_regen = self.spi * 0.84 - 13
            elif self.player.class_ == Classes.CLASS_SHAMAN:
                health_regen = self.spi * 0.28 - 3.6
                mana_regen = (self.spi / 5 + 17) / 2
            elif self.player.class_ == Classes.CLASS_WARLOCK:
                health_regen = self.spi * 0.12 + 1.5
                mana_regen = (self.spi / 5 + 15) / 2
            elif self.player.class_ == Classes.CLASS_WARRIOR:
                health_regen = self.spi * 1.26 - 22.6

            # Health

            if should_update_health and not self.in_combat or self.player.race == Races.RACE_TROLL:
                if self.player.race == Races.RACE_TROLL:
                    health_regen *= 0.1 if self.in_combat else 1.1
                if self.is_sitting:
                    health_regen *= 0.33

                if health_regen < 1:
                    health_regen = 1
                if self.health + health_regen >= self.max_health:
                    self.set_health(self.max_health)
                elif self.health < self.max_health:
                    self.set_health(self.health + int(health_regen))

            # Powers

            # Mana
            if self.power_type == PowerTypes.TYPE_MANA:
                if self.power_1 == self.max_power_1:
                    should_update_power = False
                else:
                    if self.in_combat:
                        # 1% per second (5% per 5 seconds)
                        mana_regen = self.base_mana * 0.02

                    if mana_regen < 1:
                        mana_regen = 1
                    if self.power_1 + mana_regen >= self.max_power_1:
                        self.set_mana(self.max_power_1)
                    elif self.power_1 < self.max_power_1:
                        self.set_mana(self.power_1 + int(mana_regen))
            # Rage
            elif self.power_type == PowerTypes.TYPE_RAGE:
                if self.power_2 == 0:
                    should_update_power = False
                else:
                    if not self.in_combat:
                        if self.power_2 < 200:
                            self.set_rage(0)
                        else:
                            self.set_rage(int((self.power_2 / 10) - 2))
            # Focus
            elif self.power_type == PowerTypes.TYPE_FOCUS:
                if self.power_3 == self.max_power_3:
                    should_update_power = False
                else:
                    if self.power_3 + 5 >= self.max_power_3:
                        self.set_focus(self.max_power_3)
                    elif self.power_3 < self.max_power_3:
                        self.set_focus(self.power_3 + 5)
            # Energy
            elif self.power_type == PowerTypes.TYPE_ENERGY:
                if self.power_4 == self.max_power_4:
                    should_update_power = False
                else:
                    if self.power_4 + 20 >= self.max_power_4:
                        self.set_energy(self.max_power_4)
                    elif self.power_4 < self.max_power_4:
                        self.set_energy(self.power_4 + 20)

            if should_update_health or should_update_power:
                self.set_dirty()
            self.last_regen = current_time

    # override
    def set_weapon_mode(self, weapon_mode):
        super().set_weapon_mode(weapon_mode)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]

        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.set_dirty()

    # override
    def set_stand_state(self, stand_state):
        super().set_stand_state(stand_state)
        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.set_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)

    def set_dirty(self, is_dirty=True, dirty_inventory=False):
        self.dirty = is_dirty
        self.dirty_inventory = dirty_inventory

    # override
    def update(self):
        now = time.time()

        if now > self.last_tick > 0:
            elapsed = now - self.last_tick

            # Update played time
            self.player.totaltime += elapsed
            self.player.leveltime += elapsed

            # Regeneration
            self.regenerate(now)
        self.last_tick = now

        if self.dirty:
            self.send_update_self()
            self.send_update_surrounding(self.generate_proper_update_packet())
            GridManager.update_object(self)
            self.reset_fields()

            self.set_dirty(is_dirty=False, dirty_inventory=False)

    def generate_proper_update_packet(self, is_self=False, create=False):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT,
            self.get_full_update_packet(is_self=is_self) if create else self.get_partial_update_packet()))
        return update_packet

    def send_update_self(self, update_packet=None, create=False, force_inventory_update=False):
        if not create and (self.dirty_inventory or force_inventory_update):
            self.inventory.send_inventory_update(self.session, is_self=True)
            self.inventory.build_update()

        if not update_packet:
            update_packet = self.generate_proper_update_packet(is_self=True, create=create)

        self.session.request.sendall(update_packet)

    def send_update_surrounding(self, update_packet, include_self=False, create=False):
        if not create and self.dirty_inventory:
            self.inventory.send_inventory_update(self.session, is_self=False)
            self.inventory.build_update()

        GridManager.send_surrounding(update_packet, self, include_self=include_self)
        if create:
            GridManager.send_surrounding(NameQueryHandler.get_query_details(self.player), self, include_self=True)

    def teleport_deathbind(self):
        self.teleport(self.deathbind.deathbind_map, Vector(self.deathbind.deathbind_position_x,
                                                           self.deathbind.deathbind_position_y,
                                                           self.deathbind.deathbind_position_z))

    # override
    def die(self, killer=None):
        super().die(killer)

        if killer and isinstance(killer, PlayerManager):
            death_notify_packet = PacketWriter.get_packet(OpCode.SMSG_DEATH_NOTIFY, pack('<Q', killer.guid))
            self.session.request.sendall(death_notify_packet)

        TradeManager.cancel_trade(self)

        self.set_dirty()

    # override
    def respawn(self, force_update=True):
        super().respawn()

        self.set_health(int(self.max_health / 2))
        if self.power_type == PowerTypes.TYPE_MANA:
            self.set_mana(int(self.max_power_1 / 2))

        if force_update:
            self.set_dirty()

    # override
    def get_type(self):
        return ObjectTypes.TYPE_PLAYER

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_PLAYER

    @staticmethod
    def get_team_for_race(race):
        race_entry = DbcDatabaseManager.chr_races_get_by_race(race)
        if race_entry:
            if race_entry.BaseLanguage == 1:
                return Teams.TEAM_HORDE
            elif race_entry.BaseLanguage == 7:
                return Teams.TEAM_ALLIANCE
        return Teams.TEAM_NONE
