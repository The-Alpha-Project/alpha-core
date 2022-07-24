from game.world.managers.CommandManager import CommandManager
from utils.Logger import Logger

from network.packet.PacketReader import *


class CreateItemHandler(object):

    @staticmethod
    def handle(world_session, socket, reader: PacketReader) -> int:
        player_mgr = world_session.player_mgr
        if not player_mgr:
            return 0

        if not player_mgr.is_gm:
            Logger.anticheat(f'Player {player_mgr.player.name} ({player_mgr.guid}) tried create item.')
            return 0

        if len(reader.data) >= 4:  # Avoid handling empty create item packet.
            item_entry = unpack('<I', reader.data[:4])[0]
            CommandManager.additem(world_session, str(item_entry))

        return 0
