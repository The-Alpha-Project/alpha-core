from struct import pack
from typing import Tuple, Dict

from network.packet.PacketWriter import PacketWriter
from utils.constants.ItemCodes import InventorySlots, ItemEnchantmentType, EnchantmentSlots
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UpdateFields import ItemFields


MAX_ENCHANTMENTS = 5


class EnchantmentManager(object):
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self._applied_proc_enchants: Dict[int, Tuple[int, int]] = {}  # enchantment id: (spell id, proc chance).

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

    def set_item_enchantment(self, item, slot, value, duration, charges):
        item.enchantments[slot].update(value, duration, charges)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, value)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, duration)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, charges)

        # Notify player with duration.
        if slot != EnchantmentSlots.PermanentSlot:
            self.send_enchantments_durations(slot)

        self._handle_equip_buffs(item, remove=not item.is_equipped())

    # Notify the client with the enchantment duration.
    def send_enchantments_durations(self, update_slot=-1):
        for item in list(self.unit_mgr.inventory.get_backpack().sorted_slots.values()):
            for slot, enchantment in enumerate(item.enchantments):
                if slot > EnchantmentSlots.PermanentSlot:  # Temporary enchantments.
                    if update_slot != -1 and update_slot != slot:
                        continue
                    duration = 0 if enchantment.duration <= 0 else enchantment.duration
                    data = pack('<Q2IQ', item.guid, slot, duration, self.unit_mgr.guid)
                    self.unit_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_ENCHANT_TIME_UPDATE, data))

    def handle_equipment_change(self, item):
        if not item:
            return
        was_removed = item.current_slot > InventorySlots.SLOT_TABARD
        self._handle_equip_buffs(item, remove=was_removed)

    def handle_melee_attack_procs(self, damage_info):
        for proc_enchant in self._applied_proc_enchants.values():
            proc_spell, proc_chance = proc_enchant
            if not self.unit_mgr.stat_manager.roll_proc_chance(proc_chance):
                continue

            self.unit_mgr.spell_manager.handle_cast_attempt(proc_spell, damage_info.attacker,
                                                            SpellTargetMask.UNIT, triggered=True)

    def _handle_aura_removal(self, item):
        enchantment_type = ItemEnchantmentType.BUFF_EQUIPPED
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            if effect_spell_value and self.unit_mgr.aura_manager.has_aura_by_spell_id(effect_spell_value):
                self.unit_mgr.aura_manager.cancel_auras_by_spell_id(effect_spell_value)

    def _handle_equip_buffs(self, item, remove=False):
        enchantment_type = ItemEnchantmentType.BUFF_EQUIPPED
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            if not effect_spell_value:
                continue

            if remove:
                self.unit_mgr.aura_manager.cancel_auras_by_spell_id(effect_spell_value)
                continue

            # Check if player already has the triggered aura active.
            if self.unit_mgr.aura_manager.has_aura_by_spell_id(effect_spell_value):
                # Learn spell if needed and cast.
                self.unit_mgr.spell_manager.learn_spell(effect_spell_value)
                # TODO pass triggered?
                self.unit_mgr.spell_manager.handle_cast_attempt(effect_spell_value, self.unit_mgr, SpellTargetMask.SELF)

        enchantment_type = ItemEnchantmentType.PROC_SPELL
        for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
            if remove:
                self._applied_proc_enchants.pop(enchantment.entry, None)
                continue

            effect_spell_value = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
            proc_chance = enchantment.get_enchantment_effect_points_by_type(enchantment_type)
            if not effect_spell_value or not proc_chance:
                continue
            self._applied_proc_enchants[enchantment.entry] = (effect_spell_value, proc_chance)

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
        return item.enchantments[EnchantmentSlots.PermanentSlot].entry

    @staticmethod
    def has_enchantments_effect_by_type(item, enchantment_type):
        return any(enchantment.has_enchantment_effect(enchantment_type) for enchantment in item.enchantments)

    @staticmethod
    def get_enchantments_by_type(item, enchantment_type):
        return [enchantment for enchantment in item.enchantments
                if enchantment.has_enchantment_effect(enchantment_type)]
