from network.packet.PacketReader import *


class RepopRequestHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        world_session.player_mgr.repop()

        return 0
