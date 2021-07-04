from network.packet.PacketReader import PacketReader


class DeathBindSetPointHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if world_session.player_mgr.deathbind:
            world_session.enqueue_packet(world_session.player_mgr.get_deathbind_packet())

        return 0
