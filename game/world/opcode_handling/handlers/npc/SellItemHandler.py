from struct import unpack

from game.world.managers.objects.item.ContainerManager import ContainerManager
from game.world.opcode_handling.HandlerValidator import HandlerValidator
from utils.constants.MiscCodes import SellResults


class SellItemHandler(object):

    @staticmethod
    def handle(world_session, reader):
        # Validate world session.
        player_mgr, res = HandlerValidator.validate_session(world_session, reader.opcode, disconnect=True)
        if not player_mgr:
            return res

        if len(reader.data) >= 17:  # Avoid handling empty sell item packet.
            npc_guid, item_id, sell_amount = unpack('<2QB', reader.data[:17])
            container_slot, container, slot, item = player_mgr.inventory.get_item_info_by_guid(item_id)

            if npc_guid > 0:
                if not item:
                    player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_CANT_FIND_ITEM, item_id, npc_guid)
                    return 0

                if player_mgr.guid != item.item_instance.owner:
                    player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_YOU_DONT_OWN_THAT_ITEM, item_id, npc_guid)
                    return 0

                stack_count = item.item_instance.stackcount

                # Client seems to send zero at least when simply right-clicking, default to selling whole stack.
                if sell_amount <= 0:
                    sell_amount = stack_count

                if sell_amount > stack_count:
                    player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_CANT_FIND_ITEM, item_id, npc_guid)
                    return 0

                price = item.item_template.sell_price
                if price == 0:  # Item is unsellable.
                    player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_VENDOR_NOT_INTERESTED, item_id, npc_guid)
                    return 0

                # Check if player is attempting to sell a bag with something in it.
                if isinstance(item, ContainerManager) and not item.is_empty():
                    player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_ONLY_EMPTY_BAG, item_id, npc_guid)
                    return 0

                if sell_amount < stack_count:
                    new_stack_count = item.item_instance.stackcount - sell_amount
                    item.set_stack_count(new_stack_count)
                else:
                    player_mgr.inventory.remove_item(container_slot, slot)

                player_mgr.mod_money(price * sell_amount)
        return 0
