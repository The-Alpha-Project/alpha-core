from struct import unpack


class LootReleaseHandler(object):

    @staticmethod
    def handle(world_session, reader):
        if len(reader.data) >= 8:  # Avoid handling empty loot release packet.
            guid = unpack('<Q', reader.data[:8])[0]
            if world_session.player_mgr.loot_selection and \
                    world_session.player_mgr.loot_selection.object_guid == guid:
                world_session.player_mgr.send_loot_release(world_session.player_mgr.loot_selection)

        return 0
