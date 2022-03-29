from network.packet.PacketReader import PacketReader


class BootMeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        world_session.player_mgr.logout()
        return 0
