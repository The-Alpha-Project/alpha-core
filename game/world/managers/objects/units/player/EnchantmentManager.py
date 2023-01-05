from struct import pack
from typing import Tuple, Dict

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from network.packet.PacketWriter import PacketWriter
from utils.Logger import Logger
from utils.constants.ItemCodes import InventorySlots, ItemEnchantmentType, EnchantmentSlots, InventoryTypes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UnitCodes import UnitFlags
from utils.constants.UpdateFields import ItemFields


MAX_ENCHANTMENTS = 5


class EnchantmentManager(object):
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.duration_timer_seconds = 0
        # enchantment id: (item_slot, spell id, proc chance).
        self._applied_proc_enchants: Dict[int, Tuple[int, int, int]] = {}

    # Load and apply enchantments from item_instance.
    def load_enchantments_for_item(self, item):
        db_enchantments = item.item_instance.enchantments
        if db_enchantments:
            values = db_enchantments.rsplit(',')
            for slot in range(MAX_ENCHANTMENTS):
                entry = int(values[slot * 3 + 0])
                duration = int(values[slot * 3 + 1])
                charges = int(values[slot * 3 + 2])
                self.set_item_enchantment(item, slot, entry, duration, charges)

    # TODO: Need to optimize item lookup or even move Enchantment updates to a new global thread.
    def update(self, elapsed):
        self.duration_timer_seconds += elapsed
        if self.duration_timer_seconds >= 10:
            for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
                self._update_item_enchantments(item)
            self.duration_timer_seconds = 0

    def _update_item_enchantments(self, item):
        for slot, enchantment in enumerate(item.enchantments):
            if slot > EnchantmentSlots.PERMANENT_SLOT and enchantment.entry:  # Temporary enchantments.
                new_duration = int(enchantment.duration - self.duration_timer_seconds)
                enchantment.duration = 0 if new_duration <= 0 else new_duration
                if not enchantment.duration and not enchantment.charges:
                    # Remove.
                    self.set_item_enchantment(item, slot, 0, 0, 0, expired=True)

    # noinspection PyMethodMayBeStatic
    def _consume_item_charges(self, item, enchantment_slot, used_charges=1):
        charges = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + enchantment_slot * 3 + 2)
        if charges:
            new_charges = max(0, charges - used_charges)
            item.set_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + enchantment_slot * 3 + 2, new_charges)
            item.enchantments[enchantment_slot].charges = new_charges
            return True
        return False

    def apply_enchantments(self, load=False):
        for container_slot, container in list(self.unit_mgr.inventory.containers.items()):
            if not container:
                continue
            for slot, item in list(container.sorted_slots.items()):
                if self.unit_mgr.inventory.is_bag_pos(slot):
                    continue
                # Initialize enchantments from db state if needed.
                if load:
                    self.load_enchantments_for_item(item)
                else:
                    for enchantment_slot, enchantment in enumerate(item.enchantments):
                        self.set_item_enchantment(item, enchantment_slot, enchantment.entry, enchantment.duration,
                                                  enchantment.charges)

    def set_item_enchantment(self, item, slot, value, duration, charges, expired=False):
        if not expired:
            item.enchantments[slot].update(value, duration, charges)

        current_value = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0)
        current_duration = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1)
        current_charges = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2)
        should_save = current_value != value or current_duration != duration or current_charges != charges

        # Check for buffs changes only on items that can be equipped.
        if item.item_template.inventory_type != InventoryTypes.NONE_EQUIP:
            remove_equip_buff = expired or not item.is_equipped()
            self._handle_equip_buffs(item, remove=remove_equip_buff)

        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, value)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, duration)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, charges)

        # Notify player with duration.
        if expired or duration:
            self.send_enchantments_durations(slot)

        if should_save:
            item.save()

    # Notify the client with the enchantment duration.
    # Client keeps track of the time, there is no need for constant updates.
    def send_enchantments_durations(self, update_slot=-1):
        for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
            for slot, enchantment in enumerate(item.enchantments):
                if slot > EnchantmentSlots.PERMANENT_SLOT:  # Temporary enchantments.
                    if update_slot != -1 and update_slot != slot:
                        continue
                    duration = 0 if enchantment.duration <= 0 else enchantment.duration
                    data = pack('<Q2IQ', item.guid, slot, duration, self.unit_mgr.guid)
                    self.unit_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_ENCHANT_TIME_UPDATE, data))

    def handle_equipment_change(self, item, expired=False):
        if not item:
            return
        was_removed = expired or item.current_slot > InventorySlots.SLOT_TABARD or \
            item.item_instance.bag != InventorySlots.SLOT_INBACKPACK
        self._handle_equip_buffs(item, remove=was_removed)

    def handle_melee_attack_procs(self, damage_info):
        for entry, proc_enchant in list(self._applied_proc_enchants.items()):
            item_slot, proc_spell_id, proc_chance = proc_enchant

            # Skip weapon procs if disarmed.
            is_main_hand = item_slot == InventorySlots.SLOT_MAINHAND
            if is_main_hand and self.unit_mgr.unit_flags & UnitFlags.UNIT_FLAG_DISARMED:
                continue

            if not self.unit_mgr.stat_manager.roll_proc_chance(proc_chance):
                continue

            proc_item = self.unit_mgr.inventory.get_item(InventorySlots.SLOT_INBACKPACK, item_slot)
            if not proc_item:
                continue

            # Handle proc charges.
            enchantment_slot = [i for i, enchantment in enumerate(proc_item.enchantments) if enchantment.entry == entry]
            if enchantment_slot and self._consume_item_charges(proc_item, enchantment_slot[0]):
                self._update_item_enchantments(proc_item)

            # Some enchant procs use spells that have cast times.
            # Ignore cast time for these spells by overriding cast time info.
            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(proc_spell_id)
            if spell_template:
                spell = self.unit_mgr.spell_manager.try_initialize_spell(spell_template, damage_info.target,
                                                                         SpellTargetMask.UNIT, triggered=True)
                # Unable to validate spell cast.
                if not spell:
                    Logger.warning(f'Unable to validate proc enchantment spell {spell_template.ID}.')
                    continue
                spell.cast_time_entry = None
                self.unit_mgr.spell_manager.start_spell_cast(initialized_spell=spell)
            else:
                Logger.warning(f'Unable to locate enchantment proc spell {proc_spell_id}.')

    def _handle_aura_removal(self, item):
        enchantment_type = ItemEnchantmentType.BUFF_EQUIPPED
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            if effect_spell_value and self.unit_mgr.aura_manager.has_aura_by_spell_id(effect_spell_value):
                self.unit_mgr.aura_manager.cancel_auras_by_spell_id(effect_spell_value,
                                                                    source_restriction=self.unit_mgr)

    def _handle_equip_buffs(self, item, remove=False):
        enchantment_type = ItemEnchantmentType.BUFF_EQUIPPED
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            if not effect_spell_value:
                continue

            if remove:
                self.unit_mgr.aura_manager.cancel_auras_by_spell_id(effect_spell_value,
                                                                    source_restriction=self.unit_mgr)
                continue

            # Check if player already has the triggered aura active.
            if not self.unit_mgr.aura_manager.has_aura_by_spell_id(effect_spell_value):
                self.unit_mgr.spell_manager.handle_cast_attempt(effect_spell_value,
                                                                self.unit_mgr, SpellTargetMask.SELF,
                                                                triggered=True)

        enchantment_type = ItemEnchantmentType.PROC_SPELL
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            if remove:
                self._applied_proc_enchants.pop(enchantment.entry, None)
                continue

            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            proc_chance = enchantment.get_enchantment_effect_points_by_type(enchantment_type)
            if not effect_spell_value or not proc_chance:
                continue

            self._applied_proc_enchants[enchantment.entry] = (item.current_slot, effect_spell_value, proc_chance)

        # Update stats upon add or removal.
        self.unit_mgr.stat_manager.apply_bonuses()

    @staticmethod
    def get_effect_value_for_enchantment_type(item, enchantment_type):
        if not item:
            return 0
        effect_value = 0
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            effect_value += enchantment.get_enchantment_effect_points_by_type(enchantment_type)
        return effect_value

    @staticmethod
    def has_enchantment_in_slot(item, slot: [EnchantmentSlots]):
        return item.enchantments[slot].entry if slot < MAX_ENCHANTMENTS else False

    @staticmethod
    def get_permanent_enchant_value(item):
        return item.enchantments[EnchantmentSlots.PERMANENT_SLOT].entry

    @staticmethod
    def has_enchantments_effect_by_type(item, enchantment_type):
        return any(enchantment.has_enchantment_effect(enchantment_type) for enchantment in item.enchantments)

    @staticmethod
    def get_enchantments_by_type(item, enchantment_type):
        return [enchantment for enchantment in item.enchantments
                if enchantment.has_enchantment_effect(enchantment_type)]
