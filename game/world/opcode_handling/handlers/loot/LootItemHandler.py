from struct import unpack


class LootItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        slot = unpack('<B', reader.data[:2])[0]
        world_session.player_mgr.loot_item(slot)

        return 0