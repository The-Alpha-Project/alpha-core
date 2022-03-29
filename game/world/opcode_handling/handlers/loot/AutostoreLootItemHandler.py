from struct import unpack


class AutostoreLootItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 1:  # Avoid handling empty autostore loot item packet.
            slot = unpack('<B', reader.data[:1])[0]
            world_session.player_mgr.loot_item(slot)

        return 0
