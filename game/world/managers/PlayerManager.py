from struct import pack, unpack

from game.world.managers.UnitManager import UnitManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import ObjectTypes
from network.packet.UpdatePacketFactory import UpdatePacketFactory
from utils.constants.UpdateFields import *


class PlayerManager(UnitManager):

    def __init__(self,
                 player=None,
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
                 is_online=False,
                 **kwargs):
        super().__init__(**kwargs)

        self.update_packet_factory = UpdatePacketFactory([ObjectTypes.TYPE_OBJECT.value,
                                                          ObjectTypes.TYPE_UNIT.value,
                                                          ObjectTypes.TYPE_PLAYER.value])

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

        if player:
            self.guid = player.guid
            self.level = player.level
            self.object_type.append(ObjectTypes.TYPE_PLAYER)
            self.bytes_0 = unpack('<I', pack('<4B', player.race, player.class_, player.gender, 1))[0]  # power type, handle later
            self.bytes_1 = unpack('<I', pack('<4B', self.stand_state, 0, self.shapeshift_form, self.sheath_state))[0]
            self.bytes_2 = unpack('<I', pack('<4B', self.combo_points, 0, 0, 0))[0]
            self.player_bytes = unpack('<I', pack('<4B', player.skin, player.face, player.hairstyle, player.haircolour))[0]
            self.player_bytes_2 = unpack('<I', pack('<4B', player.extra_flags, player.bankslots, player.facialhair, 0))[0]
            self.map_ = player.map
            self.zone = player.zone
            self.location.x = player.position_x
            self.location.y = player.position_y
            self.location.z = player.position_z
            self.orientation = player.orientation

            # test
            self.health = 1
            self.max_health = 1
            self.display_id = 278
            self.movement_flags = 0x08000000

    def complete_login(self):
        self.is_online = True

    def logout(self):
        self.is_online = False

    def get_tutorial_packet(self):
        # Not handling any tutorial (are them even implemented?)
        return PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, pack('<8I', 0, 0, 0, 0, 0, 0, 0, 0))

    def get_initial_spells(self):
        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, pack('<BHHHH', 0, 1, 133, 1, 0))  # TODO Test with spell 133

    def get_query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.player.name)
        player_data = pack(
            '<Q%usIII' % len(name_bytes),
            self.player.guid,
            name_bytes,
            self.player.race,
            self.player.gender,
            self.player.class_
        )
        return PacketWriter.get_packet(OpCode.SMSG_NAME_QUERY_RESPONSE, player_data)

    def get_update_packet(self):
        # Object fields
        self.update_packet_factory.update(self.update_packet_factory.object_values, ObjectFields.OBJECT_FIELD_GUID.value, self.player.guid, 'Q')
        self.update_packet_factory.update(self.update_packet_factory.object_values, ObjectFields.OBJECT_FIELD_TYPE.value, self.get_object_type_value(), 'I')
        self.update_packet_factory.update(self.update_packet_factory.object_values, ObjectFields.OBJECT_FIELD_ENTRY.value, self.entry, 'I')
        self.update_packet_factory.update(self.update_packet_factory.object_values, ObjectFields.OBJECT_FIELD_SCALE_X.value, self.scale, 'f')

        # Unit fields
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_CHANNEL_SPELL.value, self.channel_spell, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_CHANNEL_OBJECT.value, self.channel_object, 'Q')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_HEALTH.value, self.health, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_POWER1.value, self.power_1, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_POWER2.value, self.power_2, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_POWER3.value, self.power_3, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_POWER4.value, self.power_4, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MAXHEALTH.value, self.max_health, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MAXPOWER1.value, self.max_power_1, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MAXPOWER2.value, self.max_power_2, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MAXPOWER3.value, self.max_power_3, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MAXPOWER4.value, self.max_power_4, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_LEVEL.value, self.level, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_FACTIONTEMPLATE.value, self.faction, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BYTES_0.value, self.bytes_0, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_STAT0.value, self.stat_0, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_STAT1.value, self.stat_1, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_STAT2.value, self.stat_2, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_STAT3.value, self.stat_3, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_STAT4.value, self.stat_4, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASESTAT0.value, self.base_stat_0, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASESTAT1.value, self.base_stat_1, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASESTAT2.value, self.base_stat_2, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASESTAT3.value, self.base_stat_3, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASESTAT4.value, self.base_stat_4, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_FLAGS.value, self.flags, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_COINAGE.value, self.coinage, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASEATTACKTIME.value, self.base_attack_time, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BASEATTACKTIME.value + 1, self.offhand_attack_time, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value, self.resistance_0, 'q')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value + 1, self.resistance_1, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value + 2, self.resistance_2, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value + 3, self.resistance_3, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value + 4, self.resistance_4, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCES.value + 5, self.resistance_5, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BOUNDINGRADIUS.value, self.bounding_radius, 'f')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_COMBATREACH.value, self.combat_reach, 'f')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_DISPLAYID.value, self.display_id, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_MOUNTDISPLAYID.value, self.mount_display_id, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value, self.resistance_buff_mods_positive_0, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value + 1, self.resistance_buff_mods_positive_1, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value + 2, self.resistance_buff_mods_positive_2, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value + 3, self.resistance_buff_mods_positive_3, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value + 4, self.resistance_buff_mods_positive_4, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSPOSITIVE.value + 5, self.resistance_buff_mods_positive_5, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value, self.resistance_buff_mods_negative_0, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value + 1, self.resistance_buff_mods_negative_1, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value + 2, self.resistance_buff_mods_negative_2, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value + 3, self.resistance_buff_mods_negative_3, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value + 4, self.resistance_buff_mods_negative_4, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_RESISTANCEBUFFMODSNEGATIVE.value + 5, self.resistance_buff_mods_negative_5, 'i')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BYTES_1.value, self.bytes_1, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_MOD_CAST_SPEED.value, self.mod_cast_speed, 'f')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_DYNAMIC_FLAGS.value, self.dynamic_flags, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_DAMAGE.value, self.damage, 'I')
        self.update_packet_factory.update(self.update_packet_factory.unit_values, UnitFields.UNIT_FIELD_BYTES_2.value, self.bytes_2, 'I')

        # Player fields
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_FIELD_NUM_INV_SLOTS.value, self.num_inv_slots, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_BYTES.value, self.player_bytes, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_XP.value, self.xp, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_NEXT_LEVEL_XP.value, self.next_level_xp, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_BYTES_2.value, self.player_bytes_2, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_CHARACTER_POINTS1.value, self.talent_points, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_CHARACTER_POINTS2.value, self.skill_points, 'I')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_BLOCK_PERCENTAGE.value, self.block_percentage, 'f')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_DODGE_PERCENTAGE.value, self.dodge_percentage, 'f')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_PARRY_PERCENTAGE.value, self.parry_percentage, 'f')
        self.update_packet_factory.update(self.update_packet_factory.player_values, PlayerFields.PLAYER_BASE_MANA.value, self.base_mana, 'I')

        return self.update_packet_factory.build_packet()
