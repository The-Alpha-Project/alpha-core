from network.packet.PacketReader import *


class PlayerLogoutHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if not world_session.player_mgr:
            return -1

        world_session.player_mgr.logout()

        return 0
