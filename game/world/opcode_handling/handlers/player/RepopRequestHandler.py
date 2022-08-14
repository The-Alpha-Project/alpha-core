from network.packet.PacketReader import *


class RepopRequestHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        world_session.player_mgr.on_release_spirit()

        return 0
