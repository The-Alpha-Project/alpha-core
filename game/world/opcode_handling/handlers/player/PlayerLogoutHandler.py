from network.packet.PacketReader import *


class PlayerLogoutHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        world_session.player_mgr.logout()

        return 0
