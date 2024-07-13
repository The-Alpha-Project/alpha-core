from enum import IntEnum

from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.DamageInfoHolder import DamageInfoHolder
from game.world.managers.objects.units.player.EnchantmentManager import EnchantmentManager
from utils.Logger import Logger
from utils.constants.ItemCodes import ItemEnchantmentType, ItemSpellTriggerType, InventorySlots
from utils.constants.SpellCodes import SpellTargetMask


class ProcEffectType(IntEnum):
    ENCHANTMENT = 0
    EQUIPMENT_EFFECT = 1

class ProcEffect:
    item_slot: int
    spell_id: int
    proc_chance: float  # -1 for 1 PPM.
    effect_type: ProcEffectType

    def __init__(self, item_slot: int, spell_id: int, effect_type: ProcEffectType, proc_chance: float = -1):
        self.item_slot = item_slot
        self.spell_id = spell_id
        self.effect_type = effect_type
        self.proc_chance = proc_chance

    def get_proc_chance(self, weapon: ItemManager):
        if self.proc_chance != -1:
            return self.proc_chance

        # Calculate chance for 1 PPM proc effect.
        return weapon.item_template.delay * (1 / 600)


class EquipmentProcManager:
    # Indexed by enchantment ID or -spell ID
    proc_effects: dict[int, ProcEffect]

    def __init__(self, player_mgr):
        self.player_mgr = player_mgr
        self.proc_effects = dict()

    def update_procs_for_items(self, *items: [ItemManager]):
        for item in items:
            # Spell proc enchants.
            enchantment_type = ItemEnchantmentType.PROC_SPELL
            for enchantment in EnchantmentManager.get_enchantments_by_type(item, enchantment_type):
                if enchantment.is_expired():
                    self._remove_enchantment(enchantment.entry)
                    continue

                spell_id = enchantment.get_enchantment_effect_spell_by_type(enchantment_type)
                proc_chance = enchantment.get_enchantment_effect_points_by_type(enchantment_type)
                if not spell_id or not proc_chance:
                    continue
                self._add_enchantment(enchantment.entry, item.current_slot, spell_id, proc_chance)

            # Item chance on hit effects.
            for item_spell in item.spell_stats:
                if item_spell.trigger != ItemSpellTriggerType.ITEM_SPELL_TRIGGER_CHANCE_ON_HIT:
                    continue

                if not item.is_equipped():
                    self._remove_equip_spell(item_spell.spell_id)
                    continue

                self._add_equipment(item, item_spell.spell_id)

    def handle_melee_attack_procs(self, damage_info: DamageInfoHolder):
        for entry, proc_effect in self.proc_effects.items():
            attack_weapon = self.player_mgr.get_current_weapon_for_attack_type(damage_info.attack_type)
            if not attack_weapon:
                continue  # Disarmed / feral form.

            if not self.player_mgr.stat_manager.roll_proc_cha1nce(proc_effect.get_proc_chance(attack_weapon)):
                continue

            spell_template = DbcDatabaseManager.SpellHolder.spell_get_by_id(proc_effect.spell_id)
            if not spell_template:
                Logger.warning(f'Unable to locate enchantment proc spell {proc_effect.spell_id}.')
                continue

            spell = self.player_mgr.spell_manager.try_initialize_spell(spell_template, damage_info.target,
                                                                     SpellTargetMask.UNIT, triggered=True)
            if not spell:
                continue  # Validation failed.

            # Some enchant procs use spells that have cast times.
            # Ignore cast time for these spells by overriding cast time info.
            spell.force_instant_cast()
            self.player_mgr.spell_manager.start_spell_cast(initialized_spell=spell)

            # Remove enchantment charges.
            if proc_effect.effect_type == ProcEffectType.ENCHANTMENT:
                continue

            proc_item = self.player_mgr.inventory.get_item(InventorySlots.SLOT_INBACKPACK, proc_effect.item_slot)
            self.player_mgr.enchantment_manager.consume_enchant_charge(proc_item, entry)

    def _add_enchantment(self, enchant_id: int, slot: int, spell_id: int, proc_chance: float):
        self.proc_effects[enchant_id] = ProcEffect(slot, spell_id, ProcEffectType.ENCHANTMENT, proc_chance)

    def _remove_enchantment(self, enchant_id):
        self.proc_effects.pop(enchant_id, None)

    def _add_equipment(self, item: ItemManager, spell_id: int):
        self.proc_effects[-spell_id] = ProcEffect(item.current_slot, spell_id, ProcEffectType.EQUIPMENT_EFFECT)

    def _remove_equip_spell(self, spell_id):
        self.proc_effects.pop(-spell_id, None)