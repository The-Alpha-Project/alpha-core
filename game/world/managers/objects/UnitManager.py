from struct import pack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, UnitDynamicTypes
from utils.constants.UnitCodes import UnitFlags, StandState
from utils.constants.UpdateFields import UnitFields


class UnitManager(ObjectManager):
    def __init__(self,
                 channel_spell=0,
                 channel_object=0,
                 health=0,
                 power_type=0,
                 power_1=0,  # mana
                 power_2=0,  # rage
                 power_3=0,  # focus
                 power_4=0,  # energy
                 max_health=0,
                 max_power_1=0,
                 max_power_2=0,
                 max_power_3=0,
                 max_power_4=0,
                 level=0,
                 faction=0,
                 bytes_0=0,  # race, class, gender, power_type
                 stat_0=0,
                 stat_1=0,
                 stat_2=0,
                 stat_3=0,
                 stat_4=0,
                 base_stat_0=0,
                 base_stat_1=0,
                 base_stat_2=0,
                 base_stat_3=0,
                 base_stat_4=0,
                 flags=0,
                 coinage=0,
                 combat_reach=config.Unit.Defaults.combat_reach,
                 mount_display_id=0,
                 resistance_buff_mods_positive_0=0,  # Armor
                 resistance_buff_mods_positive_1=0,  # Holy
                 resistance_buff_mods_positive_2=0,  # Fire
                 resistance_buff_mods_positive_3=0,  # Nature
                 resistance_buff_mods_positive_4=0,  # Frost
                 resistance_buff_mods_positive_5=0,  # Shadow
                 resistance_buff_mods_negative_0=0,
                 resistance_buff_mods_negative_1=0,
                 resistance_buff_mods_negative_2=0,
                 resistance_buff_mods_negative_3=0,
                 resistance_buff_mods_negative_4=0,
                 resistance_buff_mods_negative_5=0,
                 base_attack_time=config.Unit.Defaults.base_attack_time,
                 offhand_attack_time=config.Unit.Defaults.offhand_attack_time,
                 resistance_0=0,  # Armor
                 resistance_1=0,
                 resistance_2=0,
                 resistance_3=0,
                 resistance_4=0,
                 resistance_5=0,
                 stand_state=0,
                 bytes_1=0,  # stand state, shapeshift form, sheathstate
                 mod_cast_speed=1,
                 dynamic_flags=0,
                 damage=0,  # current damage, max damage
                 bytes_2=0,  # combo points, 0, 0, 0
                 combat_target=0,  # victim guid
                 **kwargs):
        super().__init__(**kwargs)

        self.combat_target = combat_target
        self.channel_spell = channel_spell
        self.channel_object = channel_object
        self.health = health
        self.power_type = power_type
        self.power_1 = power_1
        self.power_2 = power_2
        self.power_3 = power_3
        self.power_4 = power_4
        self.max_health = max_health
        self.max_power_1 = max_power_1
        self.max_power_2 = max_power_2
        self.max_power_3 = max_power_3
        self.max_power_4 = max_power_4
        self.level = level
        self.faction = faction
        self.bytes_0 = bytes_0  # race, class, gender, power_type
        self.stat_0 = stat_0
        self.stat_1 = stat_1
        self.stat_2 = stat_2
        self.stat_3 = stat_3
        self.stat_4 = stat_4
        self.base_stat_0 = base_stat_0
        self.base_stat_1 = base_stat_1
        self.base_stat_2 = base_stat_2
        self.base_stat_3 = base_stat_3
        self.base_stat_4 = base_stat_4
        self.flags = flags
        self.coinage = coinage
        self.combat_reach = combat_reach
        self.mount_display_id = mount_display_id
        self.resistance_buff_mods_positive_0 = resistance_buff_mods_positive_0
        self.resistance_buff_mods_positive_1 = resistance_buff_mods_positive_1
        self.resistance_buff_mods_positive_2 = resistance_buff_mods_positive_2
        self.resistance_buff_mods_positive_3 = resistance_buff_mods_positive_3
        self.resistance_buff_mods_positive_4 = resistance_buff_mods_positive_4
        self.resistance_buff_mods_positive_5 = resistance_buff_mods_positive_5
        self.resistance_buff_mods_negative_0 = resistance_buff_mods_negative_0
        self.resistance_buff_mods_negative_1 = resistance_buff_mods_negative_1
        self.resistance_buff_mods_negative_2 = resistance_buff_mods_negative_2
        self.resistance_buff_mods_negative_3 = resistance_buff_mods_negative_3
        self.resistance_buff_mods_negative_4 = resistance_buff_mods_negative_4
        self.resistance_buff_mods_negative_5 = resistance_buff_mods_negative_5
        self.base_attack_time = base_attack_time
        self.offhand_attack_time = offhand_attack_time
        self.resistance_0 = resistance_0  # Armor
        self.resistance_1 = resistance_1
        self.resistance_2 = resistance_2
        self.resistance_3 = resistance_3
        self.resistance_4 = resistance_4
        self.resistance_5 = resistance_5
        self.stand_state = stand_state
        self.bytes_1 = bytes_1  # stand state, shapeshift form, sheathstate
        self.mod_cast_speed = mod_cast_speed
        self.dynamic_flags = dynamic_flags
        self.damage = damage  # current damage, max damage
        self.bytes_2 = bytes_2  # combo points, 0, 0, 0

        self.object_type.append(ObjectTypes.TYPE_UNIT)
        self.update_packet_factory.init_values(UnitFields.UNIT_END)

        self.is_alive = True
        self.is_sitting = False

    def play_emote(self, emote):
        if emote != 0:
            data = pack('<IQ', emote, self.guid)
            GridManager.send_surrounding_in_range(PacketWriter.get_packet(OpCode.SMSG_EMOTE, data),
                                                  self, config.World.Chat.ChatRange.emote_range)

    def die(self, killer=None):
        if not self.is_alive:
            return

        self.is_alive = False
        self.health = 0

        self.unit_flags = UnitFlags.UNIT_FLAG_DEAD
        self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_DEAD
        self.stand_state = StandState.UNIT_DEAD

    def respawn(self):
        self.is_alive = True

        self.unit_flags = UnitFlags.UNIT_FLAG_STANDARD
        self.dynamic_flags = UnitDynamicTypes.UNIT_DYNAMIC_NONE
        self.stand_state = StandState.UNIT_STANDING

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
