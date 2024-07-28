from struct import pack
from network.packet.PacketWriter import PacketWriter
from utils.constants.ItemCodes import ItemEnchantmentType, EnchantmentSlots, InventoryTypes
from utils.constants.OpCodes import OpCode
from utils.constants.SpellCodes import SpellTargetMask
from utils.constants.UpdateFields import ItemFields


MAX_ENCHANTMENTS = 5


class EnchantmentManager(object):
    def __init__(self, unit_mgr):
        self.unit_mgr = unit_mgr
        self.duration_timer_seconds = 0

    # Load and apply enchantments from item_instance.
    def load_enchantments_for_item(self, item, from_db=False):
        db_enchantments = item.item_instance.enchantments
        if not db_enchantments:
            return
        values = db_enchantments.rsplit(',')
        for slot in range(MAX_ENCHANTMENTS):
            entry = int(values[slot * 3 + 0])
            if from_db and not entry:
                continue
            duration = int(values[slot * 3 + 1])
            charges = int(values[slot * 3 + 2])
            self.set_item_enchantment(item, slot, entry, duration, charges)

    def update(self, elapsed, saving=False):
        self.duration_timer_seconds += elapsed
        if saving or self.duration_timer_seconds >= 30:
            # Updates should check all items, not just backpack.
            [self._update_item_enchantments(itm) for itm in self.unit_mgr.inventory.get_all_items()]
            self.duration_timer_seconds = 0

    def save(self):
        self.update(0, saving=True)

    def _update_item_enchantments(self, item):
        # In order to avoid more iterations for item duration field (Not enchantments, do it here).
        if item.duration:
            self._update_item_duration(item)
        # Enchantments.
        [self._update_item_enchant(item, slot, enchantment) for (slot, enchantment)
         in enumerate(item.enchantments) if slot > EnchantmentSlots.PERMANENT_SLOT and enchantment.entry]

    def _update_item_duration(self, item):
        item.duration = max(0, int(item.duration - self.duration_timer_seconds))
        if item.duration:
            item.save()
            item.send_item_duration(self.unit_mgr.guid)
        # Expired on this tick, remove item.
        else:
            self.unit_mgr.inventory.remove_item(item)

    def _update_item_enchant(self, item, slot, enchantment):
        enchantment.duration = max(0, int(enchantment.duration - self.duration_timer_seconds))
        if not enchantment.duration and not enchantment.charges:
            # Remove.
            self.set_item_enchantment(item, slot, 0, 0, 0, expired=True)
            self.unit_mgr.equipment_proc_manager.handle_equipment_change(item)  # Update procs if enchant expires.
        elif not enchantment.duration:
            item.save()

    # noinspection PyMethodMayBeStatic
    def consume_enchant_charge(self, item, spell_id):
        enchantment_slot = [i for i, enchantment in enumerate(item.enchantments) if enchantment.effect_spell == spell_id]

        if not enchantment_slot:
            return

        enchantment_slot = enchantment_slot[0]

        charges = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + enchantment_slot * 3 + 2)
        if not charges:
            return

        new_charges = max(0, charges - 1)
        item.set_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + enchantment_slot * 3 + 2, new_charges)
        item.enchantments[enchantment_slot].charges = new_charges
        self._update_item_enchantments(item)

    def apply_enchantments(self, load=False):
        for container_slot, container in list(self.unit_mgr.inventory.containers.items()):
            if not container:
                continue
            for slot, item in list(container.sorted_slots.items()):
                if self.unit_mgr.inventory.is_bag_pos(slot):
                    continue
                # Initialize enchantments from db state if needed.
                if load:
                    self.load_enchantments_for_item(item, from_db=True)
                else:
                    for enchantment_slot, enchantment in enumerate(item.enchantments):
                        self.set_item_enchantment(item, enchantment_slot, enchantment.entry, enchantment.duration,
                                                  enchantment.charges)

    def set_item_enchantment(self, item, slot, value, duration, charges, expired=False):
        duration = duration if slot != EnchantmentSlots.PERMANENT_SLOT else -1

        if not expired:
            item.enchantments[slot].update(value, duration, charges)

        current_value = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0)
        current_duration = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1)
        current_charges = item.get_uint32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2)

        should_reapply = current_value != value or current_charges != charges or expired
        should_save = current_value != value or current_duration != duration or current_charges != charges

        # Check for buffs changes only on items that can be equipped.
        if item.item_template.inventory_type != InventoryTypes.NONE_EQUIP and should_reapply:
            remove_equip_buff = expired or not item.is_equipped()
            self._handle_equip_buffs(item, remove=remove_equip_buff)

        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 0, value)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 1, duration)
        item.set_int32(ItemFields.ITEM_FIELD_ENCHANTMENT + slot * 3 + 2, charges)

        # Notify player with duration.
        if expired or duration:
            self.send_enchantments_durations(slot)
            # Remove enchantment holder entry.
            if expired and item.enchantments[slot].entry:
                item.enchantments[slot].entry = 0

        if should_save:
            item.save()

    # Notify the client with the enchantment duration.
    # Client keeps track of the time, there is no need for constant updates.
    def send_enchantments_durations(self, update_slot=-1):
        for item in list(self.unit_mgr.inventory.get_all_items()):
            for slot, enchantment in enumerate(item.enchantments):
                if slot > EnchantmentSlots.PERMANENT_SLOT:  # Temporary enchantments.
                    if update_slot != -1 and update_slot != slot:
                        continue
                    duration = 0 if enchantment.duration <= 0 else enchantment.duration
                    data = pack('<Q2I', item.guid, slot, duration)
                    self.unit_mgr.enqueue_packet(PacketWriter.get_packet(OpCode.SMSG_ITEM_ENCHANT_TIME_UPDATE, data))

    def handle_equipment_change(self, source_item, dest_item):
        if not dest_item:
            self._handle_equip_buffs(source_item, remove=not source_item.is_equipped())
            return

        for item in [source_item, dest_item] if dest_item.is_equipped() else [dest_item, source_item]:
            # Handle unequipped item first in case equipment has the same buff.
            self._handle_equip_buffs(item, remove=not item.is_equipped())

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
