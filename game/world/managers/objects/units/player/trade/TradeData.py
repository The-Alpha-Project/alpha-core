from typing import Optional
from database.dbc.DbcDatabaseManager import DbcDatabaseManager
from game.world.managers.objects.item.ItemManager import ItemManager
from game.world.managers.objects.units.player.trade.ProposedEnchantment import ProposedEnchantment
from game.world.managers.objects.units.player.trade.TradeManager import TradeManager
from utils.constants.MiscCodes import TradeStatus


class TradeData:
    TRADE_SLOT_COUNT = 6

    def __init__(self,
                 player,
                 other_player,
                 is_accepted=False,
                 money=0):
        self.player = player
        self.other_player = other_player
        self.is_accepted = is_accepted
        self.money = money
        self.proposed_enchantment: ProposedEnchantment = ProposedEnchantment()
        self.items: list[Optional[ItemManager]] = [None] * TradeManager.TRADE_SLOT_COUNT

    def get_item_by_guid(self, guid) -> Optional[ItemManager]:
        for item in self.items:
            if item and item.guid == guid:
                return item
        return None

    def get_item_by_slot(self, slot) -> Optional[ItemManager]:
        return self.items[slot]

    def get_slot_by_item(self, item) -> int:
        for slot, trade_item in enumerate(self.items):
            if trade_item == item:
                return slot
        return -1

    def get_linked_trade_data(self) -> Optional["TradeData"]:
        if not self.other_player or not self.other_player.trade_data:
            return None
        return self.other_player.trade_data

    def has_linked_trade_data(self) -> bool:
        return self.get_linked_trade_data() is not None

    def resolve_enchant_target_trade_context(self, target) -> tuple[Optional["TradeData"], int]:
        linked_trade_data = self.get_linked_trade_data()
        if not linked_trade_data:
            return None, -1

        # First try direct object identity on both trade sides.
        for trade_data in (self, linked_trade_data):
            slot = trade_data.get_slot_by_item(target)
            if slot >= 0:
                return trade_data, slot

        # Fallback to guid lookup in case the cast target instance differs from trade slot object reference.
        if not target or not isinstance(target, ItemManager):
            return None, -1

        for trade_data in (self, linked_trade_data):
            trade_item = trade_data.get_item_by_guid(target.guid)
            if not trade_item:
                continue
            slot = trade_data.get_slot_by_item(trade_item)
            if slot >= 0:
                return trade_data, slot

        return None, -1

    def set_proposed_enchant(self, trade_slot, spell_id, enchantment_slot, entry,
                             duration, charges, caster_guid, target_owner_guid, target_item_guid):
        # Mirror proposed enchant data in both trade views.
        self.proposed_enchantment.set_enchantment(trade_slot, spell_id, enchantment_slot,
                                                  entry, duration, charges, caster_guid, target_owner_guid,
                                                  target_item_guid)

    def _is_proposed_enchant_source(self):
        return self.proposed_enchantment.caster_guid == self.player.guid

    def _has_pending_proposed_enchant(self):
        return self.proposed_enchantment.is_valid()

    def _get_proposed_enchant_target_trade_data(self):
        if not self._has_pending_proposed_enchant():
            return None
        if self.proposed_enchantment.target_item_guid:
            if self.get_item_by_guid(self.proposed_enchantment.target_item_guid):
                return self
            if self.other_player and self.other_player.trade_data and \
                    self.other_player.trade_data.get_item_by_guid(self.proposed_enchantment.target_item_guid):
                return self.other_player.trade_data
        if self.proposed_enchantment.target_owner_guid == self.player.guid:
            return self
        if self.other_player and self.other_player.trade_data and \
                self.proposed_enchantment.target_owner_guid == self.other_player.guid:
            return self.other_player.trade_data
        if self.other_player and self.other_player.trade_data:
            return self.other_player.trade_data
        return None

    def _is_enchant_slot_taken(self, slot):
        # If either side tracks this slot as enchant-targeted, it is reserved.
        if self._has_pending_proposed_enchant() and self.proposed_enchantment.trade_slot == slot:
            return True
        if self.other_player and self.other_player.trade_data:
            other_proposed = self.other_player.trade_data.proposed_enchantment
            return other_proposed.is_valid() and other_proposed.trade_slot == slot
        return False

    def _get_proposed_enchant_reagents(self):
        if not self._has_pending_proposed_enchant():
            return []

        spell = DbcDatabaseManager.SpellHolder.spell_get_by_id(self.proposed_enchantment.spell_id)
        if not spell:
            return []

        reagents = (
            (spell.Reagent_1, spell.ReagentCount_1),
            (spell.Reagent_2, spell.ReagentCount_2),
            (spell.Reagent_3, spell.ReagentCount_3),
            (spell.Reagent_4, spell.ReagentCount_4),
            (spell.Reagent_5, spell.ReagentCount_5),
            (spell.Reagent_6, spell.ReagentCount_6),
            (spell.Reagent_7, spell.ReagentCount_7),
            (spell.Reagent_8, spell.ReagentCount_8)
        )
        return [(entry, count) for entry, count in reagents if entry and count > 0]

    def can_apply_proposed_enchant(self):
        # No pending trade enchant means there is nothing to validate.
        if not self._has_pending_proposed_enchant():
            return True
        # Only the enchant source side performs reagent/item validation.
        if not self._is_proposed_enchant_source():
            return True

        target_trade_data = self._get_proposed_enchant_target_trade_data()
        if not target_trade_data:
            return False
        item = target_trade_data.get_item_by_guid(self.proposed_enchantment.target_item_guid) if \
            self.proposed_enchantment.target_item_guid else None
        if not item:
            item = target_trade_data.get_item_by_slot(self.proposed_enchantment.trade_slot)
        if not item:
            return False

        for entry, count in self._get_proposed_enchant_reagents():
            if self.player.inventory.get_item_count(entry) < count:
                return False

        return True

    def apply_proposed_enchant(self):
        # No pending trade enchant means there is nothing to apply.
        if not self._has_pending_proposed_enchant():
            return True
        # Non-source mirrored entry exists for UI sync only.
        if not self._is_proposed_enchant_source():
            return True

        target_trade_data = self._get_proposed_enchant_target_trade_data()
        if not target_trade_data:
            return False
        item = target_trade_data.get_item_by_guid(self.proposed_enchantment.target_item_guid) if \
            self.proposed_enchantment.target_item_guid else None
        if not item:
            item = target_trade_data.get_item_by_slot(self.proposed_enchantment.trade_slot)
        if not item:
            return False

        # Trade-window enchants consume materials when the trade is finalized.
        for entry, count in self._get_proposed_enchant_reagents():
            if self.player.inventory.get_item_count(entry) < count:
                return False
            self.player.inventory.remove_items(entry, count)

        self.player.enchantment_manager.set_item_enchantment(item,
                                                             self.proposed_enchantment.enchantment_slot,
                                                             self.proposed_enchantment.enchantment_entry,
                                                             self.proposed_enchantment.duration,
                                                             self.proposed_enchantment.charges,
                                                             caster=self.player)

        self.player.equipment_proc_manager.handle_equipment_change(item)
        self.player.skill_manager.handle_profession_skill_gain(self.proposed_enchantment.spell_id)
        return True

    def set_item(self, slot, item):
        if self.items[slot] and self.items[slot] == item:
            return
        # Client caches proposed enchant by trade slot; changing that slot must hard-cancel.
        if self._is_enchant_slot_taken(slot):
            TradeManager.cancel_trade(self.player)
            return
        self.items[slot] = item
        self.player.enqueue_packet(item.get_query_details_packet())
        self.other_player.enqueue_packet(item.get_query_details_packet())
        self.set_accepted(False)
        self.other_player.trade_data.set_accepted(False)
        self.update_trade_status()

    def clear_item(self, slot):
        self.items[slot] = None
        # Same as set_item: clear on reserved slot invalidates the trade safely.
        if self._is_enchant_slot_taken(slot):
            TradeManager.cancel_trade(self.player)
            return
        self.update_trade_status()

    def set_money(self, money):
        self.money = money
        self.set_accepted(False)
        self.other_player.trade_data.set_accepted(False)
        self.update_trade_status()

    def update_trade_status(self):
        TradeManager.send_update_trade(self.player, self, False)
        TradeManager.send_update_trade(self.other_player, self, True)

    def set_accepted(self, is_accepted):
        self.is_accepted = is_accepted
        if not is_accepted:
            TradeManager.send_trade_status(self.player, TradeStatus.TRADE_STATUS_STATE_CHANGED)
            TradeManager.send_trade_status(self.other_player, TradeStatus.TRADE_STATUS_STATE_CHANGED)
