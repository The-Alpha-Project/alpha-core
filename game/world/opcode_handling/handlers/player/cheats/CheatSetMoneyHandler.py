from network.packet.PacketReader import PacketReader
from utils.Logger import Logger
from struct import unpack


class CheatSetMoneyHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to give himself money.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty cheat set money packet.
            new_money = unpack('<I', reader.data[:4])[0]
            world_session.player_mgr.mod_money(new_money)

        return 0
