from struct import unpack

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
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried to give himself Beastmaster.')
            return 0

        if len(reader.data) >= 1:  # Avoid handling empty beast master packet.
            # Client sends '0' if you type `beastmaster off`, and `1` if you type `beastmaster`.
            player_mgr.beast_master = unpack('<B', reader.data[:1])[0] >= 1
        ChatManager.send_system_message(world_session, f'Beastmaster '
                                                       f'{"enabled" if player_mgr.beast_master else "disabled"}')

        return 0
