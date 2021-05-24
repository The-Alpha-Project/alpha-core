from struct import unpack


class LevelCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader):
        if len(reader.data) >= 4:  # Avoid empty packet level cheat packet.
            if not world_session.player_mgr.is_gm:
                return 0

            new_level = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.mod_level(new_level)

        return 0
