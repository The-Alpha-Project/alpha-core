from game.world.objects.UnitManager import UnitManager
from network.packet.PacketWriter import *
from utils.constants.ObjectCodes import ObjectTypes


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
                 **kwargs):
        super().__init__(**kwargs)

        self.player = player
        self.num_inv_slots = num_inv_slots
        self.player_bytes = player_bytes
        self.xp = xp
        self.next_level_xp = next_level_xp
        self.player_bytes_2 = player_bytes_2
        self.talent_points = talent_points
        self.skill_points = skill_points
        self.block_percentage = block_percentage
        self.dodge_percentage = dodge_percentage
        self.parry_percentage = parry_percentage
        self.base_mana = base_mana

        self.guid = player.guid
        self.display_id = 278  # temp
        self.object_type = ObjectTypes.TYPE_PLAYER.value | ObjectTypes.TYPE_UNIT.value | ObjectTypes.TYPE_OBJECT.value
        self.bytes_0 = player.race | player.class_ | player.gender | 0  # power type, handle later
        self.player_bytes = player.skin | player.face | player.hairstyle | player.haircolour
        self.player_bytes_2 = player.extra_flags | player.bankslots | player.facialhair | 0

    def get_tutorial_packet(self):
        # Not handling any tutorial (are them even implemented?)
        return PacketWriter.get_packet(OpCode.SMSG_TUTORIAL_FLAGS, pack('!8I', 0, 0, 0, 0, 0, 0, 0, 0))

    def get_initial_spells(self):
        return PacketWriter.get_packet(OpCode.SMSG_INITIAL_SPELLS, pack('!BHHHH', 0, 0, 133, 1, 0))  # TODO Test with spell 133

    def get_query_details(self):
        name_bytes = PacketWriter.string_to_bytes(self.player.name)
        player_data = pack(
            '!Q%usIII' % len(name_bytes),
            self.player.guid,
            name_bytes,
            self.player.race,
            self.player.gender,
            self.player.class_
        )
        return PacketWriter.get_packet(OpCode.SMSG_NAME_QUERY_RESPONSE, player_data)

    def get_player_build_update_packet(self, deflate=False):
        data = pack(
            '!LIIfILIIIIIIIIIIIIIIIIIIIIIIIIIIIliiiiiffIIiiiiiiiiiiiiIfIIIIIIIIIIfffI',
            self.guid,
            self.object_type,
            self.entry,
            self.scale,
            self.channel_spell,
            self.channel_object,
            self.health,
            self.power_1,
            self.power_2,
            self.power_3,
            self.power_4,
            self.max_health,
            self.max_power_1,
            self.max_power_2,
            self.max_power_3,
            self.max_power_4,
            self.level,
            self.faction,
            self.bytes_0,
            self.stat_0,
            self.stat_1,
            self.stat_2,
            self.stat_3,
            self.stat_4,
            self.base_stat_0,
            self.base_stat_1,
            self.base_stat_2,
            self.base_stat_3,
            self.base_stat_4,
            self.flags,
            self.coinage,
            self.base_attack_time,
            self.offhand_attack_time,
            self.resistance_0,
            self.resistance_1,
            self.resistance_2,
            self.resistance_3,
            self.resistance_4,
            self.resistance_5,
            self.bounding_radius,
            self.combat_reach,
            self.display_id,
            self.mount_display_id,
            self.resistance_buff_mods_positive_0,
            self.resistance_buff_mods_positive_1,
            self.resistance_buff_mods_positive_2,
            self.resistance_buff_mods_positive_3,
            self.resistance_buff_mods_positive_4,
            self.resistance_buff_mods_positive_5,
            self.resistance_buff_mods_negative_0,
            self.resistance_buff_mods_negative_1,
            self.resistance_buff_mods_negative_2,
            self.resistance_buff_mods_negative_3,
            self.resistance_buff_mods_negative_4,
            self.resistance_buff_mods_negative_5,
            self.bytes_1,
            self.mod_cast_speed,
            self.dynamic_flags,
            self.damage,
            self.bytes_2,
            self.num_inv_slots,
            self.player_bytes,
            self.xp,
            self.next_level_xp,
            self.bytes_2,
            self.talent_points,
            self.skill_points,
            self.block_percentage,
            self.dodge_percentage,
            self.parry_percentage,
            self.base_mana
        )

        if deflate:
            return PacketWriter.get_packet(OpCode.SMSG_COMPRESSED_UPDATE_OBJECT, self._deflate(data))
        else:
            return PacketWriter.get_packet(OpCode.SMSG_UPDATE_OBJECT, data)
