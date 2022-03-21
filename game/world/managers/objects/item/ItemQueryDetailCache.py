from game.world.managers.objects.item.ItemManager import ItemManager

class ItemQueryDetailCache(object):
    CACHED_ITEM_DETAIL_QUERY_PACKET = {}
    @staticmethod
    def get_item_detail_query(item_template):
        if item_template.entry in ItemQueryDetailCache.CACHED_ITEM_DETAIL_QUERY_PACKET:
            return ItemQueryDetailCache.CACHED_ITEM_DETAIL_QUERY_PACKET[item_template.entry]
        else:
            item_mgr = ItemManager(item_template=item_template)
            ItemQueryDetailCache.CACHED_ITEM_DETAIL_QUERY_PACKET[item_template.entry] = item_mgr.query_details()
            return ItemQueryDetailCache.CACHED_ITEM_DETAIL_QUERY_PACKET[item_template.entry]

