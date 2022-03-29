from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class RechargeHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        if not world_session.player_mgr.is_gm:
            Logger.anticheat(f'Player {world_session.player_mgr.player.name} ({world_session.player_mgr.guid}) tried to recharge powers.')
            return 0

        world_session.player_mgr.recharge_power()

        return 0
