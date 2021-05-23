from network.packet.PacketReader import PacketReader


class DuelCanceledHandler(object):

    @staticmethod
    def handle(world_session, socket: int, reader: PacketReader) -> int:
        # You can trigger cancel by using /yield without being in a duel.
        if world_session.player_mgr.duel_manager:
            world_session.player_mgr.duel_manager.handle_duel_canceled(world_session.player_mgr)
        return 0
