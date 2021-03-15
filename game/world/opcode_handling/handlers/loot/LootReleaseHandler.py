from struct import unpack


class LootReleaseHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 8:  # Avoid handling null selection
            guid = unpack('<Q', reader.data[:8])[0]
            world_session.player_mgr.send_loot_release(guid)

        return 0
