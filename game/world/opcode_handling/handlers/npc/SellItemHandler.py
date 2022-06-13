from struct import unpack

from utils.constants.MiscCodes import SellResults


class SellItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 17:  # Avoid handling empty sell item packet.
            vendor_guid, item_guid, sell_amount = unpack('<2QB', reader.data[:17])
            container_slot, container, slot, item = world_session.player_mgr.inventory.get_item_info_by_guid(item_guid)

            if vendor_guid > 0:
                if not item:
                    world_session.player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_CANT_FIND_ITEM,
                                                                       item_guid, vendor_guid)
                    return 0

                owner = world_session.player_mgr.guid
                if owner != item.item_instance.owner:
                    world_session.player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_YOU_DONT_OWN_THAT_ITEM,
                                                                       item_guid, vendor_guid)
                    return 0

                stack_count = item.item_instance.stackcount

                # Client seems to send zero at least when simply right clicking, default to selling whole stack.
                if sell_amount <= 0:
                    sell_amount = stack_count

                if sell_amount > stack_count:
                    world_session.player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_CANT_FIND_ITEM,
                                                                       item_guid, vendor_guid)
                    return 0

                price = item.item_template.sell_price
                if price == 0:  # Item is unsellable.
                    world_session.player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_VENDOR_NOT_INTERESTED,
                                                                       item_guid, vendor_guid)
                    return 0

                # Check if player is attempting to sell a bag with something in it.
                if world_session.player_mgr.inventory.is_bag_pos(slot) and not item.is_empty():
                    world_session.player_mgr.inventory.send_sell_error(SellResults.SELL_ERR_ONLY_EMPTY_BAG,
                                                                       item_guid, vendor_guid)
                    return 0

                if sell_amount < stack_count:
                    new_stack_count = item.item_instance.stackcount - sell_amount
                    item.set_stack_count(new_stack_count)
                else:
                    world_session.player_mgr.inventory.remove_item(container_slot, slot)

                world_session.player_mgr.mod_money(price * sell_amount)
        return 0
