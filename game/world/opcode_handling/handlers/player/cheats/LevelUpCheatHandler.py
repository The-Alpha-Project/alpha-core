from network.packet.PacketReader import PacketReader


class LevelUpCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if not world_session.player_mgr.is_gm:
            return 0

        world_session.player_mgr.mod_level(world_session.player_mgr.level + 1)

        return 0
