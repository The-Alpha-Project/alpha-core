from struct import pack, unpack

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.GridManager import GridManager
from game.world.managers.objects.ObjectManager import ObjectManager
from network.packet.PacketWriter import PacketWriter, OpCode
from utils.ConfigManager import config
from utils.constants.ObjectCodes import ObjectTypes, ObjectTypeIds, HighGuid, UnitDynamicTypes, AttackTypes
from utils.constants.UnitCodes import UnitFlags, StandState, WeaponMode
from utils.constants.UpdateFields import UnitFields


class UnitManager(ObjectManager):
    def __init__(self,
                 channel_spell=0,
                 channel_object=0,
                 health=0,
                 power_type=0,
                 power_1=0,  # mana
                 power_2=0,  # rage
                 power_3=100,  # focus
                 power_4=100,  # energy
                 max_health=0,
                 max_power_1=0,
                 max_power_2=1000,
                 max_power_3=100,
                 max_power_4=100,
                 level=0,
                 faction=0,
                 bytes_0=0,  # race, class, gender, power_type
                 creature_type=0,
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
                 sheathe_state=WeaponMode.SHEATHEDMODE,
                 bytes_1=0,  # stand state, shapeshift form, sheathstate
                 mod_cast_speed=1,
                 dynamic_flags=0,
                 damage=0,  # current damage, max damage
                 bytes_2=0,  # combo points, 0, 0, 0
                 current_target = 0, # guid
                 combat_target=None,  # victim
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
        self.creature_type = creature_type
        self.str = stat_0
        self.agi = stat_1
        self.sta = stat_2
        self.int = stat_3
        self.spi = stat_4
        self.base_str = base_stat_0
        self.base_agi = base_stat_1
        self.base_sta = base_stat_2
        self.base_int = base_stat_3
        self.base_spi = base_stat_4
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
        self.sheath_state = sheathe_state
        self.bytes_1 = bytes_1  # stand state, shapeshift form, sheathstate
        self.mod_cast_speed = mod_cast_speed
        self.dynamic_flags = dynamic_flags
        self.damage = damage  # current damage, max damage
        self.bytes_2 = bytes_2  # combo points, 0, 0, 0
        self.current_target = current_target

        self.object_type.append(ObjectTypes.TYPE_UNIT)
        self.update_packet_factory.init_values(UnitFields.UNIT_END)

        self.dirty = False
        self.is_alive = True
        self.is_sitting = False
        self.in_combat = False
        self.attackers = {}
        self.attack_timers = {AttackTypes.BASE_ATTACK: 0,
                              AttackTypes.OFFHAND_ATTACK: 0}

    def attack(self, victim, is_melee=True):
        if not victim or victim == self:
            return False

        # Dead units can neither attack nor be attacked
        if not self.is_alive or not victim.is_alive:
            return False

        # Mounted players can't attack
        if ObjectTypes.TYPE_PLAYER in self.object_type and self.mount_display_id > 0:
            return False

        # Nobody can attack a GM
        if ObjectTypes.TYPE_PLAYER in victim.object_type and victim.is_gm:
            return False

        if victim.is_evading:
            return False

        # In fight already
        if self.combat_target:
            if self.combat_target == victim:
                if is_melee:
                    self.send_melee_attack_start(victim)
                    return True
                return False

            self.attack_stop(target_switch=True)

        self.set_current_target(victim.guid)
        self.combat_target = victim
        victim.attackers[self.guid] = self

        # TODO: Reset attack timer for offhand weapon if needed

        if is_melee:
            self.send_melee_attack_start(victim)

        return True

    def attack_stop(self, target_switch=False):
        if self.combat_target and self.guid in self.combat_target.attackers:
            self.combat_target.attackers.pop(self.guid, None)

        # Clear target
        self.set_current_target(self.guid)
        victim = self.combat_target
        self.combat_target = None

        self.send_melee_attack_stop(victim)

    def send_melee_attack_start(self, victim):
        data = pack('<2Q', self.guid, victim.guid)
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTART, data), self)

    def send_melee_attack_stop(self, victim):
        data = pack('<2QI', self.guid, victim.guid if victim else 0, 0)  # Last int can be 0x1 too, unknown.
        GridManager.send_surrounding(PacketWriter.get_packet(OpCode.SMSG_ATTACKSTOP, data), self)

    def update_melee_attacking_state(self):
        pass
        # TODO Implement

    def set_current_target(self, guid):
        self.current_target = guid
        self.set_uint64(UnitFields.UNIT_FIELD_TARGET, guid)

    def is_attack_ready(self, attack_type):
        return self.attack_timers[attack_type] <= 0

    def update_attack_time(self, attack_type, value):
        self.set_attack_timer(attack_type, self.attack_timers[attack_type] - value)

    def set_attack_timer(self, attack_type, value):
        self.attack_timers[attack_type] = value

    def play_emote(self, emote):
        if emote != 0:
            data = pack('<IQ', emote, self.guid)
            GridManager.send_surrounding_in_range(PacketWriter.get_packet(OpCode.SMSG_EMOTE, data),
                                                  self, config.World.Chat.ChatRange.emote_range)

    def set_health(self, health):
        if health < 0:
            health = 0
        self.health = health
        self.set_uint32(UnitFields.UNIT_FIELD_HEALTH, health)

    def set_max_health(self, health):
        self.max_health = health
        self.set_uint32(UnitFields.UNIT_FIELD_MAXHEALTH, health)

    def set_mana(self, mana):
        if mana < 0:
            mana = 0
        self.power_1 = mana
        self.set_uint32(UnitFields.UNIT_FIELD_POWER1, mana)

    def set_rage(self, rage):
        if rage < 0:
            rage = 0
        rage = rage * 10
        self.power_2 = rage
        self.set_uint32(UnitFields.UNIT_FIELD_POWER2, rage)

    def set_focus(self, focus):
        if focus < 0:
            focus = 0
        self.power_3 = focus
        self.set_uint32(UnitFields.UNIT_FIELD_POWER3, focus)

    def set_energy(self, energy):
        if energy < 0:
            mana = 0
        self.power_4 = energy
        self.set_uint32(UnitFields.UNIT_FIELD_POWER4, energy)

    def set_max_mana(self, mana):
        self.max_power_1 = mana
        self.set_uint32(UnitFields.UNIT_FIELD_MAXPOWER1, mana)

    def set_armor(self, armor):
        self.resistance_0 = armor
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES, self.resistance_0)

    def set_holy_res(self, holy_res):
        self.resistance_1 = holy_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 1, self.resistance_1)

    def set_fire_res(self, fire_res):
        self.resistance_2 = fire_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 2, self.resistance_2)

    def set_nature_res(self, nature_res):
        self.resistance_3 = nature_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 3, self.resistance_3)

    def set_frost_res(self, frost_res):
        self.resistance_4 = frost_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 4, self.resistance_4)

    def set_shadow_res(self, shadow_res):
        self.resistance_5 = shadow_res
        self.set_int64(UnitFields.UNIT_FIELD_RESISTANCES + 5, self.resistance_5)

    def set_melee_damage(self, min_dmg, max_dmg):
        damages = unpack('<I', pack('<2H', min_dmg, max_dmg))[0]
        self.damage = damages
        self.set_uint32(UnitFields.UNIT_FIELD_DAMAGE, damages)

    def set_melee_attack_time(self, attack_time):
        self.base_attack_time = attack_time
        self.set_uint32(UnitFields.UNIT_FIELD_BASEATTACKTIME, attack_time)

    def set_weapon_mode(self, weapon_mode):
        self.sheath_state = weapon_mode

        # TODO: Implement temp enchants updates.
        if WeaponMode.NORMALMODE:
            # Update main hand temp enchants
            # Update off hand temp enchants
            pass
        elif WeaponMode.RANGEDMODE:
            # Update ranged temp enchants
            pass

    def set_stand_state(self, stand_state):
        self.stand_state = stand_state

    def set_display_id(self, display_id):
        if display_id > 0 and \
                DbcDatabaseManager.creature_display_info_get_by_id(display_id):
            self.display_id = display_id
            self.set_uint32(UnitFields.UNIT_FIELD_DISPLAYID, self.display_id)
            self.set_dirty()

    def die(self, killer=None):
        if not self.is_alive:
            return

        self.is_alive = False
        self.set_health(0)
        self.set_stand_state(StandState.UNIT_DEAD)

        self.unit_flags = UnitFlags.UNIT_FLAG_DEAD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags |= UnitDynamicTypes.UNIT_DYNAMIC_DEAD
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

    def respawn(self):
        self.is_alive = True

        self.unit_flags = UnitFlags.UNIT_FLAG_STANDARD
        self.set_uint32(UnitFields.UNIT_FIELD_FLAGS, self.unit_flags)

        self.dynamic_flags = UnitDynamicTypes.UNIT_DYNAMIC_NONE
        self.set_uint32(UnitFields.UNIT_DYNAMIC_FLAGS, self.dynamic_flags)

        self.set_stand_state(StandState.UNIT_STANDING)

    def set_dirty(self, dirty=True):
        self.dirty = dirty

    # override
    def get_type(self):
        return ObjectTypes.TYPE_UNIT

    # override
    def get_type_id(self):
        return ObjectTypeIds.ID_UNIT
