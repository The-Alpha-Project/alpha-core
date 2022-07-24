from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class LevelUpCheatHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to modify level.')
            return 0

        player_mgr.mod_level(player_mgr.level + 1)

        return 0
