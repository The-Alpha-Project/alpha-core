from game.world.managers.objects.units.player.ChatManager import ChatManager
from network.packet.PacketReader import PacketReader
from utils.Logger import Logger


class CheatBeastMasterHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to give himself BeastMaster.')
            return 0

        # Toggle.
        player_mgr.beast_master = not player_mgr.beast_master
        ChatManager.send_system_message(world_session, f'BeastMaster: {player_mgr.beast_master}')

        return 0
