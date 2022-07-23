from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class RechargeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to recharge powers.')
            return 0

        player_mgr.recharge_power()

        return 0
