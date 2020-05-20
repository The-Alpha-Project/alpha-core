import time
from struct import unpack
from math import pi

from database.world.WorldDatabaseManager import WorldDatabaseManager
from game.world.managers.GridManager import GridManager, GRIDS
from game.world.managers.abstractions.Vector import Vector
from game.world.managers.objects.UnitManager import UnitManager
from game.world.managers.objects.player.guild.GuildManager import GuildManager
from game.world.managers.objects.player.InventoryManager import InventoryManager
from game.world.managers.objects.player.QuestManager import QuestManager
from game.world.opcode_handling.handlers.NameQueryHandler import NameQueryHandler
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import ObjectTypes, UpdateTypes, ObjectTypeIds, PlayerFlags, WhoPartyStatuses, HighGuid, QuestGiverStatuses
from utils.constants.UnitCodes import Classes, PowerTypes, Races, Genders, UnitFlags
from network.packet.UpdatePacketFactory import UpdatePacketFactory
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
                 talent_points=0,
                 skill_points=0,
                 block_percentage=0,
                 dodge_percentage=0,
                 parry_percentage=0,
                 base_mana=0,
                 sheath_state=0,
                 combo_points=0,
                 chat_flags=0,
                 is_online=False,
                 current_target=0,
                 current_selection=0,
                 deathbind=None,
                 **kwargs):
        super().__init__(**kwargs)

        self.update_packet_factory.add_type(ObjectTypes.TYPE_PLAYER)
        self.object_type.append(ObjectTypes.TYPE_PLAYER)

        self.session = session
        self.flagged_for_update = False
        self.is_teleporting = False
        self.objects_in_range = dict()

        self.player = player
        self.is_online = is_online
        self.num_inv_slots = num_inv_slots
        self.xp = xp
        self.next_level_xp = next_level_xp
        self.talent_points = talent_points
        self.skill_points = skill_points
        self.block_percentage = block_percentage
        self.dodge_percentage = dodge_percentage
        self.parry_percentage = parry_percentage
        self.base_mana = base_mana
        self.sheath_state = sheath_state
        self.combo_points = combo_points
        self.current_target = current_target
        self.current_selection = current_selection

        self.chat_flags = chat_flags
        self.group_status = WhoPartyStatuses.WHO_PARTY_STATUS_NOT_IN_PARTY
        self.race_mask = 0
        self.class_mask = 0
        self.spells = []
        self.skills = []
        self.deathbind = deathbind

        if self.player:
            self.set_player_variables()

            self.guid = self.player.guid | HighGuid.HIGHGUID_PLAYER
            self.inventory = InventoryManager(self)
            self.quests = QuestManager(self)
            self.level = self.player.level
            self.bytes_0 = unpack('<I', pack('<4B', self.player.race, self.player.class_, self.player.gender, self.power_type))[0]
            self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
            self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
            self.player_bytes = unpack('<I', pack('<4B', self.player.skin, self.player.face, self.player.hairstyle, self.player.haircolour))[0]
            self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]
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
            self.max_power_3 = self.player.power3
            self.power_3 = self.player.power3
            self.max_power_4 = self.player.power4
            self.power_4 = self.player.power4
            self.coinage = self.player.money

            self.is_gm = self.session.account_mgr.account.gmlevel > 0

            if self.is_gm:
                self.set_gm()

            # test
            self.xp = 0
            self.next_level_xp = 200

            self.guild_manager = GuildManager()

    def get_native_display_id(self, is_male, race_data=None):
        if not race_data:
            race_data = DbcDatabaseManager.chr_races_get_by_race(self.player.race)
        return race_data.MaleDisplayId if is_male else race_data.FemaleDisplayId

    def set_player_variables(self):
        race = DbcDatabaseManager.chr_races_get_by_race(self.player.race)

        self.faction = race.FactionID

        is_male = self.player.gender == Genders.GENDER_MALE

        self.display_id = self.get_native_display_id(is_male, race)

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
            self.scale = 1.3 if is_male else 1.25
        elif self.player.race == Races.RACE_GNOME:
            self.bounding_radius = 0.3519
        elif self.player.race == Races.RACE_TROLL:
            self.bounding_radius = 0.306

        self.race_mask = 1 << self.player.race
        self.class_mask = 1 << self.player.class_

    def set_gm(self, on=True):
        self.player.extra_flags |= PlayerFlags.PLAYER_FLAGS_GM
        self.chat_flags = ChatFlags.CHAT_TAG_GM

    def complete_login(self):
        self.is_online = True
        GridManager.update_object(self)

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
        for spell in self.spells:
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

    def update_surrounding(self):
        self.send_update_surrounding()
        GridManager.send_surrounding(NameQueryHandler.get_query_details(self.player), self, include_self=True)

        players, creatures, gobjects = GridManager.get_surrounding_objects(self, [ObjectTypes.TYPE_PLAYER,
                                                                                  ObjectTypes.TYPE_UNIT,
                                                                                  ObjectTypes.TYPE_GAMEOBJECT])

        for guid, player in players.items():
            if self.guid != guid:
                if guid not in self.objects_in_range:
                    update_packet = UpdatePacketFactory.compress_if_needed(
                        PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                                player.get_full_update_packet(is_self=False)))
                    self.session.request.sendall(update_packet)
                    self.session.request.sendall(NameQueryHandler.get_query_details(player.player))
                self.objects_in_range[guid] = {'object': player, 'near': True}

        for guid, creature in creatures.items():
            if guid not in self.objects_in_range:
                update_packet = UpdatePacketFactory.compress_if_needed(
                    PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                            creature.get_full_update_packet(is_self=False)))
                self.session.request.sendall(update_packet)
                self.session.request.sendall(creature.query_details())
            self.objects_in_range[guid] = {'object': creature, 'near': True}

        for guid, gobject in gobjects.items():
            if guid not in self.objects_in_range:
                update_packet = UpdatePacketFactory.compress_if_needed(
                    PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT,
                                            gobject.get_full_update_packet(is_self=False)))
                self.session.request.sendall(update_packet)
                self.session.request.sendall(gobject.query_details())
            self.objects_in_range[guid] = {'object': gobject, 'near': True}

        for guid, object_info in list(self.objects_in_range.items()):
            if not object_info['near']:
                self.session.request.sendall(self.objects_in_range[guid]['object'].get_destroy_packet())
                del self.objects_in_range[guid]
            else:
                self.objects_in_range[guid]['near'] = False

    def sync_player(self):
        if self.player and self.player.guid == self.guid:
            self.player.level = self.level
            self.player.xp = self.xp
            self.player.talent_points = self.talent_points
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

    def teleport(self, map_, location):
        if not DbcDatabaseManager.map_get_by_id(map_):
            return False

        self.is_teleporting = True

        GridManager.send_surrounding(self.get_destroy_packet(), self, include_self=False)

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
            self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_MOVE_WORLDPORT_ACK, data))
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
                DbcDatabaseManager.creature_display_info_get_by_model_id(mount_display_id):
            self.mount_display_id = mount_display_id
            self.unit_flags |= UnitFlags.UNIT_FLAG_MOUNTED
            self.flagged_for_update = True

    def unmount(self):
        if self.mount_display_id > 0:
            self.mount_display_id = 0
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_MOUNTED
            self.flagged_for_update = True

    def set_weapon_mode(self, weapon_mode):
        # TODO: Not working
        if weapon_mode == 0:
            self.unit_flags |= UnitFlags.UNIT_FLAG_SHEATHE
        elif weapon_mode == 1:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_SHEATHE
        elif weapon_mode == 2:
            self.unit_flags &= ~UnitFlags.UNIT_FLAG_SHEATHE

        self.flagged_for_update = True

    def morph(self, display_id):
        if display_id > 0 and \
                DbcDatabaseManager.creature_display_info_get_by_model_id(display_id):
            self.display_id = display_id
            self.flagged_for_update = True

    def demorph(self):
        self.morph(self.get_native_display_id(self.player.gender == 0))

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
            if 0 < level <= config.Unit.Player.Defaults.max_level:
                self.level = level
                data = pack('<I', level)
                # TODO: Finish implementing SMSG_LEVELUP_INFO packet
                self.session.request.sendall(PacketWriter.get_packet(OpCode.SMSG_LEVELUP_INFO, data))
                self.flagged_for_update = True

    def mod_money(self, amount):
        if self.coinage + amount < 0:
            amount = -self.coinage
        self.coinage += amount
        self.send_update_self()

    def load_skills(self):
        for skill in WorldDatabaseManager.player_create_skill_get(self.player.race,
                                                                  self.player.class_):
            skill_to_add = DbcDatabaseManager.skill_get_by_id(skill.Skill)
            self.skills.append(skill_to_add)

    def load_spells(self):
        for spell in WorldDatabaseManager.player_create_spell_get(self.player.race,
                                                                  self.player.class_):
            spell_to_load = DbcDatabaseManager.spell_get_by_id(spell.Spell)
            if spell_to_load:
                self.spells.append(spell_to_load)

    def set_ply_uint32(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.player_values,
                                          self.update_packet_factory.updated_player_fields, index, value, 'I')

    def set_ply_uint64(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.player_values,
                                          self.update_packet_factory.updated_player_fields, index, value, 'Q')

    def set_ply_float(self, index, value):
        self.update_packet_factory.update(self.update_packet_factory.player_values,
                                          self.update_packet_factory.updated_player_fields, index, value, 'f')

    # TODO: UPDATE_PARTIAL is not being used anywhere (it's implemented but not sure if it works correctly).
    # override
    def get_full_update_packet(self, is_self=True):
        self.inventory.send_inventory_update(self.session, is_self)

        self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
        self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
        self.player_bytes_2 = unpack('<I', pack('<4B', self.player.extra_flags, self.player.facialhair, self.player.bankslots, 0))[0]

        # Object fields
        self.set_obj_uint64(ObjectFields.OBJECT_FIELD_GUID, self.player.guid)
        self.set_obj_uint32(ObjectFields.OBJECT_FIELD_TYPE, self.get_object_type_value())
        self.set_obj_uint32(ObjectFields.OBJECT_FIELD_ENTRY, self.entry)
        self.set_obj_float(ObjectFields.OBJECT_FIELD_SCALE_X, self.scale)

        # Unit fields
        self.set_uni_uint32(UnitFields.UNIT_CHANNEL_SPELL, self.channel_spell)
        self.set_uni_uint64(UnitFields.UNIT_FIELD_CHANNEL_OBJECT, self.channel_object)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_HEALTH, self.health)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_POWER1, self.power_1)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_POWER2, self.power_2)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_POWER3, self.power_3)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_POWER4, self.power_4)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, self.max_health)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, self.max_power_1)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MAXPOWER2, self.max_power_2)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MAXPOWER3, self.max_power_3)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MAXPOWER4, self.max_power_4)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_LEVEL, self.level)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_FACTIONTEMPLATE, self.faction)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BYTES_0, self.bytes_0)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_STAT0, self.stat_0)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_STAT1, self.stat_1)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_STAT2, self.stat_2)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_STAT3, self.stat_3)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_STAT4, self.stat_4)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASESTAT0, self.base_stat_0)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASESTAT1, self.base_stat_1)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASESTAT2, self.base_stat_2)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASESTAT3, self.base_stat_3)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASESTAT4, self.base_stat_4)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_COINAGE, self.coinage)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, self.base_attack_time)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME + 1, self.offhand_attack_time)
        self.set_uni_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)
        self.set_uni_float(UnitFields.UNIT_FIELD_BOUNDINGRADIUS, self.bounding_radius)
        self.set_uni_float(UnitFields.UNIT_FIELD_COMBATREACH, self.combat_reach)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.display_id)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_MOUNTDISPLAYID, self.mount_display_id)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE, self.resistance_buff_mods_positive_0)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 1, self.resistance_buff_mods_positive_1)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 2, self.resistance_buff_mods_positive_2)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 3, self.resistance_buff_mods_positive_3)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 4, self.resistance_buff_mods_positive_4)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE + 5, self.resistance_buff_mods_positive_5)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE, self.resistance_buff_mods_negative_0)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 1, self.resistance_buff_mods_negative_1)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 2, self.resistance_buff_mods_negative_2)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 3, self.resistance_buff_mods_negative_3)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 4, self.resistance_buff_mods_negative_4)
        self.set_uni_int32(UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE + 5, self.resistance_buff_mods_negative_5)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BYTES_1, self.bytes_1)
        self.set_uni_float(UnitFields.UNIT_MOD_CAST_SPEED, self.mod_cast_speed)
        self.set_uni_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_DAMAGE, self.damage)
        self.set_uni_uint32(UnitFields.UNIT_FIELD_BYTES_2, self.bytes_2)

        # Player fields
        self.set_ply_uint32(PlayerFields.PLAYER_FIELD_NUM_INV_SLOTS, self.num_inv_slots)
        self.set_ply_uint32(PlayerFields.PLAYER_BYTES, self.player_bytes)
        self.set_ply_uint32(PlayerFields.PLAYER_XP, self.xp)
        self.set_ply_uint32(PlayerFields.PLAYER_NEXT_LEVEL_XP, self.next_level_xp)
        self.set_ply_uint32(PlayerFields.PLAYER_BYTES_2, self.player_bytes_2)
        self.set_ply_uint32(PlayerFields.PLAYER_CHARACTER_POINTS1, self.talent_points)
        self.set_ply_uint32(PlayerFields.PLAYER_CHARACTER_POINTS2, self.skill_points)
        self.set_ply_float(PlayerFields.PLAYER_BLOCK_PERCENTAGE, self.block_percentage)
        self.set_ply_float(PlayerFields.PLAYER_DODGE_PERCENTAGE, self.dodge_percentage)
        self.set_ply_float(PlayerFields.PLAYER_PARRY_PERCENTAGE, self.parry_percentage)
        self.set_ply_uint32(PlayerFields.PLAYER_BASE_MANA, self.base_mana)

        self.inventory.build_update()

        return self.create_update_packet(self.update_packet_factory, is_self)

    # override
    def update(self):
        now = time.time()

        if now > self.last_tick > 0:
            elapsed = now - self.last_tick
            self.player.totaltime += elapsed
            self.player.leveltime += elapsed
        self.last_tick = now

        if self.flagged_for_update:
            self.send_update_self()
            self.send_update_surrounding()
            GridManager.update_object(self)

            self.flagged_for_update = False

    def send_update_self(self, is_self=True):
        self.session.request.sendall(UpdatePacketFactory.compress_if_needed(
            PacketWriter.get_packet(
                OpCode.SMSG_UPDATE_OBJECT,
                self.get_full_update_packet(is_self=is_self))))

    def send_update_surrounding(self, is_self=False, include_self=False):
        update_packet = UpdatePacketFactory.compress_if_needed(PacketWriter.get_packet(
            OpCode.SMSG_UPDATE_OBJECT, self.get_full_update_packet(is_self=is_self)))
        GridManager.send_surrounding(update_packet, self, include_self=include_self)

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

        self.flagged_for_update = True

    # override
    def respawn(self, force_update=True):
        super().respawn()

        # TODO: Don't do this until stat system is finished
        # self.health = int(self.max_health / 2)
        # temp:
        self.health = 100
        if force_update:
            self.flagged_for_update = True

    # override
    def get_type(self):
        return ObjectTypes.TYPE_PLAYER

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_PLAYER

